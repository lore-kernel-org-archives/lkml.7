Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 023EEC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9C73218DE
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 09:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV6QtsA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfJBJxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 05:53:48 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36727 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfJBJxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 05:53:47 -0400
Received: by mail-wr1-f49.google.com with SMTP id y19so18895232wrd.3;
        Wed, 02 Oct 2019 02:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RWVwfPPGgKm5hw4m8UL7QQsUyKQM7jCrpOj28KmECE4=;
        b=YV6QtsA66u6NpdLJBnhIo58bUpR4pvR8qTPuK26xuilXZoPQPKZ0BFsEowdGM2j/qV
         AIYiqu3CokC2rHxDR/VIZa7RRI+TI+JhxMgbMJMhWT0bSh/1BPPj/Jy0jknUvYsyi2pB
         c2yRjCkROdtylFznRxC2woWCZjd0wjszUkKa19EOTsKvluGUJgAJTD1pCsqT+js8iivA
         hgS519EL/6XXkRa36Dx8P5btU8lIRh6IFLV28eOSEEBHPNUzK3EWtmuTQCOMS7BacQ4N
         GV+I+pXMsYzWQ8gLyeD4BaOsrCIYariVJ21+E437xdAX0ERag3SW4s+s6LZVCOMK1YR+
         hyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RWVwfPPGgKm5hw4m8UL7QQsUyKQM7jCrpOj28KmECE4=;
        b=WMKAZPByd7j05R8oXZI1LSIWn38gSty/Cq+Ite8yS926+O/vR+HbnhTpM1TJzaKH1v
         UoxLvLFkMlIy3DJkOmDaR/d4VFcqnTTLBpXc4E9SkC0iY4KeDN+Ru8fmOT7fcy3XQ+6b
         rnUGH+HO7YpoyiydfzGTbMhCAqmGKU6gA2pYy1DH3MzpdrKp6qP2xmwfqHIXcRqAgqHv
         sotozVlrVdkCq1JVNpDLxEWwrMdevMxMVFEF3CinnDSZoRgGLJn4pRTYXfIYUv3Gm/JO
         qTF3tCbfZkbzWPw8ufVXYPmR3R3pD6hh/OMQyegI/0Qk363UZnSE+Hw8Hc7lMlz7XQm8
         EbDg==
X-Gm-Message-State: APjAAAUD4Bu28s7JEgzy2XWKgJSiSbVyfF8AdGlYGf1LNjh0hrZIKf+V
        XZHhUM4LtOJJpZbTAruvngo=
X-Google-Smtp-Source: APXvYqyRaHcj9AUx2euzyJdQxard/v6bJIZ5QNY8iuPHBMotAIOJkzy9ju7WaAoGu+pt+Os50sXh+A==
X-Received: by 2002:adf:f406:: with SMTP id g6mr1855478wro.325.1570010024943;
        Wed, 02 Oct 2019 02:53:44 -0700 (PDT)
Received: from LHFYY6Y2.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id r7sm19869692wrx.87.2019.10.02.02.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 02:53:44 -0700 (PDT)
From:   Jeremy MAURO <jeremy.mauro@gmail.com>
X-Google-Original-From: Jeremy MAURO <j.mauro@criteo.com>
To:     j.mauro@criteo.com
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION SCRIPTS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] scripts/sphinx-pre-install: Change the function 'check_missing_file'
Date:   Wed,  2 Oct 2019 11:53:30 +0200
Message-Id: <20191002095330.9863-1-j.mauro@criteo.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <j.mauro@criteo.com>
References: <j.mauro@criteo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation take a simple file as first argument, this
change allows to take a list as a first argument.

Some file could have a different path according distribution version

Signed-off-by: Jeremy MAURO <j.mauro@criteo.com>
---
 scripts/sphinx-pre-install | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 3b638c0e1a4f..b5077ae63a4b 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -124,11 +124,13 @@ sub add_package($$)
 
 sub check_missing_file($$$)
 {
-	my $file = shift;
+	my $files = shift;
 	my $package = shift;
 	my $is_optional = shift;
 
-	return if(-e $file);
+	for (@$files) {
+		return if(-e $_);
+	}
 
 	add_package($package, $is_optional);
 }
@@ -343,10 +345,10 @@ sub give_debian_hints()
 	);
 
 	if ($pdf) {
-		check_missing_file("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
+		check_missing_file(["/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf"],
 				   "fonts-dejavu", 2);
 
-		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
+		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
 				   "fonts-noto-cjk", 2);
 	}
 
@@ -413,7 +415,7 @@ sub give_redhat_hints()
 	}
 
 	if ($pdf) {
-		check_missing_file("/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
+		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc"],
 				   "google-noto-sans-cjk-ttc-fonts", 2);
 	}
 
@@ -498,7 +500,7 @@ sub give_mageia_hints()
 	$map{"latexmk"} = "texlive-collection-basic";
 
 	if ($pdf) {
-		check_missing_file("/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
+		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc"],
 				   "google-noto-sans-cjk-ttc-fonts", 2);
 	}
 
@@ -528,7 +530,7 @@ sub give_arch_linux_hints()
 	check_pacman_missing(\@archlinux_tex_pkgs, 2) if ($pdf);
 
 	if ($pdf) {
-		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
+		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc"],
 				   "noto-fonts-cjk", 2);
 	}
 
@@ -549,11 +551,11 @@ sub give_gentoo_hints()
 		"rsvg-convert"		=> "gnome-base/librsvg",
 	);
 
-	check_missing_file("/usr/share/fonts/dejavu/DejaVuSans.ttf",
+	check_missing_file(["/usr/share/fonts/dejavu/DejaVuSans.ttf"],
 			   "media-fonts/dejavu", 2) if ($pdf);
 
 	if ($pdf) {
-		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf",
+		check_missing_file(["/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf"],
 				   "media-fonts/noto-cjk", 2);
 	}
 
-- 
2.23.0

