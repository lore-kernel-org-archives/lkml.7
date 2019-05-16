Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FBCC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A758720848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 10:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEPKpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 06:45:19 -0400
Received: from foss.arm.com ([217.140.101.70]:41372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbfEPKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 06:45:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E43D319BF;
        Thu, 16 May 2019 03:45:18 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8F1D3F703;
        Thu, 16 May 2019 03:45:17 -0700 (PDT)
Subject: Re: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required
 pixel clock rate
To:     Wen He <wen.he_1@nxp.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "liviu.dudau@arm.com" <liviu.dudau@arm.com>
Cc:     Leo Li <leoyang.li@nxp.com>
References: <20190515024348.43642-1-wen.he_1@nxp.com>
 <3f87b2a7-c7e8-0597-2f62-d421aa6ccaa5@arm.com>
 <AM0PR04MB4865435E9FA2D61E2D9A238EE20A0@AM0PR04MB4865.eurprd04.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <edd9dc6c-aba2-3881-3121-efee388b47cf@arm.com>
Date:   Thu, 16 May 2019 11:45:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4865435E9FA2D61E2D9A238EE20A0@AM0PR04MB4865.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2019 10:42, Wen He wrote:
> 
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: 2019年5月16日 1:14
>> To: Wen He <wen.he_1@nxp.com>; dri-devel@lists.freedesktop.org;
>> linux-kernel@vger.kernel.org; liviu.dudau@arm.com
>> Cc: Leo Li <leoyang.li@nxp.com>
>> Subject: [EXT] Re: [v1] drm/arm/mali-dp: Disable checking for required pixel
>> clock rate
>>
>> Caution: EXT Email
>>
>> On 15/05/2019 03:42, Wen He wrote:
>>> Disable checking for required pixel clock rate if ARCH_LAYERSCPAE is
>>> enable.
>>>
>>> Signed-off-by: Alison Wang <alison.wang@nxp.com>
>>> Signed-off-by: Wen He <wen.he_1@nxp.com>
>>> ---
>>> change in description:
>>>        - This check that only supported one pixel clock required clock rate
>>>        compare with dts node value. but we have supports 4 pixel clock
>>>        for ls1028a board.
>>>    drivers/gpu/drm/arm/malidp_crtc.c | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/arm/malidp_crtc.c
>>> b/drivers/gpu/drm/arm/malidp_crtc.c
>>> index 56aad288666e..bb79223d9981 100644
>>> --- a/drivers/gpu/drm/arm/malidp_crtc.c
>>> +++ b/drivers/gpu/drm/arm/malidp_crtc.c
>>> @@ -36,11 +36,13 @@ static enum drm_mode_status
>>> malidp_crtc_mode_valid(struct drm_crtc *crtc,
>>>
>>>        if (req_rate) {
>>>                rate = clk_round_rate(hwdev->pxlclk, req_rate);
>>> +#ifndef CONFIG_ARCH_LAYERSCAPE
>>
>> What about multiplatform builds? The kernel config doesn't tell you what
>> hardware you're actually running on.
>>
> 
> Hi Robin,
> 
> Thanks for your reply.
> 
> In fact, Only one platform integrates this IP when CONFIG_ARCH_LAYERSCAPE is set.
> Although this are not good ways, but I think it won't be a problem under multiplatform builds.

My point is that ARCH_LAYERSCAPE is going to be enabled in distribution 
kernels along with everything else, so you're effectively removing this 
check for all other vendors' Mali-DP implementations as well, which is 
probably not OK.

Furthermore, if LS1028A really only supports 4 specific modes as the BSP 
documentation I found claims, then surely you'd want a *more* specific 
check here, rather than no check at all?

Robin.
