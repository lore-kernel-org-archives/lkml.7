Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ADAC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD62215F1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 02:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="jDceI3nu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O4z1YV2Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfLBC6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 21:58:33 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35687 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727313AbfLBC6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 21:58:33 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1B3AC7454;
        Sun,  1 Dec 2019 21:58:32 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Sun, 01 Dec 2019 21:58:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=va9zds2kkUShR4/2SREiF7f/aOZtuH3
        Ys0/FEp1ZZwk=; b=jDceI3nutGxbAnXwraCwd0awJdlJLIV6nu86POF1goIGjwj
        fkJTh25UjJHlQ7tXafJZFsFI7NHapbjsnmJhewc+lZxxF/haezryPBwkxhJLop5U
        2UPj59fTtotjlzuHBMUeoCOkC3vJDcLZUY0hE1681x9X84llYSxPii7CAwkO0JRD
        Y3Kf1A3UWbGqD+cJwqjZ2uXFFj0BO7X+BsTE0zwsDmEZjJfCER0OWUCE271npCWc
        omInFVhWsmqjRr4VKbndggzaTqhD6FLfznHTRAdvFA+BDRTQrNRl4pBHiwdqLxKu
        kb/NB1LeH5iDZcLuMkDIY7jVeKrHDAg7ALZi65Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=va9zds
        2kkUShR4/2SREiF7f/aOZtuH3Ys0/FEp1ZZwk=; b=O4z1YV2ZcKXlyoADN68i23
        fUWjLMPJSxjjrRkBoFgZfVXyFpLVKUdJ2SCkWjXAW8tDpCxh2KA0TQ9MoOF/HKRc
        yJTW8o05RhhK4QkGB+utHy2CrVKHoUOg19Rv1AiYXlSU1g6snDXKy0Jp85UCyVrq
        5BrNdunwfP3AH4ygvU/2X1J2s5iDgvMHtpgww2UsTIY03Svvt2ZSXtiXdqu+TTZx
        BMWYb+c41h8ePkOmieAulbCZ0DeQhWrCmFZboQ7vp+XhOjjJTBj7GU3wqXVXJO6K
        m3DIGYhkyxN72TEnNcFGIhWJcIoriJSMDkORVOdJbjEsxFgNqmLhTs9w9Ke9yItg
        ==
X-ME-Sender: <xms:133kXey_hHH90ZeIXz0PoPZx-AesddbFlCyHqhreGeabCZbG-3Un2A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudejgedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuffhomh
    grihhnpehlkhhmlhdrohhrghenucfrrghrrghmpehmrghilhhfrhhomheprghnughrvgif
    segrjhdrihgurdgruhenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:133kXdbBpwIgMIZCczyiKMb7j8BB6YfbLNlnfI2qsVN4a6hje9XK2w>
    <xmx:133kXdxdHEMWPuOsLvaET6elCJs_3mUYaYRHifla1dhHNlpbD2PBKg>
    <xmx:133kXZEdWm1-Ex58vbF_gV_2CYGAJqQcVksLf3YgNDI3ddz7snB81w>
    <xmx:2H3kXcYiLFyK3Z5DQJ16JfqzwmN3yN79gDv1ty-X1vsUpGmolVhPRA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D3C7AE00A2; Sun,  1 Dec 2019 21:58:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-578-g826f590-fmstable-20191119v1
Mime-Version: 1.0
Message-Id: <23d79dff-6577-4fba-b7e6-d494ec7b8a93@www.fastmail.com>
In-Reply-To: <20191129172537.31410-3-m.felsch@pengutronix.de>
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-3-m.felsch@pengutronix.de>
Date:   Mon, 02 Dec 2019 13:30:04 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Marco Felsch" <m.felsch@pengutronix.de>,
        support.opensource@diasemi.com, "Lee Jones" <lee.jones@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Bartosz Golaszewski" <bgolaszewski@baylibre.com>,
        "Joel Stanley" <joel@jms.id.au>, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>
Subject: =?UTF-8?Q?Re:_[PATCH_v3_2/6]_gpio:_make_gpiod=5Fto=5Foffset()_available_?=
 =?UTF-8?Q?for_other_users?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 30 Nov 2019, at 03:55, Marco Felsch wrote:
> Currently gpiod_to_offset() is a gpio-subsystem private function which
> is used by the gpiolib itself and by the aspeed gpio driver. The time
> has shown that there are other drivers as well which need this
> information in some special cases e.g. MFD drivers. The patch makes the
> function public but you need to explicit add the <linux/gpio/private.h>
> include. See discussion [1] for more information.
> 
> [1] https://lkml.org/lkml/2019/11/27/357
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
> v3:
> - former patch description was "gpio: add support to get local gpio number"
> - adapt commit message and description to reflect new state
> - don't add wrapper instead use the already existing gpiod_to_offset
> - move gpiod_to_offset from gpiolib.h into gpiolib.c
> - move declaration into linux/gpio/private.h
> ---
>  drivers/gpio/gpio-aspeed.c   | 11 +++++------

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
