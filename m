Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00193C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3C72245C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfKMCu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:50:56 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:47956 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727170AbfKMCuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:50:54 -0500
Received: from mr4.cc.vt.edu (mr4.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xAD2orO6025271
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 21:50:53 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xAD2oms6010608
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 21:50:53 -0500
Received: by mail-qk1-f200.google.com with SMTP id m189so581509qkc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 18:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QTCb+WFX3FpJ3fVztSaFH+rTvdtPtL4YNVcXp9Kn7s=;
        b=KCGNkxPYKSAnzNPBG4ZsVxm8v71tHTYqSgOfYtCnC1IRqtln/pazrA/L59rQU7sZvn
         wCOtHtDdODvsGGYmvTWnJFGYIdZSa07CiChdsvTllSnJZftHd7huEIS2P1txq2qBWJA9
         CyJIJBjIDio2oqliJe5XE5hXoAfpITYSvzrqjVP73SNzrEplq/Ehy/KUR5waxg8JMXbf
         nXNdFnV0lQ4h254WLpxIPvbZn7x20FoD+i1A5UqwYTtFvGjTaK3B0k8kNlc2jkJtD7hi
         bdi/VxYUtZ+CTddxE7LS6FjP2Pd3Ik3wqV+EpIGdPyTPFm4ioSkG5Llz/o3YGpFn3Ks4
         oI3w==
X-Gm-Message-State: APjAAAVhH27mQSPRXfKKq2zKZEgrteaG9yGBkqCYp3D//f6gIKlY1I86
        Gn1QMpsWvoAlFIJwl0tmVJH3o5uqN1lAPGnCumyaroGsAaA/e6SuuxKFYR0qPsmuJpqd5MiwodB
        itgzvPQBq9mvFUg38JphX8ooL2GFvjyo7vFk=
X-Received: by 2002:a37:c44b:: with SMTP id h11mr646984qkm.234.1573613448301;
        Tue, 12 Nov 2019 18:50:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyWCFwzxoLiz+DgZpL/3YHBFIyVsL+YXuOhgpxf7giev41idLzl1WPF245u/f3hwaBto4LWkw==
X-Received: by 2002:a37:c44b:: with SMTP id h11mr646972qkm.234.1573613448001;
        Tue, 12 Nov 2019 18:50:48 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id j71sm319265qke.90.2019.11.12.18.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 18:50:47 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        syzbot+787bcbef9b5fec61944b@syzkaller.appspotmail.com,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: exfat: convert WARN to a pr_info
Date:   Tue, 12 Nov 2019 21:50:34 -0500
Message-Id: <20191113025035.186051-1-valdis.kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot took a nosedive because it runs with panic_on_warn set. And
it's quite correct, it shouldn't have been a WARN in the first place.
Other locations just use a pr_info(), so do that here too.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Reported-by: syzbot+787bcbef9b5fec61944b@syzkaller.appspotmail.com
Fixes: c48c9f7ff32b ("staging: exfat: add exfat filesystem code to staging")
---
 drivers/staging/exfat/exfat_blkdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat_blkdev.c b/drivers/staging/exfat/exfat_blkdev.c
index 7bcd98b13109..8204720b2bf2 100644
--- a/drivers/staging/exfat/exfat_blkdev.c
+++ b/drivers/staging/exfat/exfat_blkdev.c
@@ -59,8 +59,8 @@ int exfat_bdev_read(struct super_block *sb, sector_t secno, struct buffer_head *
 	if (*bh)
 		return 0;
 
-	WARN(!p_fs->dev_ejected,
-	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
+	if (p_fs->dev_ejected)
+		pr_info("[EXFAT] No bh, device seems wrong or to be ejected.\n");
 
 	return -EIO;
 }
@@ -112,8 +112,8 @@ int exfat_bdev_write(struct super_block *sb, sector_t secno, struct buffer_head
 	return 0;
 
 no_bh:
-	WARN(!p_fs->dev_ejected,
-	     "[EXFAT] No bh, device seems wrong or to be ejected.\n");
+	if (p_fs->dev_ejected)
+		pr_info("[EXFAT] No bh, device seems wrong or to be ejected.\n");
 
 	return -EIO;
 }
-- 
2.24.0

