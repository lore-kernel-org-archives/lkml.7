Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7990CC352AA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4910D22468
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l0IJTO3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfJGLXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:23:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfJGLXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JoihTJodSVi9WJBQTnnYkKBZbxE0NJTW8x9hUl9C9hM=; b=l0IJTO3GnhSDKYuxnVDiEmIvbs
        qn7/PpCYbhut5Lhyu0XETj1waXMijQLhpm6GmazJU6RUkXUE5xDa4CVCSKISqei/A3FyAfdVQUGP/
        G45ju0HQpiEXlMbaZxr1dcTXYEu7+hOYQDJub10CopJyuFzvgksIgk9GAtjcKmUNdUfxuJNnX3L0d
        IN+bzV78daGvZS6z4QFWxUv1j1R/p4KGs3hVxZrAJd8R6nR/W0QfE6e5KbDsBrAlufm3rjmthJBye
        MQQP5iNQTU08+b8c0zr/LobpYTDfJjYqdBOV5MaPtDarvXvZPHJtJn7PO/8R44DhqS8s/kEyZF9Hl
        Me0Tfwsg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003H9-LA; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D3473073D1;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 14B3F20245760; Mon,  7 Oct 2019 13:23:27 +0200 (CEST)
Message-Id: <20191007090012.23157697.0@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 8/9] jump_label,objtool: Generate possible statistics
References: <20191007084443.79370128.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	x86_64-defconfig	x86_64-allmodconfig-UBSAN-KASAN

NOP2	1641			21796
JMP8	48			114

NOP5	1010			31042
JMP32	29			91

Which results in a possible 3*(1641+48) ~ 5k saving for defconfig
and 3*(21796+114) ~ 64k saving for allmodconfig.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>
---
 tools/objtool/check.c |   43 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -817,6 +817,8 @@ static int handle_jump_alt(struct objtoo
 			   struct instruction *orig_insn,
 			   struct instruction **new_insn)
 {
+	long disp;
+
 	if ((orig_insn->len != 2) && (orig_insn->len != 5)) {
 		WARN_FUNC("jump_label: unsupported INSN length: %d",
 				orig_insn->sec, orig_insn->offset, orig_insn->len);
@@ -824,9 +826,12 @@ static int handle_jump_alt(struct objtoo
 	}
 
 	if (orig_insn->type == INSN_NOP) {
-		long disp;
 
-		if (orig_insn->len == 2) {
+		switch (orig_insn->len) {
+		case 2:
+			WARN_FUNC("jump_label: NOP2 present",
+					orig_insn->sec, orig_insn->offset);
+
 			if (special_alt->orig_sec != special_alt->new_sec) {
 				WARN_FUNC("jump_label: JMP8 crossing sections",
 						orig_insn->sec, orig_insn->offset);
@@ -839,6 +844,20 @@ static int handle_jump_alt(struct objtoo
 						orig_insn->sec, orig_insn->offset);
 				return -1;
 			}
+			break;
+
+		case 5:
+			if (special_alt->orig_sec == special_alt->new_sec) {
+				disp = special_alt->new_off - (special_alt->orig_off + 2);
+				if ((disp>>31) == (disp>>7)) {
+					WARN_FUNC("jump_label: NOP2 possible",
+							orig_insn->sec, orig_insn->offset);
+					break;
+				}
+			}
+			WARN_FUNC("jump_label: NOP5 present",
+					orig_insn->sec, orig_insn->offset);
+			break;
 		}
 
 		return 0;
@@ -850,6 +869,26 @@ static int handle_jump_alt(struct objtoo
 		return -1;
 	}
 
+	switch (orig_insn->len) {
+	case 2:
+		WARN_FUNC("jump_label: JMP8 present",
+				orig_insn->sec, orig_insn->offset);
+		break;
+
+	case 5:
+		if (special_alt->orig_sec == special_alt->new_sec) {
+			disp = special_alt->new_off - (special_alt->orig_off + 2);
+			if ((disp>>31) == (disp>>7)) {
+				WARN_FUNC("jump_label: JMP8 possible",
+						orig_insn->sec, orig_insn->offset);
+				break;
+			}
+		}
+		WARN_FUNC("jump_label: JMP32 present",
+				orig_insn->sec, orig_insn->offset);
+		break;
+	}
+
 	*new_insn = list_next_entry(orig_insn, list);
 	return 0;
 }


