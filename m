Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA194C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70EB520868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 21:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558561434;
	bh=/Yc85y5RHUSpNNnviPrhabeNHOao8MnMPjTMdomSM1Y=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DbP6U01pCznw0Y9o6no0wACFfpfZdzi/z02LSDdUurvryCRq4JnHHif4MfM9HKGbg
	 lfpwGmEOcPzUEpzrfCJ+7+qFytVbt/EtUzSLYZjR1avp58xR9wn0NMNn7hNkODp01W
	 2QW1mAdwGUrzVxI9tda+g4zbYj2xj8wsZcIkOojU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730424AbfEVVnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 17:43:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50412 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729752AbfEVVnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 17:43:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5jh3xIWNqAQlNza6UmkdEpJiH7q4tOt6SYgL3/ss/8A=; b=k+H5OJ3yiYrXCf/4QW+qKIPzT
        +Sdvm2jkSh1Sc/MgQvLOfTc3T6oI+GFbh8j8p2ZKLUOuGNxT3YtUr5PQwtgYWcRyNvWqRrs7uG/rK
        Wbm6E8zealGJ8PSPk5M5jMWvYBYvXGd9qPUdW08LD++elGTw+oo/Dyc/lFwrBYZkQEQq1rkhXIZSZ
        19a8yxu68ytiNaqhycpa1W/4dI56cLG8wUcKdOK6YyIr9AVzVXwOV+ClLoZINQeNCO8Dd88HuvICm
        NJq7eKsPnJ3mg+SW74sshs1vAkQ/7SszyJG7RPeA0sVU+dDr3gYsHxvpVdHY+D1U70cfNyD7nmpgn
        JTXp7jziA==;
Received: from [179.182.168.126] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hTZ1c-0004uZ-Ei; Wed, 22 May 2019 21:43:52 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hTZ1X-0001hw-G1; Wed, 22 May 2019 18:43:47 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] scripts/sphinx-pre-install: make it handle Sphinx versions
Date:   Wed, 22 May 2019 18:43:46 -0300
Message-Id: <ec43ec26541249eb7fd5b1fb9795c9b29e673d0a.1558561422.git.mchehab+samsung@kernel.org>
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
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 scripts/sphinx-pre-install | 86 ++++++++++++++++++++++++++++++++++----
 1 file changed, 79 insertions(+), 7 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index f6a5c0bae31e..8c2d1bcf2e02 100755
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
@@ -219,6 +223,73 @@ sub check_sphinx()
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
+	$virtenv_dir .= $rec_version;
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
+		# Sphinx 1.2.x uses a different format
+		if (m/^\s*Sphinx.*\s+([\d\.]+)$/) {
+			$cur_version=$1;
+			last;
+		}
+	}
+	close IN;
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
@@ -540,7 +611,7 @@ sub check_needs()
 		printf "\tsudo ln -sf %s /usr/bin/sphinx-build\n\n",
 		       which("sphinx-build-3");
 	}
-	if ($need_sphinx) {
+	if ($need_sphinx || $rec_sphinx_upgrade) {
 		my $activate = "$virtenv_dir/bin/activate";
 		if (-e "$ENV{'PWD'}/$activate") {
 			printf "\nNeed to activate virtualenv with:\n";
@@ -554,7 +625,8 @@ sub check_needs()
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

