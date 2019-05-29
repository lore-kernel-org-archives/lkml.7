Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8029C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FA424015
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 18:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="F6umrA5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfE2SIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 14:08:37 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45822 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727276AbfE2SIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 14:08:37 -0400
Received: by mail-ot1-f66.google.com with SMTP id t24so2943933otl.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 11:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZqciIyIwhNV/sHfg7yKs2DBtNwzOc9301XGXD64ZpLU=;
        b=F6umrA5vVhg7FYm3YxM9CPXIT1/fC0p8oz3rQuWtSZIr1DLRRLP447fdg1z10a8RXA
         s3stQquLSBD9WnhT/YctqoLpNa8q1A/NhiirquY7/qTDqQHbGvnKWMdTeyhV8tRhgjap
         p5nbNeWyi9P1yOZ7PicltL76xoa1CVyEFvCxJxDwyTK2fSQBnJO685cEmgSVf9od4FVS
         ruUm2h138e6Fc0WLClAarGD6gppw0TSgWM/XWXztUvBLRjrzhC45oVCfmpfazbskvTMw
         mO96D5V0oyU0ZxLYS2S+aueSYQJwV9nebXl8BKT+D1JAhuBvBFXTT8wvilCA34xA7+xz
         DA/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZqciIyIwhNV/sHfg7yKs2DBtNwzOc9301XGXD64ZpLU=;
        b=d7T0zKfQ5WdEJzEa89aIyqdcuXTnjJLSYBCkrKfTsIOMiOR7nt8J3MMjBs6llWfklW
         pjZOcouWruw8Q3D+W2YMXJRox6sCH13bP/YqUf12L86m66i2hlUiC2kAkVW1fK2SWpJ/
         6JZPPGbL7JMtk1eIjC+X651tuQ+OdXCgaryjfoemaJMsI1OFNRbh0LQ8hS4Hgo19ipYU
         wdIickrj6s7yrrmgRx94sRKGQt23bvl4bLYadHitFuiFb4j7UltupimB8cyP6nRaVzSW
         1/OAfM1OLUu/rNWKvczMKUK/0fUN2hfiwayeaU83NF+Mm+JIrPofxeEfoPTc2JFRV32j
         XkJg==
X-Gm-Message-State: APjAAAU7OZ31QvgXItUarnDeq8VsZAez9Z2ZdKcTysM3xRVsI1AuDXcw
        CX1Aogh5xJ3D84whTs5oN8NKszhLqEhIN9ZZGs4U9HSY
X-Google-Smtp-Source: APXvYqxwk7iPwTnvooR6G+8asbXi2Yw5DbYyD1vDk+TyUrgU9x/Eq/8XReg/kqx8GMzQxm6aPn58ViHbD6tOsA/Ctv4=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr69739914otb.81.1559153316582;
 Wed, 29 May 2019 11:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190527132200.17377-1-narmstrong@baylibre.com>
 <20190527132200.17377-3-narmstrong@baylibre.com> <CAFBinCBTK=6OW4kG=i0KZe-+AzGVXyou9g0frnh9yqLsdmB5+w@mail.gmail.com>
 <b54c7899-95b3-1202-d70b-9b8ee2955164@baylibre.com>
In-Reply-To: <b54c7899-95b3-1202-d70b-9b8ee2955164@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Wed, 29 May 2019 20:08:25 +0200
Message-ID: <CAFBinCB9PZ-mjyjCafK24cH3sN5E1r4vt1z=m+uvkHsmRW2PFQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm64: dts: meson-gxm-khadas-vim2: fix Bluetooth support
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:25 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 27/05/2019 20:36, Martin Blumenstingl wrote:
> > On Mon, May 27, 2019 at 3:22 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> From: Christian Hewitt <christianshewitt@gmail.com>
> >>
> >> - Remove serial1 alias
> >> - Add support for uart_A rts/cts
> >> - Add bluetooth uart_A subnode qith shutdown gpio
> > I tried this on my own Khadas VIM2:
> > Bluetooth: hci0: command 0x1001 tx timeout
> > Bluetooth: hci0: BCM: Reading local version info failed (-110)
> >
> > I'm not sure whether this is specific to my board or what causes this.
>
> Which kernel version ?
5.2-rc2

it's a Khadas VIM2 Basic (thus it has a AP6356S), board revision v1.2


Martin
