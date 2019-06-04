Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EFBC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D7D263AF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 02:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0Tg5fNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfFDCdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 22:33:22 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41013 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfFDCdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 22:33:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id b21so10491562oic.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 19:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/efz5fBqwkKql5eaLioEbxPG0lpeX3IuNQzBKE0KZPY=;
        b=t0Tg5fNTxniTRmz/iZalyXNNLBLd+1rhT2xgBa8LZbek9rqjAlwbOGh00WHUB1ncrx
         Yo/H4u0aKaaEw1LY3oxY/qG/vRwpEj/gpqna5xGRMKtyhf3tetBrPBVEq5/wW5OunbmT
         6P+dBmhIXg4OTMvR81tWx1OWHYVdqp3+mTeW/erFR9g1OpVb3yvcUQDsNFS7/xBbe2Ix
         099d7LnpWWUcDprl9p4V7TN5UkrBzPDwAaJK9fx2m9ZdntdbcTThl4RrqZGvB8aLAESR
         7H5CqQB/OZL7Y8tzXpk5gqxdRBj4CkDWX7h78XUi9vUABQ5ElROPygSMfDoZJKEFAcyt
         5New==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/efz5fBqwkKql5eaLioEbxPG0lpeX3IuNQzBKE0KZPY=;
        b=V/SQJHjAJioH+W/dXtPeHFN0+XfCygyuce+9NRDifW5alXNGZCyCY6r/hO0AIJIZxj
         +5lQx8jDrmIF5pCmFhivhUr/MseiszT67uN5UEY8UXDYV9zmMaMcM1lpNS3G9M/OP4NN
         bjJz3Tom1URS6IqZNKv1TrSIueCVZ+tBYhlrQ5VQAjEx2SdmjwnNG3oq5KESLZMbO2fD
         tjTVaekzSrAytDwMGIn0v1+Gs7JnjX9DeAkVqbgjseULyZ6nWUgjzSoxVOD9997Zo7Z+
         72OhW6K68JmUA/fE0ellQEuEZhdeREuSezO24otEeq5/8lA4jsoxYG0jcaWXIuLRPPfZ
         K4Uw==
X-Gm-Message-State: APjAAAXZCccv0bshWiyekPWISFJ7E5290AwyV4F/d0F48J1Y7IO/f0MQ
        8i58FX4zrfiQmzJYltjpRf4YJFSrmw0afrzyN/11zA==
X-Google-Smtp-Source: APXvYqxb/i7+n5YIjVsNZWPZfvdm7xM+4h6bvKEOeA1ig/CQVGfW4rtKxXeB0d4+sPhSP0CMWDZvMBprzf2J8CSGkSs=
X-Received: by 2002:aca:dd08:: with SMTP id u8mr74850oig.27.1559615599920;
 Mon, 03 Jun 2019 19:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1558346019.git.baolin.wang@linaro.org> <ee4ad0e7e131e4d639dbf6bd25ad93726648ce1c.1558346019.git.baolin.wang@linaro.org>
 <CAPDyKFrWiG3KJad+L3NOQ-dC2XnBM-8mQGVEsVB_Qg0ACTfVag@mail.gmail.com>
In-Reply-To: <CAPDyKFrWiG3KJad+L3NOQ-dC2XnBM-8mQGVEsVB_Qg0ACTfVag@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 4 Jun 2019 10:33:08 +0800
Message-ID: <CAMz4kuK+yX=V2zp-C4Xb-6ZjgLOY+ON2iHZU=HwONeXcJCkk4w@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: mmc: sprd: Add another optional clock documentation
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Mon, 3 Jun 2019 at 21:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 20 May 2019 at 12:12, Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > For some Spreadtrum platforms like SC9860 platform, we should enable another
> > gate clock '2x_enable' to make the SD host controller work well. Thus add
> > documentation for this optional clock.
> >
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  .../devicetree/bindings/mmc/sdhci-sprd.txt         |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > index 45c9978..a285c77 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
> > @@ -14,6 +14,7 @@ Required properties:
> >  - clock-names: Should contain the following:
> >         "sdio" - SDIO source clock (required)
> >         "enable" - gate clock which used for enabling/disabling the device (required)
> > +       "2x_enable" - gate clock controlling the device for some special platforms (optional)
>
> This is a bit vague, could you please elaborate (and fold in that
> information to the doc) on what kind of clock this is?

Sorry for confusing. For some Spreadtrum platfroms like SC9860
platform, we should enable 2 gate clocks to enable SD host controller,
that means we have 2 serialized clock gates. I know that's a little
weird, but that's our clock's design.

-- 
Baolin Wang
Best Regards
