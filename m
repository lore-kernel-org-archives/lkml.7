Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81A7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C12920815
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 14:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJ7xw8Jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfCDOss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 09:48:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44953 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfCDOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 09:48:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so3173145pff.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 06:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5M7OwyO6HgUrUJtcdI80kaZEhRjVtvCmXtUf3SxvANc=;
        b=fJ7xw8JdMM4dAArAke476bB1uuQCPCkRpvrEuv694j/65AqpQw4dwu0rT0PLE8CMUq
         8ZZdQa1JhYV/PFADTEKW8EQf740m7UiBQafFMPw0f+JWB6gkNQT1sRny56yLgtwfbyam
         BOXTPFokqTqcXuP1LyUJ3aB7CeOLkIh9sxSpzOQTkgls61EHY1hX56biugQNpS8QZSxd
         mKv1oHHQCqBB5tpWWqtGljY/YWIdAs6CEidAP37ohcKFD7YG14I6eQ4YCA53qJzIxWko
         9MDgc2PyBF6FA1jwGT8IxR4EuM/jf6gZCESscyiP3T75KlE9ZaP4HRq+cF6o6IYWVkyo
         Zc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5M7OwyO6HgUrUJtcdI80kaZEhRjVtvCmXtUf3SxvANc=;
        b=sLvAvhjGsX44DThUQBqSHYI5Pvm5nCR4MyK25Ifglib0+UZxrjzkHV6dSXATPncKpg
         DxTLAIxarm+fR6P4FRiqIrj5WbLdo7cId2AwKTPS6dMjH0EGXhsSuJLRGBQ/lwLESsSZ
         fAddb7VMccddlo8PvDNEYHf06vE/lGcDWo/AGpCJtHyE7eqzCecUZvF+IgX/5k4fzgNM
         hZSnm6qrzoiz+XdWFECltFv4DAA24rEQKvtm5mWKXzGls/C6T4xFrBUjJRl6YPADes/0
         D1UELGNW4jNgZq3VZd94656WdtSGZQGFcKN9t+4D/UFJQxZ0+MmF1vURqLEL7LkyAVW3
         FtYw==
X-Gm-Message-State: APjAAAXO9F4ZqsPBdTP9VbOF3ZnaNmUT0HuqaiM64V+UQ1f+3/hOzgjM
        96rKOQVh/9SeYZXdrLLybqRt
X-Google-Smtp-Source: APXvYqzFd3N9m0cOwhgb2geq+smMS20gI7hq9k0RX5n0UIhO8QQjfez/wbEryv8i0R0DnsQNDgpong==
X-Received: by 2002:a63:f07:: with SMTP id e7mr18909505pgl.173.1551710926837;
        Mon, 04 Mar 2019 06:48:46 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:88c:f338:bc65:e0ee:7524:9950])
        by smtp.gmail.com with ESMTPSA id 63sm10441906pfy.110.2019.03.04.06.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 06:48:46 -0800 (PST)
Date:   Mon, 4 Mar 2019 20:18:29 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wen Yang <wen.yang99@zte.com.cn>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        avifishman70@gmail.com, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Xu Wei <xuwei5@hisilicon.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>, wang.yi59@zte.com.cn
Subject: Re: [PATCH 01/15] ARM: actions: fix a leaked reference by
 addingmissing of_node_put
Message-ID: <20190304144829.GA5265@Mani-XPS-13-9360>
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
 <20190301155523.GA1915@Mani-XPS-13-9360>
 <CACRpkdb=E9_rm4_7DQV3dS5uOs1gozxEwN9MtWr0tTwmjcYe=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdb=E9_rm4_7DQV3dS5uOs1gozxEwN9MtWr0tTwmjcYe=A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Mar 04, 2019 at 01:29:33PM +0100, Linus Walleij wrote:
> On Fri, Mar 1, 2019 at 4:55 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> > Hi Wen,
> >
> > On Fri, Mar 01, 2019 at 04:56:42PM +0800, Wen Yang wrote:
> > > The call to of_get_next_child returns a node pointer with refcount
> > > incremented thus it must be explicitly decremented after the last
> > > usage.
> > >
> > > Detected by coccinelle with the following warnings:
> > > ./arch/arm/mach-actions/platsmp.c:112:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 103, but without a corresponding object release within this function.
> > > ./arch/arm/mach-actions/platsmp.c:124:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 115, but without a corresponding object release within this function.
> > > ./arch/arm/mach-actions/platsmp.c:137:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 128, but without a corresponding object release within this function.
> > >
> >
> > We have a floating patch for this:
> > https://www.spinics.net/lists/arm-kernel/msg694544.html
> >
> > Andreas: Can you please take a second look at the patchset submitted by Linus
> > Walleij and Russel for simplifying the Actions startup code?
> 
> Andreas wrote a version of simplifying secondary startup in the
> same spirit as Russell's patches, and it's merged and all
> is fine I think.
> 

Oops. I think I missed that! Can you please point me to that patch? And how it
got merged? I did the PR for actions stuff this time and haven't included any
mach-actions patches.

Thanks,
Mani

> If this patch applied on top of the current upstream code I'd say
> just forget about my patch and merge Wen's patch instead.
> 
> Yours,
> Linus Walleij
