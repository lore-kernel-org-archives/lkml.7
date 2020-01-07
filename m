Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E2C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B64E206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 12:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="s4w3jYTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgAGMTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 07:19:35 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38142 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727177AbgAGMTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 07:19:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 007CJGsI050417;
        Tue, 7 Jan 2020 06:19:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578399556;
        bh=0lJyrfWaHAIClz/zSWrqyl3gjx9r8coTtg1Qa6uzAH4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=s4w3jYTGCgYRMa22i9FZ4VKyAsn1aSA51X38BZzGWOh8+lawk2gkR7JuCtDuv7x8s
         qukAFEtV829aOgKaaLhAkD5syTS9GTZ/xoagNo644QsWPiD6iwX14xxOz8Ep9T3zlH
         NWmDr0gpmYl5SGxHp9G5lyTTl3IpxTedtJRKRgYk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 007CJGYT084614
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Jan 2020 06:19:16 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 7 Jan
 2020 06:19:16 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 7 Jan 2020 06:19:16 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 007CJCbC042717;
        Tue, 7 Jan 2020 06:19:13 -0600
Subject: Re: [PATCH] iio: buffer-dmaengine: Use dma_request_chan() directly
 for channel request
To:     Jonathan Cameron <jic23@kernel.org>, Vinod Koul <vkoul@kernel.org>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <pmeerw@pmeerw.net>
References: <20191113092453.30838-1-peter.ujfalusi@ti.com>
 <20191114043318.GE952516@vkoul-mobl> <20191116162257.550f62d6@archlinux>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <4d4c4338-b028-e28b-a603-323eadebd261@ti.com>
Date:   Tue, 7 Jan 2020 14:19:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191116162257.550f62d6@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan,

On 16/11/2019 18.22, Jonathan Cameron wrote:
> On Thu, 14 Nov 2019 10:03:18 +0530
> Vinod Koul <vkoul@kernel.org> wrote:
> 
>> On 13-11-19, 11:24, Peter Ujfalusi wrote:
>>> dma_request_slave_channel_reason() is:
>>> #define dma_request_slave_channel_reason(dev, name) \
>>> 	dma_request_chan(dev, name)  
>>
>> Reviewed-by: Vinod Koul <vkoul@kernel.org>
>>
> 
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

The sole user in mainline for dma_request_slave_channel_reason() is
industrialio-buffer-dmaengine.c (since v5.5-rc1, 5.4 had 36 users).

Are you planning to queue this patch for 5.6 (not sure if it could be
sent to -rc6) so I can retire it from the dmaengine.h?

Regards,
- Péter

> 
> Thanks,
> 
> Jonathan
> 

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
