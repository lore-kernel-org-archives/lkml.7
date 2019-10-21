Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EB8CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C9E2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571647689;
	bh=UKeT3hblqyq47ORy/hzb0QKk5IzzOWBpWK31Wsm0rSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E7eRouI4k3ec0Hi/u1hoLwOyYTo/CuLwyCA90wyYsuL+4588V9yVBrk9RE96VLibL
	 MjXNWRhDBq825/vVV07GFcRvKGyWGbFmf44L9nL8XIqIrTcDJvDmOsjPzg+g7ulvam
	 eU27VSNCql83h/bRlFjgwXabXItMMZNA/bHYQBRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfJUIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:48:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38054 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbfJUIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:48:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id 3so11856171wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KLmmSe30L+aODhM7WuVO8E/CQ0NyD3+ZyMeNHSXjuK0=;
        b=rdf47YftBU7zXq2Ioay8hQyGLkJgyAv39ctPr0tUioLU/CdUBgbKIlDOUvnwLqfZAj
         CLpS9A69dAlYAtU03jWyk8zHh9kqbGrAB+OR0ur0SatqZfIGwwKG09a6c+yrM8bWIhml
         olvVnuqJY1c+rr7eqceW4hmcP/gkKDbAc8pFVWoZMFkdu7wwUI9MBciLrSu9MU9LtR5u
         k5gdxdk9nfZ+exc2tqTJSi8liwSCI/lTe8M7PlTIcn6d8ozGLevC6sX+DE4XsXxiLI39
         BkB7JjF7D74i5wsq+nMox2xYDDBOB4dLfGNrzGCEOPgEu9nMJalCbzXXb688ajwsZGLb
         J+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KLmmSe30L+aODhM7WuVO8E/CQ0NyD3+ZyMeNHSXjuK0=;
        b=k0Qn8W63gGjY1i94QLPc5zWhAgRPWcMj2Eyb4+6kdkGtlSm8pwrbCLkUQSjMVkzIaO
         yr+o+MMbv3zPoaGZPQEjVG7DvH6v71fJLVwS+t9Yp0zBKokpHxjrULpxjet3uFg9s9+6
         4a9V8vSTCpsu6M67pf27kzOXHAqyrBCNT/g7sMLjA/Jsb43im3YgkzukUzzpVDE6/LQK
         wqAlif6/7LWKZfWM5WtB1kGjJpI/Ukw/shbaxMIHHYd7gsE04sRRE0d8oWxyqgSxa/CG
         kcXwOGycNH4fK4AR9/O6pOPIgcxymZOYKUC7luudIx8ERV0w2fYBskPP7alWYA9+CwTJ
         QycA==
X-Gm-Message-State: APjAAAVLX37fr6kSN2UCknB+QpUHR9jAmN0q8gxyg8i1kqX+zJ8EtLbn
        fvMK5Y2JnqfA5Vk5Mm3Sq90=
X-Google-Smtp-Source: APXvYqy5WqNzwEigipNzUjrMG0MzN8PvTaHV4NgrpbrkQ5IgAkpt2Q5AgCJnT2/BarFEl/X52aAItA==
X-Received: by 2002:a05:600c:2319:: with SMTP id 25mr14247789wmo.3.1571647685503;
        Mon, 21 Oct 2019 01:48:05 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 200sm3618351wme.32.2019.10.21.01.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 01:48:04 -0700 (PDT)
Date:   Mon, 21 Oct 2019 10:48:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 03/16] x86/alternatives,jump_label: Provide better
 text_poke() batching interface
Message-ID: <20191021084802.GA825@gmail.com>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.113249026@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018074634.113249026@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/arch/x86/kernel/jump_label.c
> +++ b/arch/x86/kernel/jump_label.c
> @@ -35,18 +35,19 @@ static void bug_at(unsigned char *ip, in
>  	BUG();
>  }
>  
> -static void __jump_label_set_jump_code(struct jump_entry *entry,
> -				       enum jump_label_type type,
> -				       union jump_code_union *code,
> -				       int init)
> +static const void *
> +__jump_label_set_jump_code(struct jump_entry *entry, enum jump_label_type type, int init)
>  {
> +	static union jump_code_union code; /* relies on text_mutex */
>  	const unsigned char default_nop[] = { STATIC_KEY_INIT_NOP };
>  	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
>  	const void *expect;
>  	int line;
>  
> -	code->jump = 0xe9;
> -	code->offset = jump_entry_target(entry) -
> +	lockdep_assert_held(&text_mutex);
> +
> +	code.jump = JMP32_INSN_OPCODE;
> +	code.offset = jump_entry_target(entry) -
>  		       (jump_entry_code(entry) + JUMP_LABEL_NOP_SIZE);
>  
>  	if (init) {
> @@ -54,23 +55,23 @@ static void __jump_label_set_jump_code(s
>  	} else if (type == JUMP_LABEL_JMP) {
>  		expect = ideal_nop; line = __LINE__;
>  	} else {
> -		expect = code->code; line = __LINE__;
> +		expect = code.code; line = __LINE__;

Side note: the whole 'line' logic looked weird to me and it obsfuscates 
the logic a bit, and I had to look it up to see what it's about: 
improving the debug output of text-patching crashes.

How about something like the below on top of your queue? We have %phD 
that can nicely print instructions in hex.

Totally untested though.

Thanks,

	Ingo

---
 arch/x86/kernel/jump_label.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

Index: tip/arch/x86/kernel/jump_label.c
===================================================================
--- tip.orig/arch/x86/kernel/jump_label.c
+++ tip/arch/x86/kernel/jump_label.c
@@ -16,14 +16,15 @@
 #include <asm/alternative.h>
 #include <asm/text-patching.h>
 
-static void bug_at(const void *ip, int line)
+static void bug_at(const void *ip, const void *op_expected, const void *op_unexpected)
 {
 	/*
 	 * The location is not an op that we were expecting.
 	 * Something went wrong. Crash the box, as something could be
 	 * corrupting the kernel.
 	 */
-	pr_crit("jump_label: Fatal kernel bug, unexpected op at %pS [%p] (%5ph) %d\n", ip, ip, ip, line);
+	pr_crit("jump_label: Fatal kernel bug, expected op (%*phD), unexpected op (%*phD) at %pS [%p] (%5ph\n",
+		JUMP_LABEL_NOP_SIZE, op_expected, JUMP_LABEL_NOP_SIZE, op_unexpected, ip, ip, ip);
 	BUG();
 }
 
@@ -34,23 +35,21 @@ __jump_label_set_jump_code(struct jump_e
 	const unsigned char *ideal_nop = ideal_nops[NOP_ATOMIC5];
 	const void *expect, *code;
 	const void *addr, *dest;
-	int line;
 
 	addr = (void *)jump_entry_code(entry);
 	dest = (void *)jump_entry_target(entry);
 
 	code = text_gen_insn(JMP32_INSN_OPCODE, addr, dest);
 
-	if (init) {
-		expect = default_nop; line = __LINE__;
-	} else if (type == JUMP_LABEL_JMP) {
-		expect = ideal_nop; line = __LINE__;
-	} else {
-		expect = code; line = __LINE__;
-	}
+	if (init)
+		expect = default_nop;
+	else if (type == JUMP_LABEL_JMP)
+		expect = ideal_nop;
+	else
+		expect = code;
 
 	if (memcmp(addr, expect, JUMP_LABEL_NOP_SIZE))
-		bug_at(addr, line);
+		bug_at(addr, expect, addr);
 
 	if (type == JUMP_LABEL_NOP)
 		code = ideal_nop;
