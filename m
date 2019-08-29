Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762C1C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBF12166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfH2TpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:45:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51658 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbfH2TpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:45:10 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3QLt-00062x-9g; Thu, 29 Aug 2019 21:45:01 +0200
Date:   Thu, 29 Aug 2019 21:45:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, harry.pan@intel.com,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/hpet: Disable HPET on Intel Coffe Lake
In-Reply-To: <793CCD4F-35E0-46B9-B5D4-3D3233BA5D35@canonical.com>
Message-ID: <alpine.DEB.2.21.1908292143300.1938@nanos.tec.linutronix.de>
References: <20190829091232.15065-1-kai.heng.feng@canonical.com> <alpine.DEB.2.21.1908291351510.1938@nanos.tec.linutronix.de> <793CCD4F-35E0-46B9-B5D4-3D3233BA5D35@canonical.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-342921159-1567107901=:1938"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-342921159-1567107901=:1938
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Thu, 29 Aug 2019, Kai-Heng Feng wrote:
> at 20:13, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 29 Aug 2019, Kai-Heng Feng wrote:
> > 
> > > Some Coffee Lake platforms have skewed HPET timer once the SoCs entered
> > > PC10, and marked TSC as unstable clocksource as result.
> > 
> > So here you talk about Coffee Lake and in the patch you use KABYLAKE.
> 
> Coffeelake has the same model number as Kabylake.

Yeah, just a bit more text explaining that would be helpful.
 
> > > +static const struct x86_cpu_id hpet_blacklist[] __initconst = {
> > > +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_MOBILE },
> > > +	{ X86_VENDOR_INTEL, 6, INTEL_FAM6_KABYLAKE_DESKTOP },
> > 
> > So this disables HPET on all Kaby Lake variants not just on the affected
> > Coffee Lakes. I know that I rejected the initial patch with the random
> > stepping cutoff...
> > 
> >  https://lore.kernel.org/lkml/alpine.DEB.2.21.1904081403220.1748@nanos.tec.linutronix.de
> > 
> > In the other attempt to 'fix' this I asked for clarification, but silence
> > from Intel after this:
> > 
> >  https://lore.kernel.org/lkml/alpine.DEB.2.21.1905182015320.3019@nanos.tec.linutronix.de
> > 
> > Can Intel please provide some useful information about this finally?
> 
> Hopefully Intel can provide more info.
> 
> I know we should find the root cause rather than stopping at "it’s a firmware
> bug”, but users are already affected by this issue [1].
> Is there any better short-term workaround?

Not really. And if Intel stays silent, I'm just going to apply it as is
along with a stable tag.

Thanks,

	tglx
--8323329-342921159-1567107901=:1938--
