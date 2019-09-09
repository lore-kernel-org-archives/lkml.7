Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BCC4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45D421924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YHy1qrMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbfIIRYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:24:33 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36455 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfIIRYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:24:32 -0400
Received: by mail-ot1-f67.google.com with SMTP id 67so13328917oto.3;
        Mon, 09 Sep 2019 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Wt1hD/MRsQkqqV33+GUQZHencJLKuHpXLwImoJRYqM=;
        b=YHy1qrMkczFFQ67ktlriXxOyE29+Bp3XIJ4JoIRyg3btuchKYh3OUMaKdFI2UjMXQD
         RrRefDltC3kmYcSXFqCYXX8o/i3xwLUGhJKwxrsdjspUD65Ya7wHxSH6XKvx5U4vSRBa
         R+hO9dTTrFgUaQ+8YXuQHV1dOLkj8osB0WquDFeaCIDRWie5SvRJz1hmUQWSbHQpxDvZ
         A16PEZ+me5Sa+F/aHm8nFPxB7n76Bj7m6w4LF8oG92BkZSQ/xLXI8oovo5IF8eUcl5z7
         3QVyGjBIJpEK3RoUqlvuJqdp4nosMcmKI4FVpRdJSOYNH5QgZSq9OSHNmvPBLS/uFN0G
         HJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Wt1hD/MRsQkqqV33+GUQZHencJLKuHpXLwImoJRYqM=;
        b=MgmG8LdnN4madcniVDKBUxE/QDYCjBXhDB1R4OPhKLr8t8D4VNGBEkGkLzGw32fu0L
         9FYrbWhHjUF7YfBKWFXyWRIbHxuV2zSkDcvUC5EArzD2z4K30eED67FZr098BDHUu2Eh
         dNO6mfl3W1Z6L79g6qjQia3UPf93f10gsq8Xqh0ffaNT8OBcujMKhQirPejxQSbZhgQy
         vigqaRbBZkKfVAvsHEVnvYA+EoUM+hpx1RnqLIJrBA+SfUC+KxEgiI8F4x3YfD+BWdOg
         Zd+0/gG1dps1WNFDJY9VrTtXpEUlFgABoB/fOiEuzd5fSoh04Ef/jn6XrKF2rehyMgiL
         dPeQ==
X-Gm-Message-State: APjAAAXWoWxyteql+WHtkFeM4lwaN9Gkbw37xQdtunYsFsK1CGeUFmsG
        8rjTkaVZh5rLqofr28uZQXizXwa9JUxAtQUwUqLnpw==
X-Google-Smtp-Source: APXvYqx/wYKZsFCWHqjgcQBulyAf2hyBig9egcPMosBzQP1ky90Mmva1Ji9X/RYvJZ4uQspim2j2H9duJRW0qz6v1a8=
X-Received: by 2002:a9d:5c0f:: with SMTP id o15mr21270768otk.81.1568049870233;
 Mon, 09 Sep 2019 10:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <1567667251-33466-1-git-send-email-jianxin.pan@amlogic.com>
 <1567667251-33466-5-git-send-email-jianxin.pan@amlogic.com>
 <CAFBinCBSmW4y-Dz7EkJMV8HOU4k6Z0G-K6T77XnVrHyubaSsdg@mail.gmail.com>
 <be032a85-b60d-f7f0-8404-b27784d809df@amlogic.com> <CAFBinCD7gFzOsmZCB8T1KJKVsgL7WMhoEkj3dRzyqwAnjC0CNA@mail.gmail.com>
 <a82336e2-44df-5682-1c86-daf8a8448d30@amlogic.com>
In-Reply-To: <a82336e2-44df-5682-1c86-daf8a8448d30@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 9 Sep 2019 19:24:19 +0200
Message-ID: <CAFBinCAJG4=M3BSXfREGU+iadMPkc7=yt3AdcqA1KAhQx6Wh9w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] arm64: dts: add support for A1 based Amlogic AD401
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Carlo Caione <carlo@caione.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Tao Zeng <tao.zeng@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianxin,

On Mon, Sep 9, 2019 at 2:03 PM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
>
> Hi Martin,
>
> On 2019/9/7 23:02, Martin Blumenstingl wrote:
> > Hi Jianxin,
> >
> > On Fri, Sep 6, 2019 at 7:58 AM Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> > [...]
> >>> also I'm a bit surprised to see no busses (like aobus, cbus, periphs, ...) here
> >>> aren't there any busses defined in the A1 SoC implementation or are
> >>> were you planning to add them later?
> >> Unlike previous series,there is no Cortex-M3 AO CPU in A1, and there is no AO/EE power domain.
> >> Most of the registers are on the apb_32b bus.  aobus, cbus and periphs are not used in A1.
> > OK, thank you for the explanation
> > since you're going to re-send the patch anyways: can you please
> > include the apb_32b bus?
> > all other upstream Amlogic .dts are using the bus definitions, so that
> > will make A1 consistent with the other SoCs
> In A1 (and the later C1), BUS is not mentioned in the memmap and register spec.
> Registers are organized and grouped by functions, and we can not find information about buses from the SoC document.
do you know why the busses are not part of the documentation?

> Maybe it's better to remove bus definitions for these chips.
my understanding is that devicetree describes the hardware
so if there's a bus in hardware (that we know about) then we should
describe it in devicetree

personally I think busses also make the .dts easier to read:
instead of a huge .dts with all nodes on one level it's split into
multiple smaller sub-nodes - thus making it easier to keep track of
"where am I in this file".


Martin
