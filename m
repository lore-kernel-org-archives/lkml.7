Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A146C33C99
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14641207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 08:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbgAGITg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:19:36 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40117 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgAGITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 03:19:36 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iok5P-0005uY-CY; Tue, 07 Jan 2020 09:19:35 +0100
Message-ID: <0ff51b3e4443a03f1d3ee8d3091863e03a22c2cf.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] ata: ahci_brcm: Perform reset after obtaining
 resources
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Jens Axboe <axboe@kernel.dk>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Date:   Tue, 07 Jan 2020 09:19:33 +0100
In-Reply-To: <20200106191906.18266-2-f.fainelli@gmail.com>
References: <20200106191906.18266-1-f.fainelli@gmail.com>
         <20200106191906.18266-2-f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Mon, 2020-01-06 at 11:19 -0800, Florian Fainelli wrote:
> Resources such as clocks, PHYs, regulators are likely to get a probe
> deferral return code, which could lead to the AHCI controller being
> reset a few times until it gets successfully probed. Since this is
> typically the most time consuming operation, move it after the resources
> have been acquired.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/ata/ahci_brcm.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
> index 13ceca687104..70e3e386d52e 100644
> --- a/drivers/ata/ahci_brcm.c
> +++ b/drivers/ata/ahci_brcm.c
> @@ -453,15 +453,9 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  	else
>  		reset_name = "ahci";
>  
> -	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
> -	if (!IS_ERR_OR_NULL(priv->rcdev))
> -		reset_control_deassert(priv->rcdev);
> -
>  	hpriv = ahci_platform_get_resources(pdev, 0);
> -	if (IS_ERR(hpriv)) {
> -		ret = PTR_ERR(hpriv);
> -		goto out_reset;
> -	}
> +	if (IS_ERR(hpriv))
> +		return PTR_ERR(hpriv);
>  
>  	hpriv->plat_data = priv;
>  	hpriv->flags = AHCI_HFLAG_WAKE_BEFORE_STOP | AHCI_HFLAG_NO_WRITE_TO_RO;
> @@ -478,6 +472,10 @@ static int brcm_ahci_probe(struct platform_device *pdev)
>  		break;
>  	}
>  
> +	priv->rcdev = devm_reset_control_get(&pdev->dev, reset_name);
> +	if (!IS_ERR_OR_NULL(priv->rcdev))
> +		reset_control_deassert(priv->rcdev);
> +

Please use devm_reset_control_get_optional_exclusive(), that returns
NULL if the requested reset is not specified in the device tree. Do
return the error code on IS_ERR(). You can then call
reset_control_deassert() unconditionally, it checks for and ignores
the NULL pointer.

regards
Philipp

