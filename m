Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B49C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5235B2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 18:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iytsO+zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfHLSIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:08:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43775 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHLSII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 14:08:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id v12so2291886pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AxMvcKPPSOt5h9tOESk6eM74C3v+cXx0BCMEFfeO5Dg=;
        b=iytsO+zLrR4089ozDzpPc3tz1mmM3j8pqgVIx733CHvK6m0+n7kP80jjwnb85tAH9/
         U1EbkVLTKURLnNI5KM09vWZjzObFj4srl8HjIIH9vkodhrdRjRRRbj9AXla1YegIc13q
         dTH3dOLK3AklNGYSY25a02nAlqq4YmGfncrtA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AxMvcKPPSOt5h9tOESk6eM74C3v+cXx0BCMEFfeO5Dg=;
        b=rn/IgtejAOyWNtiKZKq5p/VsL8WGknOA+tgdpod5sJZQl1yt3DGcU3OLd8/hjwDZWH
         auvbmMaZ2jPmAE0d1AESe0duKEmnRSClglvxPS4I5DdDY199pKwRKWQv4UQVI1JFHO6F
         0e5Bx3N1b0o2zkITTrr9V/gsSCLz+2lqAoYSwXI/y6PQXynw+ejebEK0ZJpFwYGCsqhp
         By3G07fqAFOX5d2U90yrrfom15UDSYxf+G/pvK/6rZ5B3XZMrX358QYpOZS8Niy32AbN
         UB5Dnufc7z6/xlxqps4ePEkebFlH0gjugFzrjy+3yLtLE8cr+OIS7O8wZXBNH2TIsRX/
         od9g==
X-Gm-Message-State: APjAAAWhY8DrmaWFj4X0RiAff6s2EGKlzPKO1pU0GZuzpJGeolmTPjjP
        AdDZkE7gBBAowqXobsbGIYpHyQ==
X-Google-Smtp-Source: APXvYqx7GB2qYifIkhLgbQzOkQXXpweNH/WY6CfmXeWoasPo9MTc+Yfo4Ft8gq7lm/41t9o2VRLAtw==
X-Received: by 2002:a17:90a:c403:: with SMTP id i3mr494779pjt.110.1565633288008;
        Mon, 12 Aug 2019 11:08:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o128sm114355469pfb.42.2019.08.12.11.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Aug 2019 11:08:07 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:08:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Jan Glauber <jglauber@marvell.com>
Subject: Re: [PATCH 4/6] lib/refcount: Move bulk of REFCOUNT_FULL
 implementation into header
Message-ID: <201908121107.C3262BBB5@keescook>
References: <20190802101000.12958-1-will@kernel.org>
 <20190802101000.12958-5-will@kernel.org>
 <20190802185222.GD2349@hirez.programming.kicks-ass.net>
 <201908021915.95BD6B26FC@keescook>
 <20190809160428.smumdvimrtn7rv6u@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809160428.smumdvimrtn7rv6u@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 05:04:28PM +0100, Will Deacon wrote:
> On Fri, Aug 02, 2019 at 07:23:07PM -0700, Kees Cook wrote:
> > On Fri, Aug 02, 2019 at 08:52:22PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 02, 2019 at 11:09:58AM +0100, Will Deacon wrote:
> > > > In an effort to improve performance of the REFCOUNT_FULL implementation,
> > > > move the bulk of its functions into linux/refcount.h. This allows them
> > > > to be inlined in the same way as if they had been provided via
> > > > CONFIG_ARCH_HAS_REFCOUNT.
> > > 
> > > Hehe, they started out this way, then Linus said to stuff them in a C
> > > file :-)
> > 
> > I asked this at the time and didn't quite get a straight answer; Linus's
> > request was private:
> > 
> > https://lore.kernel.org/lkml/20170213180020.GK6500@twins.programming.kicks-ass.net/
> > 
> > It seemed sensible to me (then and now) to have them be inline if there
> > were so many performance concerns about it, etc. Was it just the image
> > size bloat due to the WARNs? So... since we're back to this topic. Why
> > should they not be inline?
> 
> I mean, I can always just move this into an arm64-specific implementation
> if I have to, but it seems a shame given that it's completely generic and
> seems to perform just as well as the x86-specific implementation on my
> laptop.

Yeah, I prefer this being generic too. I continue to think the race
isn't meaningful compared to the benefit of gaining a reliable and cheap
"inc from zero" check.

-- 
Kees Cook
