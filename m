Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CCEC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D28D2075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 13:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgAFNhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 08:37:54 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37081 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgAFNhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 08:37:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id cy15so47424816edb.4;
        Mon, 06 Jan 2020 05:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nTRmM4JajO9uUHX21IbuaGFMr+hIBoIOQlYQd1Eaoq0=;
        b=a+6IERio2pjCQtrrPwe+56IZ1Uwji1aYvpBzrCDIPRNzS5L7fp6NfT5BCDXeV1HMRg
         LEP7+BHGE8xg9McEzJLK32FK8jheqSAYUUDvZleBoJ01IGUBXuu6MDG8bmxl+9ThQIbg
         gtSwFiLZCINwtF/MCamqvD8i9FY+f5TlA6UF1dBuCD7+HPOE1qn/zVq7fqej9NT7PedR
         H9x1loYAspN7Sikc9PGwBsSBEeTx60gOnLi7drpPmPyZK1ebUljTe2tQBp1E2En09KBE
         WJw3pr5NNd5lvBSfDFstbxOV40+VfZL6kTpBl3mZd1YHppJPMVlB4OgOh/H8Z6mTy6LG
         KRxA==
X-Gm-Message-State: APjAAAWifSErs8OjDO/1fHtXDX2OncQqB0waugKdwZuLLSi1GyfE9OK5
        iScYgkZzL+NtGHwTkfYurnEh+DyGcmU=
X-Google-Smtp-Source: APXvYqyvlBlwU3iT53pROHfeoXpEtUXCC1GpW43FqjyvfB5AEk7MUNRu1JCMhEjj9SlPptQ9zRTl5w==
X-Received: by 2002:a50:93a2:: with SMTP id o31mr107569180eda.160.1578317871233;
        Mon, 06 Jan 2020 05:37:51 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id y21sm7473385edu.70.2020.01.06.05.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2020 05:37:50 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 20so15256881wmj.4;
        Mon, 06 Jan 2020 05:37:50 -0800 (PST)
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr34993499wmg.110.1578317870539;
 Mon, 06 Jan 2020 05:37:50 -0800 (PST)
MIME-Version: 1.0
References: <20200106003849.16666-1-andre.przywara@arm.com> <20200106085613.mxe33t7eklj3aeld@gilmour.lan>
In-Reply-To: <20200106085613.mxe33t7eklj3aeld@gilmour.lan>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 6 Jan 2020 21:37:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v65=iJzPJneUF=e9Xsqj_ufhuZtr5javN5YNKtaApGq2zA@mail.gmail.com>
Message-ID: <CAGb2v65=iJzPJneUF=e9Xsqj_ufhuZtr5javN5YNKtaApGq2zA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: sun8i: R40: Add SPI controllers nodes and pinmuxes
To:     Maxime Ripard <mripard@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 4:56 PM Maxime Ripard <mripard@kernel.org> wrote:
>
> On Mon, Jan 06, 2020 at 12:38:49AM +0000, Andre Przywara wrote:
> > The Allwinner R40 SoC contains four SPI controllers, using the newer
> > sun6i design (but at the legacy addresses).
> > The controller seems to be fully compatible to the A64 one, so no driver
> > changes are necessary.
> > The first three controllers can be used on two sets of pins, but SPI3 is
> > only routed to one set on Port A.
> > Only the pin groups for SPI0 on PortC and SPI1 on PortI are added here,
> > because those seem to be the only one exposed on the Bananapi boards.
> >
> > Tested by connecting a SPI flash to a Bananapi M2 Berry SPI0 and SPI1
> > header pins.
> >
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>
> Applied, thanks!
> Maxime

Looks like this patch doesn't build. The SPI device nodes reference
a non-existent DMA node.

ChenYu
