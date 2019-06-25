Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C83C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF99214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vii5TMev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731475AbfFYMbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:31:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46775 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbfFYMbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:31:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so12454138lfh.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDFY+QTqqiMEOnTov2xDeNaIk7HwyPkPWyRkRRHSyzk=;
        b=Vii5TMev7BoCq2nTcUAUy4RbuYP5eF8K02+yxiVUgFGihW7crvsellgGLrySBn9T4t
         +ZkRMd97gjWfE+XgGd8lum0sPzBVxoZ2K816B9DvAM0Ki/jqLCcrmv3VTVxg7HhnpGJp
         SBMWg7UYzZhnl+uubEvGQjLsZDamg4LCVbD6Z8taj5/U/uA//cusuoJF11bC0dy+/Uiz
         qplUPH0xN3gxA8LErE1J7X4fM8KBREa80NElm64vR/wg1VorhA73iqTMYiSCRzSdyLv5
         UYsxileELIgN9UTwdRejFzAe9xZTj31cPdZ1M5xPnuAKfukfgIw6HyLcOEoajwel5ji6
         Xmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDFY+QTqqiMEOnTov2xDeNaIk7HwyPkPWyRkRRHSyzk=;
        b=g/4WDZApnCzn/zIThFfH9dqzPkQQYxYwY6AjScACnLm0wOp8dX5onpE0RdqbgU3DeQ
         UD0w0rP+WTLvH/4stxe6ggwAmHo7ybG7AMuQGjfzaNoHOF5cJ2ASEMHAsqtjgV7AvvBr
         uPm+HzgTRWnZdILz0wgzDPjjKcYH6EL33795nMjsXWkRXwLBhy36tXM06Z6NIx7W35aj
         ExGrg1fyyIZ5F3XZp/lvH6DkeFn1123twbcnTKsjFHggd46BnRljrQFwceZ0SmlhKR5A
         w05BVcSqZRUWvY8NzGfcsqdU+xt7vjhrAaAmEALuyAtrSYY8aDwKdBT15VpoG0ihIF3z
         RUCQ==
X-Gm-Message-State: APjAAAWTFA0VKNgHZ83N6kzjlK15mG24HCncxo9UvO7kiG/0ovWF6p0X
        HPysECgBh0Y7jyL7WM4sP4Mnul4MWTDV90uDZfBqbQ==
X-Google-Smtp-Source: APXvYqxJtx+kv4xSwtZ2Oh9SZIkuBtLHG+NnPvuNmG5fGRPD0rBSI3dyCsgfek9QsPqek/vYbO/dzGax8Uzv7n1exuo=
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr52002001lfg.152.1561465872654;
 Tue, 25 Jun 2019 05:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190618160105.26343-1-alpawi@amazon.com>
In-Reply-To: <20190618160105.26343-1-alpawi@amazon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 25 Jun 2019 14:31:00 +0200
Message-ID: <CACRpkdYgXZzvFKyvySWnsJ2_1pA1e_VHEY-QNzNYCikMUc_WVg@mail.gmail.com>
Subject: Re: [PATCH 0/2] pinctl: armada-37xx: fix for pins 32+
To:     alpawi@amazon.com
Cc:     Benjamin Herrenschmidt <benh@amazon.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 6:01 PM <alpawi@amazon.com> wrote:

> From: Patrick Williams <alpawi@amazon.com>
>
> The 37xx GPIO config registers are only 32 bits long and
> span 2 registers for the NB GPIO controller.  The function
> to calculate the offset was missing the increase to the
> config register.
>
> I have tested both raw gpio access and interrupts using
> libgpiod utilities on an Espressonbin.
>
> The first patch is a simple rename of a function because
> the original name implied it was doing IO itself ("update
> reg").  This patch could be dropped if undesired.
>
> The second patch contains the fix for GPIOs 32+.

This looks good overall. I am waiting for a maintainer review.
If nothing happens in a week, poke me and I'll just apply
the patches.

Yours,
Linus Walleij
