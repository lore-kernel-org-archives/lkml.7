Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D2FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C16F20862
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 17:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558546140;
	bh=tI77OwAxZV+m8EAIZACDiSUXSuFxXKcUy/VRtgk0/zI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1ujmh3t7SWhDJUalHLzpRRmiAnUcZlzQ3oyFXMoW1ptTllaUc/7nVTVkjvgKP9O2/
	 pWUhtPYg/W6pBxJ8cSYxrSYo9DyBGWd6alZgR2lNQjDSd+dqVj4De7WImYIz4DWauA
	 gGMefRXYhJ0r+JfxbQLhdqbXVEsqwvVzdTvC7jHc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbfEVR27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 13:28:59 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37448 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfEVR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UWF+0O1DMn3fjw5n3dlmwztB206X0RTJzr7XaVJzEJo=; b=l1k9Had6FinYJp0UHkOpnCuns
        HcJfgtopDciAmbdkSgRDXaaamrDtj89nWniHJ1Zx0OkWJa8zG/gxTI5UWHCVPAJxs278+eeu2p4XQ
        cFhERJHwtWS9xKQBy727xP6S9/6zcieOHlUnuiwtvGoAO1sM0ZA60mbL8tsgmqPuVljq5TL6lqnks
        gbySJc3Yj8QaCZAaOLSQFMQ2nNie7nmebR1YxkKFsXmrDQ+mNiDdmA/jjmno5jpJIxIWia5qbrhHU
        MBH9MhqepYOrVczUOxP4wj7VEoFudCuCCj6eKtlqJh29whiE+JxDCU+0rcJkw6r+XxDQmlA6llqN9
        oA1xrQE4Q==;
Received: from [179.182.168.126] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTV2s-0002IF-Fa; Wed, 22 May 2019 17:28:54 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hTV2o-0008Of-3X; Wed, 22 May 2019 13:28:50 -0400
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/sphinx-pre-install: make it handle Sphinx versions
Date:   Wed, 22 May 2019 13:28:34 -0400
Message-Id: <a741574b7081c162d200bdead35302ccac6fd116.1558545958.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we want to switch to a newer Sphinx version in the future,
add some version detected logic, checking if the current
version meets the requirement and suggesting upgrade it the
version is supported but too old.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---

 scripts/sphinx-pre-install | 81 ++++++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 7 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index f6a5c0bae31e..e667db230d0a 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -13,7 +13,7 @@ use strict;
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-my $virtenv_dir = "sphinx_1.4";
+my $conf = "Documentation/conf.py";
 my $requirement_file = "Documentation/sphinx/requirements.txt";
 
 #
@@ -26,7 +26,9 @@ my $need = 0;
 my $optional = 0;
 my $need_symlink = 0;
 my $need_sphinx = 0;
+my $rec_sphinx_upgrade = 0;
 my $install = "";
+my $virtenv_dir = "sphinx_";
 
 #
 # Command line arguments
@@ -201,13 +203,15 @@ sub check_missing_tex($)
 	}
 }
 
-sub check_sphinx()
+sub get_sphinx_fname()
 {
-	return if findprog("sphinx-build");
+	my $fname = "sphinx-build";
+	return $fname if findprog($fname);
 
-	if (findprog("sphinx-build-3")) {
+	$fname = "sphinx-build-3";
+	if (findprog($fname)) {
 		$need_symlink = 1;
-		return;
+		return $fname;
 	}
 
 	if ($virtualenv) {
@@ -219,6 +223,68 @@ sub check_sphinx()
 	} else {
 		add_package("python-sphinx", 0);
 	}
+
+	return "";
+}
+
+sub check_sphinx()
+{
+	my $min_version;
+	my $rec_version;
+	my $cur_version;
+
+	open IN, $conf or die "Can't open $conf";
+	while (<IN>) {
+		if (m/^\s*needs_sphinx\s*=\s*[\'\"]([\d\.]+)[\'\"]/) {
+			$min_version=$1;
+			last;
+		}
+	}
+	close IN;
+
+	die "Can't get needs_sphinx version from $conf" if (!$min_version);
+
+	open IN, $requirement_file or die "Can't open $requirement_file";
+	while (<IN>) {
+		if (m/^\s*Sphinx\s*==\s*([\d\.]+)$/) {
+			$rec_version=$1;
+			last;
+		}
+	}
+	close IN;
+
+	die "Can't get recommended sphinx version from $requirement_file" if (!$min_version);
+
+	my $sphinx = get_sphinx_fname();
+	return if ($sphinx eq "");
+
+	open IN, "$sphinx --version 2>&1 |" or die "$sphinx returned an error";
+	while (<IN>) {
+		if (m/^\s*sphinx-build\s+([\d\.]+)$/) {
+			$cur_version=$1;
+			last;
+		}
+	}
+	close IN;
+
+	$virtenv_dir .= $rec_version;
+
+	die "$sphinx didn't return its version" if (!$cur_version);
+
+	printf "Sphinx version %s (minimal: %s, recommended >= %s)\n",
+		$cur_version, $min_version, $rec_version;
+
+	if ($cur_version lt $min_version) {
+		print "Warning: Sphinx version should be >= $min_version\n\n";
+		$need_sphinx = 1;
+		return;
+	}
+
+	if ($cur_version lt $rec_version) {
+		print "Warning: It is recommended at least Sphinx version $rec_version.\n";
+		print "         To upgrade, use:\n\n";
+		$rec_sphinx_upgrade = 1;
+	}
 }
 
 #
@@ -540,7 +606,7 @@ sub check_needs()
 		printf "\tsudo ln -sf %s /usr/bin/sphinx-build\n\n",
 		       which("sphinx-build-3");
 	}
-	if ($need_sphinx) {
+	if ($need_sphinx || $rec_sphinx_upgrade) {
 		my $activate = "$virtenv_dir/bin/activate";
 		if (-e "$ENV{'PWD'}/$activate") {
 			printf "\nNeed to activate virtualenv with:\n";
@@ -554,7 +620,8 @@ sub check_needs()
 			printf "\t$virtualenv $virtenv_dir\n";
 			printf "\t. $activate\n";
 			printf "\tpip install -r $requirement_file\n";
-			$need++;
+
+			$need++ if (!$rec_sphinx_upgrade);
 		}
 	}
 	printf "\n";
-- 
2.21.0


