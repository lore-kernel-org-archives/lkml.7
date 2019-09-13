Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097E6C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71BB20693
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 16:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bj01quzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390651AbfIMQg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 12:36:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35556 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388170AbfIMQg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 12:36:56 -0400
Received: from zn.tnic (p200300EC2F0DC5006892875336F1420F.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:c500:6892:8753:36f1:420f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 513431EC026F;
        Fri, 13 Sep 2019 18:36:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1568392611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9OQbjVPYe1Zr33bmVGPtBiEvoOiy1OipJKbotsaYm/w=;
        b=bj01quzsCivkmBTlTxA814nX8naT3/KY2hxtB/Zphw2qUpbw7WelUghgVDUUEZyPBqPijQ
        eoFEu0ntNABh6FcYAWkJia8oP2n8hgB1iKRY6zywRoqP9N8HULfxqeHtxr2jUel35U0p8X
        EbxOos91wAXMEVEEogj+x3UW4WEgAVA=
Date:   Fri, 13 Sep 2019 18:36:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Rasmus Villemoes <mail@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Improve memset
Message-ID: <20190913163645.GC4190@zn.tnic>
References: <20190913072237.GA12381@zn.tnic>
 <CAHk-=wismo3SQvvKXg8j0W-eC+5Q-ctcYfr1QV3K-i90w5caBA@mail.gmail.com>
 <9dc9f1e6-5d19-167c-793d-2f4a5ebee097@rasmusvillemoes.dk>
 <20190913104232.GA4190@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190913104232.GA4190@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 12:42:32PM +0200, Borislav Petkov wrote:
> Or should we talk to Intel hw folks about it...

Or, I can do something like this, while waiting. Benchmark at the end.

The numbers are from a KBL box:

model           : 158
model name      : Intel(R) Core(TM) i5-9600K CPU @ 3.70GHz
stepping        : 12

and if I'm not doing anything wrong with the benchmark (the asm looks
ok but I could very well be missing something), the numbers say that
the REP; STOSB is better from sizes of 8 and upwards and up to two
cachelines we're pretty much on-par with the builtin variant.

But after that we're pretty close too.

But this is just a single uarch which is pretty new, I guess the 32 or
64 bytes cap should be good enough for most, especially those where REP;
STOSB isn't as good.

Hmm.

Loops: 1000000
size            builtin_memset  rep;stosb       memset_rep
0               46              85              131
8               88              65              104
16              66              65              103
24              66              65              103
32              66              65              104
40              66              65              104
48              66              65              103
56              66              65              103
64              66              65              103
72              66              65              103
80              66              65              103
88              66              65              103
96              66              65              103
104             66              65              103
112             66              65              103
120             66              65              103
128             66              65              103
136             66              71              108
144             73              71              108
152             72              71              108
160             73              71              108
168             73              71              108
176             73              71              108
184             73              71              108
192             72              74              107
200             75              78              116
208             80              78              116
216             80              78              116
224             80              78              116
232             80              78              116
240             80              78              116
248             80              78              116


---
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef unsigned long long u64;

#define DECLARE_ARGS(val, low, high)    unsigned low, high
#define EAX_EDX_VAL(val, low, high)     ((low) | ((u64)(high) << 32))
#define EAX_EDX_ARGS(val, low, high)    "a" (low), "d" (high)
#define EAX_EDX_RET(val, low, high)     "=a" (low), "=d" (high)

static __always_inline unsigned long long rdtsc(void)
{
        DECLARE_ARGS(val, low, high);

        asm volatile("rdtsc" : EAX_EDX_RET(val, low, high));

        return EAX_EDX_VAL(val, low, high);
}

/**
 * rdtsc_ordered() - read the current TSC in program order
 *
 * rdtsc_ordered() returns the result of RDTSC as a 64-bit integer.
 * It is ordered like a load to a global in-memory counter.  It should
 * be impossible to observe non-monotonic rdtsc_unordered() behavior
 * across multiple CPUs as long as the TSC is synced.
 */
static __always_inline unsigned long long rdtsc_ordered(void)
{
        /*
         * The RDTSC instruction is not ordered relative to memory
         * access.  The Intel SDM and the AMD APM are both vague on this
         * point, but empirically an RDTSC instruction can be
         * speculatively executed before prior loads.  An RDTSC
         * immediately after an appropriate barrier appears to be
         * ordered as a normal load, that is, it provides the same
         * ordering guarantees as reading from a global memory location
         * that some other imaginary CPU is updating continuously with a
         * time stamp.
         */
        asm volatile("mfence");
        return rdtsc();
}

static __always_inline void *rep_stosb(void *dest, int c, size_t n)
{
        void *ret, *dummy;

	asm volatile("rep; stosb"
		     : "=&D" (ret), "=c" (dummy)
		     : "0" (dest), "a" (c), "c" (n)
		     : "memory");

	return ret;
}

static __always_inline void *memset_rep(void *dest, int c, size_t n)
{
	void *ret, *dummy;

	asm volatile("push %%rdi\n\t"
		     "mov %%rax, %%rsi\n\t"
		     "mov %%rcx, %%rdx\n\t"
		     "andl $7,%%edx\n\t"
		     "shrq $3,%%rcx\n\t"
		     "movzbl %%sil,%%esi\n\t"
		     "movabs $0x0101010101010101,%%rax\n\t"
		     "imulq %%rsi,%%rax\n\t"
		     "rep stosq\n\t"
		     "movl %%edx,%%ecx\n\t"
		     "rep stosb\n\t"
		     "pop %%rax\n\t"
		     : "=&D" (ret), "=c" (dummy)
		     : "0" (dest), "a" (c), "c" (n)
		     : "rsi", "rdx", "memory");

	return ret;
}

#define BUF_SIZE 1024
static void bench_memset(unsigned int loops)
{
	u64 p0, p1, m_cycles = 0, r_cycles = 0, rep_cyc = 0;
	int i, s;
	void *dst;

	dst = malloc(BUF_SIZE);
	if (!dst)
		perror("malloc");

	printf("Loops: %d\n", loops);
	printf("size\t\tbuiltin_memset\trep;stosb\tmemset_rep\n");

	for (s = 0; s < BUF_SIZE; s += 16) {
		for (i = 0; i < loops; i++) {
			p0 = rdtsc_ordered();
			__builtin_memset(dst, 0, s);
			p1 = rdtsc_ordered();

			m_cycles += p1 - p0;
		}

		for (i = 0; i < loops; i++) {
			p0 = rdtsc_ordered();
			rep_stosb(dst, 0, s);
			p1 = rdtsc_ordered();

			r_cycles += p1 - p0;
		}

		for (i = 0; i < loops; i++) {
			p0 = rdtsc_ordered();
			memset_rep(dst, 0, s);
			p1 = rdtsc_ordered();

			rep_cyc += p1 - p0;
		}


		m_cycles /= loops;
		r_cycles /= loops;
		rep_cyc  /= loops;

		printf("%d\t\t%llu\t\t%llu\t\t%llu\n", s, m_cycles, r_cycles, rep_cyc);
		m_cycles = r_cycles = rep_cyc = 0;
	}

	free(dst);
}

int main(void)
{
	bench_memset(1000000);

	return 0;
}


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
