Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6295C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3E722CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 09:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566813311;
	bh=dOfsqr3uxTbNv1Mh/B7vOfAo0z4HZL5DMe1KUZBcxcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OQsfszyz37uol5aOoPWvO48Ir0BzITRNHZCykhgiMgNU1VoTYm97gE8KHLTNEEVnH
	 dBjR++Uul9lwL4NwQ+0wEd1vTbBe5o0w7P4uNS+WVvZHeuZRFsSVzaLpvTeQyi9H+Q
	 prxk5a6pjXfDhici85P0idWIaI5Scom5nHvoVT7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731163AbfHZJzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 05:55:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40972 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbfHZJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 05:55:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id j16so14653452wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 02:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n9nvAxK0w8lNdVlTmRMM2LPikj7KUjdOPXEoDkskPCc=;
        b=eWDW+gmlEsZx1PT7nhE3trO+UI2lhS35Rp1mEAhuUqY99cvHX+aCeg5PI1a4YgXoh+
         ujjmdVa1HerTbChMeH09EJEJNzxEPLn2RayJj1zlIZ95S7KrDiQNLj6mDPSvoG7BILUo
         SRXvBBYy/6XO2ufYShgYf05aH+AbI3vM3KErhaRzc3cFZ1UIruO2PZm6l38TiTwAiyBd
         DmNzk0WhYKfBji3wPa0suaxHI65ll/V0YCD4M1QRCOONb5wD+iSfYjys9NCAw78+F7ba
         hQdpgx6JjReCJUd77bXeyN45z36iW8oqxY8r13nqUkC0+Cey9dq0cVPp2pbfLw85fQFc
         cyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=n9nvAxK0w8lNdVlTmRMM2LPikj7KUjdOPXEoDkskPCc=;
        b=SafIaULovHuwsPCTl5C3d8OwJ6/KWQno8oHMU3krJ7Yuahlf5u3qd9EbTo4KNysoi5
         lDos5zrHyW85TsHIYqmvVeplOlDU4vuRacfxZ8q+zofIsMG8svh2jwz5r7K4/FCTfoAK
         srku+rTnGV2lXV/yAGFM/VE4+xMV6VTfXr6PcBzQc4O6RUiDsf5dWWYvXaTuwaopNv4K
         VpTnpAe5bzpx1DPjiQlp6GVlMWCwaLLfWFPbXScFDlNbDAb7SC4RVyZFx14QCCtpIpG+
         M9sLLOrMrr8HVyPmTlmsJcIqVq7yk15KbSLU8SeF5VA1rFd1y7ZT/5vc+UTYcUC3uVpD
         WMgw==
X-Gm-Message-State: APjAAAWSS7BCVrs5Ss3qMssNAfm9gR30DJyGmQCgrd68jNuYJiX0Hpjq
        iU/zbOX1rbUZTGyskXf1itU=
X-Google-Smtp-Source: APXvYqycpKhVaE7jtKgzKstZD/xr7ROKs+WMyRMopaNNX9+KdxEhCerVOX/izz84K2WPIRoXxHkN9A==
X-Received: by 2002:adf:f851:: with SMTP id d17mr21413918wrq.77.1566813307960;
        Mon, 26 Aug 2019 02:55:07 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id g65sm22307917wma.21.2019.08.26.02.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 02:55:07 -0700 (PDT)
Date:   Mon, 26 Aug 2019 11:55:05 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 4/5] x86/intel: Aggregate microserver naming
Message-ID: <20190826095505.GA101484@gmail.com>
References: <20190822102306.109718810@infradead.org>
 <20190822102411.337145504@infradead.org>
 <20190826092750.GA56543@gmail.com>
 <20190826094538.GQ2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826094538.GQ2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Aug 26, 2019 at 11:27:50AM +0200, Ingo Molnar wrote:
> > 
> > * Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > Currently big microservers have _XEON_D while small microservers have
> > > _X, Make it uniformly: _D.
> > > 
> > > for i in `git grep -l "INTEL_FAM6_.*_\(X\|XEON_D\)"`
> > > do
> > > 	sed -i -e 's/\(INTEL_FAM6_ATOM_.*\)_X/\1_D/g' \
> > >                -e 's/\(INTEL_FAM6_.*\)_XEON_D/\1_D/g' ${i}
> > > done
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Cc: x86@kernel.org
> > > Cc: Dave Hansen <dave.hansen@intel.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Tony Luck <tony.luck@intel.com>
> > > ---
> > >  arch/x86/events/intel/core.c          |   20 ++++++++++----------
> > >  arch/x86/events/intel/cstate.c        |   12 ++++++------
> > >  arch/x86/events/intel/pt.c            |    2 +-
> > >  arch/x86/events/intel/rapl.c          |    4 ++--
> > >  arch/x86/events/intel/uncore.c        |    4 ++--
> > >  arch/x86/events/msr.c                 |    6 +++---
> > >  arch/x86/include/asm/intel-family.h   |   10 +++++-----
> > >  arch/x86/kernel/apic/apic.c           |    2 +-
> > >  arch/x86/kernel/cpu/intel.c           |    4 ++--
> > >  arch/x86/kernel/cpu/mce/intel.c       |    2 +-
> > >  arch/x86/kernel/tsc.c                 |    2 +-
> > >  drivers/cpufreq/intel_pstate.c        |    6 +++---
> > >  drivers/edac/i10nm_base.c             |    4 ++--
> > >  drivers/edac/pnd2_edac.c              |    2 +-
> > >  tools/power/x86/turbostat/turbostat.c |   22 +++++++++++-----------
> > >  15 files changed, 51 insertions(+), 51 deletions(-)
> > 
> > I've added the additional renames below, accounting for recent changes in 
> > cpu/common.c.
> 
> Thanks, I've respun these patches (they didn't actually build), and I'll
> make sure to include that one when I repost.

I've already respun them myself and committed them to tip:x86/cpu :-)

Thanks,

	Ingo
