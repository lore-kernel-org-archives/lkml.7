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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ADFC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D56A2173C
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 07:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFnXhuif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEIHVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 03:21:19 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38158 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726525AbfEIHVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 03:21:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id v11so1441215wru.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 00:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owEgLo/HcmCzShJRdQ87tV9B/UkMK9st7rnftaLXHhA=;
        b=ZFnXhuifD3P93A3YswTNqy26WNVcmwR47CC74gBYFa3On/syduZVP9NORmfuTbK2bh
         ebFOr5uNDPk2R+jIaOB/FJ9oNXbo0R0rZVnC0CWHjnM4zIY+oPARuuUUuzkefWo8YpX+
         KUaWZQwa27yjeWgbzIerxs5m2Bl2R76ih4xtvxiiU55QvPZxsb0ACyX951phFOTfxna5
         UnNtIfteP/VCD+AzQ7k8oKxAKRA1fvKJ/AiqXQKcd9esk+P2xS5cN+M0rJuPvLe7SQ3f
         SaBUrGYyCkc8SQK97dnsanSKYlqnKgYtDcW0S1qc2Fc7lJM7Wopf1ItFUbmeXLPlEPD4
         GB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=owEgLo/HcmCzShJRdQ87tV9B/UkMK9st7rnftaLXHhA=;
        b=m/Dxa4cxu0comKh8Si303tyApTySx+mT8FIu1pHYc0/4zmiG1BGWVJrSwZg6sZvsUS
         f31NiB1GMX9zA+TJHI0u+/dtwaKb/N9UTtSGqAZpOsH4m2ut6W7RnK9m43U1yQ77RVeg
         5sUNXw9qCzovzhKuEv3aCcQ81iqGrVG/t7/3tRZX5z/tIcQ4T12ozeyLtidRNbq2BxFw
         L2PFFt0VSJKc19tZPzy1mlDtQHjmx/v2OZJ9feA7OYLgRFIzWqSbwZmp6QZodKprGQIw
         Lo/8UV4TtJ8ibzeYEXQ+p6FgDSIHb3Lyfp4+h5cAwcL+xL52KAOLbi4WkoC/10+V/Ha0
         klyA==
X-Gm-Message-State: APjAAAWDYB9P096j133OxKZAaXC1V48fVOKWa9Q/e1yCqyjL8Olwb+4o
        1RdhutFjf+xhBVffnWbCwQw=
X-Google-Smtp-Source: APXvYqyq/mLovs7TqPawx0IlYAl/xDLwTuPSgQ4VOpuJJ5ZFkDTCCIPeddTRvQAR9mYAlbp6uhyvOA==
X-Received: by 2002:adf:ec51:: with SMTP id w17mr1767999wrn.326.1557386476248;
        Thu, 09 May 2019 00:21:16 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-657-1-239-64.w80-14.abo.wanadoo.fr. [80.14.206.64])
        by smtp.gmail.com with ESMTPSA id x18sm1208632wrw.14.2019.05.09.00.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 00:21:15 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v4] checkpatch: add command-line option for TAB size
Date:   Thu,  9 May 2019 09:21:04 +0200
Message-Id: <20190509072104.18734-1-borneo.antonio@gmail.com>
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
---
 scripts/checkpatch.pl | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 916a3fbd4d47..216f2c8db7aa 100755
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
@@ -265,6 +268,8 @@ if ($color =~ /^[01]$/) {
 	die "Invalid color mode: $color\n";
 }
 
+die "Invalid TAB size: $tabsize\n" if ($tabsize <= 0);
+
 sub hash_save_array_words {
 	my ($hashRef, $arrayRef) = @_;
 
@@ -1211,7 +1216,7 @@ sub expand_tabs {
 		if ($c eq "\t") {
 			$res .= ' ';
 			$n++;
-			for (; ($n % 8) != 0; $n++) {
+			for (; ($n % $tabsize) != 0; $n++) {
 				$res .= ' ';
 			}
 			next;
@@ -2224,7 +2229,7 @@ sub string_find_replace {
 sub tabify {
 	my ($leading) = @_;
 
-	my $source_indent = 8;
+	my $source_indent = $tabsize;
 	my $max_spaces_before_tab = $source_indent - 1;
 	my $spaces_to_tab = " " x $source_indent;
 
@@ -3153,7 +3158,7 @@ sub process {
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
 # at the beginning of a line any tabs must come first and anything
-# more than 8 must use tabs.
+# more than $tabsize must use tabs.
 		if ($rawline =~ /^\+\s* \t\s*\S/ ||
 		    $rawline =~ /^\+\s*        \s*/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
@@ -3172,7 +3177,7 @@ sub process {
 				"please, no space before tabs\n" . $herevet) &&
 			    $fix) {
 				while ($fixed[$fixlinenr] =~
-					   s/(^\+.*) {8,8}\t/$1\t\t/) {}
+					   s/(^\+.*) {$tabsize,$tabsize}\t/$1\t\t/) {}
 				while ($fixed[$fixlinenr] =~
 					   s/(^\+.*) +\t/$1\t/) {}
 			}
@@ -3194,11 +3199,11 @@ sub process {
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
@@ -3216,8 +3221,8 @@ sub process {
 				my $newindent = $2;
 
 				my $goodtabindent = $oldindent .
-					"\t" x ($pos / 8) .
-					" "  x ($pos % 8);
+					"\t" x ($pos / $tabsize) .
+					" "  x ($pos % $tabsize);
 				my $goodspaceindent = $oldindent . " "  x $pos;
 
 				if ($newindent ne $goodtabindent &&
@@ -3688,11 +3693,11 @@ sub process {
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

