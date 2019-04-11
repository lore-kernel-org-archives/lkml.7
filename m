Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67299C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324212184B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 09:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EHQRD0f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfDKJuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 05:50:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50903 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfDKJtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 05:49:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id z11so5918181wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecC151pDaVmzMAtmj6j4LZHdgySbMEGj2xBocwOX5IY=;
        b=EHQRD0f7gS7fr/JQNwYVJ8bXWofMIXn3ffLjYff3o/cUcU3FdZOwzgJcdQ7rrKAyUJ
         O7GO5UjKjfI5yZ1R1nCOYu6Z+w5FRLYJs+5+RnlLRnAHEqHDCFeQQyp/2iVPzzm5wU8X
         TGhd+1cLdjwubgTahHeJ/lyYC7Xl0eCEs/cuc0gi0mBflIIo4Zm5nUQDI1a56xMIgoKD
         4oNX9y+rcbNDl0R+B+lKNBBvXjovEj/gH3ZUOh1W44Aek8R4svsTfT4i8JdppzaFeft6
         GeVPLwOa21M5nYTf154tRmjEV37j6hXYy0xWqg4V2axAixv+IFdBHXp2m4tnS40bub/1
         87sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecC151pDaVmzMAtmj6j4LZHdgySbMEGj2xBocwOX5IY=;
        b=OsM8Eayv+BNiUzTVUywZIUpJRK2dfXTgbvp72DCIyDWAmh9xjFXVACVg1v5oJPmAF1
         Ki/BETUfFFl7xUnGta3nGeZEh8PyHxzpiy1I7Fj4YE/tKW6PV1xUlPycmG8+q9POm3HT
         wUX8IUjBppbv4GZwDOm2SihajVHj4kAAqvPTtKAqzE9qAE4wDvSpw2EBzIB3c/ZvFTjk
         XJ8ah0Ees7mxTzvV+Zt5ffC4kPJAWlkXfJxd5sPacyb6yBpLj7khYOlNdtMI4+PSwN6g
         XZ1BaU71+amm9tDE7+cwi6V7bndU6AxkkUvUk+7eYqWgt2KsLB/6N0s1gx+xpuVdQb0Q
         LNbg==
X-Gm-Message-State: APjAAAX68pM0GNDEMH3ORzDljGxZEuSEnw/6LqvZYwucrmcNQIlFxPnj
        V/0xKNMbViGHaNnJpcqF6Rx08Q==
X-Google-Smtp-Source: APXvYqyVuZ73hCwDcoKv/4KRGAw1lcaf9hJeV0iTqdBmlS7NjQMlv04iLG2LS3yipL6aLqrN65jO1g==
X-Received: by 2002:a7b:c76c:: with SMTP id x12mr6056938wmk.97.1554976189584;
        Thu, 11 Apr 2019 02:49:49 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id s10sm6434066wmh.0.2019.04.11.02.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 02:49:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 2/4] um: remove uses of variable length arrays
Date:   Thu, 11 Apr 2019 11:49:42 +0200
Message-Id: <20190411094944.12245-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190411094944.12245-1-brgl@bgdev.pl>
References: <20190411094944.12245-1-brgl@bgdev.pl>
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
2.21.0

