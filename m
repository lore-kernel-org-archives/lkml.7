Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D45C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B497206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="VflhqV3k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbfC0Lmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:42:33 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:55824 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfC0Lmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:42:32 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 79B2525B7E0;
        Wed, 27 Mar 2019 22:42:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1553686950; bh=+LxG612hogtyb3lg37IijIIpcZzkgm67Lwdv9khiTis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VflhqV3k/RvT5MSUkhbC2iFJuR7ilyPO1D+zVgetftE28k74czs9ph+41bMFy+nNS
         ftwCmoktoXOB3QyTE+Nrb+auNQLLIQkk78gJI/yGZ4uI8vT0Cm+UaEQhM62DLOwwVL
         JehbJm7V6QQykl40n03FjaWEBYqAkDIhwD0yyIGs=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id AEFEA940376; Wed, 27 Mar 2019 12:42:28 +0100 (CET)
Date:   Wed, 27 Mar 2019 12:42:28 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] thermal: stm32: simplify getting .driver_data
Message-ID: <20190327114228.am642i64hscpfx2r@verge.net.au>
References: <20190319163635.30891-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319163635.30891-1-wsa+renesas@sang-engineering.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 05:36:35PM +0100, Wolfram Sang wrote:
> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> 
> Build tested only. buildbot is happy.
> 
>  drivers/thermal/st/stm_thermal.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index bbd73c5a4a4e..cf9ddc52f30e 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -570,8 +570,7 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  static int stm_thermal_suspend(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>  
>  	ret = stm_thermal_sensor_off(sensor);
>  	if (ret)
> @@ -585,8 +584,7 @@ static int stm_thermal_suspend(struct device *dev)
>  static int stm_thermal_resume(struct device *dev)
>  {
>  	int ret;
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct stm_thermal_sensor *sensor = platform_get_drvdata(pdev);
> +	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
>  
>  	ret = stm_thermal_prepare(sensor);
>  	if (ret)
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
