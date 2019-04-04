Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731E0C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C462186A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368858;
	bh=SzXhmpQOktA0XK80I1zBgGCtw3HvpI1Jmek0Q6Qb0+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WROFgKXoREy8LlJJ8c313GOkKi/278Dd31HggosgZX86JnLnFCV5lWdWx3LVY0Ymo
	 E2257/YWaglZvKYvlrsTs2svvC5t63S0jI3gUchgXdh+TQDS2DqvvIlZjOa0Pltqyj
	 9a73jduDHZ8ac3G2zCU1s6DEP5k2mVvSmcIHXUjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbfDDJHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:07:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732485AbfDDJHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:07:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C8F5218D4;
        Thu,  4 Apr 2019 09:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368853;
        bh=SzXhmpQOktA0XK80I1zBgGCtw3HvpI1Jmek0Q6Qb0+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hmKEArm8jDhXi3NJIntbjKXu+G5tNZSqA8zlsW8pi0rk4nVRUc2A7nogr2tqTSYZw
         UR4YmZuok4yVQhd4CHKtez8icZfU1CAS3EEPo2Np2tn/AhUCH33WPCBOoI31DkByWz
         WgfmSJeG1WnFkJrGDhniWxOG9P/4GjfoPipIgrQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 186/187] bcache: fix potential div-zero error of writeback_rate_p_term_inverse
Date:   Thu,  4 Apr 2019 10:48:43 +0200
Message-Id: <20190404084611.875407024@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 5b5fd3c94eef69dcfaa8648198e54c92e5687d6d ]

Current code already uses d_strtoul_nonzero() to convert input string
to an unsigned integer, to make sure writeback_rate_p_term_inverse
won't be zero value. But overflow may happen when converting input
string to an unsigned integer value by d_strtoul_nonzero(), then
dc->writeback_rate_p_term_inverse can still be set to 0 even if the
sysfs file input value is not zero, e.g. 4294967296 (a.k.a UINT_MAX+1).

If dc->writeback_rate_p_term_inverse is set to 0, it might cause a
dev-zero error in following code from __update_writeback_rate(),
	int64_t proportional_scaled =
		div_s64(error, dc->writeback_rate_p_term_inverse);

This patch replaces d_strtoul_nonzero() by sysfs_strtoul_clamp() and
limit the value range in [1, UINT_MAX]. Then the unsigned integer
overflow and dev-zero error can be avoided.

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 503ad954ccc0..d9481640b3e1 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -286,7 +286,9 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_i_term_inverse,
 			    dc->writeback_rate_i_term_inverse,
 			    1, UINT_MAX);
-	d_strtoul_nonzero(writeback_rate_p_term_inverse);
+	sysfs_strtoul_clamp(writeback_rate_p_term_inverse,
+			    dc->writeback_rate_p_term_inverse,
+			    1, UINT_MAX);
 	d_strtoul_nonzero(writeback_rate_minimum);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
-- 
2.19.1



