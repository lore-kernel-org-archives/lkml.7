Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBA7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6CE206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wo874/+C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCLNaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:30:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39329 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfCLNaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:30:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id t124so2602393wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QIFQocTUGRi3zH5QMDviZrJx7jR9iM8LInODOvNKNg=;
        b=wo874/+Csl+843lZ8Q25PESj1oWghoL6/zdckFhhIAXku6KT3/mVk6KqVfPwRzppbS
         IhgeORiHg5GQaNE02CxPxabvmVRZkJ+6Qo1bZsp/A+Djxyndw801RfXFVdawM6l4rFo/
         2D5C2WN35wCkf0aF7YUQNEkUzp7w5914lWLKTMAd08yxy89UAAZ2bnRUHHOb5KJZAJ5a
         n0CuMj82Y8WLvbbfOnxjbv3uxM9F7n1IEE0EHIf2lUAhkWyvMM6fcpFqaoji/+44/qxL
         A2+Hbtj5HiCnuRvULGpPuSRDoaT3ELCux0vcCGCYp7AdQ+O5ltC7vdvMZ5UQec927pS5
         Hspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3QIFQocTUGRi3zH5QMDviZrJx7jR9iM8LInODOvNKNg=;
        b=TyTofsr9v5e4/Afu2ZkBD0UnisSY8Ifac1yhcXN2Wv2R7lz0j0IE745PB6dRYQn3lx
         fRwBERlxPGlvoxwEQkI2n/GYCYfBoL1a2a/DA/d3JR0oiml/ZTFrcRgcwKgf8z9ixbyg
         8h+9JsIzlIdF9/P9ejb7gOShoHKKWVB6psjaI6TFOfyfccT36toWQ6Up7qOkkgAaVPDV
         14OjHh9SwXzu8mvI03R4it+9NTEkuHwpXGM8B/OKpLT1euqphIh28G1bIZXKmXe25Kf8
         dsORbObnkaaMoN4hA3H7ce0fqC3a6tFb1irrnJQ5iiCT1Rj/wGFd3SuxZEvUyBkd8euk
         cgvA==
X-Gm-Message-State: APjAAAUohVHCnzYxEeonqTjeb61qgwGZOKvPZJSIWQF9U4IxUeoERPcP
        xK9i+uO9JAa+F1DKGqya/IxiywNicpQ=
X-Google-Smtp-Source: APXvYqyAMTX7z+yeTXqDQ8Ln41XysN9xVrOYSMJH6OspoNeU6Bb/lI/HwSYEIAnHAfHiVYCO+wIomQ==
X-Received: by 2002:a1c:3c02:: with SMTP id j2mr2587786wma.72.1552397450001;
        Tue, 12 Mar 2019 06:30:50 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-27-140.w90-86.abo.wanadoo.fr. [90.86.252.140])
        by smtp.gmail.com with ESMTPSA id p5sm2187849wme.14.2019.03.12.06.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 06:30:49 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] um: remove uses of variable length arrays
Date:   Tue, 12 Mar 2019 14:30:47 +0100
Message-Id: <20190312133047.16201-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While the affected code is run in user-mode, the build still warns
about it. Convert all uses of VLA to dynamic allocations.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/um/os-Linux/umid.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
index 998fbb445458..e261656fe9d7 100644
--- a/arch/um/os-Linux/umid.c
+++ b/arch/um/os-Linux/umid.c
@@ -135,12 +135,18 @@ static int remove_files_and_dir(char *dir)
  */
 static inline int is_umdir_used(char *dir)
 {
-	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
-	char pid[sizeof("nnnnn\0")], *end;
+	char pid[sizeof("nnnnn\0")], *end, *file;
 	int dead, fd, p, n, err;
+	size_t filelen;
 
-	n = snprintf(file, sizeof(file), "%s/pid", dir);
-	if (n >= sizeof(file)) {
+	err = asprintf(&file, "%s/pid", dir);
+	if (err < 0)
+		return 0;
+
+	filelen = strlen(file);
+
+	n = snprintf(file, filelen, "%s/pid", dir);
+	if (n >= filelen) {
 		printk(UM_KERN_ERR "is_umdir_used - pid filename too long\n");
 		err = -E2BIG;
 		goto out;
@@ -185,6 +191,7 @@ static inline int is_umdir_used(char *dir)
 out_close:
 	close(fd);
 out:
+	free(file);
 	return 0;
 }
 
@@ -210,18 +217,21 @@ static int umdir_take_if_dead(char *dir)
 
 static void __init create_pid_file(void)
 {
-	char file[strlen(uml_dir) + UMID_LEN + sizeof("/pid\0")];
-	char pid[sizeof("nnnnn\0")];
+	char pid[sizeof("nnnnn\0")], *file;
 	int fd, n;
 
-	if (umid_file_name("pid", file, sizeof(file)))
+	file = malloc(strlen(uml_dir) + UMID_LEN + sizeof("/pid\0"));
+	if (!file)
 		return;
 
+	if (umid_file_name("pid", file, sizeof(file)))
+		goto out;
+
 	fd = open(file, O_RDWR | O_CREAT | O_EXCL, 0644);
 	if (fd < 0) {
 		printk(UM_KERN_ERR "Open of machine pid file \"%s\" failed: "
 		       "%s\n", file, strerror(errno));
-		return;
+		goto out;
 	}
 
 	snprintf(pid, sizeof(pid), "%d\n", getpid());
@@ -231,6 +241,8 @@ static void __init create_pid_file(void)
 		       errno);
 
 	close(fd);
+out:
+	free(file);
 }
 
 int __init set_umid(char *name)
@@ -385,13 +397,19 @@ __uml_setup("uml_dir=", set_uml_dir,
 
 static void remove_umid_dir(void)
 {
-	char dir[strlen(uml_dir) + UMID_LEN + 1], err;
+	char *dir, err;
+
+	dir = malloc(strlen(uml_dir) + UMID_LEN + 1);
+	if (!dir)
+		return;
 
 	sprintf(dir, "%s%s", uml_dir, umid);
 	err = remove_files_and_dir(dir);
 	if (err)
 		os_warn("%s - remove_files_and_dir failed with err = %d\n",
 			__func__, err);
+
+	free(dir);
 }
 
 __uml_exitcall(remove_umid_dir);
-- 
2.20.1

