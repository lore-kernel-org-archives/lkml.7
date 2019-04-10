Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB1FC10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5528020850
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 20:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qwkrXTMM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfDJU3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 16:29:22 -0400
Received: from mail.efficios.com ([167.114.142.138]:35500 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfDJU3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 16:29:21 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 898471D540B;
        Wed, 10 Apr 2019 16:29:20 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 9SoFt2tLLfu3; Wed, 10 Apr 2019 16:29:20 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2B11F1D5402;
        Wed, 10 Apr 2019 16:29:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2B11F1D5402
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554928160;
        bh=SnPtn6Kglai7FPgDVxEngiNmEWyxw0Il9J+v8PyYSMs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qwkrXTMMTu771lCi/wNtsbqCZfQ0NZwIL9Wjqdf6x0EGp2slE23uFz/rlVqi8AEf3
         bGvsCAyOjqk+rzf8mlIiwAt8r/vwW0jICOszSU3bedobzHzrGWFmC71qocMXGuGKCt
         YwHRxJPd47imW4VyQMkbJrzhsFHMlQWL5+HUxpIrgiVZ5TAuPfekRhefghSNG2Acfk
         SDdNeSZFvXEWqoOrcAtH9wH9Sh8ftim4eX2woUWYCnMdlD320YBTemXCWcaLmMC71+
         cQ/EAKfsTq9UGofAW4rv16QOOOyFAtfT1VeCd9zgBTJldteBawMQl5VJ9vejl1oGru
         f6RhYmv2JQhxQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id U09vR1nmnf5f; Wed, 10 Apr 2019 16:29:20 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0C3391D53F6;
        Wed, 10 Apr 2019 16:29:20 -0400 (EDT)
Date:   Wed, 10 Apr 2019 16:29:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>
Message-ID: <1933578130.3292.1554928159928.JavaMail.zimbra@efficios.com>
In-Reply-To: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
Subject: Re: rseq/arm32: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/arm32: choosing rseq code signature
Thread-Index: lqjgiUr5F3kvBEqSpepP+LTQoQudsWBX8YP7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 9, 2019, at 3:32 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Hi Will,
> 
> We are about to include the code signature required prior to restartable
> sequences abort handlers into glibc, which will make this ABI choice final.
> We need architecture maintainer input on that signature value.
> 
> That code signature is placed before each abort handler, so the kernel can
> validate that it is indeed jumping to an abort handler (and not some
> arbitrary attacker-chosen code). The signature is never executed.
> 
> The current discussion thread on the glibc mailing list leads us towards
> using a trap with uncommon immediate operand, which simplifies integration
> with disassemblers, emulators, makes it easier to debug if the control
> flow gets redirected there by mistake, and is nicer for some architecture's
> speculative execution.
> 
> We can have different signatures for each sub-architecture, as long as they
> don't have to co-exist within the same process. We can special-case with
> #ifdef for each sub-architecture and endianness if need be. If the architecture
> has instruction set extensions that can co-exist with the architecture
> instruction set within the same process (e.g. thumb for arm), we need to take
> into account to which instruction the chosen signature value would map (and
> possibly decide if we need to extend rseq to support many signatures).
> 
> Here is an example of rseq signature definition template:
> 
> /*
> * TODO: document trap instruction objdump output on each sub-architecture
> * instruction sets, as well as instruction set extensions.
> */
> #define RSEQ_SIG 0x########
> 
> Ideally we'd need a patch on top of the Linux kernel
> tools/testing/selftests/rseq/rseq-arm.h file that updates
> the signature value, so I can then pick it up for the glibc
> patchset.

Would the following diff work for you ? If so, can I get your
acked-by ?

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 5f262c54364f..1f261ad2ac1b 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -5,7 +5,17 @@
  * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#define RSEQ_SIG       0x53053053
+/*
+ * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
+ * value 0x5305. This traps if user-space reaches this instruction by mistake,
+ * and the uncommon operand ensures the kernel does not move the instruction
+ * pointer to attacker-controlled code on rseq abort.
+ *
+ * The instruction pattern is:
+ *
+ * e7f530f5    udf    #21253    ; 0x5305
+ */
+#define RSEQ_SIG       0xe7f530f5
 
 #define rseq_smp_mb()  __asm__ __volatile__ ("dmb" ::: "memory", "cc")
 #define rseq_smp_rmb() __asm__ __volatile__ ("dmb" ::: "memory", "cc")
@@ -78,7 +88,8 @@ do {                                                                  \
                __rseq_str(table_label) ":\n\t"                         \
                ".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
                ".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
-               ".word " __rseq_str(RSEQ_SIG) "\n\t"                    \
+               ".arm\n\t"                                              \
+               ".inst " __rseq_str(RSEQ_SIG) "\n\t"                    \
                __rseq_str(label) ":\n\t"                               \
                teardown                                                \
                "b %l[" __rseq_str(abort_label) "]\n\t"


> 
> Thanks!
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
