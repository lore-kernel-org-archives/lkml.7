Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F8FC18E7D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8647C20851
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 09:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p1vVrT54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfEVJab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 05:30:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39411 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbfEVJab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 05:30:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id n25so1416389wmk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 02:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+VK7fLshFfrAgd2rmmiVLNHyPAHPZZGXsuVy0XdS+Zc=;
        b=p1vVrT54TqP7Tv92KeSNxtCIKuVh2was82RL9sqlsEHAdDh2H92mU+5C8DI7g4nWA9
         i3gl7B3ndoe5+0YE0YsQh97LdUGeRyA+qKuVr5IxMCSdyTmWj88ezs+VPsiQSidfaUOx
         nMwyYdFrAY59hOb8Z70FDRyo6llGJNl1RnZaQjrFuGtBibmnjtPtJcqWMQBzAKGJi/yY
         w90y0HTNXO0xxbADc/H1ZIfStFB8ee25hmcLtJs5/3Rwiyv8rZau4N9xonQVjuERSZ9g
         5zA4zplXyKSdEUdqJDu/8K+MjKIv7rFTsGhQd76J7EIAPwSf8VO3O6ukvm1/MoxXQZxN
         yNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+VK7fLshFfrAgd2rmmiVLNHyPAHPZZGXsuVy0XdS+Zc=;
        b=oZ7S3LPGduP005yM7GTtosRiedLY0FNbtqNFRYks3SDw5ihXCxvqF/FQYX0tuXMKoo
         l6jTpRjpfu0QH8gcfPqMhn2O6QwXp9bs4UkjEdqWFyHPihkHcMOs1Von9ta76jDuoP7v
         cvus+RjlkwlmWc0JrE1rWv6IGatawZgoxaYPWtSrhxUkM/6a2qHtCockX+P2s5yM396B
         CFgyKEL1t5B6apbkzYjh8/9xN9BD68KEle6CeTQ1wQPnTnh8DohHYMpLiSXh+XRGg03I
         lZNDhoA7Uu0hAVE5PLgfcrf/UAqH73zLi1oAFPm76vDzFKeXvI2aJYyBm4q6nKKmYKNI
         e2sA==
X-Gm-Message-State: APjAAAUVfSRfL398IX/CWU/LoIhBKcc8U6FQVJDNI+kiJd2Jcos4Ykub
        gCYRdYFsWfWAL2AXOy7qLMZqPQ==
X-Google-Smtp-Source: APXvYqwWvQYOAuut9pW+SWIr2WhinP84EdHxdOWjWpQnLL2IrrpfL3/E5WtmX1qrlrUmJEKNMHencA==
X-Received: by 2002:a1c:7503:: with SMTP id o3mr7066267wmc.28.1558517429034;
        Wed, 22 May 2019 02:30:29 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id g17sm21322431wrr.65.2019.05.22.02.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 02:30:28 -0700 (PDT)
Date:   Wed, 22 May 2019 10:30:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] pinctrl: stmfx: Fix compile issue when CONFIG_OF_GPIO is
 not defined
Message-ID: <20190522093026.GG4574@dell>
References: <1558338735-8444-1-git-send-email-amelie.delaunay@st.com>
 <20190522054833.GB4574@dell>
 <eb8425ec-989a-9701-7fee-61bd1d2b93c1@st.com>
 <20190522084133.GF4574@dell>
 <bc1b5f1d-23b0-141d-f58f-b54ac303fe20@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc1b5f1d-23b0-141d-f58f-b54ac303fe20@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 May 2019, Amelie DELAUNAY wrote:

> On 5/22/19 10:41 AM, Lee Jones wrote:
> > On Wed, 22 May 2019, Amelie DELAUNAY wrote:
> >> On 5/22/19 7:48 AM, Lee Jones wrote:
> >>> On Mon, 20 May 2019, Amelie Delaunay wrote:
> >>>
> >>>> When CONFIG_GPIO_OF is not defined, struct gpio_chip 'of_node' member does
> >>>> not exist:
> >>>> drivers/pinctrl/pinctrl-stmfx.c: In function 'stmfx_pinctrl_probe':
> >>>> drivers/pinctrl/pinctrl-stmfx.c:652:17: error: 'struct gpio_chip' has no member named 'of_node'
> >>>>        pctl->gpio_chip.of_node = np;
> >>>>
> >>>> Fixes: 1490d9f841b1 ("pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver")
> >>>> Reported-by: kbuild test robot <lkp@intel.com>
> >>>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> >>>> ---
> >>>>    drivers/pinctrl/pinctrl-stmfx.c | 2 ++
> >>>>    1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
> >>>> index eba872c..bb64aa0 100644
> >>>> --- a/drivers/pinctrl/pinctrl-stmfx.c
> >>>> +++ b/drivers/pinctrl/pinctrl-stmfx.c
> >>>> @@ -648,7 +648,9 @@ static int stmfx_pinctrl_probe(struct platform_device *pdev)
> >>>>    	pctl->gpio_chip.base = -1;
> >>>>    	pctl->gpio_chip.ngpio = pctl->pctl_desc.npins;
> >>>>    	pctl->gpio_chip.can_sleep = true;
> >>>> +#ifdef CONFIG_OF_GPIO
> >>>>    	pctl->gpio_chip.of_node = np;
> >>>> +#endif
> >>>
> >>> This is pretty ugly.  Will STMFX ever be used without OF support?  If
> >>> not, it might be better to place this restriction on the driver as a
> >>> whole.
> >>>
> >>> Incidentally, why is this blanked out in the structure definition?
> >>> Even 'struct device' doesn't do this.
> >>>
> >> config PINCTRL_STMFX
> >> 	tristate "STMicroelectronics STMFX GPIO expander pinctrl driver"
> >> 	depends on I2C
> >> 	depends on OF || COMPILE_TEST
> >> 	select GENERIC_PINCONF
> >> 	select GPIOLIB_IRQCHIP
> >> 	select MFD_STMFX
> >>
> >> The issue is due to COMPILE_TEST: would "depends on OF || (OF &&
> >> COMPILE_TEST)" be better ?
> > 
> > Linus would be in a better position to respond, but from what I can
> > see, maybe:
> > 
> >    depends on OF || (OF_GPIO && COMPILE_TEST)
> > 
> > Although, I'm unsure why other COMPILE_TESTs haven't highlighted this
> > issue.  Perhaps because they have all been locked down to a particular
> > arch:
> > 
> > $ grep COMPILE_TEST -- drivers/pinctrl/Kconfig
> > 	bool "Support pin multiplexing controllers" if COMPILE_TEST
> > 	bool "Support pin configuration controllers" if COMPILE_TEST
> > 	depends on OF && (ARCH_DAVINCI_DA850 || COMPILE_TEST)
> > 	depends on OF && (ARCH_DIGICOLOR || COMPILE_TEST)
> > 	depends on OF && (ARCH_LPC18XX || COMPILE_TEST)
> > 	depends on ARCH_R7S72100 || COMPILE_TEST
> > 	depends on ARCH_R7S9210 || COMPILE_TEST
> > 	depends on ARCH_RZN1 || COMPILE_TEST
> > 	depends on MIPS || COMPILE_TEST
> > 
> > What about adding this to your Kconfig entry:
> > 
> >    select OF_GPIO
> > 
> 
> Yes COMPILE_TEST is combined with arch when depending on OF. But STMFX 
> isn't arch dependent, it is just OF and I2C dependent.
> 
> Randy also see a build error in pinctrl-stmfx.c when CONFIG_OF is not 
> set/enabled (randconfig):
> 
> ../drivers/pinctrl/pinctrl-stmfx.c:409:20: error: 
> ‘pinconf_generic_dt_node_to_map_pin’ undeclared here (not in a function)
>    .dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
> 
> OF_GPIO depends on OF.
> 
> So either
>      depends on OF || (OF && COMPILE_TEST)
> or
>      depends on OF || (OF_GPIO && COMPILE_TEST)
> 
> and
> 
>      select OF_GPIO
> 
> What is the prettiest way ?

I'll leave the final call up to Linus.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
