Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14922C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69F2216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 09:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBhm+5dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfEIJjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 05:39:45 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40181 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfEIJjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 05:39:44 -0400
Received: by mail-wm1-f66.google.com with SMTP id h11so2257387wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 02:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPqzVi3zKKwHtJglhj145ldMMaQbDGmaOkRBDE4CHMc=;
        b=bBhm+5dyIQED+c+WmgRwiLtO2YQNLYUbzSpC07gH67UgSdg7ziX7+9DSn5sUbgzTDU
         jc2LyjBKn00Tm57119XtksTBuaShBC43vEeCGb1Sxn9wjrnHOsQNfi/YI0STxlmklDOA
         DzHA//UWzI3+Nl64Hf+mCDlQZ3uHz99bnBuUOrsEa/ML2F3QuPb6ugkigTIg0l+88ruu
         Z7OGIEc1fw0t1k+6jQRT/JzkWCbUYkOFdy02q4DbV3kFCSTbYqOYxtt9U9nhxWpLhcpe
         6GMaC6WVzyDFl3glcKUW3kgz8T2fWEzdLty5BdDn/0P7gDRKyHK7TCICMoypl5NZr65b
         LvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EPqzVi3zKKwHtJglhj145ldMMaQbDGmaOkRBDE4CHMc=;
        b=kWI5RnHulgHdIf4FTgr7T4ng1Q1mFjND5NvtK72KDN2HS70xzZejv61Y2E9lCr32Uc
         wxBJ/paYcwfsc7QBgtPQ4Hr//4mLqzn0pnUCxNHdXnxeYCLASr8lhx1r4RwPnjJbEiRF
         PxAZs0OTxYe6bDgBqmfbZNf52+JxR6HD7j2LSv8Sw2tyjz6/TZo3EqRMxMQBx1saHt/A
         UHt5ulHJqzCbtpcKIPXeJA9wNAxUrHcbZMpLNNgdn54p76IkpD9nXm52mdnN0Zof2i1H
         5ftzja5KF/X2GiGDmmTrdch5MnTYaMNZn44evf0/CzgHQP+GGbFHp+q92Qn6w8B9QlHp
         /FHw==
X-Gm-Message-State: APjAAAUHn2cCmkwMcVJz4f+B2jOfv3jRUbvOPmKUQUYotK0eynWwedHT
        oFd50fCxyGQlSZItbvWXLy8=
X-Google-Smtp-Source: APXvYqwxoM/5kN0UOrTQ3RTn8Tq/Kb7HtHEeH9us7QhRpMe6gKeeO4emuS956ZhuEev5S1J7fDvV0A==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr2099575wmf.107.1557394782028;
        Thu, 09 May 2019 02:39:42 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-657-1-239-64.w80-14.abo.wanadoo.fr. [80.14.206.64])
        by smtp.gmail.com with ESMTPSA id 4sm1598836wmi.4.2019.05.09.02.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 02:39:41 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5] checkpatch: add command-line option for TAB size
Date:   Thu,  9 May 2019 11:39:29 +0200
Message-Id: <20190509093929.23507-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux kernel coding style requires a size of 8 characters for
both TAB and indentation, and such value is embedded as magic
value allover the checkpatch script.
This makes hard to reuse the script by other projects with
different requirements in their coding style (e.g. OpenOCD [1]
requires TAB size of 4 characters [2]).

Replace the magic value 8 with a variable.

Add a command-line option "--tab-size" to let the user select a
TAB size value other than 8.

[1] http://openocd.org/
[2] http://openocd.org/doc/doxygen/html/stylec.html#styleformat

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Signed-off-by: Erik Ahlén <erik.ahlen@avalonenterprise.com>
Signed-off-by: Spencer Oliver <spen@spen-soft.co.uk>
---
v1 -> v2
	add the command line option

v2 -> v3
	rewrite commit msg to remove script readability issue

v3 -> v4
	check for command line value positive

v4 -> v5
	exclude --tab-size=1
---
 scripts/checkpatch.pl | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 916a3fbd4d47..c36876f78bd5 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -62,6 +62,7 @@ my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
+my $tabsize = 8;
 
 sub help {
 	my ($exitcode) = @_;
@@ -96,6 +97,7 @@ Options:
   --show-types               show the specific message type in the output
   --max-line-length=n        set the maximum line length, if exceeded, warn
   --min-conf-desc-length=n   set the min description length, if shorter, warn
+  --tab-size=n               set the number of spaces for tab (default 8)
   --root=PATH                PATH to the kernel tree root
   --no-summary               suppress the per-file summary
   --mailback                 only produce a report in case of warnings/errors
@@ -213,6 +215,7 @@ GetOptions(
 	'list-types!'	=> \$list_types,
 	'max-line-length=i' => \$max_line_length,
 	'min-conf-desc-length=i' => \$min_conf_desc_length,
+	'tab-size=i'	=> \$tabsize,
 	'root=s'	=> \$root,
 	'summary!'	=> \$summary,
 	'mailback!'	=> \$mailback,
@@ -265,6 +268,9 @@ if ($color =~ /^[01]$/) {
 	die "Invalid color mode: $color\n";
 }
 
+# skip TAB size 1 to avoid additional checks on $tabsize - 1
+die "Invalid TAB size: $tabsize\n" if ($tabsize < 2);
+
 sub hash_save_array_words {
 	my ($hashRef, $arrayRef) = @_;
 
@@ -1211,7 +1217,7 @@ sub expand_tabs {
 		if ($c eq "\t") {
 			$res .= ' ';
 			$n++;
-			for (; ($n % 8) != 0; $n++) {
+			for (; ($n % $tabsize) != 0; $n++) {
 				$res .= ' ';
 			}
 			next;
@@ -2224,7 +2230,7 @@ sub string_find_replace {
 sub tabify {
 	my ($leading) = @_;
 
-	my $source_indent = 8;
+	my $source_indent = $tabsize;
 	my $max_spaces_before_tab = $source_indent - 1;
 	my $spaces_to_tab = " " x $source_indent;
 
@@ -3153,7 +3159,7 @@ sub process {
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
 # at the beginning of a line any tabs must come first and anything
-# more than 8 must use tabs.
+# more than $tabsize must use tabs.
 		if ($rawline =~ /^\+\s* \t\s*\S/ ||
 		    $rawline =~ /^\+\s*        \s*/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
@@ -3172,7 +3178,7 @@ sub process {
 				"please, no space before tabs\n" . $herevet) &&
 			    $fix) {
 				while ($fixed[$fixlinenr] =~
-					   s/(^\+.*) {8,8}\t/$1\t\t/) {}
+					   s/(^\+.*) {$tabsize,$tabsize}\t/$1\t\t/) {}
 				while ($fixed[$fixlinenr] =~
 					   s/(^\+.*) +\t/$1\t/) {}
 			}
@@ -3194,11 +3200,11 @@ sub process {
 		if ($perl_version_ok &&
 		    $sline =~ /^\+\t+( +)(?:$c90_Keywords\b|\{\s*$|\}\s*(?:else\b|while\b|\s*$)|$Declare\s*$Ident\s*[;=])/) {
 			my $indent = length($1);
-			if ($indent % 8) {
+			if ($indent % $tabsize) {
 				if (WARN("TABSTOP",
 					 "Statements should start on a tabstop\n" . $herecurr) &&
 				    $fix) {
-					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/8)@e;
+					$fixed[$fixlinenr] =~ s@(^\+\t+) +@$1 . "\t" x ($indent/$tabsize)@e;
 				}
 			}
 		}
@@ -3216,8 +3222,8 @@ sub process {
 				my $newindent = $2;
 
 				my $goodtabindent = $oldindent .
-					"\t" x ($pos / 8) .
-					" "  x ($pos % 8);
+					"\t" x ($pos / $tabsize) .
+					" "  x ($pos % $tabsize);
 				my $goodspaceindent = $oldindent . " "  x $pos;
 
 				if ($newindent ne $goodtabindent &&
@@ -3688,11 +3694,11 @@ sub process {
 			#print "line<$line> prevline<$prevline> indent<$indent> sindent<$sindent> check<$check> continuation<$continuation> s<$s> cond_lines<$cond_lines> stat_real<$stat_real> stat<$stat>\n";
 
 			if ($check && $s ne '' &&
-			    (($sindent % 8) != 0 ||
+			    (($sindent % $tabsize) != 0 ||
 			     ($sindent < $indent) ||
 			     ($sindent == $indent &&
 			      ($s !~ /^\s*(?:\}|\{|else\b)/)) ||
-			     ($sindent > $indent + 8))) {
+			     ($sindent > $indent + $tabsize))) {
 				WARN("SUSPECT_CODE_INDENT",
 				     "suspect code indent for conditional statements ($indent, $sindent)\n" . $herecurr . "$stat_real\n");
 			}
-- 
2.21.0

