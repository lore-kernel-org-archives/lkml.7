Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA9EC17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A52214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 10:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lVY2X2PD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfKKK2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 05:28:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54172 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKKK2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 05:28:55 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id xABASgF9024340;
        Mon, 11 Nov 2019 04:28:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573468122;
        bh=N3+nkAquCGSpb9qA9Jkp1kcNxBZi2iIfDWLwqJXaOec=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lVY2X2PDWwha9IAD9ulwt6I+UcqchltGoCdyFL0EZUqr41wtxxDU2sQDQzhs8zprf
         rcfv4wPD4c1xAZGtPsomrchWwOFm9ffJFPIPIqa6nVGzN8ZNyR8SC/7lthe/wUtFN9
         zhm8awX6psfFZuOD94ooPhJECr/mT576U5GG0Q5g=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xABASgnC057891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 04:28:42 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 04:28:09 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 04:28:09 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xABASMXF125167;
        Mon, 11 Nov 2019 04:28:23 -0600
Subject: Re: [PATCH v4 12/15] dmaengine: ti: New driver for K3 UDMA - split#4:
 dma_device callbacks 1
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-13-peter.ujfalusi@ti.com>
 <20191111060943.GQ952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <6d73f6e1-6d85-d468-2e69-47d36ed75807@ti.com>
Date:   Mon, 11 Nov 2019 12:29:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111060943.GQ952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2019 8.09, Vinod Koul wrote:
> On 01-11-19, 10:41, Peter Ujfalusi wrote:
> 
>> +/* Not much yet */
> 
> ?

Forgot to remove it when I did implemented the tx_status() ;)

> 
>> +static enum dma_status udma_tx_status(struct dma_chan *chan,
>> +				      dma_cookie_t cookie,
>> +				      struct dma_tx_state *txstate)
>> +{
>> +	struct udma_chan *uc = to_udma_chan(chan);
>> +	enum dma_status ret;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&uc->vc.lock, flags);
>> +
>> +	ret = dma_cookie_status(chan, cookie, txstate);
>> +
>> +	if (!udma_is_chan_running(uc))
>> +		ret = DMA_COMPLETE;
> 
> so a paused channel will result in dma complete status?

The channel is still enabled (running), the pause only sets a bit in the
channel's real time control register.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
