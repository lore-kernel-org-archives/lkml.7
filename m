Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE1ACA9EC9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04E520856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 18:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j9ShH8T6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfJ3SgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 14:36:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44494 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfJ3SgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 14:36:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id q26so2157105pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ewz3zGoQ/oT5sufHB6AjuO7iLzPrn+V2j8p2b6vWOYM=;
        b=j9ShH8T6jz5E6OrGiP0hvGkLhPbya+dw5H60tZ92Gksg1qYjPxxq5wfrXbGL+ZiZeo
         btNWixMcREdlNj/24ebkecof9Hz2OdRon/7KFD02WdvlSP9H3u0+Q1DG+1JP5N8cRgLr
         1WjV1UHgu3iE7sp7rbhafhaV+dGRci8vNX5K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ewz3zGoQ/oT5sufHB6AjuO7iLzPrn+V2j8p2b6vWOYM=;
        b=nUPvU3HLEWss7GNvUcHHpsnXPaVvYPMw5L7A/5lQuL8bzelpd8IDmbcDsjbRflQk1c
         WRt3ZbBI9XFf0/eAtmGMmOoT+IbTI6DiXOVQY2FLcFDZnO5UWfpR6coU9qC7lttirphG
         +9aQpFLQvZwA1PDAP9L1cekgTjfQq/gGbUtoO3MgcONzte3QWtq7okxZIFUu1kifmO5R
         +s0xxDRBJFBwI268qTDPABvPydGCTBXe5ENYx9QMVi/VIFa0h4GfcwIWgXC9Omv1Hbi9
         5LsLvN+YlmcPCXr4JM2PHmCln7VSizsu33uLm5CQ3Bw60QPJpxKJWlfSEbJAD91tjcYH
         7s8w==
X-Gm-Message-State: APjAAAV8I00YrWTtCSc8sdpt9RXqKKBPYUUhVEVwhCOTfvnR7LE30pEA
        Oa0Rg+z8dhOs/DMlRYWLxkM4Iw==
X-Google-Smtp-Source: APXvYqwEtldzCMnvxhg77NCeWsf2VanRztD/Ae5V4HsJ7lg7BT821TOwACbTkrdMpNcTlSy+1+dsBw==
X-Received: by 2002:a17:90a:304:: with SMTP id 4mr878674pje.128.1572460582367;
        Wed, 30 Oct 2019 11:36:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a8sm678123pff.5.2019.10.30.11.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 11:36:21 -0700 (PDT)
Date:   Wed, 30 Oct 2019 11:36:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 13/13] x86/Kconfig: Add Kconfig for KVM based XO
Message-ID: <201910301135.BDC4C7696@keescook>
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
 <20191003212400.31130-14-rick.p.edgecombe@intel.com>
 <201910291634.7993D32374@keescook>
 <d645473f01c445a70bc1f2472217f1ae426b7020.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d645473f01c445a70bc1f2472217f1ae426b7020.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 12:01:18AM +0000, Edgecombe, Rick P wrote:
> On Tue, 2019-10-29 at 16:36 -0700, Kees Cook wrote:
> > On Thu, Oct 03, 2019 at 02:24:00PM -0700, Rick Edgecombe wrote:
> > > Add CONFIG_KVM_XO for supporting KVM based execute only memory.
> > 
> > I would expect this config to be added earlier in the series so that the
> > code being added that depends on it can be incrementally build tested...
> > 
> > (Also, if this is default=y, why have a Kconfig for it at all? Guests
> > need to know to use this already, yes?)
> > 
> > -Kees
> Hmm, good point. One reason could be that this requires SPARSEMEM_VMEMMAP due to
> some pre-processor tricks that need a compile time known max physical address
> size. So maybe someone could want KVM_GUEST and !SPARSEMEM_VMEMMAP. I'm not
> sure.

Good point about the combination of other CONFIGs. All the more reason
to move it earlier, though.

-Kees

> 
> > > 
> > > Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> > > ---
> > >  arch/x86/Kconfig | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > > 
> > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > index 222855cc0158..3a3af2a456e8 100644
> > > --- a/arch/x86/Kconfig
> > > +++ b/arch/x86/Kconfig
> > > @@ -802,6 +802,19 @@ config KVM_GUEST
> > >  	  underlying device model, the host provides the guest with
> > >  	  timing infrastructure such as time of day, and system time
> > >  
> > > +config KVM_XO
> > > +	bool "Support for KVM based execute only virtual memory permissions"
> > > +	select DYNAMIC_PHYSICAL_MASK
> > > +	select SPARSEMEM_VMEMMAP
> > > +	depends on KVM_GUEST && X86_64
> > > +	default y
> > > +	help
> > > +	  This option enables support for execute only memory for KVM guests. If
> > > +	  support from the underlying VMM is not detected at boot, this
> > > +	  capability will automatically disable.
> > > +
> > > +	  If you are unsure how to answer this question, answer Y.
> > > +
> > >  config PVH
> > >  	bool "Support for running PVH guests"
> > >  	---help---
> > > -- 
> > > 2.17.1
> > > 
> > 
> > 

-- 
Kees Cook
