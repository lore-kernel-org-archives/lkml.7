Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D87C4CECD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BE6208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 11:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfILLGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 07:06:31 -0400
Received: from mail.thorsis.com ([92.198.35.195]:43925 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731203AbfILLGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 07:06:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 7BD944858;
        Thu, 12 Sep 2019 13:08:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aqkhD7EjSDJZ; Thu, 12 Sep 2019 13:08:05 +0200 (CEST)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 655798D6B; Thu, 12 Sep 2019 13:08:02 +0200 (CEST)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Eugen.Hristev@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, alexandre.belloni@bootlin.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: at91: allow 24 Mhz clock as input for PLL
Date:   Thu, 12 Sep 2019 13:06:20 +0200
Message-ID: <30755021.BkS3ObC0RA@ada>
In-Reply-To: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
References: <1568183622-7858-1-git-send-email-eugen.hristev@microchip.com>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

out of curiosity: The SAMA5D27-SOM1-EK board has a 24 MHz crystal, that is 
also what /sys/kernel/debug/clk/clk_summary says and the board runs without 
obvious problems. What is this change improving in real practice then?

Greets
Alex

Am Mittwoch, 11. September 2019, 06:39:20 CEST schrieb 
Eugen.Hristev@microchip.com:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> The PLL input range needs to be able to allow 24 Mhz crystal as input
> Update the range accordingly in plla characteristics struct
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  drivers/clk/at91/sama5d2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/at91/sama5d2.c b/drivers/clk/at91/sama5d2.c
> index 6509d09..0de1108 100644
> --- a/drivers/clk/at91/sama5d2.c
> +++ b/drivers/clk/at91/sama5d2.c
> @@ -21,7 +21,7 @@ static const struct clk_range plla_outputs[] = {
>  };
> 
>  static const struct clk_pll_characteristics plla_characteristics = {
> -	.input = { .min = 12000000, .max = 12000000 },
> +	.input = { .min = 12000000, .max = 24000000 },
>  	.num_output = ARRAY_SIZE(plla_outputs),
>  	.output = plla_outputs,
>  	.icpll = plla_icpll,


