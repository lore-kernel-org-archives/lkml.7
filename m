Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57207C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189FC2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 20:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GZIlWj+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfDIUnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:43:45 -0400
Received: from mail.efficios.com ([167.114.142.138]:55508 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfDIUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 16:43:45 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 92D837D6B5;
        Tue,  9 Apr 2019 16:43:43 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 7KuMRDMaFv2W; Tue,  9 Apr 2019 16:43:43 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 166D97D6A8;
        Tue,  9 Apr 2019 16:43:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 166D97D6A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554842623;
        bh=rpljNT4W03Re1hwIRD5UA8RXQeJsMbdUOXrWL26XfWc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GZIlWj+Fjejq5UsSqSSpfNqadXVBDPLnqEOHyxdlUpi2Ky8+2aUl5KhjPzAG15Xqr
         3CRfhgFzRZ9gv/hYnCXF5s8CDJivGSMvY4hbMSMwV2OphyV+64QWjHJJMYkOM+9n6T
         mhtT54nU9uKAbAx9LJCeMsTZC/ceyjHrPC5rLwLMB+9A/NdjtJz9+j/YLX/0jtgAli
         NP5HeQf7CUVkTrVVur4lrLVmyVjAU4vXEpbaoxJ697TTqILKBtRu/uRVQAGX/6eSWQ
         2q4Q77G4vC6O+3OvuTRGf7nsNiMLyC2pPFJKdXMdkVhsos2WSaY1cxRHiMnkcxe3iA
         U8zZShhOPQFeQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id RRClCNAf68XO; Tue,  9 Apr 2019 16:43:42 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id EDDD57D6A0;
        Tue,  9 Apr 2019 16:43:42 -0400 (EDT)
Date:   Tue, 9 Apr 2019 16:43:42 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Carlos O'Donell <carlos@redhat.com>, x86 <x86@kernel.org>
Message-ID: <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com>
In-Reply-To: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com>
References: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com>
Subject: Re: rseq/x86: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/x86: choosing rseq code signature
Thread-Index: p8pmmV5FDxK+Lim3zGdIPg86Ryyj/a0NjlXh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 9, 2019, at 3:32 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi,
> 
> We are about to include the code signature required prior to restartable
> sequences abort handlers into glibc, which will make this ABI choice final.
> We need architecture maintainer input on that signature value.
> 
> That code signature is placed before each abort handler, so the kernel can
> validate that it is indeed jumping to an abort handler (and not some
> arbitrary attacker-chosen code). The signature is never executed.
> 
> Currently, tools/testing/selftests/rseq/rseq-x86.h defines RSEQ_SIG
> as 0x53053053, and uses it as an immediate operand to the following
> instruction opcodes (as suggested by Andy Lutomirski):
> 
> x86-32:
> - .byte 0x0f, 0x1f, 0x05: nopl <sig>
> 
> x86-64:
> - .byte 0x0f, 0x1f, 0x05: nopl <sig>(%rip)
> 
> The current discussion thread on the glibc mailing list leads us towards
> using a trap with uncommon immediate operand, which simplifies integration
> with disassemblers, emulators, makes it easier to debug if the control
> flow gets redirected there by mistake, and is nicer for some architecture's
> speculative execution.
> 
> The main advantage of choosing a trap instruction over a no-op is to ensure the
> program traps if the execution flow gets redirected to the signature by mistake
> (makes it easier to debug). It's not a hard requirement, but it would be a
> bonus.
> 
> Are there trap instructions that take an uncommon 4-byte immediate
> operand you would recommend on x86 32/64 ? Or is the current choice of
> nopl confirmed to be right one ?
> 
> Here is an example of rseq signature definition template:
> 
> /*
> * TODO: document trap instruction objdump output on each sub-architecture
> * instruction sets, as well as instruction set extensions.
> */
> #define RSEQ_SIG 0x########

Peter Zijlstra suggested to use "invlpg" in user-space, which should generate
a trap. The only concern would be emulators, but ideally they would not try to
decode an instruction that is never executed. This would lead to the following
patch. Any objections/ack ?


diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 2d4887b5d3f0..e9c8a9879e18 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -7,6 +7,11 @@
 
 #include <stdint.h>
 
+/*
+ * RSEQ_SIG is used with the following privileged instructions, which trap in user-space:
+ * x86-32:    0f 01 3d 53 30 05 53      invlpg 0x53053053
+ * x86-64:    0f 01 3d 53 30 05 53      invlpg 0x53053053(%rip)
+ */
 #define RSEQ_SIG       0x53053053
 
 #ifdef __x86_64__
@@ -78,8 +83,8 @@ do {                                                                  \
 
 #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)            \
                ".pushsection __rseq_failure, \"ax\"\n\t"               \
-               /* Disassembler-friendly signature: nopl <sig>(%rip). */\
-               ".byte 0x0f, 0x1f, 0x05\n\t"                            \
+               /* Disassembler-friendly signature: invlpg <sig>(%rip). */\
+               ".byte 0x0f, 0x01, 0x3d\n\t"                            \
                ".long " __rseq_str(RSEQ_SIG) "\n\t"                    \
                __rseq_str(label) ":\n\t"                               \
                teardown                                                \
@@ -605,8 +610,8 @@ do {                                                                        \
 
 #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)            \
                ".pushsection __rseq_failure, \"ax\"\n\t"               \
-               /* Disassembler-friendly signature: nopl <sig>. */      \
-               ".byte 0x0f, 0x1f, 0x05\n\t"                            \
+               /* Disassembler-friendly signature: invlpg <sig>. */    \
+               ".byte 0x0f, 0x1f, 0x3d\n\t"                            \
                ".long " __rseq_str(RSEQ_SIG) "\n\t"                    \
                __rseq_str(label) ":\n\t"                               \
                teardown                                                \


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
