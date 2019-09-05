Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60F2C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A06322CEC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 07:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGBJ24FS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731693AbfIEH3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 03:29:35 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:35932 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbfIEH3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 03:29:35 -0400
Received: by mail-ua1-f67.google.com with SMTP id n6so449796uaq.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 00:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6LhtZNoNzRvZSAH108XwpLGps2Yh2JazOU/N47b9DrY=;
        b=wGBJ24FSeI0ftQz8FoR/io+cmoZSq4R9WzfX1YRTQqq4bDgjuQOkMUAc14czc8A7fE
         RTrc4/G6LeaIqGNA3081SM+a34BEuP4u/UCEBaarcn5N0AtDBWgMtm37BzK5eP1a3aF/
         5avzku2ru/lbbGW2fQQX03vBNtZuEMABjof0IGjaj585cv49PXFRxy/vdW18T0On14d9
         +T6f4drlFCbaT1yKDNV2UunHvRAkbbnfoMQG6sxiILp2U6WlYLjrK4shCrzb2+uUDRiC
         RGJFVMinNMBmSvVlQKNuR+u53wJP06152MYY+LT7Xxy+BlEw9EzgU6ug0hvkVG7WL+HU
         yGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6LhtZNoNzRvZSAH108XwpLGps2Yh2JazOU/N47b9DrY=;
        b=SsS7vU+gY5NVLx0u/LdI3GMpZhBJ56NRcjUwg8rNXdTTeuEAYYixkPaGTEQ7mQdlL6
         XoKHFXcQHGXwvIfotPzZu2epGc6yNcPVYvuFekzCZrobLwFeRb2ELkvjVjBWEEke0sA6
         j6rG61GKM0QNgYBlHX9HqVwtD9jF1aWr6/4ZVZ8XQPZXIFisvQ5B56l5sgKjb6aC5TA8
         bduAvvtMO1A14t3QEThOvWA6s8mBxEq7iIZqXwuAzg1jPE6qli34H0TVBjGJSjFekYHy
         sKD/vRYX41PuTExpuuOE33D6WLnUuQRYbLYEjOfBHaRzmVZzC74lm6OpKxdBnkqLUFN+
         m0EA==
X-Gm-Message-State: APjAAAW35sup/DMqvDAZLRZgqHF4Rz40kXfwyGaFwlz+Lcdp171jyVOQ
        VNurfzt7eBAPwvVE3bnxAU9wOgFJdyJl7ammzsOheuPy
X-Google-Smtp-Source: APXvYqwU8zzHowwK8eJgPAFUKUJwghzX5S69y3kO09icT4sMBL7iKeXUnrBl56ZIApRGLl790kJN3KLeXRuu6kqsKDY=
X-Received: by 2002:ab0:1562:: with SMTP id p31mr669621uae.15.1567668574370;
 Thu, 05 Sep 2019 00:29:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-2-ulf.hansson@linaro.org>
 <20190904235836.GG70797@google.com>
In-Reply-To: <20190904235836.GG70797@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Sep 2019 09:28:58 +0200
Message-ID: <CAPDyKFqAiBHb3Tta3VXWbhxJkRP_KyokgkXAr+CmJxAXqE7Cvg@mail.gmail.com>
Subject: Re: [PATCH 01/11] mmc: core: Add helper function to indicate if SDIO
 IRQs is enabled
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 at 01:58, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Ulf,
>
> On Tue, Sep 03, 2019 at 04:21:57PM +0200, Ulf Hansson wrote:
> > To avoid each host driver supporting SDIO IRQs, from keeping track
> > internally about if SDIO IRQs has been enabled, let's introduce a common
> > helper function, sdio_irq_enabled().
> >
> > The function returns true if SDIO IRQs are enabled, via using the
> > information about the number of claimed irqs. This is safe, even without
> > any locks, as long as the helper function is called only from
> > runtime/system suspend callbacks of the host driver.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  include/linux/mmc/host.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 4a351cb7f20f..0c0a565c7ff1 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
> >
> >  void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
> >
> > +/*
> > + * May be called from host driver's system/runtime suspend/resume callbacks,
> > + * to know if SDIO IRQs has been enabled.
> > +*/
> > +static inline bool sdio_irq_enabled(struct mmc_host *host)
> > +{
> > +     return host->sdio_irqs > 0;
> > +}
> > +
>
> The name of the function is a bit misleadling, since it indicates
> if SDIO IRQs should be enabled, not whether they are actually enabled
> by the host. The resulting code can look a bit confusing to the
> uninstructed reader:
>
>   if (sdio_irq_enabled(host->slot->mmc))
>     __dw_mci_enable_sdio_irq(host->slot, 1);
>
> aka 'if SDIO IRQ is enabled, enable SDIO IRQ'.
>
> sdio_irqs_claimed() could be a possible alternative.
>
> No biggie though, just something I noticed.

Thanks for the suggestions. It makes perfect sense to me, let me rename it.

Kind regards
Uffe
