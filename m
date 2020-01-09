Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463DAC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8D8206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 14:06:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbgAIOGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 09:06:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54422 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbgAIOGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 09:06:12 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ipYRV-0003WO-4H; Thu, 09 Jan 2020 15:05:45 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A3E5F1060CF; Thu,  9 Jan 2020 15:05:44 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        vincenzo.frascino@arm.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] powerpc/32: Switch VDSO to C implementation.
In-Reply-To: <207cef10-3da8-6a52-139c-0620b21b64af@c-s.fr>
References: <8ce3582f7f7da9ff0286ced857e5aa2e5ae6746e.1571662378.git.christophe.leroy@c-s.fr> <alpine.DEB.2.21.1910212312520.2078@nanos.tec.linutronix.de> <f4486e86-3c0c-0eec-1639-0e5956cdb8f1@c-s.fr> <95bd2367-8edc-29db-faa3-7729661e05f2@c-s.fr> <alpine.DEB.2.21.1910261751140.10190@nanos.tec.linutronix.de> <439bce37-9c2c-2afe-9c9e-2f500472f9f8@c-s.fr> <alpine.DEB.2.21.1910262026340.10190@nanos.tec.linutronix.de> <207cef10-3da8-6a52-139c-0620b21b64af@c-s.fr>
Date:   Thu, 09 Jan 2020 15:05:44 +0100
Message-ID: <87d0bslo7b.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe!

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> In do_hres(), I see:
>
> 		cycles = __arch_get_hw_counter(vd->clock_mode);
> 		ns = vdso_ts->nsec;
> 		last = vd->cycle_last;
> 		if (unlikely((s64)cycles < 0))
> 			return -1;
>
> __arch_get_hw_counter() returns a u64 values. On the PPC, this is read 
> from the timebase which is a 64 bits counter.
>
> Why returning -1 if (s64)cycles < 0 ? Does it means we have to mask out 
> the most significant bit when reading the HW counter ?

Only if you expect the HW counter to reach a value which has bit 63
set. That'd require:

uptime		counter frequency

~292 years      1GHz
~ 58 years      5GHz

assumed that the HW counter starts at 0 when the box is powered on.

The reason why this is implemented in this way is that
__arch_get_hw_counter() needs a way to express that the clocksource of
the moment is not suitable for VDSO so that the syscall fallback gets
invoked.

Sure we could have used a pointer for the value and a return value
indicating the validity, but given the required uptime the resulting
code overhead seemed to be not worth it. At least not for me as I'm not
planning to be around 58 years from now :)

Thanks,

        tglx
