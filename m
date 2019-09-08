Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1824EC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 14:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C21214DB
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 14:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567952010;
	bh=g9RxzkYEfVpKOAJwV3oEn7y/61ZfPHD/mrK3hZzuHnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T9GmC5wfg3s2m3+/2iaow1S79PrbR2iq1hN8YQkzRjyEBllEUoqqsonzeiUb2cTha
	 jSR471zhRyC6byMo/LHpajQ05IisjcmtSUiz3AUsUFH7pH9YU1m6gxvnmSsCN+HGUN
	 FeMZS0veaELYJ9vcQivJ5GCRQB2x49lQk9kFeS/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbfIHON0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 10:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbfIHON0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 10:13:26 -0400
Received: from localhost (unknown [122.182.221.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69EE0214DB;
        Sun,  8 Sep 2019 14:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567952005;
        bh=g9RxzkYEfVpKOAJwV3oEn7y/61ZfPHD/mrK3hZzuHnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WoBiJ481LdXQmZDqTPxZwAiFcq3EBZGBJ46sim865WlLmOJowtKJuxb6YLB6trmmn
         zupdUdIULJ2hiBhVxS4HtyhqHAfXPBEt2D6AHChVbR25Mt0yfNoLZNBc5SbMXXl8we
         3HmSm+7QUehQ2Xx+PdHsAyJNKOTu76to2aq2y9F4=
Date:   Sun, 8 Sep 2019 19:42:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com
Subject: Re: [PATCH v2 04/14] dmaengine: Add metadata_ops for
 dma_async_tx_descriptor
Message-ID: <20190908141207.GO2672@vkoul-mobl>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-5-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730093450.12664-5-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-07-19, 12:34, Peter Ujfalusi wrote:
> The metadata is best described as side band data or parameters traveling
> alongside the data DMAd by the DMA engine. It is data
> which is understood by the peripheral and the peripheral driver only, the
> DMA engine see it only as data block and it is not interpreting it in any
> way.
> 
> The metadata can be different per descriptor as it is a parameter for the
> data being transferred.
> 
> If the DMA supports per descriptor metadata it can implement the attach,
> get_ptr/set_len callbacks.
> 
> Client drivers must only use either attach or get_ptr/set_len to avoid
> misconfiguration.
> 
> Client driver can check if a given metadata mode is supported by the
> channel during probe time with
> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_CLIENT);
> dmaengine_is_metadata_mode_supported(chan, DESC_METADATA_ENGINE);
> 
> and based on this information can use either mode.
> 
> Wrappers are also added for the metadata_ops.
> 
> To be used in DESC_METADATA_CLIENT mode:
> dmaengine_desc_attach_metadata()
> 
> To be used in DESC_METADATA_ENGINE mode:
> dmaengine_desc_get_metadata_ptr()
> dmaengine_desc_set_metadata_len()
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmaengine.c   |  73 ++++++++++++++++++++++++++
>  include/linux/dmaengine.h | 108 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 181 insertions(+)
> 
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 03ac4b96117c..6baddf7dcbfd 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -1302,6 +1302,79 @@ void dma_async_tx_descriptor_init(struct dma_async_tx_descriptor *tx,
>  }
>  EXPORT_SYMBOL(dma_async_tx_descriptor_init);
>  
> +static inline int desc_check_and_set_metadata_mode(
> +	struct dma_async_tx_descriptor *desc, enum dma_desc_metadata_mode mode)
> +{
> +	/* Make sure that the metadata mode is not mixed */
> +	if (!desc->desc_metadata_mode) {
> +		if (dmaengine_is_metadata_mode_supported(desc->chan, mode))
> +			desc->desc_metadata_mode = mode;

So do we have different descriptors supporting different modes or is it
controlled based? For latter we can do this check at controller
registration!

-- 
~Vinod
