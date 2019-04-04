Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204CDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E267D2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368682;
	bh=jHqBwz2Zx7vHf+6B1phBX8R1CsZv/hTjJc4DOPHUreQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DO0js2IcgxSPKDZCf8+3bM68wAVkWckR8w2Y+XlfkFGFTNQTvVFo0SVYH0o39cbei
	 MCJp9dY0uxJbnE+r1bixT8BgxPP/O2Ut9DhCrh+RbxB9hvmLvGNgPtVQh5HYFFD72T
	 riuOErnAmIh1TnB0pfM1pRpWKdn0BW6Ml2lRQPmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbfDDJEk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:04:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732009AbfDDJEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:04:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67A62214AF;
        Thu,  4 Apr 2019 09:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368677;
        bh=jHqBwz2Zx7vHf+6B1phBX8R1CsZv/hTjJc4DOPHUreQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=knQkPARM/1/5OWp+gOwKzmLOWM24EYUimmQDVMe0evtFacLgWz76XesRsWhgRklc7
         3eQCz1D+6lDttYqjlb54wIYc0QOJ0pvKlomnXgIgOH4HZ3c3gef3j3xhmuUohOskKt
         v7qdh8YLWSnRA7cW2BkOWiDUrVK168YKRMsS6IqY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Coly Li <colyli@suse.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 113/187] bcache: fix potential div-zero error of writeback_rate_i_term_inverse
Date:   Thu,  4 Apr 2019 10:47:30 +0200
Message-Id: <20190404084608.592582747@linuxfoundation.org>
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



