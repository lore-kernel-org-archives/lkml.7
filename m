Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568ADC3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3044A215EA
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfIAT3a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 15:29:30 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:57598 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728930AbfIAT33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 15:29:29 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C7543180192E9;
        Sun,  1 Sep 2019 19:29:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: train89_1848890063c10
X-Filterd-Recvd-Size: 3603
Received: from XPS-9350.home (unknown [47.151.137.30])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Sep 2019 19:29:26 +0000 (UTC)
Message-ID: <bb9f29988f3258281956680ff39c3e19e37dc0b8.camel@perches.com>
Subject: [PATCH] checkpatch: Make git output use LANGUAGE=en_US.utf8
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Whitcroft <apw@canonical.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 01 Sep 2019 12:29:25 -0700
In-Reply-To: <2c0595c97811044a45e3d482e752d5877a14c06d.camel@perches.com>
References: <20190830163103.15914-1-sean.j.christopherson@intel.com>
         <19c9b30b3d77a65c6c4289a2eeeb6cbe40594aab.camel@perches.com>
         <20190830171731.GB15405@linux.intel.com>
         <a8afdbf13db47e7650473c7f71384f177f3dff59.camel@perches.com>
         <2c0595c97811044a45e3d482e752d5877a14c06d.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

git output parsing depends on the language being en_US english.

Make the backtick execution of all `git <foo>` commands set the
LANGUAGE of the process to en_US.utf8 before executing the actual
command using `export LANGUAGE=en_US.utf8; git <foo>`.

Because the command is executed in a child process, the parent
LANGUAGE is unchanged.

Reported-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f4b6127ff469..113c017cc8e7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -62,6 +62,8 @@ my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
+# git output parsing needs US English output, so first set backtick child process LANGUAGE
+my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 
 sub help {
 	my ($exitcode) = @_;
@@ -918,7 +920,7 @@ sub seed_camelcase_includes {
 	$camelcase_seeded = 1;
 
 	if (-e ".git") {
-		my $git_last_include_commit = `git log --no-merges --pretty=format:"%h%n" -1 -- include`;
+		my $git_last_include_commit = `${git_command} log --no-merges --pretty=format:"%h%n" -1 -- include`;
 		chomp $git_last_include_commit;
 		$camelcase_cache = ".checkpatch-camelcase.git.$git_last_include_commit";
 	} else {
@@ -946,7 +948,7 @@ sub seed_camelcase_includes {
 	}
 
 	if (-e ".git") {
-		$files = `git ls-files "include/*.h"`;
+		$files = `${git_command} ls-files "include/*.h"`;
 		@include_files = split('\n', $files);
 	}
 
@@ -970,7 +972,7 @@ sub git_commit_info {
 
 	return ($id, $desc) if ((which("git") eq "") || !(-e ".git"));
 
-	my $output = `git log --no-color --format='%H %s' -1 $commit 2>&1`;
+	my $output = `${git_command} log --no-color --format='%H %s' -1 $commit 2>&1`;
 	$output =~ s/^\s*//gm;
 	my @lines = split("\n", $output);
 
@@ -1020,7 +1022,7 @@ if ($git) {
 		} else {
 			$git_range = "-1 $commit_expr";
 		}
-		my $lines = `git log --no-color --no-merges --pretty=format:'%H %s' $git_range`;
+		my $lines = `${git_command} log --no-color --no-merges --pretty=format:'%H %s' $git_range`;
 		foreach my $line (split(/\n/, $lines)) {
 			$line =~ /^([0-9a-fA-F]{40,40}) (.*)$/;
 			next if (!defined($1) || !defined($2));


