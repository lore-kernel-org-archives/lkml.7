Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159C8C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A792075B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 22:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fYfSEu0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfG1WLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 18:11:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46186 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfG1WLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 18:11:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so56726358ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 15:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P/UUoIRi1saO6ICrZirvERC3tkUx/Rrg9Uu5W/WNhiI=;
        b=fYfSEu0NfzDyjpxjq/ysAcfDfZY2Yjdv2Ql2GucgXtjPYlngCS87l9KxOWAW9WqMsG
         7YQnuBTDQi5lzkUsX7ju8ANwHjvY9RUH9p8uqm7fuSwta6Dlt3zwJ2m7C99onbm2WOlO
         5kQIlhiEAqqZbf+UX43YuSJRk4k/V7goItgDwki5TllMdkb/aJYwH7SA5dBL/xuSuWDW
         Jq2AC0UUkcz96HnCyDSY+VjSrm3G0lf77JURZyw8jThfrM1MQ+H496xoacb3imKl/1Ie
         Nwjrrj+N5WFI4HRChmgn3C8YEOlQy+2sFGBTBwZ6HxhsL2++jWO2ibkrrJXXfDzkk+OZ
         grUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P/UUoIRi1saO6ICrZirvERC3tkUx/Rrg9Uu5W/WNhiI=;
        b=dK0w2ResZT1RPUrMYS/aGO1avq6Gf33sYEhYEY2drZqAW02YouxxEoQtIWXoa324CJ
         9dRH9PPAuMzF3mvlKgFRKe+UavK3ixnwS5T6PBBwFCnq7XUMCxS4cwLcSC4AH0i08jV4
         KWg891CWwgwgKojxiwUxeiSRzBiXBT0qWBaJwuHXBoD89aNRURqDO8KgXzue2X59sMsJ
         hB/thw6ggOFfa5eAEz8lfycSdxAVW8x+m43OqvLwFxMH+BdcAwvQ+Hy1QHPCsfkNkZef
         7X5O8Be/KI1orEeqVfffUNJ6GZ49pMmmhv37dKZ6o4WTPuWcO15tCT3LqdbzKewth6zK
         P/zg==
X-Gm-Message-State: APjAAAWeVknhAzZWw/Mj5tZGXD6MQq1XeoKdQ91uI8M51XUdxQtvxNYh
        6tdk3npBAzwBIzo0LfK9C3Ne2h0EYmy9MEypgT+JlQFV
X-Google-Smtp-Source: APXvYqxyPrbflvR8n7bEZTuQzLrXMs+cK8AFTQaEbNF0iOHog8ehTxf2NGg3ABVcU7uIcSaEND69PlsoNKKHH90DCGU=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr34303871ljm.180.1564351912427;
 Sun, 28 Jul 2019 15:11:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190713075259.243565-1-dmitry.torokhov@gmail.com> <20190713075259.243565-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20190713075259.243565-2-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 Jul 2019 00:11:41 +0200
Message-ID: <CACRpkdZxJZyQD4WZ68hSNGXtGS23hHDv=rrnu9oFmMN0oRNb2w@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers: base: swnode: link devices to software nodes
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 13, 2019 at 9:53 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> It is helpful to know what device, if any, a software node is tied to, so
> let's store a pointer to the device in software node structure. Note that
> children software nodes will inherit their parent's device pointer, so we
> do not have to traverse hierarchy to see what device the [sub]tree belongs
> to.
>
> We will be using the device pointer to locate GPIO lookup tables for
> devices with static properties.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If some device core person like Rafael and/or Greg can ACK it I can
apply this patch to the GPIO tree.

Yours,
Linus Walleij
