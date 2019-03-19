Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57134C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE602146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 11:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfCSLNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:13:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:28212 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfCSLNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 07:13:32 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Mar 2019 04:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,497,1544515200"; 
   d="scan'208";a="156311068"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 19 Mar 2019 04:13:29 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 19 Mar 2019 13:13:28 +0200
Date:   Tue, 19 Mar 2019 13:13:28 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: Fix unchecked return value
Message-ID: <20190319111328.GR7752@kuha.fi.intel.com>
References: <20190318211830.GA29785@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318211830.GA29785@embeddedor>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 04:18:30PM -0500, Gustavo A. R. Silva wrote:
> Currently there is no check on platform_get_irq() return value
> in case it fails, hence never actually reporting any errors and
> causing unexpected behavior when using such value as argument
> for function regmap_irq_get_virq().
> 
> Fix this by adding a proper check, a message error and return
> *irq* in case platform_get_irq() fails.
> 
> Addresses-Coverity-ID: 1443899 ("Improper use of negative value")
> Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/wcove.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
> index 423208e19383..6770afd40765 100644
> --- a/drivers/usb/typec/tcpm/wcove.c
> +++ b/drivers/usb/typec/tcpm/wcove.c
> @@ -615,8 +615,13 @@ static int wcove_typec_probe(struct platform_device *pdev)
>  	wcove->dev = &pdev->dev;
>  	wcove->regmap = pmic->regmap;
>  
> -	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr,
> -				  platform_get_irq(pdev, 0));
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		dev_err(&pdev->dev, "Failed to get IRQ: %d\n", irq);
> +		return irq;
> +	}
> +
> +	irq = regmap_irq_get_virq(pmic->irq_chip_data_chgr, irq);
>  	if (irq < 0)
>  		return irq;
>  
> -- 
> 2.21.0

thanks,

-- 
heikki
