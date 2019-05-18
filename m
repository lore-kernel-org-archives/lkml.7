Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82509C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48C9920873
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="g4YhRJwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfERTyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 15:54:01 -0400
Received: from sonic308-55.consmr.mail.gq1.yahoo.com ([98.137.68.31]:44586
        "EHLO sonic308-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbfERTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 15:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1558209239; bh=SCSrSmM/sHgaTX95LJ49xOTr5scF0jHGsiziNDjBYAY=; h=From:To:Cc:Subject:Date:From:Subject; b=g4YhRJwSOn8c/3ug+Vvwfh8bjVezFqtKOnPhb5wcICkdxof7By1s9FQcZ6SvbowQ/jQu30jKcWdSN/35DEfbaCGARDYlEIAIQoSXh7zmNSOPU1YwzGK78xC1cB8OWOqbX5XNrFS0MCKe92hgCpGfCrHPoB7MlCw0N7GKovf1MXiTYgLkW8zAR4JaPZznwFjj3KOv+sr1rhxImE8lffRHK0nbmG2x97q9mygFJa+WDDeIeoB2nTmm2I44/n5qO4ar8pNO8hdtvMoXdyNxQGnWHAA1c26MDYB+PDg+z3MK7B8w7uXlie7GeOsKh1giDUzu9+DdX/vDBbmJgvlDhJAHUQ==
X-YMail-OSG: DFAXVOgVM1nMpX5mXPzv9QJp4rV5lG6MyNc4QpbEMKRP.dDFdpePRvgoZtzsJtj
 pb4TE1XuNjy9XfmTd52NnTjJrJeuT5fUkVdZyn3ygBuH12MYSSzjkfcEQA4mnsJotBocJoVkbkir
 bEDzotvQ9UmIwRd7vMqhJRw2CoUQWQEOdB21uYd9oY9t3rPLbXYvMq0Kb9NvA5Fltg8c6PsFmnXR
 wmZ.PdHxv.Lb.RDA9v8iiWE9Uxp4pqSKjxx_VG0SecGpaFOWu1bsLhCwGL6NU_PuzPr8FoWwH_c7
 Ot8YO9XFXVaaxZpUpW0q.4LhEXESPKquTGzhKTWa8Jf.ucnl.F5yqngQr7GOJA.wuVZ3CU1JphBG
 wZ9mYvNysT7LFLIkQdrZ6yPCadovQcWXEvNVQeK98.bQWBSYIBB.nWp9yBPJ4fzIZDz.Cc55TxUj
 rBXoic9ZO_wfFOGFV_wYozHXbtD92uuDBHhjmG4vPasqHLDqQ9jpBXR9kxIgk90_y26vw21SsEwr
 Jyv4tcTzQ04OVFAgFw1jDYVCs3iTKCf4l.PW8iLyk1gZyZQvVXBf4pFt7D_QFCGM1JevkmI4p6Uy
 JtCpnjGXZiAGIj16o89ilD_m0lyeiQoKZpZo6a9quzqC9YTi_mAyBmbiYb5ZHreoRzdIq8MDSRjL
 xzIoht2.0soGyIr8pN._ZH84rxsMZuHIMXRUc68Pjo5TIzMJqnSFMbJECJwhxM4ZAkc0EAa.UcKr
 BaiVpLuKIdCmkykkBZQSoUmqkGRmJnaNOnRnL7qxXz9FLDgQhRtPcsy7ZNj6FaMmZv85R4Qs8Ijk
 SMXAgD.PLCX2hJrOr5xk0fkWWRqlNZGQ2_8HHkuCwJN1ovRL6TC3p9LnNkVjR2rFPQYQWGhGTgu6
 mrgSdY3B4f6DhlGqZSVI4tZe1mbU5cvICS0CvKqkAMTWSK3cLyLTHEw8z90hO4POORv5OOyJLWRx
 P6uUQYmDK7Sz6zvFaxDTPWrMtXSD8_i3CiqzqcKeLDKld9xNavqHeX0INs5djDX6khvxdRadSxyw
 lEJT2_rossEuBfSQtRdPFer5mv13SRZW2Sxw7RCR.hp3S5WaVqkxr10u4KOhpJEHZP5Omk7BvPdH
 Xhm9XN0E32iYumHozbt_8FDDik9dJTXMpYYfFfsZhhkeWy4xExKhByEg1CeKg74yj3jJghEe8_UW
 yogAyfdWr_4yDKkvILoMAw2wdpW1p_AfNkkWT_qVCQlcW7PveoFXPwQG3M7wYPDj4MDQ-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sat, 18 May 2019 19:53:59 +0000
Received: from CPE00fc8de26033-CM00fc8de26030.cpe.net.cable.rogers.com (EHLO localhost) ([99.228.156.240])
          by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7b7f3d1cc556625050b02a73e598946c;
          Sat, 18 May 2019 19:53:58 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, jpoimboe@redhat.com, peterz@infradead.org,
        hpa@zytor.com, masami.hiramatsu.pt@hitachi.com,
        ben-linux@fluff.org, adrian.hunter@intel.com,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] treewide: fix awk regexp over-escaping
Date:   Sat, 18 May 2019 15:53:52 -0400
Message-Id: <20190518195352.124018-1-alex_y_xu@yahoo.ca>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "warning: regexp escape sequence is not a known regexp operator" on
gawk 5.0.0.

Results found by:

- grepping '\\[^\[\\^$.|?*+()a-z]' on *.awk
- grepping 'awk.*\\[^\[\\^$.|?*+()a-z]'
- running awk --lint -f </dev/null >/dev/null on *.awk

Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
---
 Documentation/arm/Samsung/clksrc-change-registers.awk  | 2 +-
 arch/x86/tools/gen-insn-attr-x86.awk                   | 4 ++--
 lib/raid6/unroll.awk                                   | 2 +-
 tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk     | 4 ++--
 tools/perf/arch/x86/tests/gen-insn-x86-dat.awk         | 2 +-
 tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk | 4 ++--
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/arm/Samsung/clksrc-change-registers.awk b/Documentation/arm/Samsung/clksrc-change-registers.awk
index 7be1b8aa7cd9..d853f750c861 100755
--- a/Documentation/arm/Samsung/clksrc-change-registers.awk
+++ b/Documentation/arm/Samsung/clksrc-change-registers.awk
@@ -67,7 +67,7 @@ BEGIN {
 # to replace and create an associative array of values
 
     while (getline line < ARGV[1] > 0) {
-	if (line ~ /\#define.*_MASK/ &&
+	if (line ~ /#define.*_MASK/ &&
 	    !(line ~ /USB_SIG_MASK/)) {
 	    splitdefine(line, fields)
 	    name = fields[0]
diff --git a/arch/x86/tools/gen-insn-attr-x86.awk b/arch/x86/tools/gen-insn-attr-x86.awk
index b02a36b2c14f..a42015b305f4 100644
--- a/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/arch/x86/tools/gen-insn-attr-x86.awk
@@ -69,7 +69,7 @@ BEGIN {
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
-	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
+	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
 	lprefix_expr = "\\((66|F2|F3)\\)"
 	max_lprefix = 4
 
@@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 	return add_flags(imm, mod)
 }
 
-/^[0-9a-f]+\:/ {
+/^[0-9a-f]+:/ {
 	if (NR == 1)
 		next
 	# get index
diff --git a/lib/raid6/unroll.awk b/lib/raid6/unroll.awk
index c6aa03631df8..0809805a7e23 100644
--- a/lib/raid6/unroll.awk
+++ b/lib/raid6/unroll.awk
@@ -13,7 +13,7 @@ BEGIN {
 	for (i = 0; i < rep; ++i) {
 		tmp = $0
 		gsub(/\$\$/, i, tmp)
-		gsub(/\$\#/, n, tmp)
+		gsub(/\$#/, n, tmp)
 		gsub(/\$\*/, "$", tmp)
 		print tmp
 	}
diff --git a/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk b/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
index b02a36b2c14f..a42015b305f4 100644
--- a/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/objtool/arch/x86/tools/gen-insn-attr-x86.awk
@@ -69,7 +69,7 @@ BEGIN {
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
-	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
+	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
 	lprefix_expr = "\\((66|F2|F3)\\)"
 	max_lprefix = 4
 
@@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 	return add_flags(imm, mod)
 }
 
-/^[0-9a-f]+\:/ {
+/^[0-9a-f]+:/ {
 	if (NR == 1)
 		next
 	# get index
diff --git a/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk b/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk
index a21454835cd4..27585d032ee6 100644
--- a/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk
+++ b/tools/perf/arch/x86/tests/gen-insn-x86-dat.awk
@@ -31,7 +31,7 @@ BEGIN {
 	going = 0
 }
 
-/^\s*[0-9a-fA-F]+\:/ {
+/^\s*[0-9a-fA-F]+:/ {
 	if (going) {
 		colon_pos = index($0, ":")
 		useful_line = substr($0, colon_pos + 1)
diff --git a/tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk b/tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
index ddd5c4c21129..606ccd154392 100644
--- a/tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
+++ b/tools/perf/util/intel-pt-decoder/gen-insn-attr-x86.awk
@@ -69,7 +69,7 @@ BEGIN {
 
 	lprefix1_expr = "\\((66|!F3)\\)"
 	lprefix2_expr = "\\(F3\\)"
-	lprefix3_expr = "\\((F2|!F3|66\\&F2)\\)"
+	lprefix3_expr = "\\((F2|!F3|66&F2)\\)"
 	lprefix_expr = "\\((66|F2|F3)\\)"
 	max_lprefix = 4
 
@@ -257,7 +257,7 @@ function convert_operands(count,opnd,       i,j,imm,mod)
 	return add_flags(imm, mod)
 }
 
-/^[0-9a-f]+\:/ {
+/^[0-9a-f]+:/ {
 	if (NR == 1)
 		next
 	# get index
-- 
2.21.0

