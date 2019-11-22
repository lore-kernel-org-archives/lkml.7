Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CA87C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60252070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 21:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfKVVd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 16:33:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:60195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfKVVd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 16:33:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 13:33:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,231,1571727600"; 
   d="scan'208";a="210367928"
Received: from yyu32-desk1.sc.intel.com ([10.144.153.205])
  by orsmga003.jf.intel.com with ESMTP; 22 Nov 2019 13:33:25 -0800
Message-ID: <b33151bdfb5611de7db8493cb8fcca4b8f372267.camel@intel.com>
Subject: Re: [PATCH 1/6] x86/fpu/xstate: Fix small issues before adding
 supervisor xstates
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 22 Nov 2019 13:22:37 -0800
In-Reply-To: <20191009155847.GE10395@zn.tnic>
References: <20190925151022.21688-1-yu-cheng.yu@intel.com>
         <20190925151022.21688-2-yu-cheng.yu@intel.com>
         <20191009155847.GE10395@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-10-09 at 08:58 -0700, Borislav Petkov wrote:
> On Wed, Sep 25, 2019 at 08:10:17AM -0700, Yu-cheng Yu wrote:
> > In response to earlier comments, fix small issues before introducing XSAVES
> > supervisor states:
> > - Add spaces around '*'.
> > - Fix comments of xfeature_is_supervisor().
> > - Replace ((u64)1 << 63) with XCOMP_BV_COMPACTED_FORMAT.
> > 
> > No functional changes from this patch.
> > 
> > Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Reviewed-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/kernel/fpu/xstate.c | 15 ++++++---------
> >  1 file changed, 6 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> > index e5cb67d67c03..b793fc2156b9 100644
> > --- a/arch/x86/kernel/fpu/xstate.c
> > +++ b/arch/x86/kernel/fpu/xstate.c
> > @@ -60,7 +60,7 @@ u64 xfeatures_mask __read_mostly;
> > 
> >  static unsigned int xstate_offsets[XFEATURE_MAX] = { [ 0 ... XFEATURE_MAX - 1] = -1};
> >  static unsigned int xstate_sizes[XFEATURE_MAX]   = { [ 0 ... XFEATURE_MAX - 1] = -1};
> > -static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask)*8];
> > +static unsigned int xstate_comp_offsets[sizeof(xfeatures_mask) * 8];
> > 
> >  /*
> >   * The XSAVE area of kernel can be in standard or compacted format;
> > @@ -110,12 +110,8 @@ EXPORT_SYMBOL_GPL(cpu_has_xfeatures);
> >  static int xfeature_is_supervisor(int xfeature_nr)
> >  {
> >       /*
> > -      * We currently do not support supervisor states, but if
> > -      * we did, we could find out like this.
> > -      *
> > -      * SDM says: If state component 'i' is a user state component,
> > -      * ECX[0] return 0; if state component i is a supervisor
> > -      * state component, ECX[0] returns 1.
> > +      * Extended State Enumeration Sub-leaves (EAX = 0DH, ECX = n, n > 1)
> > +      * returns ECX[0] set to (1) for a supervisor state.
> 
> "... and cleared (0) for a user state."
> 
> I believe it is is clearer this way.
> 
> >        */
> >       u32 eax, ebx, ecx, edx;
> > 
> 
> Since you're touching this function: make it return bool as it is used
> in boolean context only and have it return simply:
> 
>         return ecx & 1;

This implicitly converts a u32 to a bool.  By looking at it, I think it should
be OK, but wonder if anything overlooked?  I would be happy to make this a
separate patch.

Yu-cheng
