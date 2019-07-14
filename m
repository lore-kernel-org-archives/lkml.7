Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753BDC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489A6214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563117022;
	bh=CW+t1bibERWXQeXeG55PP68ixVfZn/JG89LX2kv2uLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oIySrCAJ1k3PZkuG5BhT/Q9izVjq82VDJVyTeDCn8RHOJ81nRrPMxNLR5Quo7ONIq
	 s/KapJ0to91WOd3OlhgzYxWLyd5HGjp1cS7356XsagsfQG4jEqBcQ5fWj/WtL994oM
	 hir5plS4ZEmAE2pTDmDJt5JtJL7XmxnauGN4hknA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfGNPKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 11:10:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45530 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfGNPKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 11:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E27+dMUle7zU70UZTJBvQbjZ+QD96HjO9TYX+WMTsMo=; b=GMy/Inawjl7gMdYXGFjROurtNH
        LZ36I5HnSv0C6vatShRcrpxe3VaINwcmeP7fk6wi0hdtFqCDU+gaoXguCP44AZuy3zB2xRhujS/N0
        l4xDAevBTbNfjZU70RPMMvbRoCcjAsFQ+MfEMZFkZ+6GsjgnXfSgrDSQVCebjIlAYqkaI4pqLS+1W
        ntVMV9QbBn12b67yHn0um0LtDrmFCNNOvzywucKWZpCEuHrbRLDLoY1s10+J+cKMrdC+0UyJ5owbB
        qbSmouS214cH+4D0Fc3Lz/NT+6WM+ugFqFVsEp3pZYz3M3U3YxV5spBl1cn9cTPxyI0aRXTbeQhFU
        yKcAwLSQ==;
Received: from 201.86.163.160.dynamic.adsl.gvt.net.br ([201.86.163.160] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hmg8o-0004f3-Du; Sun, 14 Jul 2019 15:10:18 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hmg8l-0007TK-33; Sun, 14 Jul 2019 12:10:15 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6/8] scripts/sphinx-pre-install: seek for Noto CJK fonts for pdf output
Date:   Sun, 14 Jul 2019 12:10:11 -0300
Message-Id: <ca1aefc49ae2e44eaa8ad70d8801c962427a2a68.1563115732.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1563115732.git.mchehab+samsung@kernel.org>
References: <cover.1563115732.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The translations guide need Noto CJK fonts. So, add a logic that
would suggest its install for distros.

It also fix a few other issues while testing the script
with several distributions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 0a5c83aa5f44..3b638c0e1a4f 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -345,6 +345,9 @@ sub give_debian_hints()
 	if ($pdf) {
 		check_missing_file("/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
 				   "fonts-dejavu", 2);
+
+		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
+				   "fonts-noto-cjk", 2);
 	}
 
 	check_program("dvipng", 2) if ($pdf);
@@ -374,6 +377,7 @@ sub give_redhat_hints()
 	my @fedora_tex_pkgs = (
 		"texlive-collection-fontsrecommended",
 		"texlive-collection-latex",
+		"texlive-xecjk",
 		"dejavu-sans-fonts",
 		"dejavu-serif-fonts",
 		"dejavu-sans-mono-fonts",
@@ -408,6 +412,11 @@ sub give_redhat_hints()
 		$pdf = 0;
 	}
 
+	if ($pdf) {
+		check_missing_file("/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
+				   "google-noto-sans-cjk-ttc-fonts", 2);
+	}
+
 	check_rpm_missing(\@fedora26_opt_pkgs, 2) if ($pdf && !$old);
 	check_rpm_missing(\@fedora_tex_pkgs, 2) if ($pdf);
 	check_missing_tex(2) if ($pdf);
@@ -456,6 +465,11 @@ sub give_opensuse_hints()
 
 	$map{"latexmk"} = "texlive-latexmk-bin";
 
+	# FIXME: add support for installing CJK fonts
+	#
+	# I tried hard, but was unable to find a way to install
+	# "Noto Sans CJK SC" on openSUSE
+
 	check_rpm_missing(\@suse_tex_pkgs, 2) if ($pdf);
 	check_missing_tex(2) if ($pdf);
 	check_missing(\%map);
@@ -483,6 +497,11 @@ sub give_mageia_hints()
 
 	$map{"latexmk"} = "texlive-collection-basic";
 
+	if ($pdf) {
+		check_missing_file("/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
+				   "google-noto-sans-cjk-ttc-fonts", 2);
+	}
+
 	check_rpm_missing(\@tex_pkgs, 2) if ($pdf);
 	check_missing(\%map);
 
@@ -508,6 +527,11 @@ sub give_arch_linux_hints()
 	);
 	check_pacman_missing(\@archlinux_tex_pkgs, 2) if ($pdf);
 
+	if ($pdf) {
+		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJK-Regular.ttc",
+				   "noto-fonts-cjk", 2);
+	}
+
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
@@ -528,6 +552,11 @@ sub give_gentoo_hints()
 	check_missing_file("/usr/share/fonts/dejavu/DejaVuSans.ttf",
 			   "media-fonts/dejavu", 2) if ($pdf);
 
+	if ($pdf) {
+		check_missing_file("/usr/share/fonts/noto-cjk/NotoSansCJKsc-Regular.otf",
+				   "media-fonts/noto-cjk", 2);
+	}
+
 	check_missing(\%map);
 
 	return if (!$need && !$optional);
-- 
2.21.0

