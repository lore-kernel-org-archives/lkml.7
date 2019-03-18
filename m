Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A7BFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BEA20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBFUBm55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfCRLGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:06:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37934 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCRLGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:06:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id g1so5074212qki.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jUm0O90pdg0obPx/pFCJHgoAf1NtMJ+2lalb3fWgBuA=;
        b=UBFUBm55T5kRA+jGk3ab/GC6HCwn52Y4ATq1pUAjhAvetKsaCmKWZ/o73cJu3xqp9Y
         BE/6fYQzcXVW6Fxpqi2RjTyVwNaagPVAofVa9kTRhk0R0va1rFeblvZbomwEOhFcILCx
         i4FtoRDfs4sGRjkap9frKj+xYoQviDyuv4QQmHsDnSpRDHKxF/fXsT++EKzv7q1mgyqY
         hxtoWfr42FypKK1t20we3x7ti80zO7s6adz6C8VkyrwKrmZQOPluxb3nAEe9ohHEEpK7
         c7vlPplcdEVP3dn7OGjAUg7oxFC0ddrIFNHq8/FEGMkZLW47uZItXDw4kSG7sKEvBRdj
         rlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jUm0O90pdg0obPx/pFCJHgoAf1NtMJ+2lalb3fWgBuA=;
        b=sZS6DUHfm1VEUaxVZ6lZ+dbRHSwDilBEtsCHyTX+3gGYvwpp+3j3PvK9EOgsR+wRkm
         2wHO0u2UyiMo0K7MRpWBxSVm3lTCW9OP6FHocJ/Vu2J5TYExZ3++q0gGYJHeq4bIIWik
         JWduj5SHCNj/grTB0yXffs2EsOyU+klIZysK1YzGVEEu4amnS8pqCs6LRxt4hijiXRPo
         ZQ79hAs3nagd4fYaAnPU/DrMnOxEVkUUvfsQZwZpHbQfs9iCr7M4HPdqpWqGNN0V0/8n
         0qvPU50Bk892CO7iyo3CodfJ6qdLLY56zB8V/4hreoY4j1zlDAsPlhsFXlkLqRH36zH6
         gKbQ==
X-Gm-Message-State: APjAAAV5UvPf4GE7mFf5+99mLddXLqsHCsEOOZWxaS3sktEWfNZdYjp8
        pbj9dI741aCaxqBbBd7sgNSdezLbKhqxyKsnOvISww==
X-Google-Smtp-Source: APXvYqxRbRNk5dEDVUg1IRc43lm92Y2NflR/+89h14A3QVA73KUE02SyPrGHyXIsejDt0U4rDNqXFaj4t9vOw5y83MA=
X-Received: by 2002:a05:620a:1315:: with SMTP id o21mr1351443qkj.228.1552907165314;
 Mon, 18 Mar 2019 04:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190318100605.29120-1-benjamin.gaignard@st.com> <20190318104343.GA15574@e107155-lin>
In-Reply-To: <20190318104343.GA15574@e107155-lin>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Mon, 18 Mar 2019 12:05:54 +0100
Message-ID: <CA+M3ks6bsiGXCKEQmaFmzBRhWPVhV5wBjVhgyfCa-25DohnsOg@mail.gmail.com>
Subject: Re: [RESEND PATCH 0/7] Introduce bus domains controller framework
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
        s.hauer@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-imx@nxp.com, kernel@pengutronix.de,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun. 18 mars 2019 =C3=A0 11:43, Sudeep Holla <sudeep.holla@arm.com> a =
=C3=A9crit :
>
> On Mon, Mar 18, 2019 at 11:05:58AM +0100, Benjamin Gaignard wrote:
> > Bus domains controllers allow to divided system on chip into multiple d=
omains
> > that can be used to select by who hardware blocks could be accessed.
> > A domain could be a cluster of CPUs (or coprocessors), a range of addre=
sses or
> > a group of hardware blocks.
> >
> > Framework architecture is inspirated by pinctrl framework:
> > - a default configuration could be applied before bind the driver
> > - configurations could be apllied dynamically by drivers
> > - device node provides the bus domains configurations
> >
> > An example of bus domains controller is STM32 ETZPC hardware block
> > which got 3 domains:
> > - secure: hardware blocks are only accessible by software running on tr=
ust
> >   zone.
> > - non-secure: hardware blocks are accessible by non-secure software (i.=
e.
> >   linux kernel).
> > - coprocessor: hardware blocks are only accessible by the corpocessor.
> > Up to 94 hardware blocks of the soc could be managed by ETZPC and
> > assigned to one of the three domains.
> >
>
> You fail to explain why do we need this in non-secure Linux ?
> You need to have solid reasons as why this can't be done in secure
> firmware. And yes I mean even on arm32. On platforms with such hardware
> capabilities you will need some secure firmware to be running and these
> things can be done there. I don't want this enabled for ARM64 at all,
> firmware *has to deal* with this.

We use ETZPC to define if hardware blocks can be used by Cortex A7 or Corte=
x M4
(both non-secure) on STM32MP1 SoC, this new framework allow to change hardw=
are
block split at runtime. This could be done even on non-secure world
because their is
nothing critical to change hardware blocks users.
For example you can do "complex" tasks like display pipe configuration
on Cortex A7
where linux is running and handover the control of this hardware block
to Cortex M4 to
offload drawing on framebuffer.

Benjamin

>
> --
> Regards,
> Sudeep
