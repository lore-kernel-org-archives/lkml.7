Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F66C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E42B52146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558955273;
	bh=R8Uh0FUtGG6diLPceT1jy3h+bc4R48dyzgDNhWatJ84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ikcGkOdj0qIa0RpvFtrrREhwn8QJ17hip5ufv/cXBMMgKdsDPf6BKFWXj1FbKn6cA
	 eiOfNmKyQP9eF0DkPdpeSHbR+rzO5uRvGrE96WhvFLUt//U5pRgaH+PphDG36X7ZQo
	 sr0W5MWLG+l9nvhLPZV5wS5KXX71nFJyJ8emTa58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfE0LHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 07:07:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57830 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfE0LHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wk/SLJ+ymA7QXlObWHcZ8qPM7WGOzh2AMXrcwsp7zXM=; b=C7AR+8W6Hc/uF6yaGw3EOxwkne
        Yd5klDNHaAfAxbBxMJm2KRepTsb5YOfm3ldcssDXhGr/bhovuHovsZHFl9k8l9P4qQ1NwjoNf0QSV
        k6Zu34QICsOzMYzPNe/WhBg9F/ReuPfnGLLZH1yuwkP6nS7iCaajvYC4pYmoxso5MHgY/nv3wxeo2
        NWnZu+MwqJhMJMdw6+WiotvjDKkTncoe9w0Lk8HBAWbE14PoUG18UIrvi1ZONxRw4+whh+K+kGsS6
        HtRyaPRX+3jFybP2As+IWXsnF4Wmb9wHPMAbbIKq/MIy8jXujus2dTIXi6+JQJoFFTTPv8lTyuBue
        8UEkaL3A==;
Received: from [177.159.249.4] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVDTn-00061t-MD; Mon, 27 May 2019 11:07:47 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hVDTi-0002cm-Po; Mon, 27 May 2019 08:07:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/5] scripts/sphinx-pre-install: always check if version is compatible with build
Date:   Mon, 27 May 2019 08:07:39 -0300
Message-Id: <a1767b5694c9f4d2fe0a447377794d43a8c64d90.1558955082.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1558955082.git.mchehab+samsung@kernel.org>
References: <cover.1558955082.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the script every time a make docs target is selected, on
a simplified check mode.

With this change, the script will set two vars:

$min_version - obtained from `needs_sphinx` var inside
	       conf.py (currently, '1.3')

$rec_version - obtained from sphinx/requirements.txt.

With those changes, a target like "make htmldocs" will do:

1) If no sphinx-build/sphinx-build3 is found, it will run
   the script on normal mode as before, checking for all
   system dependencies and providing install hints for the
   needed programs and will abort the build;

2) If no sphinx-build/sphinx-build3 is found, but there is
   a sphinx_${VER}/bin/activate file, and if
   ${VER} >= $min_version (string comparation), it will
   run in full mode, and will recommend to activate the
   virtualenv. If there are multiple virtualenvs, it
   will string sort the versions, recommending the
   highest version and will abort the build;

3) If Sphinx is detected but has a version lower than
   $min_version, it will run in full mode - with will
   recommend creating a virtual env using sphinx/requirements.txt,
   and will abort the build.

4) If Sphinx is detected and version is lower than
   $rec_version, it will run in full mode and will
   recommend creating a virtual env using sphinx/requirements.txt.

   In this case, it **won't** abort the build.

5) If Sphinx is detected and version is equal or righer than
   $rec_version it will return just after detecting the
   version ("quick mode"), not checking if are there any
   missing dependencies.

Just like before, if one wants to install Sphinx from the
distro, it has to call the script manually and use `--no-virtualenv`
argument to get the hints for his OS:

    You should run:

	sudo dnf install -y python3-sphinx python3-sphinx_rtd_theme

While here, add a small help for the three optional arguments
for the script.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/Makefile     |  5 +++++
 scripts/sphinx-pre-install | 46 +++++++++++++++++++++++++-------------
 2 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index e889e7cb8511..380e24053d6f 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -70,12 +70,14 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	$(abspath $(BUILDDIR)/$3/$4)
 
 htmldocs:
+	@./scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
 linkcheckdocs:
 	@$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,linkcheck,$(var),,$(var)))
 
 latexdocs:
+	@./scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,latex,$(var),latex,$(var)))
 
 ifeq ($(HAVE_PDFLATEX),0)
@@ -87,14 +89,17 @@ pdfdocs:
 else # HAVE_PDFLATEX
 
 pdfdocs: latexdocs
+	@./scripts/sphinx-pre-install --version-check
 	$(foreach var,$(SPHINXDIRS), $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" -C $(BUILDDIR)/$(var)/latex || exit;)
 
 endif # HAVE_PDFLATEX
 
 epubdocs:
+	@./scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,epub,$(var),epub,$(var)))
 
 xmldocs:
+	@./scripts/sphinx-pre-install --version-check
 	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,xml,$(var),xml,$(var)))
 
 endif # HAVE_SPHINX
diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index ded3e2ef3f8d..f001fc2fcf12 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -38,6 +38,7 @@ my $min_version;
 
 my $pdf = 1;
 my $virtualenv = 1;
+my $version_check = 0;
 
 #
 # List of required texlive packages on Fedora and OpenSuse
@@ -277,20 +278,22 @@ sub check_sphinx()
 
 	die "$sphinx didn't return its version" if (!$cur_version);
 
-	printf "Sphinx version %s (minimal: %s, recommended >= %s)\n",
-		$cur_version, $min_version, $rec_version;
-
 	if ($cur_version lt $min_version) {
-		print "Warning: Sphinx version should be >= $min_version\n\n";
+		printf "ERROR: Sphinx version is %s. It should be >= %s (recommended >= %s)\n",
+		       $cur_version, $min_version, $rec_version;;
 		$need_sphinx = 1;
 		return;
 	}
 
 	if ($cur_version lt $rec_version) {
+		printf "Sphinx version %s\n", $cur_version;
 		print "Warning: It is recommended at least Sphinx version $rec_version.\n";
-		print "         To upgrade, use:\n\n";
 		$rec_sphinx_upgrade = 1;
+		return;
 	}
+
+	# On version check mode, just assume Sphinx has all mandatory deps
+	exit (0) if ($version_check);
 }
 
 #
@@ -575,14 +578,18 @@ sub check_distros()
 
 sub check_needs()
 {
-	if ($system_release) {
-		print "Detected OS: $system_release.\n";
-	} else {
-		print "Unknown OS\n";
-	}
-
 	# Check for needed programs/tools
 	check_sphinx();
+
+	if ($system_release) {
+		print "Detected OS: $system_release.\n\n";
+	} else {
+		print "Unknown OS\n\n";
+	}
+
+	print "To upgrade Sphinx, use:\n\n" if ($rec_sphinx_upgrade);
+
+	# Check for needed programs/tools
 	check_perl_module("Pod::Usage", 0);
 	check_program("make", 0);
 	check_program("gcc", 0);
@@ -601,13 +608,14 @@ sub check_needs()
 	}
 	if ($need_sphinx || $rec_sphinx_upgrade) {
 		my $min_activate = "$ENV{'PWD'}/${virtenv_prefix}${min_version}/bin/activate";
-                my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
+		my @activates = glob "$ENV{'PWD'}/${virtenv_prefix}*/bin/activate";
 
-                @activates = sort {$b cmp $a} @activates;
+		@activates = sort {$b cmp $a} @activates;
 
-		if (scalar @activates > 0 && $activates[0] ge $min_activate) {
-			printf "\nNeed to activate virtualenv with:\n";
+		if ($need_sphinx && scalar @activates > 0 && $activates[0] ge $min_activate) {
+			printf "\nNeed to activate a compatible Sphinx version on virtualenv with:\n";
 			printf "\t. $activates[0]\n";
+			exit (1);
 		} else {
 			my $rec_activate = "$virtenv_dir/bin/activate";
 			my $virtualenv = findprog("virtualenv-3");
@@ -646,8 +654,14 @@ while (@ARGV) {
 		$virtualenv = 0;
 	} elsif ($arg eq "--no-pdf"){
 		$pdf = 0;
+	} elsif ($arg eq "--version-check"){
+		$version_check = 1;
 	} else {
-		print "Usage:\n\t$0 <--no-virtualenv> <--no-pdf>\n\n";
+		print "Usage:\n\t$0 <--no-virtualenv> <--no-pdf> <--version-check>\n\n";
+		print "Where:\n";
+		print "\t--no-virtualenv\t- Recommend installing Sphinx instead of using a virtualenv\n";
+		print "\t--version-check\t- if version is compatible, don't check for missing dependencies\n";
+		print "\t--no-pdf\t- don't check for dependencies required to build PDF docs\n\n";
 		exit -1;
 	}
 }
-- 
2.21.0

