Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB3C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E076C20659
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="LBJvUu/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLFQ3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:29:35 -0500
Received: from mail-40138.protonmail.ch ([185.70.40.138]:11488 "EHLO
        mail-40138.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfLFQ3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:29:34 -0500
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Fri, 06 Dec 2019 11:29:33 EST
Date:   Fri, 06 Dec 2019 16:13:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1575648792;
        bh=z5ckHnM1JT0bjLvn3hu4ZpaORLMeQ8ST4azSjqKt/OI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=LBJvUu/rQZkFQkYxEnV1DHmyjivJCcrljuT6+EmK6y1juedk/dCQonL5Z22l5fmRh
         5GgA7lg5FL7hpb+KuTpYPzxna6usQ0kC1uruq2SLXjQuLRezWJ7WkpBWU5W+CyCF5E
         MN6S0Ndur6pvnTwJ3yKsFbWEPr1hGRWDOAvGOQFI=
To:     Peter Zijlstra <peterz@infradead.org>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>,
        "malat@debian.org" <malat@debian.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Don't use cpuid 0x16 leaf to determine cpu speed.
Message-ID: <s2tCh5akte6KmZimjnjJ0dn_zhWfLr_DEXJ6je2DFCUwZwrF9wqS4kPcJ-j1LOtP8rmkjR6oMg58anmztMJMd0e1Dfe8CvtTZudBXRT4gik=@protonmail.com>
In-Reply-To: <20191206103942.GE2844@hirez.programming.kicks-ass.net>
References: <SoluZg51N39Rx0tDCSJFbEvvgMrDnJ_g0RdRdN5mtCfag4GahIOPfok7UbkyeO5Qpl3wUHp8H8y73JtClcZvr1ARSIOBIFQAne0Z712el8M=@protonmail.com>
 <20191206103942.GE2844@hirez.programming.kicks-ass.net>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your reply.

I experience 2% tsc clock-drift (671s ahead of my local NTP server after 9.=
5h)
on my machine with Supermicro's Hyperspeed turned on. There's no clock
drift when I turn Hyperspeed off.

As far as I know Hyperspeed increases base clock frequency[1].

That's what CPUID says about my overclocked Intel Xeon Gold 6146:

   Time Stamp Counter/Core Crystal Clock Information (0x15):
      TSC/clock ratio =3D 256/2
      nominal core crystal clock =3D 0 Hz
   Processor Frequency Information (0x16):
      Core Base Frequency (MHz) =3D 0xc80 (3200)
      Core Maximum Frequency (MHz) =3D 0x1068 (4200)
      Bus (Reference) Frequency (MHz) =3D 0x64 (100)

tsc_refine_calibration_work never corrects the early calibration
because it calculates a tsc frequency beyond 1% tolerance.

I've bumped the tsc_refine_calibration_work's tolerance to 3% and made it w=
ork:

Hyperspeed:
[    8.571471] tsc: Refined TSC clocksource calibration: 3264.012 MHz
No hyperspeed:
[    8.506009] tsc: Refined TSC clocksource calibration: 3200.013 MHz

Increasing the tolerance to 3% would work in my case but apparently some
servers can increase the base-clock frequency to 6%. [2]
At this point in order to completely eliminate this bug we would need to
significantly increase the tolerance which might introduce other bugs.

[1]: https://www.supermicro.com/support/faqs/faq.cfm?faq=3D21337
[2]: https://www.servethehome.com/supermicro-hyper-speed-server-overclockin=
g-bios/

Kind regards,
Krzysztof Piecuch

