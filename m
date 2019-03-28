Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA52DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955132082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PfImegt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbfC1QnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:43:18 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35297 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1QnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:43:18 -0400
Received: by mail-lf1-f68.google.com with SMTP id u21so14511053lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jaNrgd1g55IoM81UacYAJ1Xpwyq7RE4BrscS2SbcSG4=;
        b=PfImegt/ErnnH5XHna2hB/3i4fT8b65qnTRPT0py270Zf4kxSjA+9Bl2d0qsS61a9n
         bZf8Ku/DeuCMU3sNg+uIZm+baTfF+D9BQxwxCdDnHH7yQwTtiywK/k27XtdfRhVDhc83
         qwvIkVL4p1OZcGGU4ibauUpvbt4/gLmlQt/1omVT3JUJb+5ORvAYUvTaGm/zLWJ9OIkm
         hY4m55GDVQuMEXXBdgEqKb7bf9gRfQsjEnA3584CWOFhc0VLscRWesuq/avV97og7N1s
         fmLUMEQHR7W6krhGYkVt9GNVcmVaDSFM1BCFshbDtDPUW+0eZBPVY0v5mU/Pa6vAA0ge
         m75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jaNrgd1g55IoM81UacYAJ1Xpwyq7RE4BrscS2SbcSG4=;
        b=m7nbtIDhGumVTxEKP+snbaTrv1hHd0darabKBFl8+jy21/hMYzu1I5BcqtXAVPH395
         6JQE2+tugMJkdMdnRqIIofLHE3Ka0xmZ2ZRrvGKmt5fpsPyTVD5Upb1K6Z1JM9V6A5xr
         VvSml0IEFje4U6ymZ/MprxS0+pZWvKvrswcX4rBiIEJR+oC5hys30w7c1MNGdW+noyVs
         BQFKtUcBLjVwPNQyvBdgZrP/5Ro7l+Px6uRql7JK9BgLw5Mb6CK3pj+R0qgBox6+799u
         vMXcJ6HXkL186Zki/F4REFy2WWn5zVbQDnaZUXRgGUWeCuaonO6pbpZRf8LsF8sL/w2s
         3wyQ==
X-Gm-Message-State: APjAAAWdtpNuenzH2R1oatJsgSryAMaJ6veuw8buA8S3PHukyX/byXwA
        Qe6aALDBViABBiwUxjTGFwkOOXaYImonwDk+3Eflta++
X-Google-Smtp-Source: APXvYqzOwrsu1mWvHpi73v+hwthMtL3AlqBWGIUzc5sLIk/R02iUtUFLpSiSDWYJWtL5KzWc0i6VnYvgUoPppmlS1LY=
X-Received: by 2002:a19:5789:: with SMTP id l131mr22037709lfb.8.1553791395949;
 Thu, 28 Mar 2019 09:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190309015635.5401-1-manivannan.sadhasivam@linaro.org>
 <20190309015635.5401-2-manivannan.sadhasivam@linaro.org> <20190312122711.b2ibipico2dgavl7@holly.lan>
 <20190320065658.GA22381@Mani-XPS-13-9360> <20190320172956.lt4eq3vusq4traea@shell.armlinux.org.uk>
 <20190321111716.weqoderiyuicbktc@holly.lan>
In-Reply-To: <20190321111716.weqoderiyuicbktc@holly.lan>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Mar 2019 17:43:04 +0100
Message-ID: <CACRpkdZN2=qRQn2Je0uzPiuJ37+nAzboGfW+sFCb=dmzO4O_Zg@mail.gmail.com>
Subject: Re: [PATCH 1/2] amba: Take device out of reset before reading pid and
 cid values
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Xu Wei <xuwei5@hisilicon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Guodong Xu <guodong.xu@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 12:17 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On Wed, Mar 20, 2019 at 05:29:56PM +0000, Russell King - ARM Linux admin wrote:
> > On Wed, Mar 20, 2019 at 12:26:58PM +0530, Manivannan Sadhasivam wrote:

> > That said, if a reset line is shared between multiple devices, and a
> > driver wants to assert the reset line, it would disrupt the operation
> > of all those devices, so there would need to be some kind of
> > synchronisation between the drivers.
>
> That is what shared ownership of the reset line provides. When a line is
> shared a single driver does not have the authority to unilaterally
> assert reset because deasserts and asserts are counted and the line only
> goes high again when they balance.

This is what we want for this I'm pretty sure. Regulators have the same
thing with internal reference counting so that if you turn a shared regulator
on from several clients it just increases the refcount and it will not really
be turned off until the last consumer is disabling it.

Yours,
Linus Walleij
