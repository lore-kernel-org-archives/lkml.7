Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DCFC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60C0221473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730435AbfEVUvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:51:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:49398 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfEVUvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:51:00 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 8DC681429;
        Wed, 22 May 2019 20:50:59 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 8/8] scripts/sphinx-pre-install: make it handle Sphinx versions
Date:   Wed, 22 May 2019 14:50:34 -0600
Message-Id: <20190522205034.25724-9-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

As we want to switch to a newer Sphinx version in the future,
add some version detected logic, checking if the current
version meets the requirement and suggesting upgrade it the
version is supported but too old.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
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

