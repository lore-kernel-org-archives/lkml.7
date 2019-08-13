Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9014DC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D46205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBdZbbpf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfHMVMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:12:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38595 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfHMVMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:12:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id m12so11161411plt.5;
        Tue, 13 Aug 2019 14:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FMTZJ1aiZ/0neMZIJIfdCL03wiBYtnF9l3HUQlAYkfM=;
        b=UBdZbbpfTWiMG45dD99/jnk1Qg4/EW7lShmDgqEaUP1kZ4OeSPf9AHWgGwL7xstCQq
         eGk1slz4uVR9cMtThrKOCf8QuPhW/LpC+qhg6lMaeSGSOadO4SwaMgTE2yWCEIi5lyMJ
         F6q0XD6F2D+GK2Q2mRLosHyw2o+DYepPim63nkZZAWdep21CeGrvHCa1qk5h+MsSiz57
         TrO7XlnLDXcw+syTN4g+MKsAIBN0qYs5zUhmc5hTxUvO2OrDs/boK+51QbG5GhteBxGK
         l1bJtmEXB58q4obqrbwD59kZDfsxPbfSwap7tlQQeXPje1UTvh7vhYxj7Omq2juQOU9P
         CKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FMTZJ1aiZ/0neMZIJIfdCL03wiBYtnF9l3HUQlAYkfM=;
        b=W/WG7mDuzTKNxx2wadX1N/zS2JgVQOBKlipyIXh6T7V5QCymXyGg/tehklbX0fNLB4
         sPUxtIeoFIBtjiuJcaLRUPlZpZBHjhfhKA6SSTIoVUf//TsmF32WGfAXQSqIToWueXx9
         h3xRCTK+EnJhS/WPZ36aLulsYex+iuhMXsoVo9B4/m4x6AI3Ehr5tSoczsFi1PzGRxoJ
         CGWAlERbywSGPUjiHR5RqP02WrKH3DwiQKD7Xa31hZLISh6MME41G8YvDv41K8pkjYrH
         b3ykjAm47X6oDMWX542AJ17WyIkrIbZFq5bw9+EkjQD1/W6wQ+cqItgk6N0Y0G1j6Abu
         xpKQ==
X-Gm-Message-State: APjAAAXKuqfAF9AHf6/WLxCboLocIiWvCce6ESrW6FRcrP2XgnfiHY54
        yceZfFyw/S4KdRQP0zzImrU=
X-Google-Smtp-Source: APXvYqwPLiE5R2WBPKC4YOkIWhqTWmJSM/5GBkicwcSuUUURz6mfiMeLgdoUjUyceQK8l7WuIaYEIw==
X-Received: by 2002:a17:902:ba81:: with SMTP id k1mr19879412pls.213.1565730759731;
        Tue, 13 Aug 2019 14:12:39 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id e2sm8584707pff.49.2019.08.13.14.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Aug 2019 14:12:39 -0700 (PDT)
Date:   Tue, 13 Aug 2019 14:13:38 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        vdumpa@nvidia.com
Subject: Re: [PATCH] mmc: tegra: Implement enable_dma() to set dma_mask
Message-ID: <20190813211337.GA18501@Asurada-Nvidia.nvidia.com>
References: <20190812224217.12423-1-nicoleotsuka@gmail.com>
 <20190813093651.GE1137@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813093651.GE1137@ulmo>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 11:36:51AM +0200, Thierry Reding wrote:
> On Mon, Aug 12, 2019 at 03:42:17PM -0700, Nicolin Chen wrote:
> > Commit 68481a7e1c84 ("mmc: tegra: Mark 64 bit dma broken on Tegra186")
> > added a SDHCI_QUIRK2_BROKEN_64_BIT_DMA flag to let sdhci core fallback
> > to 32-bit DMA so as to fit the 40-bit addressing on Tegra186. However,
> > there's a common way, being mentioned in sdhci.c file, to set dma_mask
> > via enable_dma() callback in the device driver directly.
> > 
> > So this patch implements an enable_dma() callback in the sdhci-tegra,
> > in order to set an accurate DMA_BIT_MASK, other than 32-bit or 64-bit.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-tegra.c | 28 +++++++++++++++++++---------
> >  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> I like this. However, I'd prefer if we set the DMA mask explicitly for
> each generation. A while ago, I had done a similar patch which relied on
> some core changes that no longer seem necessary with this enable_dma()
> hook. You can find the DMA masks for each generation in that patch:
> 	http://patchwork.ozlabs.org/patch/1020678/

Thank you for the reference patch. I will add those masks in v2.
