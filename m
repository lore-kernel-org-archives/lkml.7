Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21096C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1B9020882
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 15:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPtk0fOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387446AbfIVPDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 11:03:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33800 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729089AbfIVPDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 11:03:42 -0400
Received: by mail-lf1-f68.google.com with SMTP id r22so8211081lfm.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//yhO9YShfBboqEeYtnHpLNW0sjYFlBd1DBOZAf6ZMo=;
        b=lPtk0fOb3hEIvdkQnGRXg7FDSJ+82hQroxY0q39ANwS7ua5/lCtb+8+lkfcxC1rwNY
         Yg3lay9o3vk6BHjkB2eoJ49IMOm69kAsEcY8C4wDlim66erQ2DMu9kuYBkhVS6TSWbRp
         29w99xbe83yqegN/U0H70IgrnH6PQEXL79EtmavEeoK+i9YTL9/xolsSUHSsjrUvqE1x
         465yVUp3CFTq303W0DTysrvwmUJLo+EsIvtY7dvkiaTnGmc72epOuTiulbD9VKYrcM2t
         Z4FfBb8ywM0TPRQ62r81f5dTV+nnPXgAEdCRanmNMe62NxzLnQb/VOuGFn7+b9j8XQmQ
         3QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//yhO9YShfBboqEeYtnHpLNW0sjYFlBd1DBOZAf6ZMo=;
        b=WmP3js2UyNzOb/zUWi5bPTHT9qDZOlXa0LJEX+BcPjfbUMTpQBtigfZqNVQM9va483
         p5r2OCowrEcWsQmvO7wKAzuJGftATks+4DasVxP0m2crLPjS1DvZ7CzDUw9502ulvdWb
         5YCXZFE1O1LjguGMTqCqKypZmp8Wu3en/nObzpmK7Ctdzlbl8atB7nDrI6X5ZkctxpBx
         FZzPh1n5D26h8OE6wW/0Wedf4FblC8jwYG9S5c1oqByH1Sz7+G34JVOvUkIihp1R/aeV
         MTHFr5+dATmt5nQr0IRDOJsV0WIxeDbuG4QposM1OWFVqjZP+5fontT7RJ52KH/my3mn
         YDQA==
X-Gm-Message-State: APjAAAXmKe8L2cQ6tEd5KJo1iS2AEJRUKbQ96y7RvN5sbyQb59b9N7Sb
        hE0pBKDThhR126h99+7TFQtJCJ7WFM0=
X-Google-Smtp-Source: APXvYqwlVZznU5PXwYxaPEiFTjZg/Zqbe/WoB69ERAcBk3UfNmyN12eh8kjPjeCkoxTsfzD0QpWulQ==
X-Received: by 2002:a19:f111:: with SMTP id p17mr14289342lfh.187.1569164620514;
        Sun, 22 Sep 2019 08:03:40 -0700 (PDT)
Received: from pc-sasha.localdomain ([95.47.123.158])
        by smtp.gmail.com with ESMTPSA id e29sm1696477ljb.105.2019.09.22.08.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 08:03:37 -0700 (PDT)
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, Alexander Kapshuk <alexander.kapshuk@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH RESEND] gen-insn-attr-x86.awk: Fix regexp warnings
Date:   Sun, 22 Sep 2019 18:03:28 +0300
Message-Id: <20190922150328.6722-1-alexander.kapshuk@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190922083342.GO13569@xsang-OptiPlex-9020>
References: <20190922083342.GO13569@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the regexp warnings shown below:
GEN      /home/sasha/torvalds/tools/objtool/arch/x86/lib/inat-tables.c
awk: ../arch/x86/tools/gen-insn-attr-x86.awk:260: warning: regexp escape sequence `\:' is not a known regexp operator
awk: ../arch/x86/tools/gen-insn-attr-x86.awk:350: (FILENAME=../arch/x86/lib/x86-opcode-map.txt FNR=41) warning: regexp escape sequence `\&' is not a known regexp operator

The ':' and '&' characters need not escaping when used in string constants
as part of regular expressions.

[Test-run]
awk -f arch/x86/tools/gen-insn-attr-x86.awk \
	arch/x86/lib/x86-opcode-map.txt >../tmp/inat-tables.c

diff arch/x86/lib/inat-tables.c ~/tmp/inat-tables.c; echo $?
0

awk -f tools/arch/x86/tools/gen-insn-attr-x86.awk \
	tools/arch/x86/lib/x86-opcode-map.txt >../tmp/inat-tables.c

diff tools/objtool/arch/x86/lib/inat-tables.c ~/tmp/inat-tables.c; echo $?
0

[Debugging output]
DBG:ext:(66&F2)
DBG:match(ext, ...):(66&F2)
DBG:match(..., lprefix3_expr):\((F2|!F3|66&F2)\)

Signed-off-by: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
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

