Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80039ECE58E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 597CD21835
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uvYSScH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfJIHhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:37:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37700 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIHhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:37:23 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x997bF5W009620;
        Wed, 9 Oct 2019 02:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570606635;
        bh=GCItb3o8zhNxqRL1dRRtIRmWKNz8QsnOl1OUx9AOT4I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=uvYSScH8JQexfEgbwLHmKsT+mxIii8+PYvvzx80wIrWuyzqCrneKqYeRU+c3v5TjR
         33258nGN8c2GtCF3hKAtxp+bQMLqGjQpQwxQpuqucOv9w2b9AS4gthrF8nqgz3lx3Z
         365eJkW25sexQFudnADgsBKL4aWPCohdphSn5LH4=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x997bFWP060657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Oct 2019 02:37:15 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 9 Oct
 2019 02:37:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 9 Oct 2019 02:37:13 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x997bAx9121069;
        Wed, 9 Oct 2019 02:37:10 -0500
Subject: Re: [PATCH v3 04/14] dmaengine: Add metadata_ops for
 dma_async_tx_descriptor
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-5-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <1d4e049b-737c-3904-2bb1-6e058ab69a4d@ti.com>
Date:   Wed, 9 Oct 2019 10:37:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001061704.2399-5-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2019 09:16, Peter Ujfalusi wrote:
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

Again couple of typos below, but other than that:

Reviewed-by: Tero Kristo <t-kristo@ti.com>

> ---
>   drivers/dma/dmaengine.c   |  73 ++++++++++++++++++++++++++
>   include/linux/dmaengine.h | 108 ++++++++++++++++++++++++++++++++++++++

<snip>

> + * @DESC_METADATA_ENGINE - the metadata buffer is allocated/managed by the DMA
> + *  driver. The client driver can ask for the pointer, maximum size and the
> + *  currently used size of the metadata and can directly update or read it.
> + *  dmaengine_desc_get_metadata_ptr() and dmaengine_desc_set_metadata_len() is
> + *  provided as helper functions.
> + *
> + * Client drivers interested to use this mode can follow:
> + * - DMA_MEM_TO_DEV / DEV_MEM_TO_MEM:
> + *   1. prepare the descriptor (dmaengine_prep_*)
> + *   2. use dmaengine_desc_get_metadata_ptr() to get the pointer to the engine's
> + *	metadata area
> + *   3. update the metadata at the pointer
> + *   4. use dmaengine_desc_set_metadata_len()  to tell the DMA engine the amount
> + *	of data the client has placed into the metadata buffer
> + *   5. submit the transfer
> + * - DMA_DEV_TO_MEM:
> + *   1. prepare the descriptor (dmaengine_prep_*)
> + *   2. submit the transfer
> + *   3. on transfer completion, use dmaengine_desc_get_metadata_ptr() to get the
> + *	pointer to the engine's metadata are

are = area?

> + *   4. Read out the metadate from the pointer

metadate = metadata?

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
