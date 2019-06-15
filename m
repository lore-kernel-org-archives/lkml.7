Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DB2C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 09:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB8A21848
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 09:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsVylsI+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfFOJel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 05:34:41 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46252 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfFOJel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 05:34:41 -0400
Received: by mail-lj1-f193.google.com with SMTP id v24so4711754ljg.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 02:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S+e3ae3nDo211Phfm6lcT95OA7IYBp3eNuvxr46hQI8=;
        b=zsVylsI+bnY06zotdYazoqPbnqUS2bZqtx0d0MuPW/bi3FvKVPndysWw/GmsA8nyHT
         8OH/NT4ce1fzy5TYJlw+GTkMjV7R1XaROP5ucrGnnw9G+yWfWFxFlIgWx3OVZ0x1I5tl
         QnwB4lxeWcknPXNyNPm3rS4cHa7P5WmM815esIo4rsIvSI7OdC5YxnnU8It9uAtMks6l
         K850SbpvjROUXWEPw6SiH2O9omsXoqefhAPei/vVTEUCASiIZYeatcjTMajo59ZtyfWb
         DWVcboaNAnc11jo7aidKR2y3twNjWkTIb2gO4WO2e7TpPWH+XJkry/tpYuGouE7lLcyR
         0c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S+e3ae3nDo211Phfm6lcT95OA7IYBp3eNuvxr46hQI8=;
        b=loLoVl+I66lkcNX83EmNgsi0x9ES3Nj1Ykb9/t/hTdhE8BQK2W/mdt5std0gTBk+CM
         BnN4+E13m8pxD5QkvfHZ9BDmmxAAGBNIaURox8YWaxFgVQC/BWCyN3ja/RMFdRgVj+H/
         L7YmBhd8v72HDggMmewUig3uCp28HD7qGb+Y0PDZCjpPpNVeG2fgNr1etwlFPxUEmPZG
         iOIwNqXv0EWbeOkaZ4NPFBgChYhEjHjqCVwqrw3DL2Wh+rEDgHikR5YGx7MGF5OQ070Y
         20a0yAulTdNmC6LjgLG25xVnVAh6ej6seZFhp6u9A9BpxSX8bIpPNvAlONP/I+P6tSzs
         MOBw==
X-Gm-Message-State: APjAAAW4tIavzW2+3mN3WPJetFP/9+7U7YJN46MOQeXF2uQDYtIq8W5U
        K70IOHuxKCRizepV4E0XWoe4t8KWcP10ezeBFUMMqQ==
X-Google-Smtp-Source: APXvYqwLTbopvLRNBKb2DO7gOLSSgRDu4W/A9L+CndsAaEJ7YfZQiyyOgo75eSM8f89ms/J7M3hBuD/kna+45G311Jo=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr23119868ljm.180.1560591279344;
 Sat, 15 Jun 2019 02:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190612193115.6751-1-martin.blumenstingl@googlemail.com>
 <20190612193115.6751-2-martin.blumenstingl@googlemail.com>
 <CACRpkdajXRXRFz=XpbEzwUb-crhBxNQ4f-m9rfdY6+HcG0+_gA@mail.gmail.com> <CAFBinCAimhth8fDcBZ3vNdy_9dGmHZVAAK0=TUczWWC4Dsa-pA@mail.gmail.com>
In-Reply-To: <CAFBinCAimhth8fDcBZ3vNdy_9dGmHZVAAK0=TUczWWC4Dsa-pA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 15 Jun 2019 11:34:25 +0200
Message-ID: <CACRpkdbQ5VivFJhL4keOgmUe7BzhVU2v2R0Lso8rQx5s3tHY8w@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/1] net: stmmac: use GPIO descriptors in stmmac_mdio_reset
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     netdev <netdev@vger.kernel.org>,
        Giuseppe CAVALLARO <peppe.cavallaro@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15, 2019 at 11:11 AM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:

> I think I finally understand why you want to switch everything over to
> GPIO descriptors

A bit after-the-fact reasoning, but after I was made aware of an interesting
lecture by John Ousterhout I feel the best description of the descriptor
refactoring is the idea to make the GPIO API narrow and deep, make
it simple for consumers (hence <linux/gpio/consumer.h>) and handle
as much special cases (polarity inversion, open drain...) as possible
behind the scenes.

Yours,
Linus Walleij
