Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331A9C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE27A216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8u313E8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfGBHPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:15:19 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:56985 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfGBHPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:15:19 -0400
Received: by mail-pl1-f201.google.com with SMTP id o6so8578231plk.23
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=K8Aexb7ljwnjo43LTD84KFxt2yaGUlciYewUGizxqp8=;
        b=I8u313E8FBDrYJbHjZTqlq9VFU2xsZDW/+q0ovmtc6t5f9akeBUHu4ahrsM5qqlBxU
         +wqic6S14w0ZfSbKtCZYxIRdeM3SNZscRHz6YumpcCn+qA7gKfM6ZLvRQTljOuNl/7dY
         0vogG0ZPjZvUecplrxHpwaDiB4qufA2wonaIZUY1hq7CrZc1BsWNwOsvN0XgOEPInKA/
         a3sAOB5ExVdMRqQJZ9PMTxtKQavFNSontACIoGATuBaO4n3/BAN4e7YwXZHaz/bCnoWW
         Bdb0IPtLchhv0XEsSS70YRGodKiO+AwwnwC1HYxrKSw4nco/9zIkbV7n5viarectEKop
         6b/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=K8Aexb7ljwnjo43LTD84KFxt2yaGUlciYewUGizxqp8=;
        b=qIntT5QUowikrB2TqXgER49RKSAYFvlrEv15xcyDX3NHTSMLhvxSnwZ5K0MxRKCo+a
         /t77iv6Y+p3jZnR528vUG7GOv7IXbQsg3yCDLvDONL5baWS4/CJ4kfmxUsfs8Ls15WuT
         r90Am/PtbRcleEO+40SVCY6QnfeLqEhKmo2vIe/ADnN6g8qRM76mElpEZyWWRsBxs63u
         I0pKr1RqvZZIxuR9u2gZx6we/ZJUfW1XBNBMdgPesSIhpv39QklEsJfAMpjwsPStXrF3
         QofhdWz9lFa/ERbFOMBKL462lreKKh27U68w3B1+BcuTldx/2wMf5XbkOTGmOIZC15YK
         LRSg==
X-Gm-Message-State: APjAAAUn+HSKidTon+jyquEeYNisnzz5LEDrPjYCzNTL7FxVS/TtnPtK
        QyT7X3HqF5f3Pu0Mi0OayNIBLb6f3adNyHA=
X-Google-Smtp-Source: APXvYqyNbkUWK4ZjMisvx3QNm+os2jiG+ShivAJCx8Dft26tvmFVMGPVIfe17cJhkyVPwEZgQqTehJX9HdetKU0=
X-Received: by 2002:a63:60cc:: with SMTP id u195mr28865210pgb.13.1562051718453;
 Tue, 02 Jul 2019 00:15:18 -0700 (PDT)
Date:   Tue,  2 Jul 2019 15:15:10 +0800
Message-Id: <20190702071510.158351-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH] f2fs: avoid out-of-range memory access
From:   Ocean Chen <oceanchen@google.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     oceanchen@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_off might over 512 due to fs corrupt.
Use ENTRIES_IN_SUM to protect invalid memory access.

Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8dee063c833f..b83c23ebae1f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -3403,6 +3403,8 @@ static int read_compacted_summaries(struct f2fs_sb_info *sbi)
 
 		for (j = 0; j < blk_off; j++) {
 			struct f2fs_summary *s;
+			if (blk_off >= ENTRIES_IN_SUM)
+				return -EFAULT;
 			s = (struct f2fs_summary *)(kaddr + offset);
 			seg_i->sum_blk->entries[j] = *s;
 			offset += SUMMARY_SIZE;
-- 
2.22.0.410.gd8fdbe21b5-goog

