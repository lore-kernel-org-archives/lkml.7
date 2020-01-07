Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02067C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13E420678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbbmHQQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgAGRXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:23:36 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35206 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgAGRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:23:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id k4so178931oik.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PhbKXDsZRakhZSRRK1aI18rLOfc33MtTwpsaXmjInuw=;
        b=EbbmHQQ4NFvrnDJ/svaJN+YrbNc3VOZfPcMkWS15V7rtm9mrlJaKvGXq7P77JLqRIk
         qpOig7knyFuxj3paE/RmThGUJyGqTciXaJ7+eJtPjl5lJ4V6E/Mxzukb64MOubhpLgY4
         sIcCUixqubZJ/jASNlxozT1K8sPsRyMCQTdEvl0S5bnHpXlTnn4meY+D+zAYmasE7Atv
         ZX4zEM6U5Q/eScg3I4tPCga0TyadDKd8h6Ix+nUiBPy1G0EicxUs5dcgNpAvelKpQ7bH
         KkwWBIVs9jitnHW7gdVyxntgUWpGz3erJtiT0mjvf4GWegftjXIfGru6uKgMGXPy96Iq
         2www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PhbKXDsZRakhZSRRK1aI18rLOfc33MtTwpsaXmjInuw=;
        b=HJ3D/fCBk0Cl3xT9TJNZYGnLvHiiDRUXBYsldDAkk8mec/UZuA7JMYfdxAxyS0F9oG
         xPRz9YWxhnVJnQtAW/Ferh3cgUtmpiEXaVTrVrWw1u3zWTkiffXfuEecyAnIJWNw0wzt
         xIp835H3X1eGXT7fPnX3E/wM60skcB91QCGTpAp7F9Rpywyrfs1JPEKf3FfWK9e/7igv
         pfmU8O+u7RBXzICbixsUKdR01aUDcBwfZib6s+BCIQ94MIuuCVn8hE6dWMDkY9nkpAOk
         fe8wNJHeXgAj0ybfbZygJiEhrF0uMA0duw3Yj6rnUH4zNG9uq0CyvY4+KAeqHje2krcG
         fVcg==
X-Gm-Message-State: APjAAAXYFJoBfqOgeQeLUNfWsUcqK1JruVNnmE1XaYS/POsRH0B7Ptd9
        TEFu7xrYWq/6/0z1/W8V2jtPbNiSElZS/zyEyKrdYw==
X-Google-Smtp-Source: APXvYqz6rMGmaMVQDiSCZZAtpdpF7l7/5wCJHHz4aURiMLR4ym0pxXAeUP8cHumFFyHeZvVwCzurTkgYPEEDx8qz4TI=
X-Received: by 2002:aca:c551:: with SMTP id v78mr478240oif.161.1578417814776;
 Tue, 07 Jan 2020 09:23:34 -0800 (PST)
MIME-Version: 1.0
References: <20200107010350.58657-1-john.stultz@linaro.org> <bb0651eb7b1c81755ec43fe9d85f27a5fd83af88.camel@pengutronix.de>
In-Reply-To: <bb0651eb7b1c81755ec43fe9d85f27a5fd83af88.camel@pengutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 7 Jan 2020 09:23:24 -0800
Message-ID: <CALAqxLW-pLkeDodqNWg-TtsKTi6Rak_z9Gki3FJSLReqO+arPg@mail.gmail.com>
Subject: Re: [PATCH] reset: Kconfig: Set CONFIG_RESET_QCOM_AOSS as tristate
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 7, 2020 at 12:32 AM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Tue, 2020-01-07 at 01:03 +0000, John Stultz wrote:
> > Allow CONFIG_RESET_QCOM_AOSS to be set as as =m
> > to allow for the driver to be loaded from a modules.
> >
> > Cc: Todd Kjos <tkjos@google.com>
> > Cc: Alistair Delva <adelva@google.com>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Amit Pundir <amit.pundir@linaro.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  drivers/reset/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > index 3ad7817ce1f0..45e70524af36 100644
> > --- a/drivers/reset/Kconfig
> > +++ b/drivers/reset/Kconfig
> > @@ -99,7 +99,7 @@ config RESET_PISTACHIO
> >         This enables the reset driver for ImgTec Pistachio SoCs.
> >
> >  config RESET_QCOM_AOSS
> > -     bool "Qcom AOSS Reset Driver"
> > +     tristate "Qcom AOSS Reset Driver"
>
> This doesn't seem right on its own, the driver still uses
> builtin_platform_driver().

Huh. Thanks for pointing that out!
It seems like it was working fine as a module with just the kconfig
change, but let me double check this and I'll revise with a follow-on
patch to address this bit.

Very much appreciate the review!

thanks
-john
