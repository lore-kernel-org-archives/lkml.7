Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8A1C73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F932063F
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563117029;
	bh=HyKYM+r7yUpbpcUOySqaHKygJYkjn/zb3p4TBPwzwps=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wkoGHLt4l9cAQSx6Jr3lhpJePaMJjOFNt1Cp5Ol6hZqdmJ1v5NskbSZ2Pe95sDTq3
	 UBYpEMic1zqhghxnPXhetb0vDTIOU2qxvhR46BCZM96dEJKhWza0qnG7Ya1g4ARGqb
	 3Zjcx8F6bOT69IGhzbAtYECWkdtsjlNlhzUepQXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbfGNPK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:10:28 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45554 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfGNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=i7MBSJrUNlhCKGjlZAmu2GT/MGdBqxk/UuCTvQRDuxQ=; b=JNPq9ico7L8KiU5UqAETPbsGnU
        ougBb/OW6NNY9e3xSHCVE5/mhUfl9KVTXb8rvvchWHf975JR+0QePn5S/MO9U/okeiY/PyWMEkqRw
        O6F4KGXuqtbBJezJ9yhFGiiEoKTijn3Gi2vgBlGtX9pcGkuH86S9ehpBUfnxTSJvoSYJ8Y/cfXzve
        xpOobJsLpOOh2K5hxyUDV+kB/tElh8EumMj4uZM8OmPCFVgiPQ9m3AjCnOoZBV+KuNSYz9xujMb7s
        UXEaDzwaC6AMt7Ei3REncbzlrB2hGRazcPXnSFDu2a/yywBx4sSRic3IFYo2LZn1MuoWP1N+Yeny8
        FxZsy5lw==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg8o-0004f2-Da; Sun, 14 Jul 2019 15:10:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmg8l-0007T8-0O; Sun, 14 Jul 2019 12:10:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/8] scripts/sphinx-pre-install: don't use LaTeX with CentOS 7
Date:   Sun, 14 Jul 2019 12:10:08 -0300
Message-Id: <29c0462ebb1c563cefcdb7eb502eebbc6642f2d4.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There aren't enough texlive packages for LaTeX-based builds
to work on CentOS/RHEL <= 7.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 68 ++++++++++++++++++++++++++++----------
 1 file changed, 50 insertions(+), 18 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 101ddd00bf02..33efadd6c0b6 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -83,6 +83,17 @@ sub check_missing(%)
 	foreach my $prog (sort keys %missing) {
 		my $is_optional = $missing{$prog};
 
+		# At least on some LTS distros like CentOS 7, texlive doesn't
+		# provide all packages we need. When such distros are
+		# detected, we have to disable PDF output.
+		#
+		# So, we need to ignore the packages that distros would
+		# need for LaTeX to work
+		if ($is_optional == 2 && !$pdf) {
+			$optional--;
+			next;
+		}
+
 		if ($is_optional) {
 			print "Warning: better to also install \"$prog\".\n";
 		} else {
@@ -333,10 +344,10 @@ sub give_debian_hints()
 
 	if ($pdf) {
 		check_missing_file("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
-				   "fonts-dejavu", 1);
+				   "fonts-dejavu", 2);
 	}
 
-	check_program("dvipng", 1) if ($pdf);
+	check_program("dvipng", 2) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -371,22 +382,40 @@ sub give_redhat_hints()
 	#
 	# Checks valid for RHEL/CentOS version 7.x.
 	#
+	my $old = 0;
+	my $rel;
+	$rel = $1 if ($system_release =~ /release\s+(\d+)/);
+
 	if (!($system_release =~ /Fedora/)) {
 		$map{"virtualenv"} = "python-virtualenv";
-	}
 
-	my $release;
+		if ($rel && $rel < 8) {
+			$old = 1;
+			$pdf = 0;
 
-	$release = $1 if ($system_release =~ /Fedora\s+release\s+(\d+)/);
+			printf("Note: texlive packages on RHEL/CENTOS <= 7 are incomplete. Can't support PDF output\n");
+			printf("If you want to build PDF, please read:\n");
+			printf("\thttps://www.systutorials.com/241660/how-to-install-tex-live-on-centos-7-linux/\n");
+		}
+	} else {
+		if ($rel && $rel < 26) {
+			$old = 1;
+		}
+	}
+	if (!$rel) {
+		printf("Couldn't identify release number\n");
+		$old = 1;
+		$pdf = 0;
+	}
 
-	check_rpm_missing(\@fedora26_opt_pkgs, 1) if ($pdf && $release >= 26);
-	check_rpm_missing(\@fedora_tex_pkgs, 1) if ($pdf);
-	check_missing_tex(1) if ($pdf);
+	check_rpm_missing(\@fedora26_opt_pkgs, 2) if ($pdf && !$old);
+	check_rpm_missing(\@fedora_tex_pkgs, 2) if ($pdf);
+	check_missing_tex(2) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
 
-	if ($release >= 18) {
+	if (!$old) {
 		# dnf, for Fedora 18+
 		printf("You should run:\n\n\tsudo dnf install -y $install\n");
 	} else {
@@ -425,8 +454,8 @@ sub give_opensuse_hints()
 		"texlive-zapfding",
 	);
 
-	check_rpm_missing(\@suse_tex_pkgs, 1) if ($pdf);
-	check_missing_tex(1) if ($pdf);
+	check_rpm_missing(\@suse_tex_pkgs, 2) if ($pdf);
+	check_missing_tex(2) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -450,7 +479,7 @@ sub give_mageia_hints()
 		"texlive-fontsextra",
 	);
 
-	check_rpm_missing(\@tex_pkgs, 1) if ($pdf);
+	check_rpm_missing(\@tex_pkgs, 2) if ($pdf);
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -473,7 +502,8 @@ sub give_arch_linux_hints()
 		"texlive-latexextra",
 		"ttf-dejavu",
 	);
-	check_pacman_missing(\@archlinux_tex_pkgs, 1) if ($pdf);
+	check_pacman_missing(\@archlinux_tex_pkgs, 2) if ($pdf);
+
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -492,7 +522,7 @@ sub give_gentoo_hints()
 	);
 
 	check_missing_file("/usr/share/fonts/dejavu/DejaVuSans.ttf",
-			   "media-fonts/dejavu", 1) if ($pdf);
+			   "media-fonts/dejavu", 2) if ($pdf);
 
 	check_missing(\%map);
 
@@ -560,7 +590,7 @@ sub check_distros()
 	my %map = (
 		"sphinx-build" => "sphinx"
 	);
-	check_missing_tex(1) if ($pdf);
+	check_missing_tex(2) if ($pdf);
 	check_missing(\%map);
 	print "I don't know distro $system_release.\n";
 	print "So, I can't provide you a hint with the install procedure.\n";
@@ -589,11 +619,13 @@ sub check_needs()
 	check_program("make", 0);
 	check_program("gcc", 0);
 	check_python_module("sphinx_rtd_theme", 1) if (!$virtualenv);
-	check_program("xelatex", 1) if ($pdf);
 	check_program("dot", 1);
 	check_program("convert", 1);
-	check_program("rsvg-convert", 1) if ($pdf);
-	check_program("latexmk", 1) if ($pdf);
+
+	# Extra PDF files - should use 2 for is_optional
+	check_program("xelatex", 2) if ($pdf);
+	check_program("rsvg-convert", 2) if ($pdf);
+	check_program("latexmk", 2) if ($pdf);
 
 	check_distros();
 
-- 
2.21.0

