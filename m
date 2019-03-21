Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53113C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 189FB21900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k37tqebX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfCUXcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:32:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41275 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfCUXcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:32:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so165478pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 16:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GEocbLjjDTKTljdWOMhW+1JP4PUi5ZACKOFHF1tRnIs=;
        b=k37tqebXfM1ddWWXMbk/NieuKojSrULiHf+wTL8c6OHAhh5GpQfn2WjHbp/TdSltyw
         wZ42ZRcM5Q2/TMUfJzz4f5hmIMOikMB1tBFekviHHXQqtHFDdtV1/mod/3KaNl0Lj/Ar
         yDdCTM/Qkwgtdz8Oc1MvejwxYRzzMEJOW5Zi8RDWxN2PMN2rbndXCoj9A0lWn1OV4Ywi
         0l4qqNl3IE1+gAUrKhUGNlskzmKx/nIeDo+aqcZ2mXrIWbqxvSSRvM8tpDiD7GWdcf4B
         MB7L3UCw38Xc1S/QQuVKj3WENIJlbrZdhQt9tFE6mGbF902fiAekZrXvDQ6DoxxhAzF0
         mdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GEocbLjjDTKTljdWOMhW+1JP4PUi5ZACKOFHF1tRnIs=;
        b=iY7DrMS90GyAcm0F30SVgwZEWagaB80Kw7rZreFEFxYOR7htMTyRNmAgAhQWvvRQsP
         9uNRRhA5F8nGyfrORX5JiPTHXJZacwgE45nbl1FEP4nVp21I7w3yf0Q24fdGTmK4BG8D
         kOsP3PlMJVJqt+BW9RTPWhueQYZYfwurJ0gI+aKzRHzSGGGV0t80FDKF3jnsrevKblvu
         n4AZM0cY+F5NBtcsFw+FEfDicbyj8DJu2b9cmc4SRt3xzVthIkdNc5FlSanPlVtRiELd
         PpSztcs0Z1z4zgxZ1oPFMOjO8AHL5AUaeX+0zvZlFGnpFpsdc1rNuuGWZWFEHCmOjr8U
         wm7w==
X-Gm-Message-State: APjAAAXZaFgga2Io6hcOXqB4y2/1riKb2mpXjPngY/HsvQ+m2LG7naq0
        WaCfSWoibvCq86T8lSOmiOs=
X-Google-Smtp-Source: APXvYqwuNdqA1gmUED9ljwJawDm6D4Kj41V/VZoFSFqM7mJPNQTnReo0MaGF0gRsUXP2NBN8MSF01w==
X-Received: by 2002:a62:2a97:: with SMTP id q145mr6187680pfq.22.1553211174050;
        Thu, 21 Mar 2019 16:32:54 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id w18sm10219623pfg.75.2019.03.21.16.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 16:32:53 -0700 (PDT)
Date:   Thu, 21 Mar 2019 16:32:49 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     hch@lst.de, robin.murphy@arm.com, vdumpa@nvidia.com,
        will.deacon@arm.com, chris@zankel.net, jcmvbkbc@gmail.com,
        joro@8bytes.org, dwmw2@infradead.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, iommu@lists.linux-foundation.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH v2 RFC/RFT] dma-contiguous: Get normal pages for
 single-page allocations
Message-ID: <20190321233248.GA6941@Asurada-Nvidia>
References: <20190305183202.16216-1-nicoleotsuka@gmail.com>
 <20190319144301.GG59586@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319144301.GG59586@arrakis.emea.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

Thank you for the review. And I realized that the free() path
is missing too.

On Tue, Mar 19, 2019 at 02:43:01PM +0000, Catalin Marinas wrote:
> On Tue, Mar 05, 2019 at 10:32:02AM -0800, Nicolin Chen wrote:
> > The addresses within a single page are always contiguous, so it's
> > not so necessary to always allocate one single page from CMA area.
> > Since the CMA area has a limited predefined size of space, it may
> > run out of space in heavy use cases, where there might be quite a
> > lot CMA pages being allocated for single pages.
> > 
> > However, there is also a concern that a device might care where a
> > page comes from -- it might expect the page from CMA area and act
> > differently if the page doesn't.
> > 
> > This patch tries to get normal pages for single-page allocations
> > unless the device has its own CMA area. This would save resources
> > from the CMA area for more CMA allocations. And it'd also reduce
> > CMA fragmentations resulted from trivial allocations.
> 
> This is not sufficient. Some architectures/platforms declare limits on
> the CMA range so that DMA is possible with all expected devices. For
> example, on arm64 we keep the CMA in the lower 4GB of the address range,
> though with this patch you only covered the iommu ops allocation.

I will follow the way of v1 by adding alloc_page()/free_page()
function to those callers who don't have fallback allocations.
In this way, archs may use different callbacks to alloc pages.

> Do you have any numbers to back this up? You don't seem to address
> dma_direct_alloc() either but, as I said above, it's not trivial since
> some platforms expect certain physical range for DMA allocations.

What's the dma_direct_alloc() here about? Mind elaborating?
