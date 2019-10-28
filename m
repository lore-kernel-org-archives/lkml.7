Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC35CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259E721479
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389109AbfJ1V5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:57:46 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:48215 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfJ1V5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:57:45 -0400
Received: from belgarion ([90.55.204.252])
        by mwinf5d17 with ME
        id K9xj210025TFNlm039xje7; Mon, 28 Oct 2019 22:57:43 +0100
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Mon, 28 Oct 2019 22:57:43 +0100
X-ME-IP: 90.55.204.252
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 33/46] ARM: pxa: pcmcia: move smemc configuration back to arch
References: <20191018154052.1276506-1-arnd@arndb.de>
        <20191018154201.1276638-33-arnd@arndb.de>
X-URL:  http://belgarath.falguerolles.org/
Date:   Mon, 28 Oct 2019 22:57:43 +0100
In-Reply-To: <20191018154201.1276638-33-arnd@arndb.de> (Arnd Bergmann's
        message of "Fri, 18 Oct 2019 17:41:48 +0200")
Message-ID: <87d0egjzxk.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/26 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> Rather than poking at the smemc registers directly from the
> pcmcia/pxa2xx_base driver, move those bits into machine file
> to have a cleaner interface.
>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> -static int pxa2xx_pcmcia_set_mcxx(struct soc_pcmcia_socket *skt, unsigned int clk)
> +static int pxa2xx_pcmcia_set_timing(struct soc_pcmcia_socket *skt)
>  {
> +	unsigned long clk = clk_get_rate(skt->clk) / 1000;
>  	struct soc_pcmcia_timing timing;
>  	int sock = skt->nr;
>  
>  	soc_common_pcmcia_get_timing(skt, &timing);
>  
> -	pxa2xx_pcmcia_set_mcmem(sock, timing.mem, clk);
> -	pxa2xx_pcmcia_set_mcatt(sock, timing.attr, clk);
> -	pxa2xx_pcmcia_set_mcio(sock, timing.io, clk);
> +	pxa_smemc_set_pcmcia_timing(sock,
> +		pxa2xx_pcmcia_mcmem(sock, timing.mem, clk),
> +		pxa2xx_pcmcia_mcatt(sock, timing.attr, clk),
> +		pxa2xx_pcmcia_mcio(sock, timing.io, clk));
>  
>  	return 0;
>  }
>  
> -static int pxa2xx_pcmcia_set_timing(struct soc_pcmcia_socket *skt)
> -{
> -	unsigned long clk = clk_get_rate(skt->clk);
> -	return pxa2xx_pcmcia_set_mcxx(skt, clk / 10000);
That curious, because you divide here by 10^4, while in the old
pxa2xx_pcmcia_set_mcxx() that was 10^3 ... is that a fix I don't see ?

Cheers.

--
Robert
