Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE54AC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 04:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E94D207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 04:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRcTkDjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407735AbfIXErO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 00:47:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42148 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394439AbfIXErO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 00:47:14 -0400
Received: by mail-lj1-f196.google.com with SMTP id y23so420176lje.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 21:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q2XadshqjbJ2rA412+I3YJ2cFnRkZxM8gf+AHI3iIDs=;
        b=qRcTkDjcJ30tgUtRQBp5fxoy4gJPuuojf5ifHaprlU5iW1dPqAgzBSdxnPjPbrEatM
         7SxejX2A/JZFr583KuzC3h5aU39fLtQeWiqVjvxSiGXncJRJNygcMqi97NNzbQTo8VHR
         5fTrJg1eb9RpjrKz6MrqJXyQ8Pih2qExotpzberjbbaJEyFuYxOzxBzj9tvAXQ1QU8W0
         /YkoJPkDj0H5qVW/pouNdsQnxfr05UrZWVN7oRDknotPOs1giXcyli3F5D5czncrNTcn
         LGBu9F3MFZYxQS31sXFVojpp3MjCv1j/i/HAZdDuJdEObcpcL6PVE4A1qc0wDczMA1ir
         U5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q2XadshqjbJ2rA412+I3YJ2cFnRkZxM8gf+AHI3iIDs=;
        b=HREbkdiigz85oKH/+EOGGrYLtojMc4k1681ormmRDiOdKAQGW5m6joVql+U9BjeQLm
         X4W1HmV83p2/zpCZOKCPwCjfubNuP+OSakeuB6EWKUa0roFoYn8rTQxxm+wQYsubetFe
         34rhnxTgHqhgyOzVV6f3YaMhZkLacgLV0zA4sJ6A/uTsLUj5M2sPNwbYEow9nhCIq3p2
         N7ssVL3/BagXDHxr8R8Pn9PJ+m9ekRzu+8eKwom9zmJ1mE/uzv3gpEVGgg3noRrxemez
         TdChIfg9Xehx6H+jPokuilJySg8Mo+NpJV2LecsytkimGWHOQfridFhtcIFToSvi2hJb
         Fdfg==
X-Gm-Message-State: APjAAAX36dFgs20Mq9Ja8fTgjo++JlxwuoxVN2IvbM+JpXEK3NZt8vxH
        MVetmhmhZ5566eyLKNwAOaedpXBwCuY=
X-Google-Smtp-Source: APXvYqzCEqh+V/Onrbr1zWZBopYQW7p4tZ9I/3SEuky/dCbxR69NGxAmEAGDqLx7DHPj8k7g/yvRRA==
X-Received: by 2002:a05:651c:154:: with SMTP id c20mr536478ljd.83.1569300430744;
        Mon, 23 Sep 2019 21:47:10 -0700 (PDT)
Received: from pc-sasha.localdomain ([95.47.123.158])
        by smtp.gmail.com with ESMTPSA id v1sm139762lji.89.2019.09.23.21.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 21:47:09 -0700 (PDT)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, mhiramat@kernel.org,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH RESEND] gen-insn-attr-x86.awk: Fix regexp warnings
Date:   Tue, 24 Sep 2019 07:46:59 +0300
Message-Id: <20190924044659.3785-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190923114904.dd63949b3433376aeb4b7789@kernel.org>
References: <20190923114904.dd63949b3433376aeb4b7789@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gawk 5.0.1 generates the regexp warnings shown below:
GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator

Ealier versions of gawk are not known to generate these warnings.

The gawk manual referenced below does not list characters ':' and '&'
as needing escaping, so 'unescape' them.
https://www.gnu.org/software/gawk/manual/html_node/Escape-Sequences.html

Running diff on the output generated by the script before and after
applying the patch reported no differences.

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Borislav Petkov <bp@alien8.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/tools/gen-insn-attr-x86.awk       | 4 ++--
 tools/arch/x86/tools/gen-insn-attr-x86.awk | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/tools/arch/x86/tools/gen-insn-attr-x86.awk b/tools/arch/x86/tools/gen-insn-attr-x86.awk
index b02a36b2c14f..a42015b305f4 100644
--- a/tools/arch/x86/tools/gen-insn-attr-x86.awk
+++ b/tools/arch/x86/tools/gen-insn-attr-x86.awk
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
2.23.0

