Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47F5C74A21
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752A72087F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 15:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxwfYVCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfGJPbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 11:31:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40469 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbfGJPbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 11:31:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id p184so1271841pfp.7;
        Wed, 10 Jul 2019 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pm+PJklPDL7RXAYEnFIQUHQOZIeIWdE5Djef4qB8TxU=;
        b=TxwfYVCumbWfzYlPAawF+xfNKfJq391aS7rxGNYsxY8qDeKDep/0JIhBv2TFfgiWvx
         vBZOK3ZOt62Bv5yzzUtKbH2xUyq/5NCF4yfBIh+UjMZuyN4hEYTSPiim1IKK6aUFca0G
         Q1FPB+hCYKuJkZCWZHno5U+KgNJ8bgSDPkWnA0EJoAzU6G7BUMrnVI1haZJd0yGyNkAt
         +6dL6YXRzl0MApe948zf1Qv3KjAlP8c4pr+edE7mj2JPA01HxNzqJZPNSm+8Sz5DIHnC
         ziA/axYEAtF+xtkMz4vAIcRfaAAPbxi2tHMYdYuf7vVRADx7IkR052QI7tAkk20zZgQ9
         kJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pm+PJklPDL7RXAYEnFIQUHQOZIeIWdE5Djef4qB8TxU=;
        b=bXRusyFPWm28v/SqrKYqqPCCp+bg+W++2sNTa0weOdhBikiL8KBguZ1US29CImv7J1
         uvnPUcr1WYt9mt5/VY8Nj2YOViRV+dYjMc4NfcnjYZkMp7yjRwEfJB2TycV9f38WSFn7
         OKkjggxpKnsLwWFxM+0qDgkv47XFcL4I7bqNd82UC7VroFxtAAkTmGFz6qcb4nWrKlb8
         Q+naULCny2nYbk59BXji68zzk/zJKTDUdktVeOTgasoaXIWdmeSEKx7VPMCRh15zxQyV
         6jyxFtbKQN3cYtT4Ihrw9JnkSn/K4Jd6CR5ZIfVDr+iOHs4SsAoILp5Ixnzdp7NrIZB4
         jmVQ==
X-Gm-Message-State: APjAAAVXYJ03/6cbLrMej5vTG7jGrCigSw/lpTtH6VICVjFCLVqh11jS
        WVNwZvG7BndVxRXMagfwMt4=
X-Google-Smtp-Source: APXvYqxVoXAdDOWm/o5rlTb6G5DyCVNDnc9gPfrj14oyqx3axmaPC1ijC03nP5WbU9+AMR0pLQe52g==
X-Received: by 2002:a63:5c1c:: with SMTP id q28mr37077097pgb.288.1562772693385;
        Wed, 10 Jul 2019 08:31:33 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id q1sm2794918pfg.84.2019.07.10.08.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 10 Jul 2019 08:31:32 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, skhan@linuxfoundation.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH v3] Documentation: filesystems: Convert ufs.txt to reStructuredText format
Date:   Wed, 10 Jul 2019 08:31:23 -0700
Message-Id: <1562772683-32422-1-git-send-email-shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20190710092605.73ddee8b@coco.lan>
References: <20190710092605.73ddee8b@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation of ufs.txt to
reStructuredText format. Added to documentation build process
and verified with make htmldocs

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
Changes in v3:
        1. Reverted to minimally changed ufs.rst
	2. Fix Minor Space Issues
        3. Used -M1 in git format-patch to show files as renamed
Changes in v2:
        1. Removed flat-table
        2. Moved ufs.rst to admin-guide

 Documentation/admin-guide/index.rst                |  1 +
 .../{filesystems/ufs.txt => admin-guide/ufs.rst}   | 36 +++++++++++++---------
 2 files changed, 23 insertions(+), 14 deletions(-)
 rename Documentation/{filesystems/ufs.txt => admin-guide/ufs.rst} (69%)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 2871b79..9bfb076 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -71,6 +71,7 @@ configure specific aspects of kernel behavior to your liking.
    bcache
    ext4
    jfs
+   ufs
    pm/index
    thunderbolt
    LSM/index
diff --git a/Documentation/filesystems/ufs.txt b/Documentation/admin-guide/ufs.rst
similarity index 69%
rename from Documentation/filesystems/ufs.txt
rename to Documentation/admin-guide/ufs.rst
index 7a602ad..55d1529 100644
--- a/Documentation/filesystems/ufs.txt
+++ b/Documentation/admin-guide/ufs.rst
@@ -1,37 +1,45 @@
-USING UFS
+=========
+Using UFS
 =========
 
 mount -t ufs -o ufstype=type_of_ufs device dir
 
 
-UFS OPTIONS
+UFS Options
 ===========
 
 ufstype=type_of_ufs
 	UFS is a file system widely used in different operating systems.
 	The problem are differences among implementations. Features of
 	some implementations are undocumented, so its hard to recognize
-	type of ufs automatically. That's why user must specify type of 
+	type of ufs automatically. That's why user must specify type of
 	ufs manually by mount option ufstype. Possible values are:
 
-	old	old format of ufs
+	old
+                old format of ufs
 		default value, supported as read-only
 
-	44bsd	used in FreeBSD, NetBSD, OpenBSD
+	44bsd
+                used in FreeBSD, NetBSD, OpenBSD
 		supported as read-write
 
-	ufs2    used in FreeBSD 5.x
+	ufs2
+                used in FreeBSD 5.x
 		supported as read-write
 
-	5xbsd	synonym for ufs2
+	5xbsd
+                synonym for ufs2
 
-	sun	used in SunOS (Solaris)
+	sun
+                used in SunOS (Solaris)
 		supported as read-write
 
-	sunx86	used in SunOS for Intel (Solarisx86)
+	sunx86
+                used in SunOS for Intel (Solarisx86)
 		supported as read-write
 
-	hp	used in HP-UX
+	hp
+                used in HP-UX
 		supported as read-only
 
 	nextstep
@@ -47,14 +55,14 @@ ufstype=type_of_ufs
 		supported as read-only
 
 
-POSSIBLE PROBLEMS
-=================
+Possible Problems
+-----------------
 
 See next section, if you have any.
 
 
-BUG REPORTS
-===========
+Bug Reports
+-----------
 
 Any ufs bug report you can send to daniel.pirkl@email.cz or
 to dushistov@mail.ru (do not send partition tables bug reports).
-- 
2.7.4

