Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A878DC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C10B20859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 10:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gy9EASSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfE0K4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 06:56:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33024 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfE0K4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 06:56:44 -0400
Received: by mail-pl1-f194.google.com with SMTP id g21so6948507plq.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQG94E91rcdUfSlkW1uYF9ApGj+jgzKgN0E+vtaKz6A=;
        b=Gy9EASSRYlr9i12Logn21TdN5ujim45QVkv2y2MggLHvc1zjqiO1HnQBLFMvdefKhV
         8EUvnRVO5xeo+ymGVEjsG02qBU4VBKJE1w07kzfdcqPRGvvU6qwS7CcKyUwBb43n6ctR
         GXh4BXEKOgL0SWJtNXegveEi3DU5WYLZJg+61DjGG2FPDXWGfylwfRNQeZlbtfrm0Ca+
         3h/DBbQC5pmXA6gRd0uHwD+EOUkhThBuDvV1Iai08L58GcavSub2+7rJ+l4x9dHUQrr6
         XJqz9SfLROkIZQU/3aNmTia9K5JyI8CzL9X7+4mJCGAJPvtRPfLc2cg1CoPnV0/ANVEJ
         kf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQG94E91rcdUfSlkW1uYF9ApGj+jgzKgN0E+vtaKz6A=;
        b=kYqSFiTXr0v9ldFYajXwAIqEbrqM3nSBmlaeBSW2pbVzmobHs2GVRP2isVcK+Qgy4U
         hnXFISDjTFN8D/rcMVxV6Z3U3e0vD1NVmI1hj9X1a02UHgmV8zYXOHv75bRS7qTDvn9g
         GckJ9sJeN2PBUIn8XAnnQQPQ/DplPJllx852AVOokw8jlltJ2FoafnB6Y5DC+8NfLLLf
         VtSpVvrWLr+pcXr6fU3qAPz5s0M5fIlLbI1DzYrgNR9ovdW+SSF89J4i+aoPygRZpFs+
         vSabuj/auNEStbGkgKMvgabBi/XJz/QEzAdHTxZjY9EBdoqN/KQBot7729zPNpHyoE0u
         i5KA==
X-Gm-Message-State: APjAAAWehiFJg6tn3uII9kECDAZ5oSbjc0he3v/FzvNR71MQJDvCAf9W
        wKwnDtbo8Ay5JxXImPxDO1E=
X-Google-Smtp-Source: APXvYqwYifFGznpVmbp990JQuxYufhL5+M7CwwnvfxITZA/hhhnqSphHZcc/3LL1+bFx/1MWhz5Akw==
X-Received: by 2002:a17:902:28c9:: with SMTP id f67mr20202766plb.19.1558954603720;
        Mon, 27 May 2019 03:56:43 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x10sm14034629pfj.136.2019.05.27.03.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 May 2019 03:56:43 -0700 (PDT)
Date:   Mon, 27 May 2019 03:55:29 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     hch@lst.de, robin.murphy@arm.com, m.szyprowski@samsung.com,
        vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, tony@atomide.com,
        akpm@linux-foundation.org, sfr@canb.auug.org.au,
        treding@nvidia.com, keescook@chromium.org, iamjoonsoo.kim@lge.com,
        wsa+renesas@sang-engineering.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        dann.frazier@canonical.com
Subject: Re: [PATCH v3 2/2] dma-contiguous: Use fallback alloc_pages for
 single pages
Message-ID: <20190527105528.GA26916@Asurada-Nvidia.nvidia.com>
References: <20190524040633.16854-1-nicoleotsuka@gmail.com>
 <20190524040633.16854-3-nicoleotsuka@gmail.com>
 <20190524161618.GB23100@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524161618.GB23100@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ira,

On Fri, May 24, 2019 at 09:16:19AM -0700, Ira Weiny wrote:
> On Thu, May 23, 2019 at 09:06:33PM -0700, Nicolin Chen wrote:
> > The addresses within a single page are always contiguous, so it's
> > not so necessary to always allocate one single page from CMA area.
> > Since the CMA area has a limited predefined size of space, it may
> > run out of space in heavy use cases, where there might be quite a
> > lot CMA pages being allocated for single pages.
> > 
> > However, there is also a concern that a device might care where a
> > page comes from -- it might expect the page from CMA area and act
> > differently if the page doesn't.
> 
> How does a device know, after this call, if a CMA area was used?  From the
> patches I figured a device should not care.

A device doesn't know. But that doesn't mean a device won't care
at all. There was a concern from Robin and Christoph, as a corner
case that device might act differently if the memory isn't in its
own CMA region. That's why we let it still use its device specific
CMA area.

> > +	if (dev && dev->cma_area)
> > +		cma = dev->cma_area;
> > +	else if (count > 1)
> > +		cma = dma_contiguous_default_area;
> 
> Doesn't dev_get_dma_area() already do this?

Partially yes. But unwrapping it makes the program flow clear in
my opinion. Actually I should have mentioned that this patch was
suggested by Christoph also.

Otherwise, it would need an override like:
	cma = dev_get_dma_area();
	if (count > 1 && cma == dma_contiguous_default_area)
		cma = NULL;

Which doesn't look that bad though..

Thanks
Nicolin
