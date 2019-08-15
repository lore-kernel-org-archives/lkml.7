Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDABC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB2A2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbfHOUam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:30:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40812 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHOUam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:30:42 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyMON-0005jQ-Os; Thu, 15 Aug 2019 22:30:39 +0200
Date:   Thu, 15 Aug 2019 22:30:39 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Helmut Grohne <helmut.grohne@intenta.de>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "clocksource/drivers/sp804: Add COMPILE_TEST to
 CONFIG_ARM_TIMER_SP804"
In-Reply-To: <20190815120352.3sakpao2cpjl3sl2@laureti-dev>
Message-ID: <alpine.DEB.2.21.1908152227590.1908@nanos.tec.linutronix.de>
References: <20190815120352.3sakpao2cpjl3sl2@laureti-dev>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Aug 2019, Helmut Grohne wrote:

> This reverts commit dfc82faad72520769ca146f857e65c23632eed5a.
> 
> The commit effectively makes ARM_TIMER_SP804 depend on COMPILE_TEST,
> which makes it unselectable for practical uses.
> 
> Link: https://lore.kernel.org/lkml/20190618120719.a4kgyiuljm5uivfq@laureti-dev/
> Signed-off-by: Helmut Grohne <helmut.grohne@intenta.de>
> ---
>  drivers/clocksource/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 5e9317dc3d39..72e924374591 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -393,7 +393,7 @@ config ARM_GLOBAL_TIMER
>  	  This options enables support for the ARM global timer unit
>  
>  config ARM_TIMER_SP804
> -	bool "Support for Dual Timer SP804 module" if COMPILE_TEST
> +	bool "Support for Dual Timer SP804 module"

The obvious fix is to add

    	depends on ARM || ARM64 || COMPILE_TEST

instead of reverting the whole thing. Care to do that?

Thanks,

	tglx
