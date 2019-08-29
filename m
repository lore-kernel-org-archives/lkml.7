Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D9EC41514
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650CF21726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 12:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfH2MYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 08:24:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50003 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfH2MYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 08:24:39 -0400
Received: from p5de0b6c5.dip0.t-ipconnect.de ([93.224.182.197] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1i3JTU-0002if-UQ; Thu, 29 Aug 2019 14:24:25 +0200
Date:   Thu, 29 Aug 2019 14:24:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mac Chiang <mac.chiang@intel.com>
Subject: Re: linux-next: build failure after merge of the tip tree
In-Reply-To: <20190829074644.GL2369@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1908291422520.1938@nanos.tec.linutronix.de>
References: <20190829162012.36ac9d7c@canb.auug.org.au> <20190829074644.GL2369@hirez.programming.kicks-ass.net>
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

On Thu, 29 Aug 2019, Peter Zijlstra wrote:
> On Thu, Aug 29, 2019 at 04:20:12PM +1000, Stephen Rothwell wrote:
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Thu, 29 Aug 2019 16:08:49 +1000
> > Subject: [PATCH] ASoC: Intel: boards: merge fix for INTEL_FAM6_KABYLAKE_MOBILE -> INTEL_FAM6_KABYLAKE_L change
> > 
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  sound/soc/intel/common/soc-intel-quirks.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
> > index e6357d306cb8..863a477d3405 100644
> > --- a/sound/soc/intel/common/soc-intel-quirks.h
> > +++ b/sound/soc/intel/common/soc-intel-quirks.h
> > @@ -36,7 +36,7 @@ SOC_INTEL_IS_CPU(byt, INTEL_FAM6_ATOM_SILVERMONT);
> >  SOC_INTEL_IS_CPU(cht, INTEL_FAM6_ATOM_AIRMONT);
> >  SOC_INTEL_IS_CPU(apl, INTEL_FAM6_ATOM_GOLDMONT);
> >  SOC_INTEL_IS_CPU(glk, INTEL_FAM6_ATOM_GOLDMONT_PLUS);
> > -SOC_INTEL_IS_CPU(cml, INTEL_FAM6_KABYLAKE_MOBILE);
> > +SOC_INTEL_IS_CPU(cml, INTEL_FAM6_KABYLAKE_L);
> 
> ARGHH... rebase again?

No. This is a conflict with the sound tree which added the MOBILE
thingy. So what you could do for now is

#define INTEL_FAM6_KABYLAKE_MOBILE INTEL_FAM6_KABYLAKE_L

and remove that after both trees have hit mainline, i.e. around rc1.

Thanks,

	tglx

