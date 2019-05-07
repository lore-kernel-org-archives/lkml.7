Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BE3C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E94172053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ZffoboO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfEGGWi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:22:38 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:51094 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725858AbfEGGWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:22:37 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7B4ECC01FB;
        Tue,  7 May 2019 06:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557210151; bh=rtlCcy+5EB/RInI7Lu8gsi7Il/2pYlW9pVRFC5xLwm4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=ZffoboO1PJXaeS/kTlekLEZwwi02jdKfjxZoG/kA3mg/NQt3w6cblF4rTn8uwT52G
         vrqzr50Px6UlUxVmLO2NcHVW7cjC0UHeR7qbdL2ShZUzNclazsIDxvj1LVdHtT7lEy
         exMJDvGUD/EmxjoiwgHUVT51twG4u4Z9Fj+l7igLMRkovzn+cRUbMVa8ApqKs+ftee
         ZvLlkmdZPXduO6CAnctFXmRPu2EX6igsuxx3iTGzYvGTVIhsuLVA53fH6cXpXxHVBZ
         pW+8bRbCHMTM83fNjBCKZ0bDpD6GeC0vz8d5A7BMMo7BEtanYbyCrfJkK5D7xrqXR5
         1Pe93Rn6RUk+Q==
Received: from [10.116.70.206] (hminas-7480.internal.synopsys.com [10.116.70.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id DCEBCA0095;
        Tue,  7 May 2019 06:22:34 +0000 (UTC)
Subject: Re: [PATCH] usb: dwc2: Force 8bit UTMI width for Samsung Exynos SoCs
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20190503204958.GA12532@kozik-lap>
 <CGME20190506130052eucas1p25afd4e15648e9efc6fd011e46081fbea@eucas1p2.samsung.com>
 <20190506130046.20898-1-m.szyprowski@samsung.com>
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
Message-ID: <2f09e746-b3da-cac3-56f4-941fa2bca9d4@synopsys.com>
Date:   Tue, 7 May 2019 10:22:33 +0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506130046.20898-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/2019 5:01 PM, Marek Szyprowski wrote:
> Samsung Exynos SoCs require to force UTMI width to 8bit, otherwise the
> host side of the shared USB2 PHY doesn't work.
> 
> Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> Fixes: 707d80f0a3c5 ("usb: dwc2: gadget: Replace phyif with phy_utmi_width")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Acked-by: Minas Harutyunyan <hminas@synopsys.com>

> ---
>   drivers/usb/dwc2/params.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 6900eea57526..9ece4affb9d4 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -76,6 +76,7 @@ static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
>   	struct dwc2_core_params *p = &hsotg->params;
>   
>   	p->power_down = 0;
> +	p->phy_utmi_width = 8;
>   }
>   
>   static void dwc2_set_rk_params(struct dwc2_hsotg *hsotg)
> 

