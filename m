Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC64C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F7320833
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 07:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kQL2AZP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388308AbfFJH6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 03:58:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33279 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388261AbfFJH6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 03:58:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id h9so13244525edr.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlJ7kEpQ8wNqI+qin5NIgLFKGHCVC1ANXb/nCDBzTgQ=;
        b=kQL2AZP0gBm+87LmnpAKPXsOFeHuskGZAqtDENXQ/pKLYBwGsN6NaE81wgpDmot6Hj
         7fNmavFRolq1Db2Mq7AZ3WHlDhuOyRXBv8JepydsyiqQKVLjUCQlnmLmgvx6Du80Gl0A
         MCMu/Pgz4vY3DJg0rAisvrMPjvVdfTJGxc5OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlJ7kEpQ8wNqI+qin5NIgLFKGHCVC1ANXb/nCDBzTgQ=;
        b=qQs1P2p8y6J6HzyFbu51O2ZAMxbMUg+YZ4G/aTuHDOiHFhnSehHZ43swaqdRnmcajC
         deWE4foT3Rq204fBVhEjB+L2heoJv9PzV3sX2FQ4PmRvvKHNDEcg8rLoU6VUSk7WBqPz
         AUxtsB4JGlEHKCChWUUZM4ypF7pgdFxYXJzOUWDJIU/e/3Oxov/mkcnjmmd4b0KT53Ao
         F8dOwjncV7gWyjbqCIGEnNef4EZwnljQ/ETt699UneKxWTYooEGtSbGnnQ/yWizsDS9V
         Oqs1FTGwIp+JtMDxzcJFI86UXvUxgcRhAxfWTGILBsLDf9TvN1nWlb59ZO1lZYpNlyys
         LNgA==
X-Gm-Message-State: APjAAAW34Eyi+tHukhqfzLgAxx9WzJndh+tHpQKB4UWmBqJ7uBAjotqW
        7ffhjCmNwxfqW0D6q1e6yCifIJuK7oBbkQ==
X-Google-Smtp-Source: APXvYqwdTyPWUNtzuMBXgjtfagcutTe4QiQLdfyEhmiNExCoWXQ9+c7jLAl3eU0mwrTSsY66WBSqLA==
X-Received: by 2002:a17:906:2acf:: with SMTP id m15mr58724587eje.31.1560153496027;
        Mon, 10 Jun 2019 00:58:16 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id u26sm2606130edf.91.2019.06.10.00.58.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 00:58:15 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id u8so7161996wmm.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 00:58:14 -0700 (PDT)
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr13318912wmj.64.1560153493721;
 Mon, 10 Jun 2019 00:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <1559643115-15124-1-git-send-email-stu.hsieh@mediatek.com>
 <1559643115-15124-2-git-send-email-stu.hsieh@mediatek.com>
 <1560134057.28527.5.camel@mtksdaap41> <CAHD77H=vuPi2Rj4Mw-CQ2=UYX7YnS8w8FpUk0QTVxNUVLWKbJg@mail.gmail.com>
 <1560153073.31854.6.camel@mtksdaap41>
In-Reply-To: <1560153073.31854.6.camel@mtksdaap41>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 10 Jun 2019 16:58:02 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DDE-L7mW8sTXVYOTLZ8yi3+X6Q3O73fJ61e1aUoeddgg@mail.gmail.com>
Message-ID: <CAAFQd5DDE-L7mW8sTXVYOTLZ8yi3+X6Q3O73fJ61e1aUoeddgg@mail.gmail.com>
Subject: Re: [PATCH v4 01/14] dt-bindings: Add binding for MT2712 MIPI-CSI2
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Stu Hsieh <stu.hsieh@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 4:51 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Tomasz:
>
> On Mon, 2019-06-10 at 12:32 +0900, Tomasz Figa wrote:
> > Hi CK, Stu,
> >
> > On Mon, Jun 10, 2019 at 11:34 AM CK Hu <ck.hu@mediatek.com> wrote:
> > >
> > > Hi, Stu:
> > >
> > > "mediatek,mt2712-mipicsi" and "mediatek,mt2712-mipicsi-common" have many
> > > common part with "mediatek,mt8183-seninf", and I've a discussion in [1],
> > > so I would like these two to be merged together.
> > >
> > > [1] https://patchwork.kernel.org/patch/10979131/
> > >
> >
> > Thanks CK for spotting this.
> >
> > I also noticed that the driver in fact handles two hardware blocks at
> > the same time - SenInf and CamSV. Unless the architecture is very
> > different from MT8183, I'd suggest splitting it.
> >
> > On a general note, the MT8183 SenInf driver has received several
> > rounds of review comments already, but I couldn't find any comments
> > posted for this one.
> >
> > Given the two aspects above and also based on my quick look at code
> > added by this series, I'd recommend adding MT2712 support on top of
> > the MT8183 series.
>
> In [1], "mediatek,mt8183-seninf" use one device to control multiple csi
> instance, so it duplicate many register definition. In [2], one
> "mediatek,mt2712-mipicsi" device control one csi instance, so there are
> multiple device and the register definition does not duplicate.

I guess we didn't catch that in the review yet. It should be fixed.

> You
> recommend adding MT2712 support on top of the MT8183 series, do you mean
> that "mediatek,mt2712-mipicsi" should use one device to control multiple
> csi instance and duplicate the register setting?

There are some aspects of MT8183 series that are done better than the
MT2712 series, but apparently there are also some better aspects in
MT2712. We should take the best aspects of both series. :)

Best regards,
Tomasz

>
> [1] https://patchwork.kernel.org/patch/10979121/
> [2] https://patchwork.kernel.org/patch/10974573/
>
> Regards,
> CK
>
> >
> > Best regards,
> > Tomasz
>
>
