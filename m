Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35DEC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D35B2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 19:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FHQCAPmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfDITcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 15:32:23 -0400
Received: from mail.efficios.com ([167.114.142.138]:49592 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfDITcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 15:32:21 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 6476C1D32D8;
        Tue,  9 Apr 2019 15:32:20 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 79BBmovTSlrn; Tue,  9 Apr 2019 15:32:20 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 24A8C1D32D0;
        Tue,  9 Apr 2019 15:32:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 24A8C1D32D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554838340;
        bh=kIN9MrbIG6csDhz8Dt9rOKAIp2X1+m6j+Dj2PzDB9TI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FHQCAPmbowu9sRS1Tf/GBnY6nM/blkQYobLj2NclFGqAuw/W5t1fmaMj2qCUYgRBH
         bGJVAa9sA3bSjtoDX0dNI3sCaB4x/zByUg5KTd8dy1gEosjTmJqfT+W1QgFzdDC6ps
         uzFxnFuHmd3B8hCOgLM7JTzRSnEVjl13LDOBliFtIwtvRiW5fs/zsdck/wBP466E2B
         /hCwAmYkbagyW7zF7NqrxFyRBSRDeHjqU6uC1PFr1kt18s/tlH8Eb5I/xe51z1NOVO
         JBH0y+J1uPYsXB25V4Eti4+4W/7HWpEnAm6/ikz4bTQrsRucVwZvpl1fG1+ZXDVJEl
         Ip4IWTHU8qitA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id z9PNttRSc8K0; Tue,  9 Apr 2019 15:32:20 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 080881D32C5;
        Tue,  9 Apr 2019 15:32:20 -0400 (EDT)
Date:   Tue, 9 Apr 2019 15:32:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Carlos O'Donell <carlos@redhat.com>
Message-ID: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
Subject: rseq/arm32: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Index: lqjgiUr5F3kvBEqSpepP+LTQoQudsQ==
Thread-Topic: rseq/arm32: choosing rseq code signature
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

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
instruction set within the same process (e.g. thumb for arm), we need to take
into account to which instruction the chosen signature value would map (and
possibly decide if we need to extend rseq to support many signatures).

Here is an example of rseq signature definition template:

/*
 * TODO: document trap instruction objdump output on each sub-architecture
 * instruction sets, as well as instruction set extensions.
 */
#define RSEQ_SIG 0x########

Ideally we'd need a patch on top of the Linux kernel
tools/testing/selftests/rseq/rseq-arm.h file that updates
the signature value, so I can then pick it up for the glibc
patchset.

Thanks!

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
