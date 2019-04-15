Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD866C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955EC20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfDOH7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:59:42 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:51873 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfDOH7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:59:41 -0400
Received: from webmail.gandi.net (webmail14.sd4.0x35.net [10.200.201.14])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPA id AB4E8200012;
        Mon, 15 Apr 2019 07:59:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Apr 2019 09:59:39 +0200
From:   gregory.clement@bootlin.com
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: lpc32xx: stop overwriting TEST_CLK_SEL
In-Reply-To: <20190411141209.3106-1-alexandre.belloni@bootlin.com>
References: <20190411141209.3106-1-alexandre.belloni@bootlin.com>
Message-ID: <b5b97198d85ead33afa2fcf619a50944@bootlin.com>
X-Sender: gregory.clement@bootlin.com
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-11 16:12, Alexandre Belloni wrote:
> While the UDA1380 is described in some lpc3250 device trees, there is
> currently no real user of that codec. Anyway, if the codec needs a 
> clock,
> it should take it explicitly.
> 
> lpc3250_machine_init is called for all the lpc32xx machines and some 
> are
> using test1_clk (for example to strobe an HW watchdog). Overwriting
> TEST_CLK_SEL prevents booting those platforms.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


Tested-by: Gregory CLEMENT <gregory.clement@bootlin.com>


> ---
>  arch/arm/mach-lpc32xx/phy3250.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c 
> b/arch/arm/mach-lpc32xx/phy3250.c
> index fdbb1409c32b..1db8508493a5 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -128,11 +128,6 @@ static void __init lpc3250_machine_init(void)
>  {
>  	lpc32xx_serial_init();
> 
> -	/* Test clock needed for UDA1380 initial init */
> -	__raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC |
> -		LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN,
> -		LPC32XX_CLKPWR_TEST_CLK_SEL);
> -
>  	of_platform_default_populate(NULL, lpc32xx_auxdata_lookup, NULL);
>  }
