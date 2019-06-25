Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA02EC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B212208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 17:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561484357;
	bh=uN+wDDacNJwqx+v/3/n9nLahoHqzeiFAwdlzYipdI4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZBLBr//u+YbNu839HemVlWHiwz6doz375qOxHfJwCyWl08qHD7B0ag04nEm3H3IpK
	 O1bsjEfMJ+4oz5JEugx0leRf8sOswKdgPhHOHoAq1HCA7C6gH7qfpykLr6Ye1NSPgu
	 jMpg5J44Om77aSoJqyGM+kmR2j7UcGf9gjiaYcuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfFYRjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 13:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfFYRjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 13:39:16 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5318208CA;
        Tue, 25 Jun 2019 17:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561484354;
        bh=uN+wDDacNJwqx+v/3/n9nLahoHqzeiFAwdlzYipdI4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DZClxw/ihopBvtSbOR8Z1H0A4Pac9E37GVJDGLb5uGZFu+kZDSY5rK6XQLgx77MGu
         PZWac+VgZuLeOQlZkw5MTWkK76V3Cvn5l724U3UUKKRahQ4StmpEdHw7+tMuFEZ35w
         f0pAHmJoix4gJmL4t9ALd8FeAQUbyBDdcKOUDJ8U=
Received: by mail-qt1-f173.google.com with SMTP id p15so19354822qtl.3;
        Tue, 25 Jun 2019 10:39:14 -0700 (PDT)
X-Gm-Message-State: APjAAAVO5ney6DEo3qabSQJNJcu36eDXk52uhyQKMPG96eD5MtkSrRbV
        j/61dSEllkxBdWFljIcko+TjbjjxLYbO6gtv0g==
X-Google-Smtp-Source: APXvYqyklRzybJRVDTEpfp0SeahUkH+awTTyyTlDMslpGY15qipWFkQLHnSeins0DWa3Bf2iY4HJCCw2GsgIen75KcU=
X-Received: by 2002:a0c:b627:: with SMTP id f39mr65154134qve.72.1561484354003;
 Tue, 25 Jun 2019 10:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190623043801.14040-1-icenowy@aosc.io> <20190623043801.14040-6-icenowy@aosc.io>
 <CACRpkdbbxgeGPh1oKfyKKOMhpXiz4sQWjZv23FbYaafCz6NyCQ@mail.gmail.com>
In-Reply-To: <CACRpkdbbxgeGPh1oKfyKKOMhpXiz4sQWjZv23FbYaafCz6NyCQ@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 25 Jun 2019 11:39:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+w-+cRwfAMu=kZPK=e85ujq8hu9Lh=jjf+Qy=R7C-AQA@mail.gmail.com>
Message-ID: <CAL_Jsq+w-+cRwfAMu=kZPK=e85ujq8hu9Lh=jjf+Qy=R7C-AQA@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] dt-bindings: vendor-prefixes: add SoChip
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 7:55 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Sun, Jun 23, 2019 at 6:39 AM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> > Shenzhen SoChip Technology Co., Ltd. is a hardware vendor that produces
> > EVBs with Allwinner chips. There's also a SoC named S3 that is developed
> > by Allwinner (based on Allwinner V3/V3s) but branded SoChip.
> >
> > Add the vendor prefix for SoChip.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> > No changes in v3.
> >
> > Changes in v2:
> > - Add the review tag by Rob.
>
> Should I apply this to the pinctrl tree? Rob?

I'd like to take these 2 because we have lots of vendor prefix changes
(adding a bunch of undocumented ones) this cycle.

Rob
