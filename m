Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F47C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 138F8206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQqJRk5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfHAPBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:01:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41337 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfHAPBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:01:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id x15so24011062pgg.8;
        Thu, 01 Aug 2019 08:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j3+SbVpPKelvEjCYc5JFdKjnflgfhHUFgbni1JQLfug=;
        b=ZQqJRk5fnVcG1ZOCbng7J1FYxp1NpriIQnPyrnpOaP3jNvwcRX1GGy4xoRsPPt8I0h
         lGgnJmDeeBouSVcnowi5GED8tWCns2QB/l2DzNzmV2w0K0+gdfX7w9ZZxTncE/TSCKHU
         lMS/327tLGJ28/j43VsHs6Ni+mbp4blBAKONcbgKWmAws97UhBh/9c7JJrk3oIx+Bk02
         6SB2RgFOw5AIYlQTMq40Cl1JiIcwmeQ1BNr5CRlWfF1LUFMubPyoTfVDVBICVH9ECtGi
         AjPygJoObpOjTO+tlgJ4RanDeXp+wT6YRMMy4t3JO6gdR+yMXCGgrve5yu7sFLc47+y8
         ZfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j3+SbVpPKelvEjCYc5JFdKjnflgfhHUFgbni1JQLfug=;
        b=pD3FCSewQ/+xUQG1jbusjQduTdwKe7vsq0kDw8W1mm7gqmlYKNyU+5pGeKO/CHBa0B
         9lPmyDawF9unVQkQ1QdqnsYYnbhgFvMu0z6l/xxjx7rP9IosKdg5hTHYoKI+12h1wX3H
         L5e9+cbCQYalJSgjilnsol42RnOPDgnGYnaEdzmhaDXcpt2WxMAkMEJJ00VM0U8NOH+E
         avt4PUsmRBtv+66GVoicfN8gVuQ/QOh2P0LEyDp9NKwTlp9H5mYhwW4xdzaV0nw7kb/6
         aC23Ibp6lCoDuSRUAVfv0gP4LTn5EygDyq9eRuJQllT56em6yXaN9SrKN1QnaJuOCuN9
         FQoA==
X-Gm-Message-State: APjAAAVK5nd16RUL4e2mVK5bD/6Lk4edLMYy1tfMXRPaUm1hRrAmm6nF
        J5agUYYjdkFTc42YC3HLj7uAmuYgBJeyUC7XXsI=
X-Google-Smtp-Source: APXvYqzkEzQOIoAQkYZs2MqaRPgXLz6Zfkv0nVGVPl3rbKiRFFbjxuq3ZqweBfBqDY6+SR+kJXEgcACCbz4rf3wqnZo=
X-Received: by 2002:a17:90a:7788:: with SMTP id v8mr9433611pjk.132.1564671702133;
 Thu, 01 Aug 2019 08:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190726062115.16231-1-fe@dev.tdt.de> <d35c844e-4202-9710-dbe6-f10bebf75e3a@metux.net>
In-Reply-To: <d35c844e-4202-9710-dbe6-f10bebf75e3a@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Aug 2019 18:01:30 +0300
Message-ID: <CAHp75VfC+XhXDUe0NzoYRP9HTFPPKkV78JRMQXFskWaLeYD0PQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] platform/x86/pcengines-apuv2: add mpcie reset gpio export
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     Florian Eckert <fe@dev.tdt.de>, Eckert.Florian@googlemail.com,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 1:50 PM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 26.07.19 08:21, Florian Eckert wrote:
> > On APUx we have also mpcie2/mpcie3 reset pins. To make it possible to reset
> > the ports from the userspace, add the definition to this platform
> > device. The gpio can then be exported by the legancy gpio subsystem to
> > toggle the mpcie reset pin.
> >
> > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > ---
> >
> > v2:
> >    Noting changed for this patch. Only resend because other patches of
> >    the series where dropped or updated and resend by other people
> >
> >   drivers/platform/x86/pcengines-apuv2.c | 8 ++++++++
> >   1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> > index c1ca931e1fab..f6d8ed100cab 100644
> > --- a/drivers/platform/x86/pcengines-apuv2.c
> > +++ b/drivers/platform/x86/pcengines-apuv2.c
> > @@ -32,6 +32,8 @@
> >   #define APU2_GPIO_REG_LED3          AMD_FCH_GPIO_REG_GPIO59_DEVSLP1
> >   #define APU2_GPIO_REG_MODESW                AMD_FCH_GPIO_REG_GPIO32_GE1
> >   #define APU2_GPIO_REG_SIMSWAP               AMD_FCH_GPIO_REG_GPIO33_GE2
> > +#define APU2_GPIO_REG_MPCIE2         AMD_FCH_GPIO_REG_GPIO59_DEVSLP0
> > +#define APU2_GPIO_REG_MPCIE3         AMD_FCH_GPIO_REG_GPIO51
> >
> >   /* order in which the gpio lines are defined in the register list */
> >   #define APU2_GPIO_LINE_LED1         0
> > @@ -39,6 +41,8 @@
> >   #define APU2_GPIO_LINE_LED3         2
> >   #define APU2_GPIO_LINE_MODESW               3
> >   #define APU2_GPIO_LINE_SIMSWAP              4
> > +#define APU2_GPIO_LINE_MPCIE2                5
> > +#define APU2_GPIO_LINE_MPCIE3                6
> >
> >   /* gpio device */
> >
> > @@ -48,6 +52,8 @@ static int apu2_gpio_regs[] = {
> >       [APU2_GPIO_LINE_LED3]           = APU2_GPIO_REG_LED3,
> >       [APU2_GPIO_LINE_MODESW]         = APU2_GPIO_REG_MODESW,
> >       [APU2_GPIO_LINE_SIMSWAP]        = APU2_GPIO_REG_SIMSWAP,
> > +     [APU2_GPIO_LINE_MPCIE2]         = APU2_GPIO_REG_MPCIE2,
> > +     [APU2_GPIO_LINE_MPCIE3]         = APU2_GPIO_REG_MPCIE3,
> >   };
> >
> >   static const char * const apu2_gpio_names[] = {
> > @@ -56,6 +62,8 @@ static const char * const apu2_gpio_names[] = {
> >       [APU2_GPIO_LINE_LED3]           = "front-led3",
> >       [APU2_GPIO_LINE_MODESW]         = "front-button",
> >       [APU2_GPIO_LINE_SIMSWAP]        = "simswap",
> > +     [APU2_GPIO_LINE_MPCIE2]         = "mpcie2_reset",
> > +     [APU2_GPIO_LINE_MPCIE3]         = "mpcie3_reset",
> >   };
> >
> >   static const struct amd_fch_gpio_pdata board_apu2 = {
> >
>
> Acked-by: Enrico Weigelt <info@metux.net>

Applied, thanks!

>
> --
> Enrico Weigelt, metux IT consult
> Free software and Linux embedded engineering
> info@metux.net -- +49-151-27565287



-- 
With Best Regards,
Andy Shevchenko
