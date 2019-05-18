Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A166C072A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 10:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBBC20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 10:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558175811;
	bh=M1cIR0VtB3TnODl/YmcCk/DeYpsOPIWvqiJuH+ZAFUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qqrRPt/w4Hbqr9tAxezBaxxAKkUXYHxfGsRqbZjl2BzMk/4pVK7O21ji4+WbVCLVD
	 jBC38K50w5T8kfwL6VtzvwQmmSTmNnko773wmKMYCeTdXiAY55MVBCfGR8WbIRL30D
	 YfgapAQ45tAXtCe6x56uLZaUEhE3juHYE0u7u9wQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfERKgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 06:36:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfERKgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 06:36:50 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE78A2087E;
        Sat, 18 May 2019 10:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558175809;
        bh=M1cIR0VtB3TnODl/YmcCk/DeYpsOPIWvqiJuH+ZAFUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zHTz8ROxUjXgte53XjHgXP5dkTZVEV0pmQckU89uK6+MPaGeN9/N+brp4jDieoyoc
         k2r6IvTw63gXs8CGpigA7dRWuBeYJkFp5YI+lk10B1P8VTMnmpDlB1s46MDMveWw6h
         0Z9DOouy3lTGmuty10y5oQom+ftK+0O+NPUuqhi4=
Date:   Sat, 18 May 2019 11:36:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <peter.wang@mediatek.com>, <kuohong.wang@mediatek.com>,
        <jg_poxu@mediatek.com>
Subject: Re: [PATCH 4/4] iio: auxadc: mediatek: change to subsys_initcall
Message-ID: <20190518113643.53a42976@archlinux>
In-Reply-To: <1557994247-16739-5-git-send-email-chun-hung.wu@mediatek.com>
References: <1557994247-16739-1-git-send-email-chun-hung.wu@mediatek.com>
        <1557994247-16739-5-git-send-email-chun-hung.wu@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2019 16:10:47 +0800
Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:

>   Move auxadc platform_driver_register() from module_init
> to subsys_initcall because auxadc user drivers
> are all moudle drivers, need to gurantee
> auxadc driver ready before module_init.
> 
Is it not possible to make them use deferred handling to come
back later if this isn't yet available?

subsys_initcall often ends up being a more fragile approach.

Thanks,

Jonathan

> Signed-off-by: Chun-Hung Wu <chun-hung.wu@mediatek.com>
> ---
>  drivers/iio/adc/mt6577_auxadc.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> index 58d7cb2..cb8e3dd 100644
> --- a/drivers/iio/adc/mt6577_auxadc.c
> +++ b/drivers/iio/adc/mt6577_auxadc.c
> @@ -350,7 +350,19 @@ static int mt6577_auxadc_remove(struct platform_device *pdev)
>  	.probe	= mt6577_auxadc_probe,
>  	.remove	= mt6577_auxadc_remove,
>  };
> -module_platform_driver(mt6577_auxadc_driver);
> +
> +static int __init mt6577_auxadc_init(void)
> +{
> +	return platform_driver_register(&mt6577_auxadc_driver);
> +}
> +
> +static void __exit mt6577_auxadc_exit(void)
> +{
> +	platform_driver_unregister(&mt6577_auxadc_driver);
> +}
> +
> +subsys_initcall(mt6577_auxadc_init);
> +module_exit(mt6577_auxadc_exit);
>  
>  MODULE_AUTHOR("Zhiyong Tao <zhiyong.tao@mediatek.com>");
>  MODULE_DESCRIPTION("MTK AUXADC Device Driver");

