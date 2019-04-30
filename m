Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22497C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E341821655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 02:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="eU1yWPlM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfD3CSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 22:18:11 -0400
Received: from sonic310-15.consmr.mail.bf2.yahoo.com ([74.6.135.125]:33146
        "EHLO sonic310-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729803AbfD3CSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 22:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1556590689; bh=SCSrSmM/sHgaTX95LJ49xOTr5scF0jHGsiziNDjBYAY=; h=From:To:Cc:Subject:Date:From:Subject; b=eU1yWPlMHlJxRSQX+h3/FfCahBL2/pByInrwc9S0Jvgplm0qQAZVGN/2a+K/X6kUHJxG6zQereG7C5YBphdJECpELtIPJFMxBrlnhHGGF8qeCOgxwdDU8i/SFEO7RWz69j2OzvtVw9jA0v3WsV3Dw21yEN/Mc5o9jDXoK4O1SY7IMHFvT3Z0u/pFm57SO7xRE+b+Rzm1H4rWvr9gAp+1Xmn2Bd/IrBRt/1nvyMH9UIwKNrm90JjPnewBymxdryhoY674nOeE723v+xolV+pub42K42vvcrTRYkCNyrRY/9GyYE6fdT4HWav4hgnSw4uArbGQZd/45ofKCtdydYM8FA==
X-YMail-OSG: KZvyNc0VM1lvIbJ8sc2x9JkYde8nKdgVnM0yOC7EgulMR6tMEvMMviaAZu_XxKz
 j8wb3aC9.Kr2FSHOd5hmi010AAWdy2RNotnm4Aqcv7TZro3q1_Y0cLAP8qTRHX0oXNgpRgAZcvjg
 1MwgKQFPVenrLRStHlyPxJzSTMM4J.rWpyR.us3fbzTV1k7EXHpfHXHW7SB3EhsNL8ih1mxoiWp3
 2X5nn__AxozhxBPddY16kTkrB4xZnzgp55LZjuqYBwUfHwlLRirvAHQ_u8zifAXHB_qbVdDFeKZm
 Zc2sMfnZneGQpBXOnQ2Xjprk3tGoLokEX_MvBYG3XcCZ0i4pEVe4TOmKNddcAPLUZ4leZkPWZeZR
 n9PnGpo0.Xe11Wrckc2GpirO0mNTp3yjkgRdJhsyzRpcWjZE.faE4WyUbK49sfFgHZh0nm.9RdBj
 h0by1STu_I3CMgbV9PPEy9ygaj2SXpKipKR6RyP07uLwhTtpdUs6308mKKNf43ft0zMn7yZV0rJt
 gmXjQMqTUofouxJaZUrl21T9JnQgTBdlKINh39KY6d3G64.0zlKSPUxh9kJHx0dGRglllzHE0r0s
 u7ngf2GBxQ3MnVEUMfsVwDYpmu08Z.JjFD_AMUdzV7XkpI4xOUYYX5NosUFgaBqhkRVpHaxrGXJm
 5KzWS89uX0U5xm2DFnx.z4ffF4TDNp12FfjEzd044ydoIpub81dejdYAvbrAETPDW.DrSO_Z08PQ
 q4dwkEb0e3qK5DuKMZvfzfo7ta6UNxUplBWBx9Gpz1XSExmSSytugQ.4jKPECY1BsDBd8o1HjmLL
 SWIhl4Q46UmicPyp6fqzhibmxzEjzaKoX46UITnVW4FmlQOVtg3LLJtusqHb9YKDji61TJvWIHSV
 1jF4mKQkRvfxI1SD9ZX7uww_HAHQFSFi66dtxDrfcVbhkoyozteOkxFYOfDgK6lvtlXZt1kdVe2S
 wJFFZjBnH.n8sBEY.bRNPTdzuxSJlbV52RXrEjeTAe8eDZa33xf79RvctY0gF0tz0NUFuuOsT1ut
 g3rUCz6O6.8oZmgh3UKns3Ec6HaY_t9NxOmfM4lQQJ20qAy8ptwg6OBerddH7V9bHSyLZYZx730L
 pGOEivZ3baahPu2Q4tl6SbJDLyFyiP.u6oHIu0bfecyYWSzhoD_N9GVueRxnyqWr75Wk0yNE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Tue, 30 Apr 2019 02:18:09 +0000
Received: from pink.alxu.ca (EHLO localhost.localdomain) ([198.98.62.56])
          by smtp425.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8219803eb22854fb0d87c6d2884d9645;
          Tue, 30 Apr 2019 02:18:04 +0000 (UTC)
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, jpoimboe@redhat.com, peterz@infradead.org,
        hpa@zytor.com, masami.hiramatsu.pt@hitachi.com,
        ben-linux@fluff.org, adrian.hunter@intel.com,
        "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: [PATCH] treewide: fix awk regexp over-escaping
Date:   Mon, 29 Apr 2019 22:17:13 -0400
Message-Id: <20190430021713.664490-1-alex_y_xu@yahoo.ca>
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

