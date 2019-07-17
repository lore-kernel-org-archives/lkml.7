Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B046C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FFCF2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tLPXq7Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388629AbfGRGE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:04:29 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46903 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRGE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:04:29 -0400
Received: by mail-qt1-f193.google.com with SMTP id h21so25926142qtn.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s7CXeF8uvBKnNU0aV0PhameaA3sT+h57hx3g24HEe2U=;
        b=tLPXq7XrsYVgQigVAOJiBXuul4CBsKrMICZCKovCK44Ov5zeezEwUScV326bhHtdJ7
         gmrrc0pTRuUABFxdKGxNtBBe4GhKDSOQF9ujQTQkEtJz+NtgnIgzqLKyxcjDe5an6qTy
         jhEnNgp/Mjqd0ZnEiMu94xmdX48ujqe4U7PJSRsLBxQXBMh8R/6El7/G88a2V3cbkqsC
         Woh+q3GDc9/Brhf+DUj6sPN9MugKmhUbL+hs2t5WnjTajja6E//HEh8/dDPtHA/Lusa4
         dDWavsoZYZJSlOHjrUJ59m+tIt0RR0at2gGOpvkA8k+chVNPiIbso8uEsml5RxRmq1jy
         RepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s7CXeF8uvBKnNU0aV0PhameaA3sT+h57hx3g24HEe2U=;
        b=bH9NXpJTSIrb3y9qmrcmgbjXlqemZdiYV6Dq3Ufm3K3tHdF2aq92Sy8GawPg4ydmHa
         XVN0oV/I5qTnSAiSdv83dtNUrj/oiQGi8Pk7NxK+srSVEWR7I4U9/ANmFkC3K907xwnd
         mxVQyUxy38SIsHwFCqPibOdP8SzGtHrf21nA1wmf0dF76eS1Iwr10Q1bv6n5rGB06xdf
         5O2b9TV9k9RD+Tzg7vGGQCWbSxMfCUQJgntp9fIFWdF55JsOnsPp/r+0Ua8LfAUdqE27
         v7kj81UZ5qjrhd+1KR13ZDFF3CRGGAU9RCUUYePEgvvFdD4iej2dulA/LvcpXRMNy17z
         QN3w==
X-Gm-Message-State: APjAAAUGfJdmX6RlKeY1WMBC/q4FlgfKqRzKRKI6KHzR8TXlnN24OPun
        Xa3ZR7nt24cVd67mBcisxR0=
X-Google-Smtp-Source: APXvYqzYIUatZiQ88JgMXznb7BmGeGoORVj6WzuMUstkNhdu0jSUZcv4xnSY1iqHI+C6yWxwEWQdDQ==
X-Received: by 2002:aed:222d:: with SMTP id n42mr30703133qtc.144.1563429868394;
        Wed, 17 Jul 2019 23:04:28 -0700 (PDT)
Received: from k8s-master.slicetest.com (kovt.soborka.net. [94.158.152.75])
        by smtp.googlemail.com with ESMTPSA id p59sm12527196qtd.75.2019.07.17.23.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2019 23:04:27 -0700 (PDT)
From:   Kovtunenko Oleksandr <alexander198961@gmail.com>
To:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     alexander198961@gmail.com
Subject: [PATCH] fix null pointer bugzilla 203737 . wich is triggered in function bio_set_dev(bio, bdev) in case bdev is null Signed-off-by: Kovtunenko Oleksandr <alexander198961@gmail.com>
Date:   Wed, 17 Jul 2019 08:04:50 +0000
Message-Id: <1563350690-7734-1-git-send-email-alexander198961@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 fs/jfs/jfs_logmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 9330eff..c2fcaa0 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1209,6 +1209,7 @@ static int open_dummy_log(struct super_block *sb)
 		/* Make up some stuff */
 		dummy_log->base = 0;
 		dummy_log->size = 1024;
+		dummy_log->bdev = sb->s_bdev;
 		rc = lmLogInit(dummy_log);
 		if (rc) {
 			kfree(dummy_log);
-- 
1.8.3.1

