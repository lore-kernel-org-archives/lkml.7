Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644F9C31E50
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395C2206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2TwOOg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfFQON3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:13:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44466 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQON3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:13:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id p144so6205987qke.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=A4+NWm3uj2vW47hGvQEajXQiT2mH6czBZ2S5v1C4m2A=;
        b=J2TwOOg4uFCQ5V4sjkSOauUtMooFNdefA59sKPmvuUNK7uSEf0SZ+L5IAaapTkR9UL
         yNMfQbWCae/R7eO6yJQx08kaKyK9nqodzyBeiLkN4vhkUnyXe70EoUjNcrdpqlJodG9S
         f+lHajYvJsZVbdC71ETaVN3WF8wXjFeIt99fJj39Y1is4W7Sud8qA4s+JGODUveushr0
         LLagS2AZ2dXtSSgh4Cm8zja4ajiH4cX3+c4iS6LvT8eC+C3vhkcxFYytcnvPe2CfpkIK
         6AZ3JvVSGl/F4N3kTsTEGqAnllXGL90LpxkldHFtvQ4rVvO4SVXcEXLc6gHUM/2YJtcq
         Vaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=A4+NWm3uj2vW47hGvQEajXQiT2mH6czBZ2S5v1C4m2A=;
        b=Im/xTvpbUCsDTTVLiEAjrfQhFtkhNI9EZzTHo+8wSi4pUDY15wMIMorCcLD5aKJ2si
         fAOvPC4W+QVi4ObNnfgmSEh/UXsiUNdoue9f3lxZgyEI+jRXnEV4+bMgX2V0yUsO1rAf
         WVjc7g2eM/nMaEN4chKtMAt1pb07WjJN9d5Xa5twrovjcAcHgeEDT5gIj7wKXxSqZ2Ha
         +VGsaiy6WZsvaR1wJUXDlYgY1yBUXeiM1PB812Ow5IyBTceTu95yXMb6Bmu3V4/W9qbq
         2YCds1jarRYKe+UVfr/3pl134zKY5QHiBQJnIztPsZIrSyW5UQoQ+Qkc3s1HrcVc+R7h
         Ck1w==
X-Gm-Message-State: APjAAAWaugBT0/1sCx91yqnBJN3aoFZwAr/xitYKkXtrDsU9ksGcNdjc
        nGmCbhmhqM1Mt2E6C3O5Zr8=
X-Google-Smtp-Source: APXvYqy7osGY+vzxkDkQlaDeRn+XdHSIdKCAIm2+EfSROS9Q0KncFtK6lZof35B1QSLilLBCqoW2UA==
X-Received: by 2002:a37:68d2:: with SMTP id d201mr90585636qkc.65.1560780808643;
        Mon, 17 Jun 2019 07:13:28 -0700 (PDT)
Received: from k8s-master.slicetest.com (kovt.soborka.net. [94.158.152.75])
        by smtp.googlemail.com with ESMTPSA id x7sm6917426qth.37.2019.06.17.07.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 07:13:27 -0700 (PDT)
From:   Kovtunenko Oleksandr <alexander198961@gmail.com>
To:     shaggy@kernel.org, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     alexander198961@gmail.com
Subject: [PATCH] set block device for dummy log . In this fix try to avoid null in the call  bio_set_dev(bio, bdev) because in case bdev is null we  have  NULL pointer dereference ticket reference https://bugzilla.kernel.org/show_bug.cgi?id=203737
Date:   Mon, 17 Jun 2019 14:13:21 +0000
Message-Id: <1560780801-5364-1-git-send-email-alexander198961@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 fs/jfs/jfs_logmgr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 6b68df3..3cd7026 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -1223,6 +1223,7 @@ static int open_dummy_log(struct super_block *sb)
 		/* Make up some stuff */
 		dummy_log->base = 0;
 		dummy_log->size = 1024;
+         	dummy_log->bdev = sb->s_bdev;
 		rc = lmLogInit(dummy_log);
 		if (rc) {
 			kfree(dummy_log);
-- 
1.8.3.1

