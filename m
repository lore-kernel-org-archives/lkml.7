Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D15C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB82520842
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 13:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saxHJAYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfJBNdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 09:33:54 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54299 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfJBNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 09:33:54 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so7230970wmp.4;
        Wed, 02 Oct 2019 06:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2ZdCqwmctahUnIjBSN/Q/RPRZtg+DYynqp31Zv7If4=;
        b=saxHJAYK4fZ7OzId92NunP9Z5Jt+Be9zct4aVUpad8ChoBIQ1RYD1p9g9D1jYgWhEY
         CQeA0DLmm4K8eczRaCcPyDWwGjhIZ+QA32hYdxaZ17Ucrjp/9QvFdNsTJWTgQq9upble
         FloVYmVRZOo3DaEsxHOuRy+9CZ2wtnCOdbnCegTnyTTV8OBiORFZ2GoAj4N26EUReiDO
         dvAG5ctjA9wj4vz95XwyVlOyPgtp1TILrf11fZ4WuKDmIt/uCc7bQxYBA5CTcKa9d8SB
         Ht/9I93WQBSR7uzfS8euw49KsIxey1WWDB8T0GNKfclPL21T5MTPUYzO+CVHQ+OwJDV7
         MuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2ZdCqwmctahUnIjBSN/Q/RPRZtg+DYynqp31Zv7If4=;
        b=VgT4N+ItGVMjnha3mTIAkMMtjKybgxmwvrVLUf/lcl0bTiGKulmGoVvCkhG9uddhOh
         7vee60oIQHKtfc7DEGyWSGWH57yO4L3be1J2WwX1YeXn+ZppGb+9KPaTz5cXNgu9QEYb
         QiNBvQzeS2vWeygkgMavSZ1EPvaKy7d29KFsruSWhPK9xnn7paKpivHhogLE2ydNqK0K
         8/kXRYJRzU1f3T0wPcIkMpzCG5sSu1aiEwtaWRhAQo2pWDGtXB4FFuKyzSnIeKWo2h1e
         FnKLN//b2VUQ8tF5ZULszFWaKYXg/SW99MLb/VXCAJ7anB0YkDfKzeTuRcYe9QKRc3ar
         kCcQ==
X-Gm-Message-State: APjAAAW+/jKjY+b9chdHgEfDbFmnbl5MFuIQrWb1ELn9iWBLT7+RNFEO
        75PDar3mLJtuQS+vxrKnLtJMet4uiKIjOQ==
X-Google-Smtp-Source: APXvYqwn6Z9RYlG/ZJ/5RxF01YtmOb7r4KGjSWoiFYXbh43S/a9raLlS4H/uCUp+WyoHKXFfzCEqQA==
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr2810628wmi.73.1570023228320;
        Wed, 02 Oct 2019 06:33:48 -0700 (PDT)
Received: from LHFYY6Y2.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id q19sm45176832wra.89.2019.10.02.06.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 06:33:47 -0700 (PDT)
From:   Jeremy MAURO <jeremy.mauro@gmail.com>
X-Google-Original-From: Jeremy MAURO <j.mauro@criteo.com>
Cc:     j.mauro@criteo.com, Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION SCRIPTS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] scripts/sphinx-pre-install: allow checking for multiple missing files
Date:   Wed,  2 Oct 2019 15:33:39 +0200
Message-Id: <20191002133340.10854-1-j.mauro@criteo.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002073526.228fc7e1@coco.lan>
References: <20191002073526.228fc7e1@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation take a simple file as first argument, this
change allows to take a list as a first argument.

Some file could have a different path according distribution version

Signed-off-by: Jeremy MAURO <j.mauro@criteo.com>
---
Changes in v2:
- Change the commit message

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

