Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5886C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82FDC20675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cvnaPEL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfCEUSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:18:37 -0500
Received: from mail.efficios.com ([167.114.142.138]:42788 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfCEUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:18:37 -0500
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CF01EA5338;
        Tue,  5 Mar 2019 15:18:35 -0500 (EST)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id GkS-2GDmZnT6; Tue,  5 Mar 2019 15:18:35 -0500 (EST)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 49884A5332;
        Tue,  5 Mar 2019 15:18:35 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 49884A5332
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1551817115;
        bh=BfIHl0qE6lNio2wLWkAv3tmhEEysKq5YuSTSg3+tDAc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cvnaPEL6VrQDSRt7TkSLqgQgGlodBXIFmj+Jidlw1K/IStvbIjqa3NcPlFb4BBhV1
         SCJjdU8DbuyCOclf1N3y2VYKH9FQKRw46TZdkeZ6dxq6ZN5IqtkYAzh2d5qWyZxhSh
         x+64CYgdt6EkLoOz4/pOd7UaN5mxHEkwyAz/Tj/9EMzPPo4DhtK7DKiXjbiiL2Gcwa
         z5xAp7Qj4K2ZprRwGtEgkQVZlbtEEGk8PMmYhTSMAvCaQQMRlPdJmzcLfN3pY4Mr7o
         kQySSMF085tr2NhKZS5Rh1bRTec5VHtuavdBHSNLuKz3Wu7SVPcw7zNU8ggdyn7Lbj
         E3rsKcWMeH9UA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id vhYEV-bl9se0; Tue,  5 Mar 2019 15:18:35 -0500 (EST)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 2ECEEA5327;
        Tue,  5 Mar 2019 15:18:35 -0500 (EST)
Date:   Tue, 5 Mar 2019 15:18:35 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Message-ID: <1689743723.311.1551817115045.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH for 5.1 0/3] Restartable Sequences updates for 5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.11_GA_3780 (ZimbraWebClient - FF65 (Linux)/8.8.11_GA_3780)
Thread-Topic: Restartable Sequences updates for 5.1
Thread-Index: WL6w4Ap2pvRT2yF5Hn4NTT5x4je3yQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 5, 2019, at 2:47 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Those changes aiming at 5.1 include one comment cleanup, the removal of
> the rseq_len field from the task struct which serves no purpose
> considering that the struct size is fixed by the ABI, and a selftest
> improvement adapting the number of threads to the number of detected
> CPUs, which is nicer for smaller systems.

For those interested, here is a status update on how things are evolving
in terms of rseq Linux ecosystem integration:

I've been working with glibc maintainers for the past months to get rseq
registration integrated into glibc. The patchset is awaiting feedback
from glibc maintainers at this point. An important part of that integration
is the user-level ABI defining interaction between the executable and
libraries wishing to register rseq within the same process. This is needed
because the rseq system call only supports a single rseq registration per
thread (this was done on purpose). If all goes well we should see rseq
integration in glibc as part of the glibc 2.30 release in August 2019.

For those interested in upcoming rseq kernel patches I have ready, those are
available at [1].

The main reason why we're not seeing more users of rseq out there right now
is because the user-level ABI to interact between libc, applications, and
early adopter libraries needs to be specified before projects start using
rseq. An early adopter of rseq should not be incompatible with a glibc
which introduces rseq registration support.

Once glibc integration is done, here are a few things I have ready:

* NUMA node ID in TLS

Having the NUMA node ID available in a TLS variable would allow glibc to
perform interesting NUMA performance improvements within its locking
implementation, so I have a patch adding NUMA node ID support to rseq
as a new rseq system call flag.

* Adaptative mutex improvements

I have done a prototype using rseq to implement an adaptative mutex which
can detect preemption using a rseq critical section. This ensures the
thread doesn't continue to busy-loop after it returns from preemption, and
calls sys_futex() instead. This is part of a user-space prototype branch [2],
and does not require any kernel change.

* cpu_opv system call

Use-cases requiring access to remote per-cpu data such as memory migration
in a memory allocator and access to specific per-cpu buffers from a
ring-buffer consumer will end up requiring this additional system call.
I'm awaiting a broader adoption of rseq (which depends on glibc integration)
for simpler use-cases before pushing the cpu_opv system call again.

Thanks,

Mathieu

[1] https://git.kernel.org/pub/scm/linux/kernel/git/rseq/linux-rseq.git/
[2] https://github.com/compudj/rseq-test/blob/adapt-lock/test-rseq-adaptative-lock.c

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
