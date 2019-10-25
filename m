Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A17C47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09747222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439097AbfJYLNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:13:48 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:50482 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408808AbfJYLNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:13:47 -0400
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id HnDl2101D5USYZQ01nDl2x; Fri, 25 Oct 2019 13:13:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNxSN-0003rD-QR; Fri, 25 Oct 2019 13:08:35 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iNvnV-0006E0-TV; Fri, 25 Oct 2019 11:22:17 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] scripts/dtc: dtx_diff - add color output support
Date:   Fri, 25 Oct 2019 11:22:15 +0200
Message-Id: <20191025092215.23887-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new -c/--color options, to enhance the diff output with color, and
improve the user's experience.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Frank Rowand <frank.rowand@sony.com>
Tested-by: Frank Rowand <frank.rowand@sony.com>
---
v3:
  - Add Reviewed-by, Tested-by,

v2:
  - Document that -c/--color requires a diff command with color support,
  - Ignore -c/--color if diff command lacks color support.
---
 scripts/dtc/dtx_diff | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/scripts/dtc/dtx_diff b/scripts/dtc/dtx_diff
index e9ad7834a22d9459..d3422ee15e300bc7 100755
--- a/scripts/dtc/dtx_diff
+++ b/scripts/dtc/dtx_diff
@@ -20,6 +20,8 @@ Usage:
 
 
       --annotate    synonym for -T
+      --color       synonym for -c (requires diff with --color support)
+       -c           enable colored output
        -f           print full dts in diff (--unified=99999)
        -h           synonym for --help
        -help        synonym for --help
@@ -178,6 +180,7 @@ compile_to_dts() {
 annotate=""
 cmd_diff=0
 diff_flags="-u"
+diff_color=""
 dtx_file_1=""
 dtx_file_2=""
 dtc_sort="-s"
@@ -189,6 +192,13 @@ while [ $# -gt 0 ] ; do
 
 	case $1 in
 
+	-c | --color )
+		if diff --color /dev/null /dev/null 2>/dev/null ; then
+			diff_color="--color=always"
+		fi
+		shift
+		;;
+
 	-f )
 		diff_flags="--unified=999999"
 		shift
@@ -344,7 +354,7 @@ DTC="\
 
 if (( ${cmd_diff} )) ; then
 
-	diff ${diff_flags} --label "${dtx_file_1}" --label "${dtx_file_2}" \
+	diff ${diff_flags} ${diff_color} --label "${dtx_file_1}" --label "${dtx_file_2}" \
 		<(compile_to_dts "${dtx_file_1}" "${dtx_path_1_dtc_include}") \
 		<(compile_to_dts "${dtx_file_2}" "${dtx_path_2_dtc_include}")
 
-- 
2.17.1

