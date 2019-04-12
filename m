Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C22C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FC1206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="raXhuTkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfDLN75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:59:57 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:55109 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726702AbfDLN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:59:57 -0400
Received: by mail-it1-f193.google.com with SMTP id a190so7406395ite.4;
        Fri, 12 Apr 2019 06:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikgIFIv6KfAdT2IE3ELumyKYrYodKRPGbJs61/rWg7I=;
        b=raXhuTktOAfOy05DpwVE5xb5lHsHHt5MoKOlU915ettgmqicVRPTqArm5a0suY5WbR
         ZplY6W+Lz+1F9yAXQvNs60dcwiyS7y+k4YvveiSJaGN7Wgr2vYFGBqfagYe9RlxOS+YW
         CygK8CAQkQRV6FYQZPAUi2aNbJm8zjfphOutQ3TFQwppOtUZMcKD2nI6rVConuSZo4oB
         oc0Ysjj1bTzPe0w+5pPRkhKLMUWOUXwr/0jyqPsAtd/dIEPPrxK2WQOhx92rovqm5ueD
         sBin4puatjp06bMPa0xghHMNScHnczDlfPgFUAycz+66/hcymqqRGLcOIwMjjQV4xRo9
         tAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikgIFIv6KfAdT2IE3ELumyKYrYodKRPGbJs61/rWg7I=;
        b=QsEYjPwBwlu+kNYwtFd+F9hzsALSQzFWKk1J/7bjV+KN0aNGC2o1sSz3dVWJwRsHYf
         nnTN2YFOMK+nd0SqZBya5dLun9tC98UpOhN43KnH82Hv7KDwhrvOdB1nlgf+9chG2vdi
         erpb5JgjjvulNpWHtuTskd2xOd2GD8Mpsxy9lJ0ynSUoH1bI28Y3xLR9BBVxW59xoM4D
         PqghCYFZRaO2sBi0ksL4y1OLAjd6zZbDjIaMZseAoQvzieSYb6sxJNnWi2763NOkbou8
         atqbDhf5gHv4kA7s3UJlMS+iKK7UgcTXk24GJPK2tuERSK5j/0HUeYJ03Uii3v8tPRbu
         J/Rw==
X-Gm-Message-State: APjAAAWzV9Zyi2s/w99qZE/0nRKFvp/CWur3wjf33jCxEYyXfQw8h+hc
        C9OVHPTZ51IEgr1xUPqmPdCrGDpGwF+jGdRwxcc=
X-Google-Smtp-Source: APXvYqwk6ozZkTY6JT08TtWQ7f3kB3slYsOiJqp+gNZrtZSIAlhJjus2FyjE/LyV3Sba/kbl3yqiulDZqUgDduSetOQ=
X-Received: by 2002:a02:c843:: with SMTP id r3mr40803426jao.12.1555077596294;
 Fri, 12 Apr 2019 06:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-3-brgl@bgdev.pl>
 <57fe079c-fd69-45ef-b4fb-a2c792218c21@ti.com>
In-Reply-To: <57fe079c-fd69-45ef-b4fb-a2c792218c21@ti.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 12 Apr 2019 08:59:44 -0500
Message-ID: <CAHCN7x+BpuuNnV+wteD=JBwuYF3z7EDD4kig26Kj4rOdJcW+LA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: da850-evm: enable cpufreq
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Lechner <david@lechnology.com>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 8:06 AM Sekhar Nori <nsekhar@ti.com> wrote:
>
> On 08/04/19 1:29 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Enable cpufreq-dt support for da850-evm. The cvdd is supplied by the
> > tps6507 pmic with configurable output voltage, so all operating points
> > can be enabled.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Adam, can you please ack? Looks good to me.

Sekhar,
Based on what I read in the thread about the LCDK, I want to do some
tests on the da850-evm before put my name on it.  I like what I see in
general, so I am excited to this this here.

Bartosz - which kernel branch should I use as a starting point to apply these?

adam
>
> Thanks,
> Sekhar
>
> > ---
> >  arch/arm/boot/dts/da850-evm.dts | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
> > index f04bc3e15332..f94bb38fdad9 100644
> > --- a/arch/arm/boot/dts/da850-evm.dts
> > +++ b/arch/arm/boot/dts/da850-evm.dts
> > @@ -191,6 +191,19 @@
> >       };
> >  };
> >
> > +&cpu {
> > +     cpu-supply = <&vdcdc3_reg>;
> > +};
> > +
> > +/*
> > + * The standard da850-evm kits and SOM's are 375MHz so enable this operating
> > + * point by default. Higher frequencies must be enabled for custom boards with
> > + * other variants of the SoC.
> > + */
> > +&opp_375 {
> > +     status = "okay";
> > +};
> > +
> >  &sata {
> >       status = "okay";
> >  };
> > --
> > 2.21.0
> >
>
