Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35159ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149E02082C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502100AbfJQLPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:15:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52702 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406044AbfJQLPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:15:25 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iL3kR-0006th-Mr; Thu, 17 Oct 2019 13:15:15 +0200
Date:   Thu, 17 Oct 2019 13:15:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>
cc:     Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Christopher S . Hall" <christopher.s.hall@intel.com>
Subject: Re: [RFC PATCH 1/5] x86: tsc: add tsc to art helpers
In-Reply-To: <87y2y4vk4g.fsf@gmail.com>
Message-ID: <alpine.DEB.2.21.1910171256580.1824@nanos.tec.linutronix.de>
References: <20190716072038.8408-1-felipe.balbi@linux.intel.com> <20190716072038.8408-2-felipe.balbi@linux.intel.com> <alpine.DEB.2.21.1907160952040.1767@nanos.tec.linutronix.de> <87y2zvt1hk.fsf@gmail.com> <alpine.DEB.2.21.1908151458560.1923@nanos.tec.linutronix.de>
 <87y2y4vk4g.fsf@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 1 Oct 2019, Felipe Balbi wrote:
> (sorry for the long delay, got caught up in other tasks)

Delayed by vacation :)

> Thomas Gleixner <tglx@linutronix.de> writes:
> > On Thu, 15 Aug 2019, Felipe Balbi wrote:
> >> Thomas Gleixner <tglx@linutronix.de> writes:
> >> > On Tue, 16 Jul 2019, Felipe Balbi wrote:
> >> >
> >> > So some information what those interfaces are used for and why they are
> >> > needed would be really helpful.
> >> 
> >> Okay, I have some more details about this. The TGPIO device itself uses
> >> ART since TSC is not directly available to anything other than the
> >> CPU. The 'problem' here is that reading ART incurs extra latency which
> >> we would like to avoid. Therefore, we use TSC and scale it to
> >> nanoseconds which, would be the same as ART to ns.
> >
> > Fine. But that's not really correct:
> >
> >       TSC = art_to_tsc_offset + ART * scale;
> 
> From silicon folks I got the equation:
> 
> ART = ECX * EBX / EAX;

What is the content of ECX/EBX/EAX and where is it coming from?
 
> If I'm reading this correctly, that's basically what
> native_calibrate_tsc() does (together with some error checking the safe
> defaults). Couldn't we, instead, just have a single function like below?
> 
> u64 convert_tsc_to_art_ns()
> {
> 	return x86_platform.calibrate_tsc();
> }

Huch? How is that supposed to work? calibrate_tsc() returns the TSC
frequency.

> Another way would be extract the important parts from
> native_calibrate_tsc() into a separate helper. This would safe another
> call to cpuid(0x15,...);

What for?

The relation between TSC and ART is already established via detect_art()
which reads all relevant data out of CPUID(ART_CPUID_LEAF).

We use exactly that information for convert_art_to_tsc() so the obvious
solution for calculating ART from TSC is to do the reverse operation.

convert_art_to_tsc()
{
        rem = do_div(art, art_to_tsc_denominator);

        res = art * art_to_tsc_numerator;
        tmp = rem * art_to_tsc_numerator;

        do_div(tmp, art_to_tsc_denominator);
        res += tmp + art_to_tsc_offset;
}

which is translated into math:

      TSC = ART * SCALE + OFFSET

where

      SCALE = N / D

and

      N = CPUID(ART_CPUID_LEAF).EAX
      D = CPUID(ART_CPUID_LEAF).EBX

So the obvious reverse operation is:

     ART = (TSC - OFFSET) / SCALE;

Translating that into code should not be rocket science.

Thanks,

	tglx
