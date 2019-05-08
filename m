Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D72EC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06537205C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inaYL9Os"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfEHSgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:36:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45326 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbfEHSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:36:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so28468238wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q07F+dOokgazOKXPszZFLZD4kp165U7xyfXyaLUOkSA=;
        b=inaYL9Os3r1Yrb27FgF/4ogVqeHSlreLQBW0Zn+51brNgds85LoPi0eHF53pv3LmFM
         rf2GJihU3XGrSlCnI3C1iqZ6UlkQvVNsmwNn2gfWqsR5hMCDUEKmLn9r6m+/XLp3nF+u
         vluOBhO5zj791UwGo1KkMZBmPwt3exnxRI+kf07IKtOb8RsDL4eSqwy3O+v5dSgwuO6u
         PpgmMBFqtqqVHo3PfJqw8FpDHkG4C1fxzFit88QrI3uHhFs0zqPZF/VYk5LSoPlHAai/
         w+idyVAGMj2pn4o0+CPOXJJF9VKh6T8dL04bMYcQn+EXKmXk31gwsgSfAccCwz/5blWz
         Lwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q07F+dOokgazOKXPszZFLZD4kp165U7xyfXyaLUOkSA=;
        b=b5huyRRQxUWa+wecbEh93+zVf2fJPWiRvWh6jmjZ39e23iu12zULMfGUaeGAfHK9H+
         ikdn4YUV0VvPWNvaT/vlI5q9bj7fc9VPzYZ4OnQ7HoW5pnqzEDOfFrmUrC75cDMOPKFe
         2ooE/I6iNHR8/CN5XJoIu3rDi/Ze12q1lq2KKDMR8SU1ftyA3NP6i9y1ymuWKMYDUKnT
         J1ROaI5x/NNmtt10Gpt7RzrasEEsXXi3UHssSzhexq5xXIJi5kh4YVtbpPGDuHdS5E1x
         Z8yDb1Vn410IHQXzMjTtJsO7mVKfSjO3IFdKY+t0Gj06t2qpyooHjUjMnBU4Pz39hQtp
         fWAA==
X-Gm-Message-State: APjAAAUYtC8ORv9C+nSbA8oW0SnFlNfMpWkaF+wjl3mlJpZBnwGG21cW
        QYHvCR3xcZpuEkrUUCaTOo//WiwTxwI=
X-Google-Smtp-Source: APXvYqx48We9EV8yJ6onk3HWCgBmhAGQGUuRKaXu+tEHSIT5r0D0lqR24CRE+Mzj/Vkzk3O9Ro2wCQ==
X-Received: by 2002:adf:f108:: with SMTP id r8mr18457898wro.221.1557340579252;
        Wed, 08 May 2019 11:36:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:edb8:72e0:1074:1d8f:2a88:25e6])
        by smtp.gmail.com with ESMTPSA id s8sm7719813wrm.26.2019.05.08.11.36.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:36:18 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: add command-line option for TAB size
Date:   Wed,  8 May 2019 20:36:06 +0200
Message-Id: <20190508183606.14767-1-borneo.antonio@gmail.com>
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

 scripts/checkpatch.pl | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 916a3fbd4d47..90f641bf1895 100755
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
@@ -1211,7 +1214,7 @@ sub expand_tabs {
 		if ($c eq "\t") {
 			$res .= ' ';
 			$n++;
-			for (; ($n % 8) != 0; $n++) {
+			for (; ($n % $tabsize) != 0; $n++) {
 				$res .= ' ';
 			}
 			next;
@@ -2224,7 +2227,7 @@ sub string_find_replace {
 sub tabify {
 	my ($leading) = @_;
 
-	my $source_indent = 8;
+	my $source_indent = $tabsize;
 	my $max_spaces_before_tab = $source_indent - 1;
 	my $spaces_to_tab = " " x $source_indent;
 
@@ -3153,7 +3156,7 @@ sub process {
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
 # at the beginning of a line any tabs must come first and anything
-# more than 8 must use tabs.
+# more than $tabsize must use tabs.
 		if ($rawline =~ /^\+\s* \t\s*\S/ ||
 		    $rawline =~ /^\+\s*        \s*/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
@@ -3172,7 +3175,7 @@ sub process {
 				"please, no space before tabs\n" . $herevet) &&
 			    $fix) {
 				while ($fixed[$fixlinenr] =~
-					   s/(^\+.*) {8,8}\t/$1\t\t/) {}
+					   s/(^\+.*) {$tabsize,$tabsize}\t/$1\t\t/) {}
 				while ($fixed[$fixlinenr] =~
 					   s/(^\+.*) +\t/$1\t/) {}
 			}
@@ -3194,11 +3197,11 @@ sub process {
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
@@ -3216,8 +3219,8 @@ sub process {
 				my $newindent = $2;
 
 				my $goodtabindent = $oldindent .
-					"\t" x ($pos / 8) .
-					" "  x ($pos % 8);
+					"\t" x ($pos / $tabsize) .
+					" "  x ($pos % $tabsize);
 				my $goodspaceindent = $oldindent . " "  x $pos;
 
 				if ($newindent ne $goodtabindent &&
@@ -3688,11 +3691,11 @@ sub process {
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

