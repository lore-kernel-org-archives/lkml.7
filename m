Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242F8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB761214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 00:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NazPIa6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbfB1All (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 19:41:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37965 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730131AbfB1All (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 19:41:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id m2so8796450pgl.5;
        Wed, 27 Feb 2019 16:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QaQgui+Uqm7iZjL3134DAwSFPs3Gz5Qy3G0UKS3OGfM=;
        b=NazPIa6iJZNoFtWD7cGGaFiEVBgTXdNdje7haVepGKjUIQllpMcAFoZqxHB5HmO17W
         ZD+oy0LUW5h4av3i055X6y+DCdKZH4sB/0TiT9GmRasNaFmA/mgvFPAT0/jadamQN7Oe
         d+Gqa+q1uZBC7A1weRAC7BjnVuKYqrx0RrxZkTDGWm233bPy2HEiwd2rsNnC7x45e2Bt
         eV5qaiZGMMgi8Xpni06DXE7429T9QeOcDsKzX7BDDsM0/mgukoNkd1vfvtZhbFHRtSCc
         A3WLERTQInKuVv4ZQXEXYsdwr6dnu1bIrt4gpHSzr7839azzlw8Fom3GcWjC1FZ0khvb
         NfIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QaQgui+Uqm7iZjL3134DAwSFPs3Gz5Qy3G0UKS3OGfM=;
        b=YPElMc0VWY2Xzt4FIXz8cW47OiHwT8CJ5eYzomQF9LlYfZ21nGyePLKzAxcBe/RD2P
         ve6TI6+DIfvdYr7JNtsW3lAXeV9OpB52ps/v+o2eCJ49DaBMZwT0KV+nf5XA6pha1sy0
         28pG4wF0K9en1diYKYbFlcqDlhyqzpb2+aU+3I76JYx7b7wO2dUKcztwECB4xRFrIAPg
         tqznDeIbPqaz9/iffuCzQCrg/DPO8B4XKBNwn28l/S2zjjkrScr2VDFwLVcEOj7p4G6l
         OqGjwH6iD54ViVyVzcpNd6RVxlJustssDbEowjbOpGdrWe9QlLMpTID1yhUq/cN49GD9
         hm4A==
X-Gm-Message-State: AHQUAuYth13F5i1Vleu+ZHbim9A88LKOWFUBJWFcPCUc58VFHVthwHml
        AD07fATwo+eKq6sZQFOgtzE=
X-Google-Smtp-Source: AHgI3IaX1vRwvf/aQJO2SUwltnjIH9Z6wL26Pop85HDpjfaq/WbWMKVpGE4yDf5cL7votn/kCdJoDQ==
X-Received: by 2002:a63:6244:: with SMTP id w65mr5636697pgb.300.1551314500180;
        Wed, 27 Feb 2019 16:41:40 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::87c4])
        by smtp.gmail.com with ESMTPSA id x15sm22033649pfn.74.2019.02.27.16.41.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 16:41:39 -0800 (PST)
Date:   Wed, 27 Feb 2019 16:41:51 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Samuel Chessman <chessman@tux.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] tlan: use pci_zalloc instead of pci_alloc
Message-ID: <20190228004151.GA26282@bobby.localdomain>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
 <51125a3daac49f7b5bb360a422663aee26e6776b.1551246708.git.bobbyeshleman@gmail.com>
 <ce11feb21863662cf2ad96f0f7b69f0edcabfcf7.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce11feb21863662cf2ad96f0f7b69f0edcabfcf7.camel@perches.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 10:22:06PM -0800, Joe Perches wrote:
> On Tue, 2019-02-26 at 22:09 -0800, Robert Eshleman wrote:
> > This patch replaces a pci_alloc_consistent and memset(,0) call
> > with a single call to pci_zalloc_consistent.
> []
> > diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
> []
> > @@ -845,17 +845,16 @@ static int tlan_init(struct net_device *dev)
> >  
> >  	dma_size = (TLAN_NUM_RX_LISTS + TLAN_NUM_TX_LISTS)
> >  		* (sizeof(struct tlan_list));
> > -	priv->dma_storage = pci_alloc_consistent(priv->pci_dev,
> > -						 dma_size,
> > -						 &priv->dma_storage_dma);
> > +	priv->dma_storage = pci_zalloc_consistent(priv->pci_dev,
> > +						  dma_size,
> > +						  &priv->dma_storage_dma);
> >  	priv->dma_size = dma_size;
> >  
> > -	if (priv->dma_storage == NULL) {
> > +	if (!priv->dma_storage) {
> >  		pr_err("Could not allocate lists and buffers for %s\n",
> >  		       dev->name);
> 
> unrelated trivia:
> 
> This pr_err (and likely others in this file)
> could be replace by netdev_err
> 

Definitely good to know (I may make that change too).  Thanks Joe.

-Bobby
