Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3769EC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B03213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 07:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554102919;
	bh=LyvHeAeP1djEbb49Sell3K+VoOHSA6z/zCyDGEs6RU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yM2bWyRaduNpeH4jpE91mw9Mhw57dZXeK68Gj5w1t9YZoHdbPCfYMuH6dHGTbx61Z
	 afnZDRi+qnwsXo52zxAde+Smiv+hZkDGGLuhIRwGPYHVqpB9k9HXAiwYm+VlV5vuzu
	 DCIkTsQdsUVtfYta1c8DOX5z+lGbPDoQ3AHCBRIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731881AbfDAHPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 03:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731160AbfDAHPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 03:15:17 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2592A218FE;
        Mon,  1 Apr 2019 07:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554102916;
        bh=LyvHeAeP1djEbb49Sell3K+VoOHSA6z/zCyDGEs6RU4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2Pxh3P6jVbIjibByxtUUFgI+JnUmzHETkxOfaxQfMC9UMsZAwKcm62lHWmUw5/zr0
         EWLS3kVBKX51p+SoggWDlYr3sXCdUoQxdwQFnEn0kh+pgAcfy72tjQXOpuMEvIG8mS
         whi4FZbKqoTq67qcR8OT4aVZ3UD1ioeTT6ujcMRE=
Received: by mail-lf1-f50.google.com with SMTP id v14so5482283lfi.0;
        Mon, 01 Apr 2019 00:15:16 -0700 (PDT)
X-Gm-Message-State: APjAAAXXqCUyFaLszmexZk3zSuygnGy/JYSLgLEJJ6YZ04CJEGIi9a7p
        +QlVBxfwXq21im6eqIZrEllBhab4Y6OPIezIs14=
X-Google-Smtp-Source: APXvYqw+YYiKb2sU1g9YqLcWIiPTVfznwQAzQL2ojBMiqnywM8UMiNpYcMcsFqxgE+GGLIwkE7Hbw7CsIBNkfladbFY=
X-Received: by 2002:a19:6a02:: with SMTP id u2mr13696808lfu.20.1554102914230;
 Mon, 01 Apr 2019 00:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190401032425.18647-1-daniel.lezcano@linaro.org>
In-Reply-To: <20190401032425.18647-1-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 1 Apr 2019 09:15:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdF3s53noZs0oye=gW6Ap_pF=oomVL11KU9DLKYTFF1Tw@mail.gmail.com>
Message-ID: <CAJKOXPdF3s53noZs0oye=gW6Ap_pF=oomVL11KU9DLKYTFF1Tw@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/core: Remove the module Kconfig's option
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rui.zhang@intel.com, edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Guenter Roeck <groeck@chromium.org>,
        Daniel Mack <daniel@zonque.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019 at 05:24, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The module support for the thermal subsystem does have a little sense:
>  - some subsystems relying on it are not modules, thus forcing the
>    framework to be compiled in
>  - it is compiled in for almost every configs, the remaining ones
>    are a few platforms where I don't see why we can not switch the thermal
>    to 'y'. The drivers can stay in tristate.
>  - platforms need the thermal to be ready as soon as possible at boot time
>    in order to mitigate
>
> Usually the subsystems framework are compiled-in and the plugs are as module.
>
> Remove the module option. The removal of the module related dead code will
> come after this patch gets in or is acked.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/configs/mini2440_defconfig        | 2 +-

For mini2440:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
