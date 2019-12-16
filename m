Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC88C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABA62072B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 11:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbfLPLUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 06:20:55 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61473 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfLPLUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 06:20:53 -0500
Received: from 79.184.253.1.ipv4.supernova.orange.pl (79.184.253.1) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.320)
 id 8f1ea1b690dcc29b; Mon, 16 Dec 2019 12:20:50 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Yangtao Li <tiny.windzz@gmail.com>, daniel.lezcano@linaro.org
Cc:     shc_work@mail.ru, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: clps711x: convert to devm_platform_ioremap_resource
Date:   Mon, 16 Dec 2019 12:20:50 +0100
Message-ID: <5309821.Xs2qqjuCkx@kreacher>
In-Reply-To: <20191215130206.30265-1-tiny.windzz@gmail.com>
References: <20191215130206.30265-1-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, December 15, 2019 2:02:05 PM CET Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/cpuidle/cpuidle-clps711x.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/cpuidle/cpuidle-clps711x.c b/drivers/cpuidle/cpuidle-clps711x.c
> index 6e36740f5719..fc22c59b6c73 100644
> --- a/drivers/cpuidle/cpuidle-clps711x.c
> +++ b/drivers/cpuidle/cpuidle-clps711x.c
> @@ -37,10 +37,7 @@ static struct cpuidle_driver clps711x_idle_driver = {
>  
>  static int __init clps711x_cpuidle_probe(struct platform_device *pdev)
>  {
> -	struct resource *res;
> -
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	clps711x_halt = devm_ioremap_resource(&pdev->dev, res);
> +	clps711x_halt = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(clps711x_halt))
>  		return PTR_ERR(clps711x_halt);
>  
> 

Daniel, any concerns here?



