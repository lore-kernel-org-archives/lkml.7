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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9B0C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AA121734
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 17:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhNFw54H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfEHRoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 13:44:10 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55872 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfEHRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 13:44:10 -0400
Received: by mail-wm1-f67.google.com with SMTP id y2so4317498wmi.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0j60MRyF2dLgfUzyzUN9NoPILGI+oOjVImbhhCX4xc=;
        b=fhNFw54HXvQX4vFN3n1foypXf8vS03tUTbZlDr9mrGHrQL1+kqARgvMGiVxS8qEp8J
         p/EebwkgXinmVA5GdCKm2SAiZBZ5x8Fi1KAuNEIkBMkaMh0/w5Rx1rjJfHPok6M1ha0R
         0BLZYSUzKm4wHIldsoieJijpxThRjDQG9L3T/bjzyzyVaLbGA3wYT+1GVaqdKPRYHmxN
         2n4gq1VYgvpLknJVJcufho6JED/6aOdX1QS3TJ6HpE0GrfyVgBqHP43Y+sziQegu0lDf
         58NbLgpbsi2kLbYWVtU4H0AKL0YyvOwTnOUYTn7dRJPgi//34fKLmxmFdVj4z2XgV6bn
         5kDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0j60MRyF2dLgfUzyzUN9NoPILGI+oOjVImbhhCX4xc=;
        b=HX+AMiLPvIQ2Hn9ij4fALJo8xSgQdw3cj65EDwoosAhzI3RIevm3QFtJEuq+TgaGLp
         A84LIvzaLME8oHO0ymqgJJwUc5faX9tSfdPCRDpTTVkHXn0YBtJzMfY7tZPdK9T95TU4
         bmaocr0YQ7a64FjFKavsthN3/acVzVPrE+cI/IPD6nAylLQbOuegB6l3o4xCzXxOCj4d
         mwju1k+SzV/iJcdCP87+Zk9qKIaPrdgZmFWcZlIkTX23aV+AVFtBvB+hAOpO7HxRAuRY
         nuoGnFEwkL3L6d1MM1X8YL+W1VFoLgi576DCBM32BmRQU/7zWjOk38uvY4gl9nROH5dw
         I/HA==
X-Gm-Message-State: APjAAAXUMwAbpYjXgGb+pymyULUCKowUATvYhqmnftR5JaEzFi7b2Oqk
        dC8eEvb07ZkDaNM6RtPQZFk=
X-Google-Smtp-Source: APXvYqwB7dRv1066OqGReDohRz/UhCvyrWzh7ruVNl/JwnTTJdE7LCk5WSjdupIed8Q/j6vU8BUpzg==
X-Received: by 2002:a1c:494:: with SMTP id 142mr2933265wme.115.1557337447803;
        Wed, 08 May 2019 10:44:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:edb8:72e0:1074:1d8f:2a88:25e6])
        by smtp.gmail.com with ESMTPSA id v5sm24006004wra.83.2019.05.08.10.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 10:44:07 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] checkpatch: add command-line option for TAB size
Date:   Wed,  8 May 2019 19:43:56 +0200
Message-Id: <20190508174356.13952-1-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The size of 8 characters used for both TAB and indentation is
embedded as magic value allover the checkpatch script, and this
makes the script less readable.

Replace the magic value 8 with a variable.
From the context of the code it's clear if it is used for
indentation or tabulation, so no need to use two separate
variables.

Add a command-line option "--tab-size" to let the user select a
TAB size value other than 8.
This makes easy to reuse this script by other projects with
different requirements in their coding style (e.g. OpenOCD [1]
requires TAB size of 4 characters [2]).

[1] http://openocd.org/
[2] http://openocd.org/doc/doxygen/html/stylec.html#styleformat

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Signed-off-by: Erik Ahlén <erik.ahlen@avalonenterprise.com>
Signed-off-by: Spencer Oliver <spen@spen-soft.co.uk>
---
V1 -> V2
	add the command line option

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

