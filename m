Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E080EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFE9B206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Kzf9SYmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbfDCIjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:39:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51782 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbfDCIjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:39:12 -0400
Received: by mail-wm1-f67.google.com with SMTP id 4so6428930wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 01:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ecC151pDaVmzMAtmj6j4LZHdgySbMEGj2xBocwOX5IY=;
        b=Kzf9SYmIkhvFHsVSsrarA5IqJOh16o5tNXtlRUhkYKdC49zsRlPiVTkF4z5SsL7t1i
         KFebfJlXL+k/4YXs0QQQoFMRTjf6+JMDWO5TLWVHesIZcstbSwvqTAYfpKRoRaoIFTK/
         50ZDg2OArMYai+N7tFNPvAff7Dkb2441t1OuVIzHfTlksd2gUz+aSki8FJI8zdvGT2VF
         6ViAPC5TENDp0c8WgYiWb4ULwmbeVIzJ7nVOTs+OaUSgyupYXFcDUafI9VNrXQ+9pOoF
         cUJpG32ddvh3DkYYudBspjUIh6eBF87xowz3th68TJfFBBBJpcrgdPyoeMT/RuaL5t32
         undw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ecC151pDaVmzMAtmj6j4LZHdgySbMEGj2xBocwOX5IY=;
        b=J8oYDHuFYwJ0oJPwpUwRZSwxUAl8qkzcRH5Yq70+IpjuDr8etGr0A+S32FirFHR4lb
         JB9mx8NnuLTmEu/enQu1B+7OYsKErTtBimsNwxRLuoGji4IXCaFGGolEu7+5011vTY3+
         k9ZLO5h7sJ+TeMQ99mJkbmC3AJZdg6abW9UUgB+oLJYaru1dhRMAF1tv0QA+u6RbY2kG
         xw8AFHAHYCqSS/Lgfbo9/jCqZxcCOaxVPEA3hZrWS2OqDO71n2axsD9xIu/UdJ3tLs0c
         +O2du80H/r8LlMIgOTAtMvGekdOH8ZKD7oshplGyaGKB74mEaLCO7ew3ACPyi9Ia5Mz6
         jKrA==
X-Gm-Message-State: APjAAAVEyk8kbT9SQMALgEwrDloCLjDzEvTci7azdqsS88Cviu8gPvGm
        AWWCEQvkhj+0+yxwxhL9oE4j05MjuBQ=
X-Google-Smtp-Source: APXvYqxXmJOJGOdq6YfH3V77Eo4uSiyeI1l0v1y7Aj+lcWOZJk1xi5MgUw1mnPQigg11tq1WGxrrjg==
X-Received: by 2002:a7b:c5d6:: with SMTP id n22mr1148929wmk.112.1554280750456;
        Wed, 03 Apr 2019 01:39:10 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-29-77.w90-86.abo.wanadoo.fr. [90.86.254.77])
        by smtp.gmail.com with ESMTPSA id v192sm23655771wme.24.2019.04.03.01.39.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 01:39:09 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH 2/4] um: remove uses of variable length arrays
Date:   Wed,  3 Apr 2019 10:39:00 +0200
Message-Id: <20190403083902.3975-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190403083902.3975-1-brgl@bgdev.pl>
References: <20190403083902.3975-1-brgl@bgdev.pl>
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

