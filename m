Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562D9CA9EC4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 05:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CCE20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 05:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GaC3Sbcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfJ3FJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 01:09:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41808 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfJ3FJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 01:09:14 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9U59AEd030682;
        Wed, 30 Oct 2019 00:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572412150;
        bh=+UZO5Rzpyae9BI3I3UhwNUHD9+mTPpwFLq884upLfIU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GaC3SbcrrCYVrhz+qF5M0oNiwmYRF7DAqBcRQ+KiT9r3OYYmpBnOTvzePUTdrl2dh
         r/UPAbCEkAdjGlY7FMP1TRlDV+s5P5d5H03oL1uMYaZQm6JjjEpcaq+Vh+q9uYJU3A
         P3ArbojLgNed10bOwUQ0HmDpMdqeYggvkZhiHtFs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9U59AeA012986
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Oct 2019 00:09:10 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 30
 Oct 2019 00:08:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 30 Oct 2019 00:09:09 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9U596Lf053443;
        Wed, 30 Oct 2019 00:09:07 -0500
Subject: Re: [PATCH] phy: broadcom: phy-brcm-usb-init.c: Fix comparing pointer
 to 0
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        <alcooperx@gmail.com>, <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     <saurav.girepunje@hotmail.com>
References: <20191028202945.GA29284@saurav>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d3e2fca7-3552-bf98-f455-7cd27f04336c@ti.com>
Date:   Wed, 30 Oct 2019 10:38:33 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191028202945.GA29284@saurav>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/10/19 1:59 AM, Saurav Girepunje wrote:
> Compare pointer-typed values to NULL rather than 0
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

I've already merged a patch by Ben Dooks for fixing this
https://lore.kernel.org/r/20191015160332.15244-2-ben.dooks@codethink.co.uk

Thanks
Kishon

> ---
>  drivers/phy/broadcom/phy-brcm-usb-init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/broadcom/phy-brcm-usb-init.c b/drivers/phy/broadcom/phy-brcm-usb-init.c
> index 3c53625f8bc2..2ea1e84b544b 100644
> --- a/drivers/phy/broadcom/phy-brcm-usb-init.c
> +++ b/drivers/phy/broadcom/phy-brcm-usb-init.c
> @@ -707,7 +707,7 @@ static void brcmusb_usb3_otp_fix(struct brcm_usb_init_params *params)
>  	void __iomem *xhci_ec_base = params->xhci_ec_regs;
>  	u32 val;
>  
> -	if (params->family_id != 0x74371000 || xhci_ec_base == 0)
> +	if (params->family_id != 0x74371000 || xhci_ec_base == NULL)
>  		return;
>  	brcmusb_writel(0xa20c, USB_XHCI_EC_REG(xhci_ec_base, IRAADR));
>  	val = brcmusb_readl(USB_XHCI_EC_REG(xhci_ec_base, IRADAT));
> 
