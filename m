Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C7BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FC52173B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 11:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XrNSkAXf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbfJGLZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 07:25:09 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50246 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfJGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 07:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=HDI4WAx6GIbiYKz//PoiNlF+oJVxk+1ziP15Z96D3lk=; b=XrNSkAXfZoEgbnsjEbN9k/uWP5
        LNy0ZeCpkfrej61ruXYgwn676U4i0QNQWzyGFT3RfOfS7riUYIIP8thSd1br93B9XCdJNrwEhbq5S
        w+16vLFEuHVdzdjHPo/LTf5c5BlwRPM9uykJ+BY5gNHlFGVA3lsfWyZTdSWdmbcNl/9tFLzudQxKf
        rTTBe3lvCeJYAsOfN22emQKiTL/1xMvMCJTk1UpOTLD5Ox0zMxtGN7Im+h8tzYQqTrMqMWkDAEbd2
        VSjGRGlM1+Lq07K5Ji5WbBYtfrsl2oI6Ad6rihlDt6CIAqpPhRPXMonJACvI176p5cOR41s/Kbp3s
        F/NH0p6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iHR6y-0003Gw-5C; Mon, 07 Oct 2019 11:23:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 594B73073C7;
        Mon,  7 Oct 2019 13:22:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0EDDA20244E26; Mon,  7 Oct 2019 13:23:27 +0200 (CEST)
Message-Id: <20191007090012.17501722.9@infradead.org>
User-Agent: quilt/0.65
Date:   Mon, 07 Oct 2019 10:44:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bristot@redhat.com,
        jbaron@akamai.com, torvalds@linux-foundation.org,
        tglx@linutronix.de, mingo@kernel.org, namit@vmware.com,
        hpa@zytor.com, luto@kernel.org, ard.biesheuvel@linaro.org,
        jpoimboe@redhat.com, hjl.tools@gmail.com
Subject: [RFC][PATCH 7/9] jump_label,objtool: Validate variable size jump labels
References: <20191007084443.79370128.1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since variable sized jump_label support is somewhat 'inspired', ensure
objtool validates the tricky bits. Specifically it is important that
the displacement for the 2 byte jump is limited to a single byte --
since this is the hardest part of the whole scheme and relies on
somewhat dodgy GAS tricks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>
---
 tools/objtool/check.c |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -817,8 +817,32 @@ static int handle_jump_alt(struct objtoo
 			   struct instruction *orig_insn,
 			   struct instruction **new_insn)
 {
-	if (orig_insn->type == INSN_NOP)
+	if ((orig_insn->len != 2) && (orig_insn->len != 5)) {
+		WARN_FUNC("jump_label: unsupported INSN length: %d",
+				orig_insn->sec, orig_insn->offset, orig_insn->len);
+		return -1;
+	}
+
+	if (orig_insn->type == INSN_NOP) {
+		long disp;
+
+		if (orig_insn->len == 2) {
+			if (special_alt->orig_sec != special_alt->new_sec) {
+				WARN_FUNC("jump_label: JMP8 crossing sections",
+						orig_insn->sec, orig_insn->offset);
+				return -1;
+			}
+
+			disp = special_alt->new_off - (special_alt->orig_off + 2);
+			if ((disp >> 31) != (disp >> 7)) {
+				WARN_FUNC("jump_label: JMP8 displacement not a byte",
+						orig_insn->sec, orig_insn->offset);
+				return -1;
+			}
+		}
+
 		return 0;
+	}
 
 	if (orig_insn->type != INSN_JUMP_UNCONDITIONAL) {
 		WARN_FUNC("unsupported instruction at jump label",


