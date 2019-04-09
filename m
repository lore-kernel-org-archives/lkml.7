Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9032C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7430620820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Q+Fk1gzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfDITc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:32:27 -0400
Received: from mail.efficios.com ([167.114.142.138]:49606 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfDITcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:32:24 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2E64E1D32ED;
        Tue,  9 Apr 2019 15:32:23 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id vUSNMqrH-hYw; Tue,  9 Apr 2019 15:32:22 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D8D9F1D32EA;
        Tue,  9 Apr 2019 15:32:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D8D9F1D32EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554838342;
        bh=RgIdMsNYziUUgB3yzbunxiCN3VtyEeBtcNKkrJl49l4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Q+Fk1gzmWprLvC67Ap78hQObBTPczaRtLbtMTIMkYcfKeNg76aTZr1tO73DLqxz26
         fmCgoIgK/FHh21et5Ot02xZciVt1uJhRX5jyoy5qM2ZLA5UjmqjWGLH11jsb49ZHw3
         4+NxHEmUHfGa5pz89HAjvVoiQ9RpFveJKsw3YBjBfQvkrzHh/xR0vqQzLQjOqrJjMz
         R8pd0SGIVvoHqM5N+GxKr3DLyEgshtveCZTVDXM1ue+vuQ4nnIiu0NEehPO09FyG3n
         cT3hHZ3g/lho2fjaYi1xsAIKywRAqQUAp3b5NevLc4rt2AaU1KGaG03BQL87B2Q0Af
         ucEh5DnujWl5g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7OrR7bAUYm1Y; Tue,  9 Apr 2019 15:32:22 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B91E81D32DE;
        Tue,  9 Apr 2019 15:32:22 -0400 (EDT)
Date:   Tue, 9 Apr 2019 15:32:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     heiko carstens <heiko.carstens@de.ibm.com>,
        schwidefsky <schwidefsky@de.ibm.com>, gor <gor@linux.ibm.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Carlos O'Donell <carlos@redhat.com>
Message-ID: <1779981820.2626.1554838342731.JavaMail.zimbra@efficios.com>
Subject: rseq/s390: choosing code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Index: rw0yh+TLA/QoEMPFAX3xNuasWSgKdA==
Thread-Topic: rseq/s390: choosing code signature
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

The current discussion thread on the glibc mailing list leads us towards
using a trap with uncommon immediate operand, which simplifies integration
with disassemblers, emulators, makes it easier to debug if the control
flow gets redirected there by mistake, and is nicer for some architecture's
speculative execution.

We can have different signatures for each sub-architecture, as long as they
don't have to co-exist within the same process. We can special-case with
#ifdef for each sub-architecture and endianness if need be. If the architecture
has instruction set extensions that can co-exist with the architecture
instruction set within the same process, we need to take into account to which
instruction the chosen signature value would map (and possibly decide if we
need to extend rseq to support many signatures).

Here is an example of rseq signature definition template:

/*
 * TODO: document trap instruction objdump output on each sub-architecture
 * instruction sets, as well as instruction set extensions.
 */
#define RSEQ_SIG 0x########

Ideally we'd need a patch on top of the Linux kernel
tools/testing/selftests/rseq/rseq-s390.h file that updates
the signature value, so I can then pick it up for the glibc
patchset.

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
