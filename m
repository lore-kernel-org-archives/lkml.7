Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F4BC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17EB20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDyOL8Af"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbfJGRyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:54:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34961 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728079AbfJGRyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:54:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id w2so13490508qkf.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=chm4+pVZmsumVF0HJu/5iYzdACVCyceJBu876a91SHA=;
        b=DDyOL8AfJ8mhpbpT+/dnBo73nA4Aq0nS3BtajVASoI1KcY0G7bbu6hrwgJuutTHcfZ
         mIaznFLDOc69jxYOdRdo7o12FGIN4EQlM2/uVEdewuaqJ+Lns6tt9c2OhGJY6R5b10Ma
         +0VoZfu1IFPUbCQPD0SIZVAKV9k/ePXRZcgSgkRrtU66lRzsvQnjocowjkMrkv5zFUjM
         4/XJZs/oc5/dfv5TRkoFhQmr20n9Tx0a/ljynKW/OAuoH4E3a9VkcgIQbQDifjAImru2
         b4RPjGFtaeF6TR1+svI76vQSYtf22NzJLBvJ/CpT8bbVgPKNs8zTQrKVZwRR5vpX/Ifv
         PF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=chm4+pVZmsumVF0HJu/5iYzdACVCyceJBu876a91SHA=;
        b=teek1QpOmBB0toSctyMVddGb2KKwNRqfpIuZsd7pknAmYkXO01UhoK7dfrD5YAemeP
         tpZSxAgDw9oQB1+9R/q3evtEc8tn1Secp5Spts3ldAtZg8ihkf4EvGb9o50UobqG6M7P
         aRQWIVr/teLU0O7OG5bEW4kG+WOA+9uC/8WrUJk75Da6tcfuADqby/9lAS1oRVnisMNl
         2WlDkDsatf8F97mKfsieILNdg00C047Sq2ouOv+24StNnLp78nqTQEPz8AP53kPoP0X3
         +qUV9Bg5zrFIA70kUPopbMW7siBvM75unZLdS8FuXJMYQF3lPn35+Ca0rWvrNg4LhUxi
         VH+g==
X-Gm-Message-State: APjAAAUxiQAAvxSsyK2lwn7HuQHCHGFZ6F7gVzPKrqyUvZe6y02tvsNi
        SV6HwKtN6/hh7AP10Bzf3mY=
X-Google-Smtp-Source: APXvYqwVmJ4UlHQywYLNcrWm7aqbamCdkRWyXhoEauxVz0tc2kjehxlWXJ2MO+Z7TQttVGJUhS60Uw==
X-Received: by 2002:a37:ad8:: with SMTP id 207mr25405804qkk.38.1570470874752;
        Mon, 07 Oct 2019 10:54:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f27sm7447938qtv.85.2019.10.07.10.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 10:54:34 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 7 Oct 2019 13:54:32 -0400
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: ehci-pci breakage with dma-mapping changes in 5.4-rc2
Message-ID: <20191007175430.GA32537@rani.riverdale.lan>
References: <20191007022454.GA5270@rani.riverdale.lan>
 <20191007073448.GA882@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007073448.GA882@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 09:34:48AM +0200, Christoph Hellwig wrote:
> Hi Arvind,
> 
> can you try the patch below?
> 
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 3f974919d3bd..52b709bf2b55 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3775,6 +3775,13 @@ static int intel_map_sg(struct device *dev, struct scatterlist *sglist, int nele
>  	return nelems;
>  }
>  
> +static u64 intel_get_required_mask(struct device *dev)
> +{
> +	if (!iommu_need_mapping(dev))
> +		return dma_direct_get_required_mask(dev);
> +	return DMA_BIT_MASK(32);
> +}
> +
>  static const struct dma_map_ops intel_dma_ops = {
>  	.alloc = intel_alloc_coherent,
>  	.free = intel_free_coherent,
> @@ -3787,6 +3794,7 @@ static const struct dma_map_ops intel_dma_ops = {
>  	.dma_supported = dma_direct_supported,
>  	.mmap = dma_common_mmap,
>  	.get_sgtable = dma_common_get_sgtable,
> +	.get_required_mask = intel_get_required_mask,
>  };
>  
>  static void

It doesn't boot with the patch. Won't it go
	dma_get_required_mask
	-> intel_get_required_mask
	-> iommu_need_mapping
	-> dma_get_required_mask
?

Should the call to dma_get_required_mask in iommu_need_mapping be
replaced with dma_direct_get_required_mask on top of your patch?
