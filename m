Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F54C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F09207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 00:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XBamOGLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgAHAkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:40:09 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:36321 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHAkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:40:08 -0500
Received: by mail-ua1-f67.google.com with SMTP id y3so486587uae.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 16:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WLjZaC1aGgIebUtU9dIlnWx8pS+fdlckVdmM03eP7cw=;
        b=XBamOGLjiMe/1wboMnC4akJ4E7uWFgoz+IAx3WrGXh8MIA49FAMMEpAe/JubLMybzk
         5K/VH5v+UpBAozWzfOvjvWeMWDGLGm5/NkCINpdgsiGT2QEScK+exPIW1a+FS4mbv/OI
         vhAS/Jr/otz5BhNI8nE2G41Cnc/z4+NhLDk68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WLjZaC1aGgIebUtU9dIlnWx8pS+fdlckVdmM03eP7cw=;
        b=SrsJUOodKTE6JSzE6pgayHRF83lRPEYTs4nByyWEj3exkG9jpwD3R1Zio3pmvNn+IO
         54ar94lgZstUId1OwZWVBuWnRnOtHlvLz/rmq2RFmeCnk+IK4992JzKCd2Mxr25cwaxQ
         EDyzCOsUSO4wnYPTT2dohxWBRwfus+v2SUAGMHsRxQs1IBEwzUfx9lQAm6FqZKKZW9mR
         cCNuBT/+P+Ak+RnN7y9wCcYR2Aif1Jr4p4f4xcr3P9dp5pgqlqTVFRAUCR/bWSm4UaHM
         qBTW2dO1BlgwFZpmxdr1aZMgysABwPuFrI8YjanW2Ky1X0u41/b08Lno/QduVVN+jWmb
         zZ/w==
X-Gm-Message-State: APjAAAWz7pLTHgQbwN/Rcm4ujGXUEqPSZZnP19ffXCr7API9vsLA/GVQ
        GnELJP/5IQ4Isgj6wWLdOYCtEjVUVy8=
X-Google-Smtp-Source: APXvYqwsgfg4kUEs5ARlV2H6thL/77GAydy2QTZi+DH/ZxFukKjjWhZ9JClPuG2Dc4NAmi7SXI0x0g==
X-Received: by 2002:ab0:3350:: with SMTP id h16mr1536585uap.142.1578444007514;
        Tue, 07 Jan 2020 16:40:07 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id v65sm452489vke.13.2020.01.07.16.40.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2020 16:40:06 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id f7so473974uaa.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 16:40:06 -0800 (PST)
X-Received: by 2002:ab0:1697:: with SMTP id e23mr1621573uaf.91.1578444006103;
 Tue, 07 Jan 2020 16:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20191217005424.226858-1-swboyd@chromium.org> <CAD=FV=UQAgd2R=ykTCnBZuOvFFKoWu4o-3Rq=GEdrc1KKSi9cQ@mail.gmail.com>
 <20191220231040.GA11384@bogus> <5e12cc29.1c69fb81.fe838.d5f3@mx.google.com>
In-Reply-To: <5e12cc29.1c69fb81.fe838.d5f3@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 7 Jan 2020 16:40:05 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UnYCSZy-OP3m2c4nKy4fw47z5qT6f7xzpQ-UJj5nO3DQ@mail.gmail.com>
Message-ID: <CAD=FV=UnYCSZy-OP3m2c4nKy4fw47z5qT6f7xzpQ-UJj5nO3DQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: tpm: Convert cr50 binding to YAML
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
        <devicetree@vger.kernel.org>, Andrey Pronin" <apronin@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Jan 5, 2020 at 9:57 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> > > I'd like to see if we can delete most of what you've written here.
> > > Specifically in "spi/spi-controller.yaml" you can see a really nice
> > > description of what SPI devices ought to look like.  Can we just
> > > reference that?  To do that I _think_ we actually need to break that
> > > description into a separate YAML file and then include it from there
> > > and here.  Maybe someone on the list can confirm or we can just post
> > > some patches for that?
>
> I'm not sure what to do here.

Ignore me.  I guess it's overkill to try to do this and I suppose if
someone ever wants to do it they can always do it later.


-Doug
