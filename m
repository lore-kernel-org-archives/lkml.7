Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C18C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6130B20693
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 09:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="g7fnb/zh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HZaFc5gR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfFFJi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 05:38:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52412 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfFFJiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 05:38:25 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D266E60FEB; Thu,  6 Jun 2019 09:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559813904;
        bh=tsqL//XVJSyHPsn4WnbGr5Qz0DMSjGS8jSJVKedC0gA=;
        h=From:To:Cc:Subject:Date:From;
        b=g7fnb/zhTz/exA2ecO/+qVG4B7WFy4UzhxYZr3rIkg6w9Nn3h7mfU4NSYmFlH16D6
         eLBg6HARf3cEifaVGm5kv9fU5ZnbAjNvJSS/l2RX0JTwh4iO/0RXIBGC0EGL19rFKh
         J0cZg9qFglVCw/uurYFaJf5FObBPn0R/4UD8USN0=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E43CF60255;
        Thu,  6 Jun 2019 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559813903;
        bh=tsqL//XVJSyHPsn4WnbGr5Qz0DMSjGS8jSJVKedC0gA=;
        h=From:To:Cc:Subject:Date:From;
        b=HZaFc5gRGbuyS+uPsJOXHvLIc16i7lWVrelWKdHiOZCIZaJ4IaH5XQmk2kk0ESAPW
         U+3D/41cvMHrA6AUO1xd2+JccF7soEZuOWpO6yUNgcetn9eBp4GSHHLtMFujXvIc5i
         HI5X7MWbx0zNSxgpjkLk03sMqLf1mXFd5is10zpc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E43CF60255
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: fix is_idle() check for discard type
Date:   Thu,  6 Jun 2019 15:08:13 +0530
Message-Id: <1559813893-23452-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The discard thread should issue upto dpolicy->max_requests at once
and wait for all those discard requests at once it reaches
dpolicy->max_requests. It should then sleep for dpolicy->min_interval
timeout before issuing the next batch of discard requests. But in the
current code of is_idle(), it checks for dcc_info->queued_discard and
aborts issuing the discard batch of max_requests. This
dcc_info->queued_discard will be true always once one discard command
is issued.

It is thus resulting into this type of discard request pattern -

- Issue discard request#1
- is_idle() returns false, discard thread waits for request#1 and then
  sleeps for min_interval 50ms.
- Issue discard request#2
- is_idle() returns false, discard thread waits for request#2 and then
  sleeps for min_interval 50ms.
- and so on for all other discard requests, assuming f2fs is idle w.r.t
  other conditions.

With this fix, the pattern will look like this -

- Issue discard request#1
- Issue discard request#2
  and so on upto max_requests of 8
- Issue discard request#8
- wait for min_interval 50ms.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 95adedb..ea34fef 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2209,7 +2209,7 @@ static inline bool is_idle(struct f2fs_sb_info *sbi, int type)
 		get_pages(sbi, F2FS_DIO_WRITE))
 		return false;
 
-	if (SM_I(sbi) && SM_I(sbi)->dcc_info &&
+	if (type != DISCARD_TIME && SM_I(sbi) && SM_I(sbi)->dcc_info &&
 			atomic_read(&SM_I(sbi)->dcc_info->queued_discard))
 		return false;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

