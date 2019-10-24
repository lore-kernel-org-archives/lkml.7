Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996BCCA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79F2A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409843AbfJXPy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:27 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42814 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2409832AbfJXPyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:24 -0400
Received: from mr1.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFsNh5010165
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:23 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsItK023159
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:23 -0400
Received: by mail-qk1-f200.google.com with SMTP id b29so23738349qka.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zUGAOh/GAteO6zvZvvY5cTNeZU5s4fMdWwFbCvuXq0c=;
        b=WnPt3m1NuvRi3M6eSFDzTnkNd/U8TjSsmXPBq+p7BG0PDAt7fs2pOm6RxAetQJJ6k8
         V1ZCfI/gten72rI/7z/vbDX6WZzNgxVdr2JLcNAqt+xhK/ZBfnQdwho7oeWhgdSVlyFs
         XWFyDPVscxcKpD3mNCLRMTv6W1cVi70oM33ky/NAV19Ko95LafFrPiH9FBHF789pnFUm
         7AOIY4MLC4N//4aXWKgyiUZCo0t5ye6dnMiPnguOzuxpLN+dx5RNinQBoUFhs/TxZc9Y
         AYxCeKDXZbqa0f2b7Edrjsih/7Pdl9UUyjbsCi8TtImeZGqVsKwkeA/dnZMgal/hTwwv
         7/9A==
X-Gm-Message-State: APjAAAX+tY/D1mbAT01rQ66GfdSxHO6BsTij3ESdHai6dcn3ZV/wpn0F
        IZZ0fKf7+8P6CDZkBNCUJ/9sFqiVpWTSXRtsFA+Gbk5B6eDI9BXO4SrrRrqcRizDB4Apn53hDk2
        O3W6Tm1/r6aj+8oBWWiD+9dwyjQ5MZmO+VRI=
X-Received: by 2002:a05:620a:2144:: with SMTP id m4mr3441281qkm.226.1571932457887;
        Thu, 24 Oct 2019 08:54:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwbLMNY04ECnlnj33HTLJXy7DWyauisrTQfb1G5d+sgpaJQG7/tZjo3ugMJbOpSBCXQtPufYQ==
X-Received: by 2002:a05:620a:2144:: with SMTP id m4mr3441251qkm.226.1571932457601;
        Thu, 24 Oct 2019 08:54:17 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:16 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/15] staging: exfat: Clean up return codes - FFS_NAMETOOLONG
Date:   Thu, 24 Oct 2019 11:53:16 -0400
Message-Id: <20191024155327.1095907-6-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_NOTNAMETOOLONG to -ENAMETOOLONG

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 1 -
 drivers/staging/exfat/exfat_super.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 86bdcf222a5a..a2b865788697 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -221,7 +221,6 @@ static inline u16 get_row_index(u16 i)
 #define FFS_MAXOPENED           13
 #define FFS_EOF                 15
 #define FFS_MEMORYERR           17
-#define FFS_NAMETOOLONG		18
 #define FFS_ERROR               19
 
 #define NUM_UPCASE              2918
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index fd5d8ba0d8bc..eb3c3642abca 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -2362,7 +2362,7 @@ static int exfat_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 			err = -EEXIST;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
-		else if (err == FFS_NAMETOOLONG)
+		else if (err == -ENAMETOOLONG)
 			err = -ENAMETOOLONG;
 		else
 			err = -EIO;
@@ -2643,7 +2643,7 @@ static int exfat_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 			err = -EEXIST;
 		else if (err == -ENOSPC)
 			err = -ENOSPC;
-		else if (err == FFS_NAMETOOLONG)
+		else if (err == -ENAMETOOLONG)
 			err = -ENAMETOOLONG;
 		else
 			err = -EIO;
-- 
2.23.0

