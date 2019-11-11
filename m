Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF8EC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544022075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QSJ+7qPZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKKJLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:11:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:37496 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbfKKJLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:11:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xAB9AwrH050270;
        Mon, 11 Nov 2019 03:10:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573463458;
        bh=8Wpw0XqBideX91ytsjRMUFPNbL55iIhVaIU5YNr3y4o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QSJ+7qPZptkGiyhSBZHS5ngqiDD8cRBXkKfgJ/fEbNSuF1Lcr0Wf6pPsizmcj+fyD
         +M67khNbZokWzVBncJK5agHHkQJqF1PvPJF0TluMfdHUTOJ+DiHWnjp06vNGeE+FgJ
         MbUpA7A91C/3XLKKMu+dpW9w+GWyqjnojS5+KyG0=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xAB9AwCX002661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Nov 2019 03:10:58 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 11
 Nov 2019 03:10:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 11 Nov 2019 03:10:39 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xAB9AqA3037788;
        Mon, 11 Nov 2019 03:10:53 -0600
Subject: Re: [PATCH v4 09/15] dmaengine: ti: New driver for K3 UDMA - split#1:
 defines, structs, io func
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-10-peter.ujfalusi@ti.com>
 <20191111052828.GN952516@vkoul-mobl>
 <00777586-a3ac-2404-5226-e8c887936a32@ti.com>
 <20191111090057.GT952516@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <675112ec-d53e-09d6-d511-d04554b96fa0@ti.com>
Date:   Mon, 11 Nov 2019 11:12:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191111090057.GT952516@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2019 11.00, Vinod Koul wrote:
> On 11-11-19, 10:33, Peter Ujfalusi wrote:
>> On 11/11/2019 7.28, Vinod Koul wrote:
>>> On 01-11-19, 10:41, Peter Ujfalusi wrote:
> 
>>>> +	struct udma_static_tr static_tr;
>>>> +	char *name;
>>>> +
>>>> +	struct udma_tchan *tchan;
>>>> +	struct udma_rchan *rchan;
>>>> +	struct udma_rflow *rflow;
>>>> +
>>>> +	bool psil_paired;
>>>> +
>>>> +	int irq_num_ring;
>>>> +	int irq_num_udma;
>>>> +
>>>> +	bool cyclic;
>>>> +	bool paused;
>>>> +
>>>> +	enum udma_chan_state state;
>>>> +	struct completion teardown_completed;
>>>> +
>>>> +	u32 bcnt; /* number of bytes completed since the start of the channel */
>>>> +	u32 in_ring_cnt; /* number of descriptors in flight */
>>>> +
>>>> +	bool pkt_mode; /* TR or packet */
>>>> +	bool needs_epib; /* EPIB is needed for the communication or not */
>>>> +	u32 psd_size; /* size of Protocol Specific Data */
>>>> +	u32 metadata_size; /* (needs_epib ? 16:0) + psd_size */
>>>> +	u32 hdesc_size; /* Size of a packet descriptor in packet mode */
>>>> +	bool notdpkt; /* Suppress sending TDC packet */
>>>> +	int remote_thread_id;
>>>> +	u32 src_thread;
>>>> +	u32 dst_thread;
>>>> +	enum psil_endpoint_type ep_type;
>>>> +	bool enable_acc32;
>>>> +	bool enable_burst;
>>>> +	enum udma_tp_level channel_tpl; /* Channel Throughput Level */
>>>> +
>>>> +	/* dmapool for packet mode descriptors */
>>>> +	bool use_dma_pool;
>>>> +	struct dma_pool *hdesc_pool;
>>>> +
>>>> +	u32 id;
>>>> +	enum dma_transfer_direction dir;
>>>
>>> why does channel have this, it already exists in descriptor
>>
>> The channel can not change role, it is set when it was requested. In the
> 
> how do you do this on set? The channel is requested, we do not know the
> direction. When prep_ is invoked we know it..

In UDMAP we must know it as a channel can do only one direction transfer:

dmas = <&main_udmap 0xc400>, <&main_udmap 0x4400>;
dma-names = "tx", "rx";

0xc400 is a destination thread ID, so the 'tx' channel can only do
MEM_TO_DEV
0x4400 is a source thread, 'rx' can only do DEV_TO_MEM.

We can not switch direction runtime.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
