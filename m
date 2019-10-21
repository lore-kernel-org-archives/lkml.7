Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E004DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9A52084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 21:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbfJUV3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 17:29:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37779 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbfJUV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 17:29:25 -0400
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iMfEg-0002d0-Qs; Mon, 21 Oct 2019 23:29:06 +0200
Date:   Mon, 21 Oct 2019 23:29:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
In-Reply-To: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr>
Message-ID: <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Christophe Leroy wrote:

> This is a tentative to switch powerpc/32 vdso to generic C implementation.
> It will likely not work on 64 bits or even build properly at the moment.
> 
> powerpc is a bit special for VDSO as well as system calls in the
> way that it requires setting CR SO bit which cannot be done in C.
> Therefore, entry/exit and fallback needs to be performed in ASM.
> 
> To allow that, C fallbacks just return -1 and the ASM entry point
> performs the system call when the C function returns -1.
> 
> The performance is rather disappoiting. That's most likely all
> calculation in the C implementation are based on 64 bits math and
> converted to 32 bits at the very end. I guess C implementation should
> use 32 bits math like the assembly VDSO does as of today.

> gettimeofday:    vdso: 750 nsec/call
> 
> gettimeofday:    vdso: 1533 nsec/call

The only real 64bit math which can matter is the 64bit * 32bit multiply,
i.e.

static __always_inline
u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
{
        return ((cycles - last) & mask) * mult;
}

Everything else is trivial add/sub/shift, which should be roughly the same
in ASM.

Can you try to replace that with:

static __always_inline
u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
{
        u64 ret, delta = ((cycles - last) & mask);
        u32 dh, dl;

        dl = delta;
        dh = delta >> 32;

        res = mul_u32_u32(al, mul);
        if (ah)
                res += mul_u32_u32(ah, mul) << 32;

        return res;
}

That's pretty much what __do_get_tspec does in ASM.

Thanks,

	tglx

