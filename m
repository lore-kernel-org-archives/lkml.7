Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC2A20652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HkL4i1Mk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfCETDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:03:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42647 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfCETDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:03:38 -0500
Received: by mail-lf1-f68.google.com with SMTP id p1so6989800lfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9eV+w1rVq47KEm/c+5FT1lKhow3a5EjOUVBdcY7lcDw=;
        b=HkL4i1MkL55mfllBwyKBifkM7QxVHKETERcfYHMqrhCEB9Vkjtn5cF4QhK20H03m/w
         NB89+Fz9hnc4+SoUycQdBxlFbClHwxiIZ9T2JUgXFiZCtCkNvcwVvi93WQ/c0l5IW+nG
         Vtp6MGDQWfdBTOmcWzmRxp9k4deVneQyxckXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9eV+w1rVq47KEm/c+5FT1lKhow3a5EjOUVBdcY7lcDw=;
        b=JYg6Fr34eUfHOFmJgDG4bkHFKKpvkYGdLqEOG/DAG8A7wWo7oHC4jCKaybPhNr0dKN
         tWMVQE1JxkYYTLil6PIwgpQtujGoCZzR63ztBr6iwYv6H7ihwDaFuWaHhK5RrzUrIhwg
         fNpdU0QqPhMEquSNa9vAnn9Z3YF1aEAS0HKFht+mpMksDdpCFXIuPbHJhAILWNk6ko5e
         EpyBkZNVEPvXVA/1czEMOGrrVs71O2qFGXAZMd4Ls03kn7R/Y6cQbqyjuJeRrxLLPaBR
         ke+WHTE9VDgBkArlWGcMQvjYusVBaM7veWMJ7vDUGw4uEFdJ9SEpPg212rMX9TmGf6gl
         5puQ==
X-Gm-Message-State: APjAAAX5Lk0sro/XiLdHpsAvRhwqVsdgfxQlJpF35C6wtzmTGf756d13
        44rBIzEXO38xF9OXYDXRaaQdQ/Pal48=
X-Google-Smtp-Source: APXvYqwihmMbTjPb+1q4QVcoh2I6MQrsbbSrf97ddOnIOW8ev1xc3GmFVhiL7omlGw5pE5jaqJbe1Q==
X-Received: by 2002:a19:d502:: with SMTP id m2mr1631533lfg.128.1551812615974;
        Tue, 05 Mar 2019 11:03:35 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a5sm2309621lfk.12.2019.03.05.11.03.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:03:35 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id z7so8581716lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:03:34 -0800 (PST)
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr118058ljj.30.1551812614556;
 Tue, 05 Mar 2019 11:03:34 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-6-git-send-email-yong.wu@mediatek.com> <CAE=gft71J+5ui_FFm4D+62uSy6KHYzT7wru_NNdPsvrCDV3ekw@mail.gmail.com>
 <1551277985.17917.48.camel@mhfsdcap03>
In-Reply-To: <1551277985.17917.48.camel@mhfsdcap03>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 5 Mar 2019 11:02:58 -0800
X-Gmail-Original-Message-ID: <CAE=gft4=VjbQut0vGVJ=ViqBCva00tdq1K-QnyJKSkzA4f0rUw@mail.gmail.com>
Message-ID: <CAE=gft4=VjbQut0vGVJ=ViqBCva00tdq1K-QnyJKSkzA4f0rUw@mail.gmail.com>
Subject: Re: [PATCH 05/13] memory: mtk-smi: Add device-link between smi-larb
 and smi-common
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Arnd Bergmann <arnd@arndb.de>,
        yingjoe.chen@mediatek.com, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 6:33 AM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2019-02-25 at 15:54 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > Normally, If the smi-larb HW need work, we should enable the smi-common
> > > HW power and clock firstly.
> > > This patch adds device-link between the smi-larb dev and the smi-common
> > > dev. then If pm_runtime_get_sync(smi-larb-dev), the pm_runtime_get_sync
> > > (smi-common-dev) will be called automatically.
> > >
> > > Since smi is built-in driver like IOMMU and never unbound,
> > > DL_FLAG_AUTOREMOVE_* is not needed.
> > >
> > > CC: Matthias Brugger <matthias.bgg@gmail.com>
> > > Suggested-by: Tomasz Figa <tfiga@chromium.org>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  drivers/memory/mtk-smi.c | 16 +++++++---------
> > >  1 file changed, 7 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> > > index 9688341..30930e4 100644
> > > --- a/drivers/memory/mtk-smi.c
> > > +++ b/drivers/memory/mtk-smi.c
> > > @@ -271,6 +271,7 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> > >         struct device *dev = &pdev->dev;
> > >         struct device_node *smi_node;
> > >         struct platform_device *smi_pdev;
> > > +       struct device_link *link;
> > >
> > >         larb = devm_kzalloc(dev, sizeof(*larb), GFP_KERNEL);
> > >         if (!larb)
> > > @@ -310,6 +311,12 @@ static int mtk_smi_larb_probe(struct platform_device *pdev)
> > >                 if (!platform_get_drvdata(smi_pdev))
> > >                         return -EPROBE_DEFER;
> > >                 larb->smi_common_dev = &smi_pdev->dev;
> > > +               link = device_link_add(dev, larb->smi_common_dev,
> > > +                                      DL_FLAG_PM_RUNTIME);
> >
> > Doesn't this need to be torn down in remove()? You mention that it's
> > built-in and never removed, but it does seem to have a remove()
>
> The MTK IOMMU driver need depend on this SMI driver. the IOMMU is a
> builtin driver, thus the SMI also should be a builtin driver.
>
> Technically, If the driver is builtin, then the "remove" function can be
> removed? If yes, I could use a new patch do it.

Yeah, I guess so. It's always sad to see cleanup code getting removed,
but it makes sense to me.


>
> It looks the MACRO(builtin_platform_driver) only support one driver, but
> we have two driver(smi-common and smi-larb) here.
>
> > function that tears down everything else, so it seemed a shame to
> > start leaking now. Maybe the AUTOREMOVE flag would do it.
>
>
