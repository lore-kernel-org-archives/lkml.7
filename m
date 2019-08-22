Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E5CC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 822D921848
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yezPFauY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388383AbfHVMNi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:13:38 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46310 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfHVMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:13:37 -0400
Received: by mail-ua1-f65.google.com with SMTP id y19so1885508ual.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mvo3obOpukOfhgTtLVmsxidJD3UDOJN2LjSEIs/pCEY=;
        b=yezPFauYmhYaA1IvJm9bJpL2dY24hl2CuZ23kSamOTyei7zmkpM9OwfeezL77smNmy
         brPejKcqSkGbdeG0TZhPjVTnbbSR+wUP/ef7qlhKjm1WrevaaTKdM1H5BJlulQSNFFBu
         ffPG25/rp7o/Np+uiVJ5mzu29geogy+OlShFowhzezrqK6jSKy2/ttts946z7KwBEK5H
         wnQkO/mNQJxlV1Z14pPtRBkgMBP1xn5E1R8TR3s9I8XCM+WYiRCE1b8xj+vvhDBM350a
         eawe58pkj08f/lPQkGSdVpLTGANBXb3hC9izuEQG64fH8ePiwIAUom1q0sA5Yp1ctCCV
         rMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mvo3obOpukOfhgTtLVmsxidJD3UDOJN2LjSEIs/pCEY=;
        b=LCl0nlnUqiKTiySpOwyIv6dnJc4eRkaqUUMcd+Y1hxmmDup4VtYerUppD3HSZTPeuG
         3l9G/v75IURCA/5lvI89TV6SAcCosqLlqaSaTpLirqqOTimiJeimlxixCvcvMtyYRXYB
         uYiofqt7G2XR8maicB3hOyU0CTfTa9y6VuNKj9ZTgLN5Xd+lAxa38UscC3txe9P3iKjY
         mLmC2Ty20fv8tZUv1s7eQfLoMaQn1IfX4B4apr8VPYb5jrOok5gWi/NL45Br/1/H+4on
         /5dtQ6rIa5MV/j++QFvmw7UPjPxSNGs5S4jz7qMlRamD08Gc/sCop7uXGg+qM5asghff
         5SIA==
X-Gm-Message-State: APjAAAXr9OsX4BO15CWQyfprV0hPayRJqyKTuny6+vEGm0y7Web4QfLm
        o0eBCpR/h72VA88sxrwRr8Lw1Vb2kz1uzHQT/51Mdg==
X-Google-Smtp-Source: APXvYqw7ToGHxamlJhqcq3M4yWdo5/jCqSU8fUkV8Z6lMD/B9TiMtkFuCTmQqe2Zj1ICY4zk9zXEx7jisLrgFwz9Yzs=
X-Received: by 2002:ab0:1562:: with SMTP id p31mr5468313uae.15.1566476015930;
 Thu, 22 Aug 2019 05:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <1565252928-28994-1-git-send-email-eugen.hristev@microchip.com>
 <CAPDyKFrUr8_VP1JLRk48zR8_p1Y62wKLBnS0iTgdhUSArwD49Q@mail.gmail.com> <20190809080842.zl4ytbjyt54bj6ta@M43218.corp.atmel.com>
In-Reply-To: <20190809080842.zl4ytbjyt54bj6ta@M43218.corp.atmel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 22 Aug 2019 14:12:59 +0200
Message-ID: <CAPDyKFp_UdPqnOtqsOZcNxt+fTayMYm89_YLNH8J5-=VRcWTJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-of-at91: add quirk for broken HS200
To:     Eugen.Hristev@microchip.com,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Nicolas Ferre <Nicolas.Ferre@microchip.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019 at 10:09, Ludovic Desroches
<ludovic.desroches@microchip.com> wrote:
>
> On Thu, Aug 08, 2019 at 05:23:00PM +0200, Ulf Hansson wrote:
> > On Thu, 8 Aug 2019 at 10:35, <Eugen.Hristev@microchip.com> wrote:
> > >
> > > From: Eugen Hristev <eugen.hristev@microchip.com>
> > >
> > > HS200 is not implemented in the driver, but the controller claims it
> > > through caps.
> > > Remove it via quirk.
> > > Without this quirk, the mmc core will try to enable hs200, which will fail,
> > > and the eMMC initialization will fail.
> > >
> > > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> >
> > Should this be applied as a fix and possibly tagged for stable?
> >
> > In such case, do you have a specific commit that it fixes?
>
> I think so, I would say:
> Fixes: bb5f8ea4d514 ("mmc: sdhci-of-at91: introduce driver for the Atmel SDMMC")
> Cc: stable@vger.kernel.org #v4.4 and later
>
> It doesn't apply on 4.4 but resolution is trivial.
>
> Regards
>
> Ludovic
>

[...]

Applied for fixes, by adding the above tags, thanks!

Kind regards
Uffe
