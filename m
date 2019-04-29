Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6624EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A72A21743
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556547017;
	bh=xj7bE+I4lk+gqwSsMWtKtuHD+DyBxGy5Jwq7FNnHg7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZONN61GSG46zKm2KRlEg8+bjdd2I3hlImOY0fQb6RJxRA1z/lCQe/zy7hbP2fPkBS
	 0/vdlckIHankooKHu6FAEEEubNS/85trv1yt3mNco4pYXgIoS7O8ZV+r/oR2FmB+KX
	 SEjztYvuNPwZg4gQRNGEsNPybDjI1uQciGIMpW6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfD2OKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728208AbfD2OKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:10:15 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 441032084B;
        Mon, 29 Apr 2019 14:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556547015;
        bh=xj7bE+I4lk+gqwSsMWtKtuHD+DyBxGy5Jwq7FNnHg7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Fbmw+8GfM9xj/7f1UtCHL6gJJnj+VwgKny/DnoHygGMICqGYMVUe5SNDrvADfqAM
         xSPtu/3PPUWLU9kBfg3KvVmJEtcZrzIywwscnQzc0XbkCw/JFusAdTCa4pVZ/eCVVU
         o8wAqkVg/dcNQKKgFkWX16cbsggQt/NMy79/6Y8s=
Date:   Mon, 29 Apr 2019 19:40:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, eric.long@unisoc.com,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/7] dmaengine: sprd: Add interrupt support for 2-stage
 transfer
Message-ID: <20190429141009.GO3845@vkoul-mobl.Dlink>
References: <cover.1555330115.git.baolin.wang@linaro.org>
 <07c070b4397296a4500d04abe16dfd8a71a2f211.1555330115.git.baolin.wang@linaro.org>
 <20190429120108.GL3845@vkoul-mobl.Dlink>
 <CAMz4kuJB2+6HziyDep4ctfmjFYpmZ-v_vrFQsJ9tHvwYzSJeKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuJB2+6HziyDep4ctfmjFYpmZ-v_vrFQsJ9tHvwYzSJeKA@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-04-19, 20:11, Baolin Wang wrote:
> On Mon, 29 Apr 2019 at 20:01, Vinod Koul <vkoul@kernel.org> wrote:
> > On 15-04-19, 20:15, Baolin Wang wrote:

> > > @@ -429,6 +433,9 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
> > >               val = chn & SPRD_DMA_GLB_SRC_CHN_MASK;
> > >               val |= BIT(schan->trg_mode - 1) << SPRD_DMA_GLB_TRG_OFFSET;
> > >               val |= SPRD_DMA_GLB_2STAGE_EN;
> > > +             if (schan->int_type != SPRD_DMA_NO_INT)
> >
> > Who configure int_type?
> 
> The int_type is configured through the flags of
> sprd_dma_prep_slave_sg() by users, see:
> https://elixir.bootlin.com/linux/v5.1-rc6/source/include/linux/dma/sprd-dma.h#L9

Please use DMA_PREP_INTERRUPT flag instead!

-- 
~Vinod
