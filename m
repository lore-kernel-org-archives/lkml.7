Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E4CC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AB7120652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gOZK4Y2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfCETDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:03:33 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37575 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbfCETDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:03:32 -0500
Received: by mail-lj1-f195.google.com with SMTP id a17so8549479ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s81Hn40LodeFW3tMTDiMnNX38soGliRkaSDKi58WZ1Y=;
        b=gOZK4Y2zc80yAAKafM7YgwPJVU0JYjTVv8mUmCeRU2Ma+EL0BB1pdrLc2gjMIq5I31
         MhcfwBqbf4ch9sC8ITueN5bUbWmOMhETAyMKa2o/orXpl0Fc5x+pG3XIFPPxOQRKml4k
         iytEcVlVFY4k3U3Wq+8lI5s2ho1Fqmixps0ss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s81Hn40LodeFW3tMTDiMnNX38soGliRkaSDKi58WZ1Y=;
        b=QMsdBgC2uPndNryogNrqTPIrBZldxg1eoY6hX/gFQ3eMXvs6SlGXvPvozBMLSaBXqF
         Ucv8bdWZ/ZStc/AawgvLswDGfF6737lSg1GW2DaEta9Y9OeCHuHGWo5bWrIIk6QAISlN
         7b/vGougHj7xo/ou9xMb7kztYuRgv8XaFcju63xWsKpBToI5xS+xyqKU0ZJfbHJ2Vmvj
         lNA85QJQV8lL8fUXgjXcUhAK6M52ViNmA4vQK1o5HQBHn6jOE+yI4YpBSHM0TUIY7XdI
         OuX+5xY7AvE8auu43WfTDcg1nFXd1bOEmMNvquE/shTlf69+gg7gV5k1jcD68Hk7Np3B
         V9Tg==
X-Gm-Message-State: APjAAAVEJUkrLN/vJ2PcPP84C2rKObGTe+oVODybir7ASmJ4G1bbZ217
        y44cdHtWkmfq6vfnehxMeMJ79I/qqcQ=
X-Google-Smtp-Source: APXvYqycEWqLBxyrBrXZ07l/IdoDIkZtAppgblunzEGnFWcyW18dptYUqX9TyclUIkL5vkXPnY/tQg==
X-Received: by 2002:a2e:93ca:: with SMTP id p10mr114325ljh.16.1551812609898;
        Tue, 05 Mar 2019 11:03:29 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v20sm2281534ljv.83.2019.03.05.11.03.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:03:28 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id d24so8549491ljc.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:03:27 -0800 (PST)
X-Received: by 2002:a2e:6a18:: with SMTP id f24mr82616ljc.97.1551812607271;
 Tue, 05 Mar 2019 11:03:27 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-4-git-send-email-yong.wu@mediatek.com> <CAE=gft4aJxXbrecehAhgYL0TANxdwukmdQtpiLgNkzCDAUO6Cg@mail.gmail.com>
 <1551278034.17917.52.camel@mhfsdcap03>
In-Reply-To: <1551278034.17917.52.camel@mhfsdcap03>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 5 Mar 2019 11:02:50 -0800
X-Gmail-Original-Message-ID: <CAE=gft51UT7Hy4Tbbg3WS72FHB-41rWstQHD+otMZcM2qLVX7Q@mail.gmail.com>
Message-ID: <CAE=gft51UT7Hy4Tbbg3WS72FHB-41rWstQHD+otMZcM2qLVX7Q@mail.gmail.com>
Subject: Re: [PATCH 03/13] iommu/mediatek: Add probe_defer for smi-larb
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     youlin.pei@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, srv_heupstream@mediatek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 6:34 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > The iommu consumer should use device_link to connect with the
> > > smi-larb(supplier). then the smi-larb should run before the iommu
> > > consumer. Here we delay the iommu driver until the smi driver is
> > > ready, then all the iommu consumer always is after the smi driver.
> > >
> > > When there is no this patch, if some consumer drivers run before
> > > smi-larb, the supplier link_status is DL_DEV_NO_DRIVER(0) in the
> > > device_link_add, then device_links_driver_bound will use WARN_ON
> > > to complain that the link_status of supplier is not right.
> > >
> >
> > I don't quite have enough knowledge of device links to figure out if
> > this is a) the right fix, b) a deficiency in the device_links code, or
> > c) neither.
>
> I can not say more about the device link, But from the MTK iommu point
> of view, it looks a right fix. As the comment above, we should make sure
> the probe sequence, SMI-larb should be before MTK IOMMU which need be
> before iommu-consumer. this patch help SMI-larb always is before
> MTK_IOMMU.
>
> Then if there is no this patchset, what the MTK_IOMMU will happen?.
>
> The MTK_IOMMU is subsys_initcall, all the consume only need after the
> MTK_IOMMU and don't need wait for SMI-larb driver. If some consume run
> before SMI-larb driver, It also is OK while it don't call
> mtk_smi_larb_get in this probe.(Of course it will abort if it call this
> while smi-driver don't probe at that time). the consumer and smi-larb
> normally are module_init, we can not guarantee the the sequence. it is a
> potential issue.
>
> Some consume know it should wait for SMI-larb like [1], but It don't
> work.
>
> [1]
> https://elixir.bootlin.com/linux/v5.0-rc1/source/drivers/media/platform/mtk-mdp/mtk_mdp_comp.c#L145

Ok, I think I get it now. The device_links that get created are
enforcing a probe order dependency, but in cases where this driver
probes before those device links are even created, then this extra
check defers so that the probe order stays correct. Then the
device_links were correct to WARN because they're basically saying,
"hey, you asked us to enforce a particular dependency, but I can
already see probe is happening in an order that violates that
dependency".

Is that right?

-Evan
