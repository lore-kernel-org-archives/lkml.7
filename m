Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD69C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FE320820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="YRAwfDAW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbfDITcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:32:19 -0400
Received: from mail.efficios.com ([167.114.142.138]:49560 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDITcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:32:18 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 375841D32AE;
        Tue,  9 Apr 2019 15:32:17 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id b5o0xCtcQ29c; Tue,  9 Apr 2019 15:32:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id BB8FE1D32A6;
        Tue,  9 Apr 2019 15:32:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BB8FE1D32A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554838336;
        bh=RIC/P5A/Z0g1MEWs57Icu43/KtRHSKBbQigvsK7pRVc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=YRAwfDAWQqikCdX2ZxAa9R3CP3BuevqRyv9ai3VxmHUz8MvLfpV3lGvNzNeWAtYh1
         PdzGlg7rKEimJo8AM2nh0h5sfXxkasatDCCiqE2TnEYbTpfArRhuWaNhHBKq7JWG/1
         sYKVBmipPNciCcBHCm6wFzlH65bTuPnCHey4/X3VEMy80s5cKn6wmCr9NrIv8pIasU
         wGPp4vhusidPGCMg4BS9Fc0hS/pnu2j0plRCL/594XmJA4O5L1M0339luXQKiS2BRH
         t2VFtusW05YVQGVGVLDVNpK9RRFM5b5QsRq/KGNaOCLuIXsLxeKq6qLbOzGUASQQhA
         VzxB7kUD/okSA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Hebn4mgG_Tem; Tue,  9 Apr 2019 15:32:16 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9A4041D329E;
        Tue,  9 Apr 2019 15:32:16 -0400 (EDT)
Date:   Tue, 9 Apr 2019 15:32:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Carlos O'Donell <carlos@redhat.com>, x86@kernel.org
Message-ID: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com>
Subject: rseq/x86: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Index: p8pmmV5FDxK+Lim3zGdIPg86Ryyj/Q==
Thread-Topic: rseq/x86: choosing rseq code signature
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We are about to include the code signature required prior to restartable
sequences abort handlers into glibc, which will make this ABI choice final.
We need architecture maintainer input on that signature value.

That code signature is placed before each abort handler, so the kernel can
validate that it is indeed jumping to an abort handler (and not some
arbitrary attacker-chosen code). The signature is never executed.

Currently, tools/testing/selftests/rseq/rseq-x86.h defines RSEQ_SIG
as 0x53053053, and uses it as an immediate operand to the following
instruction opcodes (as suggested by Andy Lutomirski):

x86-32:
- .byte 0x0f, 0x1f, 0x05: nopl <sig>

x86-64:
- .byte 0x0f, 0x1f, 0x05: nopl <sig>(%rip)

The current discussion thread on the glibc mailing list leads us towards
using a trap with uncommon immediate operand, which simplifies integration
with disassemblers, emulators, makes it easier to debug if the control
flow gets redirected there by mistake, and is nicer for some architecture's
speculative execution.

The main advantage of choosing a trap instruction over a no-op is to ensure the
program traps if the execution flow gets redirected to the signature by mistake
(makes it easier to debug). It's not a hard requirement, but it would be a bonus.

Are there trap instructions that take an uncommon 4-byte immediate
operand you would recommend on x86 32/64 ? Or is the current choice of
nopl confirmed to be right one ?

Here is an example of rseq signature definition template:

/*
 * TODO: document trap instruction objdump output on each sub-architecture
 * instruction sets, as well as instruction set extensions.
 */
#define RSEQ_SIG 0x########

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
