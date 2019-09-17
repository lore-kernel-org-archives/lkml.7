Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0965C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 04:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781B5216C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 04:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QhM2Jojk";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hSgSYEJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392293AbfIQEty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 00:49:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40764 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfIQEty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 00:49:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1B0EC602F8; Tue, 17 Sep 2019 04:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568695793;
        bh=9DAhlffFQLmyiQ/NBcdB+CPjXZvxyNPw99SVt6x2WNI=;
        h=From:To:Cc:Subject:Date:From;
        b=QhM2JojkQfrWeNPMh1yBFMab870y0RI92asD564PBlf5BXDy91uU3A5HlT04w7spr
         OD43qEvbA3KHi7nCTY14juqsjxqAEipjGCzVla9tS+meWujUkynjvOjN5J/RCe6sW0
         0Vh65Gd/Rg+QLfARCCcpJljtz60msbyMHJGOjdU8=
Received: from codeaurora.org (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8AD46607C3;
        Tue, 17 Sep 2019 04:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568695792;
        bh=9DAhlffFQLmyiQ/NBcdB+CPjXZvxyNPw99SVt6x2WNI=;
        h=From:To:Cc:Subject:Date:From;
        b=hSgSYEJzeXsrKDUNDKTmqyprObM9NX0u+TRioBXgAlgSauRz+qWM67cc3HWUpq+q/
         nP1yc38DAsIlmltF4GoHU+FizSaSZS8prTDeMrsqMUCuvQ85CeaVXHtK6s8V8/vSjM
         kxs6owP5qD/oNwm8dWCd1QX4E+e/WOS4NK48n4UE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AD46607C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] f2fs: add a condition to detect overflow in f2fs_ioc_gc_range()
Date:   Tue, 17 Sep 2019 10:19:23 +0530
Message-Id: <1568695763-29343-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

end = range.start + range.len;

If the range.start/range.len is a very large value, then end can overflow
in this operation. It results into a crash in get_valid_blocks() when
accessing the invalid range.start segno.

This issue is reported in ioctl fuzz testing.

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 fs/f2fs/file.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5474aaa..c2b4767 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2123,9 +2123,8 @@ static int f2fs_ioc_gc_range(struct file *filp, unsigned long arg)
 		return -EROFS;
 
 	end = range.start + range.len;
-	if (range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi)) {
+	if (end < range.start || range.start < MAIN_BLKADDR(sbi) || end >= MAX_BLKADDR(sbi))
 		return -EINVAL;
-	}
 
 	ret = mnt_want_write_file(filp);
 	if (ret)
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

