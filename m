Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E6FC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8892089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GLqOvUYQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfIKMHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:07:13 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38971 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbfIKMHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:07:12 -0400
Received: by mail-ua1-f67.google.com with SMTP id s15so6673884uaq.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/W60zi2CsnYN3oTG7y8mYKQVQdd1OgZCvvKaWEAFp1Q=;
        b=GLqOvUYQJXCW5SvJ4CneXBkrDEz8pJWYKS2UiBssfPdaLACxSvkuI5OvIYJGEYjjqE
         cUKV2A5GorrESRFbUXruLYcRkLE7zysW9cB3DKRhYleYX7lfuaMEjH9ms1pLUXgUk/ga
         AtWSvRuI1lRk+Iyz2TkD0lPx4g07tYYl9X6G+AbpiumYRog0O1rzm9VT33DP6Z0kmYz4
         vMab7Wfv8VvJLhGFAuKqmODy0KH7+8olA6iIsgLC1GJ6h8cJPzFzFViLd+rFxMCRubVv
         LANBylL1rUTIy8ZgvuoDO/kgM8B8H6Ikxqa9IyMKv8xIbSQAegJmuPU/eZzMsC08oh/h
         6piw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/W60zi2CsnYN3oTG7y8mYKQVQdd1OgZCvvKaWEAFp1Q=;
        b=UdIjdNOFsJro8P0aRZHP7vRLJy97D05FRqhJEBY11sm77MkxEyxDIdQZljAqxLKO3o
         8qmudaDYfPRNUEujNM11aF9yYgBmggR5Ilbo/G6LCFIWWWTb1tF8RW2+Nx/klZfScgzB
         OGWJV4A2k3FZlVTZHvDEqN5GKpbe37AvtmQSL5GcCOTWMCFhyBobo+Y5+tBLi+LNFPBT
         FVlXyuExwtGzoSqUGCiA4aFmXZ7eRX5zaqJ5mSuG+38jS+bW/WOxQUraGomasAoaAKNi
         JouNGI9Nvd6cRouqzN4vnMuopqvY437LT6Ny6SzgunThELI20dzYRVKLwK6f8BCDCCBu
         CW2A==
X-Gm-Message-State: APjAAAXMha0c/5qQGrc81yHHxZWCDdAKMR4CoybZ24DpszquK8+R3etv
        u+/YRWJrm9WU4+FalL2RNIKMpmGZCSVAyR4DbAO7lg==
X-Google-Smtp-Source: APXvYqyHwlzHmgm/F3rLCurrnWpPOQ6N0VtapKXg6cMw0YxI7Dd9PBI/rZrdtfNNpy0PoR1fPnLL/GpHB6Hiw8NQA7E=
X-Received: by 2002:ab0:3113:: with SMTP id e19mr2059643ual.129.1568203631219;
 Wed, 11 Sep 2019 05:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190908101236.2802-1-ulf.hansson@linaro.org> <20190908101236.2802-4-ulf.hansson@linaro.org>
 <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
In-Reply-To: <CAD=FV=U=ohP9KFWrMYfdbT4WbOxGXFNMd71c7ej1G9Qrtim=7w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 11 Sep 2019 14:06:35 +0200
Message-ID: <CAPDyKFpaM5Os_B_f=b5aY87Espm6GvGG=C6sRemzvfG=9rE74A@mail.gmail.com>
Subject: Re: [PATCH v2 03/11] mmc: mtk-sd: Re-store SDIO IRQs mask at system resume
To:     Doug Anderson <dianders@chromium.org>
Cc:     Linux MMC List <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Sep 2019 at 00:29, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sun, Sep 8, 2019 at 3:12 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > In cases when SDIO IRQs have been enabled, runtime suspend is prevented by
> > the driver. However, this still means msdc_runtime_suspend|resume() gets
> > called during system suspend/resume, via pm_runtime_force_suspend|resume().
> >
> > This means during system suspend/resume, the register context of the mtk-sd
> > device most likely loses its register context, even in cases when SDIO IRQs
> > have been enabled.
> >
> > To re-enable the SDIO IRQs during system resume, the mtk-sd driver
> > currently relies on the mmc core to re-enable the SDIO IRQs when it resumes
> > the SDIO card, but this isn't the recommended solution. Instead, it's
> > better to deal with this locally in the mtk-sd driver, so let's do that.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 6946bb040a28..ae7688098b7b 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -2408,6 +2408,9 @@ static void msdc_save_reg(struct msdc_host *host)
> >         } else {
> >                 host->save_para.pad_tune = readl(host->base + tune_reg);
> >         }
> > +
> > +       if (sdio_irq_claimed(host->mmc))
> > +               __msdc_enable_sdio_irq(host, 1);
> >  }
> >
> >  static void msdc_restore_reg(struct msdc_host *host)
>
> I don't personally have a Mediatek device setup to test this patch on.
> If it's super urgent I could try to track down one and try to set it
> up, but hopefully it's easier for someone else...
>
> That being said, from code inspection it seems like you should be
> adding your code to msdc_restore_reg(), not to msdc_save_reg().  Am I
> confused?

No, you are absolutely correct, my bad. Thanks a lot for spotting this!

Kind regards
Uffe
