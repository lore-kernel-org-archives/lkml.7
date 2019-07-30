Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C562C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F33206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 07:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=innovation.ch header.i=@innovation.ch header.b="DezN6Day"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfG3HBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 03:01:18 -0400
Received: from chill.innovation.ch ([216.218.245.220]:57186 "EHLO
        chill.innovation.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729357AbfG3HBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 03:01:18 -0400
Date:   Tue, 30 Jul 2019 00:01:17 -0700
DKIM-Filter: OpenDKIM Filter v2.10.3 chill.innovation.ch B809F640134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=innovation.ch;
        s=default; t=1564470077;
        bh=odb/ex7qOOtzc025BL4OpTK8RF6DI6yzZ3QasbAko7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DezN6DayzvMgu/0eVN8JKWYfm4qrm28k/brozTrH1P0fsv3tn3MSa7NaSubIEwMBQ
         +D+X7IUoEfacU9ERnhifzW/WVvNH37126TwbQWeV0+oBjAVz7aG02XXybJ+6wpZfWm
         FfDNHjl3+ZfPQZV6F7IyXH7ZWtQw0nuRq7uyUo1qAmlqoW8aY9QTqi+95haW68kUY7
         bDETWtheGhyCZs5ByJTaU3DnkRBv+8bWpphBIhWd5FptidkrJ2EwgDz+1GwBbu/DBC
         fZ8O6/AoG6bP3J+KwEsHnBJDnvIVaMOeHBIMPcAkSCaqtzC3uC6EQwgVj/0/tg9Rxe
         5sWhYQRjbgiBw==
From:   "Life is hard, and then you die" <ronald@innovation.ch>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, nikolas@gnu.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: applespi - Fix build error
Message-ID: <20190730070117.GB20206@innovation.ch>
References: <20190729031455.59400-1-yuehaibing@huawei.com>
 <20190729140438.GA2372@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190729140438.GA2372@penguin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jul 29, 2019 at 04:04:38PM +0200, Dmitry Torokhov wrote:
> On Mon, Jul 29, 2019 at 11:14:55AM +0800, YueHaibing wrote:
> > If CONFIG_KEYBOARD_APPLESPI=y but CONFIG_LEDS_CLASS=m
> > building fails:
> > 
> > drivers/input/keyboard/applespi.o: In function `applespi_probe':
> > applespi.c:(.text+0x1fcd): undefined reference to `devm_led_classdev_register_ext'
> > 
> > Wrap it in LEDS_CLASS macro to fix this.
> 
> No, we should add "depends on LEDS_CLASS" to the Konfig instead.

While the loss of keyboard-backlight functionality is certainly not
critical, in practice when building a kernel for desktops/laptops
(i.e. where this module would be used) I see no real reason why you'd
not have/want LEDS_CLASS enabled. So I'd agree with Dmitry that a
Kconfig depends-on is probably the preferred approach.


  Cheers,

  Ronald

