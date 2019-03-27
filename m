Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F1C206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713343;
	bh=+UVlh/mmCwZPFjknKpC3gc1db+dbUUC4PwzYWi+3frs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RgWooPSfGWbYubKD8EM+Trin05kxN8iirZJPKW1vVUl6dgBq+pAJnKTiKhztJ+kl9
	 tmxqZ4CXC2PVRFZAlXwbgHBxtereyDedbGP/xBWr6dh0bI5sBAM3cbu672Zt/Zag5S
	 qwhlQpE/FR1idYBCg7/owsHVXjugszpTKN6CvqRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbfC0TCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:02:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:56636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389505AbfC0SNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:13:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 617D6217F9;
        Wed, 27 Mar 2019 18:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710429;
        bh=+UVlh/mmCwZPFjknKpC3gc1db+dbUUC4PwzYWi+3frs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sWC8fDicGVC+rIBiFSDHBtfdb9H9QGvOQLTUQgzEDwIbUJO2YiR3lJ+nRmEEeVoPj
         QFzJCiOt4a42RfkoYyRGMh4l7ipXsnPxRTBD3ZR0f2qBnsWbOIKooI44869f2iafsh
         +eyst80kvesVexoHrk3+bJx/HTGlF14hUaYDVSow=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 115/192] bcache: fix potential div-zero error of writeback_rate_i_term_inverse
Date:   Wed, 27 Mar 2019 14:09:07 -0400
Message-Id: <20190327181025.13507-115-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coly Li <colyli@suse.de>

[ Upstream commit c3b75a2199cdbfc1c335155fe143d842604b1baa ]

dc->writeback_rate_i_term_inverse can be set via sysfs interface. It is
in type unsigned int, and convert from input string by d_strtoul(). The
problem is d_strtoul() does not check valid range of the input, if
4294967296 is written into sysfs file writeback_rate_i_term_inverse,
an overflow of unsigned integer will happen and value 0 is set to
dc->writeback_rate_i_term_inverse.

In writeback.c:__update_writeback_rate(), there are following lines of
code,
      integral_scaled = div_s64(dc->writeback_rate_integral,
                      dc->writeback_rate_i_term_inverse);
If dc->writeback_rate_i_term_inverse is set to 0 via sysfs interface,
a div-zero error might be triggered in the above code.

Therefore we need to add a range limitation in the sysfs interface,
this is what this patch does, use sysfs_stroul_clamp() to replace
d_strtoul() and restrict the input range in [1, UINT_MAX].

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/bcache/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 01c7c4452a26..503ad954ccc0 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -283,7 +283,9 @@ STORE(__cached_dev)
 	sysfs_strtoul_clamp(writeback_rate_update_seconds,
 			    dc->writeback_rate_update_seconds,
 			    1, WRITEBACK_RATE_UPDATE_SECS_MAX);
-	d_strtoul(writeback_rate_i_term_inverse);
+	sysfs_strtoul_clamp(writeback_rate_i_term_inverse,
+			    dc->writeback_rate_i_term_inverse,
+			    1, UINT_MAX);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
 	d_strtoul_nonzero(writeback_rate_minimum);
 
-- 
2.19.1

