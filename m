Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36172C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F4A2070B
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 02:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="WEFXcU/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfHaCxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 22:53:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36724 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbfHaCxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 22:53:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so4439379pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 19:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=TcyKIVZa6jDNzUj3tYKEQq2VBZtAcn28A/dAzDMcqB4=;
        b=WEFXcU/DVe/kv1NFGIue1kkWHjHKcmCywg9nrpJGCiS7ca6W4bHcBM3Cu27gMuR5HW
         uhB/dZVPFbIXfClOL8SnPxO1gxt/kSe123AhkS9dlpnzRIMB4xFdN+j28LPYPlpOf5jH
         Il+lak+vk4acWsOuL/1cgRkKDJq33XxaVya9p5gWcDnqX2DIQJeMkuIbFUoZOvlsIyPA
         WekqyeJle+vtM2rP11vXmJyE90jKsJibWyumscs5dCxyITX7yX5+QdYEE90HUGq6gM7q
         brauFe3CBWQQDuP2LHOGJVQ6f8jCdUzeLVHBFc9BikofxJ6rqOWsnm2GhHiPKZALGh3o
         EQ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=TcyKIVZa6jDNzUj3tYKEQq2VBZtAcn28A/dAzDMcqB4=;
        b=czo6cMxjWkyljQeMHfO/yeoVLJEAOL2hFHBnxpMCs5Vk8j/qKdQJSe5rpmjMpTMgqx
         a6i7gNHxGT4zM8WaGOuMTYmrILoYl2U1/RqZerVP8FSiwYmA9eUT9tHBgG12AcxN8RJI
         DK9CIKyZRoN1C/gov6BkC3Et0e3aS+lcNXBbhCFwNx3Ea9Obaht5z7qYU1nsI1GrVcf3
         ZfDpsodStb3T/Nh+vmzI26mk0aVuEoaDiLjM8tmvBv+ZTUfVejQJrptfRce2yBZ2v41N
         +JQGxd5CD1mBhPa/RvkAwSSzslmAM1R7u6mIxcf+ehjw9iXzWhGMfBm/EcF0vwouJc06
         TIAA==
X-Gm-Message-State: APjAAAVllNy1e9YAneqQGezMX5E0rfCjIW4NdlFpmOlH/DYcpqYQCmU5
        g1q+7rE/265xZcmfofxVTYc/gQ==
X-Google-Smtp-Source: APXvYqxfFVxDzm4BjpO5NkLMuM3Xv0D2H4t0n+BOM+Ax/QLKeOjyc8MmEjXrNdn3uuElKoxhoMgpaA==
X-Received: by 2002:a63:316:: with SMTP id 22mr4527823pgd.242.1567219998821;
        Fri, 30 Aug 2019 19:53:18 -0700 (PDT)
Received: from localhost ([216.9.110.10])
        by smtp.gmail.com with ESMTPSA id i14sm4289933pfo.158.2019.08.30.19.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 19:53:18 -0700 (PDT)
Date:   Fri, 30 Aug 2019 19:53:17 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@alien8.de>,
        palmer@sifive.com, linux-riscv@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH] riscv: move sifive_l2_cache.c to drivers/soc
In-Reply-To: <20190822062635.00f6e507@coco.lan>
Message-ID: <alpine.DEB.2.21.9999.1908301951080.16731@viisi.sifive.com>
References: <20190818082935.14869-1-hch@lst.de> <20190819060904.GA4841@zn.tnic> <20190819062619.GA20211@lst.de> <20190822062635.00f6e507@coco.lan>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Thu, 22 Aug 2019, Mauro Carvalho Chehab wrote:

> I'm wandering if we should at least add an entry for this one at
> MAINTAINERS, pointing it to the EDAC mailing list. Something like:
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7dfe381c8b43..1c3bc5aa3af0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5906,6 +5906,7 @@ M:	Yash Shah <yash.shah@sifive.com>
>  L:	linux-edac@vger.kernel.org
>  S:	Supported
>  F:	drivers/edac/sifive_edac.c
> +F:	drivers/soc/sifive/
>  
>  EDAC-SKYLAKE
>  M:	Tony Luck <tony.luck@intel.com>

There's already a MAINTAINERS entry that should cover drivers/soc/sifive.  
Probably it's not needed to add another one here.


- Paul
