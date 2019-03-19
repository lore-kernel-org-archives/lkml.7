Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA872183F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Vs1YInwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfCSRTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:19:52 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36593 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfCSRTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:19:52 -0400
Received: by mail-io1-f65.google.com with SMTP id f6so18525044iop.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 10:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IxVy5IeopPv89ZhexGBG2/z9sRTCGR4jiEJz4kuX/6E=;
        b=Vs1YInwDYdluw+886pBN0Mc56+OvYwhoSQtnYw0AbwWlZod9LqI9VJ9z0StJ5V4/+k
         xr+ekuNO4Z4O2FRgNF5lKrVz2ZG1pbaM3VMPyin2K66qBdv5ux2/UADPdFrSWe9xev9A
         ur6a+3hwUQjXFsk4jFVf3yNxtoXvrhOaYOU8iyM9YobwoUjIbVNiCVFHoMc4Z5C81I9n
         U5S2ht2MtIUIJ93FwzcOOWBDUY291Tqtw7Oy8dHPd6t4Kb2HxTpsV8gCYLnEuv6ti4Cz
         KtxctOa/D4lS3eWBv1VBM66/pWK09n1turVpqqaC3LdwOhEdqS89rJguZjYDCgEd/QFm
         rFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IxVy5IeopPv89ZhexGBG2/z9sRTCGR4jiEJz4kuX/6E=;
        b=JQmpKV4V0SKsne1Zug/MczrF8vG5nFQ8S0THJe7zq2wxbo+Y0B2tQQqVmJ6fUAgWUe
         equddQ+lN1kQQAIDD3T28LMHahatq4C1yPMjQ8K5vc+CWur1mzJfBJUR38NvOccsFcc1
         y6t/dC93zOUb2NUUDxStY8yThBDyyGT6jG2arKZNq/6CcnTXELM64697LukRFXtpsRnF
         shLzyy8K7YwcfiPaavn9IgeCyGSVi6jUkfv9NPsGrIMYE9jnV8T6gQXUsuNyZfbqgFMR
         wxjDW2vIkdIorwgCWEKO9x3IRHwmukIZ0tlkyGGKkcEXtoJ7dwn+jNDd0RsMq/yhZj00
         3UzQ==
X-Gm-Message-State: APjAAAXfqUTK6wbgKdzbiOIt44NEMuIis5hm71Mwhzs4UaqeDLti0ASO
        Z9QkgVJSfwMFuWD8YU/4RetFaBqq0bS546MIHyv+Ng==
X-Google-Smtp-Source: APXvYqz25c5jK7rZC8EthdRi+822eXeRWcXEtaAQoBC1kqnkslFHGa3f3NXPJPlDH7L8sEfcANdpeoOItQf/2NG8odE=
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr2291579ior.258.1553015991275;
 Tue, 19 Mar 2019 10:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1903191513170.2537@nanos.tec.linutronix.de> <alpine.DEB.2.21.1903191552550.2537@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903191552550.2537@nanos.tec.linutronix.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Mar 2019 18:19:40 +0100
Message-ID: <CAMRc=MeUY5uK6j9rCZasTFzDBk9Yc6qHh_nFs4OorKbCdXpAzA@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: amd-fch: Fix bogus SPDX identifier
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Enrico Weigelt <info@metux.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 19 mar 2019 o 15:54 Thomas Gleixner <tglx@linutronix.de> napisa=C5=82(=
a):
>
> spdxcheck.py complains:
>
>  include/linux/platform_data/gpio/gpio-amd-fch.h: 1:28 Invalid License ID=
: GPL+
>
> which is correct because GPL+ is not a valid identifier. Of course this
> could have been caught by checkpatch.pl _before_ submitting or merging th=
e
> patch.
>
>  WARNING: 'SPDX-License-Identifier: GPL+ */' is not supported in LICENSES=
/...
>  #271: FILE: include/linux/platform_data/gpio/gpio-amd-fch.h:1:
>  +/* SPDX-License-Identifier: GPL+ */
>
> Fix it under the assumption that the author meant GPL-2.0+, which makes
> sense as the corresponding C file is using that identifier.
>
> Fixes: e09d168f13f0 ("gpio: AMD G-Series PCH gpio driver")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> Stupid me should refresh patches before sending them. Blush!
> ---
> diff --git a/include/linux/platform_data/gpio/gpio-amd-fch.h b/include/li=
nux/platform_data/gpio/gpio-amd-fch.h
> index a867637e172d..7290ec40a71e 100644
> --- a/include/linux/platform_data/gpio/gpio-amd-fch.h
> +++ b/include/linux/platform_data/gpio/gpio-amd-fch.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL+ */
> +/* SPDX-License-Identifier: GPL-2.0+ */
>
>  /*
>   * AMD FCH gpio driver platform-data
>

Patch applied.

Bart
