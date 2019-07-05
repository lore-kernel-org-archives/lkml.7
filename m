Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6592C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D715216E3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 03:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfGEDQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 23:16:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54229 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726404AbfGEDQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 23:16:35 -0400
X-UUID: 9cd6be45711545b1b7e865ae69250a74-20190705
X-UUID: 9cd6be45711545b1b7e865ae69250a74-20190705
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1322901554; Fri, 05 Jul 2019 11:16:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 5 Jul 2019 11:16:27 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 5 Jul 2019 11:16:27 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        "Yingjoe Chen" <yingjoe.chen@mediatek.com>
Subject: [PATCH v3] checkpatch: add several Kconfig default value tests
Date:   Fri, 5 Jul 2019 11:16:26 +0800
Message-ID: <20190705031626.13859-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds 3 Kconfig default value tests.

1. discourage default n cases:
e.g.,
default n

2. discourage default "[ynm]" cases:
e.g.,
arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
arch/powerpc/Kconfig:   default "y" if PPC_POWERNV
arch/powerpc/Kconfig:   default "n"
drivers/auxdisplay/Kconfig:     default "n"
drivers/crypto/Kconfig: default "m"
drivers/rapidio/devices/Kconfig:        default "n"

3. discourage default EXPERT or default !EXPERT cases:
e.g.,
drivers/hid/Kconfig:    default !EXPERT

tested cases:
default m
default n if ALPHA_EV5 || ALPHA_EV56 || (ALPHA_EV4 && !ALPHA_LCA)
default y if ALPHA_QEMU
default n if PPC_POWERNV
default n
default EXPERT
default !EXPERT
default "m"
default "n"
default "y" if EXPERT
default "y" if PPC_POWERNV

test result:
WARNING: 'default n' is the default value, no need to write it explicitly
+       default n

WARNING: Avoid using default EXPERT
+       default EXPERT

WARNING: Avoid using default EXPERT
+       default !EXPERT

WARNING: Use 'default m' not 'default "m"'
+       default "m"

WARNING: Use 'default n' not 'default "n"'
+       default "n"

WARNING: Use 'default y' not 'default "y"'
+       default "y" if EXPERT

WARNING: Use 'default y' not 'default "y"'
+       default "y" if PPC_POWERNV

test --fix capability:
default n => delete line
default "m" => default m
default "n" => default n
default "y" if EXPERT => default y if EXPERT
default "y" if PPC_POWERNV => default y if PPC_POWERNV
default !EXPERT => no change
default EXPERT => no change

Change since v1:
discourage default n$
discourage default "[ynm]"
discourage default \!?EXPERT

Change since v2:
(Joe has provided the whole patch and I just post it)
test Kconfig in a single block
print precise message such as 'default "m"', not 'default "[ynm]"'
provide --fix capability

Cc: Joe Perches <joe@perches.com>
Cc: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 scripts/checkpatch.pl | 139 ++++++++++++++++++++++++++----------------
 1 file changed, 85 insertions(+), 54 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 342c7c781ba5..94799f23339c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2932,60 +2932,98 @@ sub process {
 				      "Do not include the paragraph about writing to the Free Software Foundation's mailing address from the sample GPL notice. The FSF has changed addresses in the past, and may do so again. Linux already includes a copy of the GPL.\n" . $herevet)
 		}
 
-# check for Kconfig help text having a real description
-# Only applies when adding the entry originally, after that we do not have
-# sufficient context to determine whether it is indeed long enough.
-		if ($realfile =~ /Kconfig/ &&
-		    # 'choice' is usually the last thing on the line (though
-		    # Kconfig supports named choices), so use a word boundary
-		    # (\b) rather than a whitespace character (\s)
-		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
-			my $length = 0;
-			my $cnt = $realcnt;
-			my $ln = $linenr + 1;
-			my $f;
-			my $is_start = 0;
-			my $is_end = 0;
-			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
-				$f = $lines[$ln - 1];
-				$cnt-- if ($lines[$ln - 1] !~ /^-/);
-				$is_end = $lines[$ln - 1] =~ /^\+/;
-
-				next if ($f =~ /^-/);
-				last if (!$file && $f =~ /^\@\@/);
-
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
-					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
-					if ($lines[$ln - 1] =~ "---help---") {
-						WARN("CONFIG_DESCRIPTION",
-						     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
+# Kconfig tests
+		if ($realfile =~ /Kconfig/) {
+			# check for Kconfig help text having a real description
+			# Only applies when adding the entry originally, after
+			# that we do not have sufficient context to determine
+			# whether it is indeed long enough.
+			# 'choice' is usually the last thing on the line (though
+			# Kconfig supports named choices), so use a word
+			# boundary (\b) rather than a whitespace character (\s)
+			if ($line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
+				my $length = 0;
+				my $cnt = $realcnt;
+				my $ln = $linenr + 1;
+				my $f;
+				my $is_start = 0;
+				my $is_end = 0;
+				for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
+					$f = $lines[$ln - 1];
+					$cnt-- if ($lines[$ln - 1] !~ /^-/);
+					$is_end = $lines[$ln - 1] =~ /^\+/;
+
+					next if ($f =~ /^-/);
+					last if (!$file && $f =~ /^\@\@/);
+
+					if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|prompt)\s*["']/) {
+						$is_start = 1;
+					} elsif ($lines[$ln - 1] =~ /^\+\s*(?:help|---help---)\s*$/) {
+						if ($lines[$ln - 1] =~ "---help---") {
+							WARN("CONFIG_DESCRIPTION",
+							     "prefer 'help' over '---help---' for new help texts\n" . $herecurr);
+						}
+						$length = -1;
+					}
+
+					$f =~ s/^.//;
+					$f =~ s/#.*//;
+					$f =~ s/^\s+//;
+					next if ($f =~ /^$/);
+
+					# This only checks context lines in the patch
+					# and so hopefully shouldn't trigger false
+					# positives, even though some of these are
+					# common words in help texts
+					if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
+							   if|endif|menu|endmenu|source)\b/x) {
+						$is_end = 1;
+						last;
 					}
-					$length = -1;
+					$length++;
+				}
+				if ($is_start && $is_end && $length < $min_conf_desc_length) {
+					WARN("CONFIG_DESCRIPTION",
+					     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
 				}
+				#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
+			}
 
-				$f =~ s/^.//;
-				$f =~ s/#.*//;
-				$f =~ s/^\s+//;
-				next if ($f =~ /^$/);
-
-				# This only checks context lines in the patch
-				# and so hopefully shouldn't trigger false
-				# positives, even though some of these are
-				# common words in help texts
-				if ($f =~ /^\s*(?:config|menuconfig|choice|endchoice|
-						  if|endif|menu|endmenu|source)\b/x) {
-					$is_end = 1;
-					last;
+# discourage the use of boolean for type definition attributes
+			if ($line =~ /^\+\s*\bboolean\b/) {
+				if (WARN("CONFIG_TYPE_BOOLEAN",
+					 "Use of boolean is deprecated, please use bool instead\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\bboolean\b/bool/;
+				}
+			}
+
+# Kconfig: discourage redundant 'default n'
+			if ($line =~ /^\+\s*default\s+n$/) {
+				if (WARN("CONFIG_DEFAULT_VALUE_STYLE",
+					 "'default n' is the default value, no need to write it explicitly\n" . $herecurr) &&
+				    $fix) {
+					fix_delete_line($fixlinenr, $rawline);
 				}
-				$length++;
 			}
-			if ($is_start && $is_end && $length < $min_conf_desc_length) {
-				WARN("CONFIG_DESCRIPTION",
-				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
+
+# Kconfig: discourage quoted defaults: use default [ynm], not default "[ynm]"
+			if ($rawline =~ /^\+\s*default\s+"([ynm])"/) {
+				if (WARN("CONFIG_DEFAULT_VALUE_STYLE",
+					 "Use 'default $1' not 'default \"$1\"'\n" . $herecurr) &&
+				    $fix) {
+					$fixed[$fixlinenr] =~ s/\b(default\s+)"(.)"/$1$2/;
+				}
+			}
+
+# Kconfig: discourage using default EXPERT or !EXPERT
+			if ($line =~ /^\+\s*default\s+\!?\s*EXPERT\b/) {
+				WARN("CONFIG_DEFAULT_VALUE_STYLE",
+				     "Avoid using default EXPERT\n" . $herecurr);
 			}
-			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
+# End of Kconfig tests
+
 
 # check for MAINTAINERS entries that don't have the right form
 		if ($realfile =~ /^MAINTAINERS$/ &&
@@ -2998,13 +3036,6 @@ sub process {
 			}
 		}
 
-# discourage the use of boolean for type definition attributes of Kconfig options
-		if ($realfile =~ /Kconfig/ &&
-		    $line =~ /^\+\s*\bboolean\b/) {
-			WARN("CONFIG_TYPE_BOOLEAN",
-			     "Use of boolean is deprecated, please use bool instead.\n" . $herecurr);
-		}
-
 		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
 		    ($line =~ /\+(EXTRA_[A-Z]+FLAGS).*/)) {
 			my $flag = $1;
-- 
2.18.0

