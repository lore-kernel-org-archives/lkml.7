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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150B3C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9F021744
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 12:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UompOFt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfEHM1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 08:27:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37387 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfEHM1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 08:27:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id y5so3028458wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sNjqukul5u7HGksqG2zRf3b9B+HWdlpjwZ8F3uXYtMk=;
        b=UompOFt4jFZuue0a6Pd4JJGnhksRvGJpysjG3VONr6phJZs/eX80CmvcqIck30xoDX
         jjc0Zk+1lZwfBmZddBuuqOsb/KvDxD2sAKFZEOTtV2JNb9qjEvt29Hmha45O+aHUYcWf
         /FWp23bODd+AiisI4Xn35ItlvcgI5QZS5+QDz4x7q8BJgGQhOQm2wq8PR/r6br56T6ik
         Sn+4RjksEOjN9nffopWr+bLcQIVfBGJMiTsy9EevMm4CtGx2LzSmlsUsdcPO7ZVnPslW
         qevuIZof3Fo9WUHVTXpIsK/NYN/0gtrZk1uEOGOBxeUbGco+o6r6MVLhglemNXwoLFzb
         bFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sNjqukul5u7HGksqG2zRf3b9B+HWdlpjwZ8F3uXYtMk=;
        b=l4HcEb4xtbQsOJZevjK5S4L2r2fcQgT2aN1LewD2ch7rQN0MoagCMiGT45fFgd+gF0
         2P4s6eLWgO4kXxMNBVuUWI6jm5Yvq1HtOJkW8JQ310vWY0m7hGCwseRl2/rEKQRqIiXm
         6dipLb7/vjpA17gcFLQN0sGFN5ji091VO51upAe4FuZRiioVyvJ1US2J3BgtRWReRced
         pbsA+6v+aFwLxvAuXuaVEW+7a/o5CyFyeB3ZAJB4i4Ui57tCxmbhxJ47ZlSwvGams67k
         RH9hYxRTvJ/Sc6sO544Obh2hxKsEi8g9hujcW/ye9eKPj0ZeGT2RR/mZNkigMEg7rLIi
         KUFQ==
X-Gm-Message-State: APjAAAXUJpmkkGrpR2bzyo3l5dBPiLEm9qPD9G0T/Yk99k8Cf+F6mV3W
        Ai2ovhqINb+vcn1s4KGpgSQ=
X-Google-Smtp-Source: APXvYqw0Kn6dZXFt2WpLMKd3HmtY609WO7VzQJL73mK/kWvI3eIESwr/7INMWKvmC/bvRV0ant+q/g==
X-Received: by 2002:a1c:7518:: with SMTP id o24mr2897048wmc.42.1557318458700;
        Wed, 08 May 2019 05:27:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e34:edb8:72e0:1074:1d8f:2a88:25e6])
        by smtp.gmail.com with ESMTPSA id s124sm3217737wmf.42.2019.05.08.05.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 05:27:37 -0700 (PDT)
From:   Antonio Borneo <borneo.antonio@gmail.com>
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] checkpatch: replace magic value for TAB size
Date:   Wed,  8 May 2019 14:27:21 +0200
Message-Id: <20190508122721.7513-4-borneo.antonio@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508122721.7513-1-borneo.antonio@gmail.com>
References: <20190508122721.7513-1-borneo.antonio@gmail.com>
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

Replace the magic value 8 with the perl variable "$tabsize".
From the context of the code it's clear if it is used for
indentation or tabulation, so no need to use two separate
variables.

As side benefit of this change, it makes easy to replace the TAB
size when this script is used by other projects with different
requirements in their coding style (e.g. OpenOCD [1] requires
TAB size of 4 characters [2]).
In these cases the script will be probably modified and adapted,
so there is no need (at least for the moment) to expose this
setting on the script's command line.

[1] http://openocd.org/
[2] http://openocd.org/doc/doxygen/html/stylec.html#styleformat

Signed-off-by: Antonio Borneo <borneo.antonio@gmail.com>
Signed-off-by: Erik Ahlén <erik.ahlen@avalonenterprise.com>
Signed-off-by: Spencer Oliver <spen@spen-soft.co.uk>
---
 scripts/checkpatch.pl | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 373ad345f732..3c8115600516 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -62,6 +62,7 @@ my $conststructsfile = "$D/const_structs.checkpatch";
 my $typedefsfile = "";
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
+my $tabsize = 8;
 
 sub help {
 	my ($exitcode) = @_;
@@ -1211,7 +1212,7 @@ sub expand_tabs {
 		if ($c eq "\t") {
 			$res .= ' ';
 			$n++;
-			for (; ($n % 8) != 0; $n++) {
+			for (; ($n % $tabsize) != 0; $n++) {
 				$res .= ' ';
 			}
 			next;
@@ -2224,7 +2225,7 @@ sub string_find_replace {
 sub tabify {
 	my ($leading) = @_;
 
-	my $source_indent = 8;
+	my $source_indent = $tabsize;
 	my $max_spaces_before_tab = $source_indent - 1;
 	my $spaces_to_tab = " " x $source_indent;
 
@@ -3153,7 +3154,7 @@ sub process {
 		next if ($realfile !~ /\.(h|c|pl|dtsi|dts)$/);
 
 # at the beginning of a line any tabs must come first and anything
-# more than 8 must use tabs.
+# more than $tabsize must use tabs.
 		if ($rawline =~ /^\+\s* \t\s*\S/ ||
 		    $rawline =~ /^\+\s*        \s*/) {
 			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
@@ -3172,7 +3173,7 @@ sub process {
 				"please, no space before tabs\n" . $herevet) &&
 			    $fix) {
 				while ($fixed[$fixlinenr] =~
-					   s/(^\+.*) {8,8}\t/$1\t\t/) {}
+					   s/(^\+.*) {$tabsize,$tabsize}\t/$1\t\t/) {}
 				while ($fixed[$fixlinenr] =~
 					   s/(^\+.*) +\t/$1\t/) {}
 			}
@@ -3194,11 +3195,11 @@ sub process {
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
@@ -3216,8 +3217,8 @@ sub process {
 				my $newindent = $2;
 
 				my $goodtabindent = $oldindent .
-					"\t" x ($pos / 8) .
-					" "  x ($pos % 8);
+					"\t" x ($pos / $tabsize) .
+					" "  x ($pos % $tabsize);
 				my $goodspaceindent = $oldindent . " "  x $pos;
 
 				if ($newindent ne $goodtabindent &&
@@ -3688,11 +3689,11 @@ sub process {
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

