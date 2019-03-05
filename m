Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C38C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D36720652
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 19:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ohQr+Bxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfCETEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 14:04:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42914 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfCETE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 14:04:29 -0500
Received: by mail-lj1-f194.google.com with SMTP id d14so8576491ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fL+TKYligpedsr6yGW7admNa5ubTDeYOjHMXRI35U3I=;
        b=ohQr+BxeQg1+LF6sZhHrM+Mt1kdjBZHmM4qKZ+yYqe4oByz42NT0LBeCh1Y5Z5MhMM
         8q1s/p1fqhu4TGy05fCGxlxPbn6pk/yQv4BQaKWKTMOhT3UYZ76jofNzlKR1SS6nEGSx
         mRS3hPZ+TT6TsYjWIfw8GAZbyxsG67UUJDTLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fL+TKYligpedsr6yGW7admNa5ubTDeYOjHMXRI35U3I=;
        b=WB3sCsJrCZIcKnql6XQIOHXTe4OISPNIZqsq6xNVtSGeij/wsVwCyjjodmMp+k3r1F
         kFfJoCDePMy8gmeROI2fl5xlg541oZVK2/BVHdphVaC5RABsoE2wN3cA+xC81WbW9Rqr
         jCWXsHZTBHxd8cxXGnwAQmyNAVsrYZNSR0TeaVOaYg01SwmCMxuT/mvMO4XkCvr4KyM5
         hillL0nOwYuHtvt6GEUhS8NlFYdALHVs8kNfI8vK5NvW+GjXSwpYIDVmr2WW42CnR/PU
         BYJECirDdTA7XtLXh4CIMTn9vOlFwf7tqYvCow2vh8dJwKSoDH/WcE410QmDkX0hNNrW
         H/Dw==
X-Gm-Message-State: APjAAAWNcTnE3zqAPWUzL2qWCAja4tLCu1Ran4ranFhAmm4u53DpJLhD
        NYOQg8xaxCdqja8bGeYPL8WPHJMydKk=
X-Google-Smtp-Source: APXvYqxnehmw43i/KVZSV0Ve+uCflo+f4/T367pmZDM9Lmb2uSpHnrKVt+HFaRQxSVGolndb5fpM9A==
X-Received: by 2002:a2e:8886:: with SMTP id k6mr95519lji.43.1551812666521;
        Tue, 05 Mar 2019 11:04:26 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id c190sm2329041lfg.84.2019.03.05.11.04.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 11:04:26 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id h6so2759355lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 11:04:25 -0800 (PST)
X-Received: by 2002:a19:a417:: with SMTP id q23mr1716948lfc.27.1551812665056;
 Tue, 05 Mar 2019 11:04:25 -0800 (PST)
MIME-Version: 1.0
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-3-git-send-email-yong.wu@mediatek.com> <CAE=gft7mWs1jc+KQQcPuuhcmxpFRnRBTt35+uC3F20N6R554bQ@mail.gmail.com>
 <1551278000.17917.50.camel@mhfsdcap03>
In-Reply-To: <1551278000.17917.50.camel@mhfsdcap03>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 5 Mar 2019 11:03:49 -0800
X-Gmail-Original-Message-ID: <CAE=gft4iHRo8VQot26dH2NaRNLtxxRYWBmSpjkoL2BE_i6eXQw@mail.gmail.com>
Message-ID: <CAE=gft4iHRo8VQot26dH2NaRNLtxxRYWBmSpjkoL2BE_i6eXQw@mail.gmail.com>
Subject: Re: [PATCH 02/13] driver core: Remove the link if there is no driver
 with AUTO flag
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
> On Mon, 2019-02-25 at 15:53 -0800, Evan Green wrote:
> > On Mon, Dec 31, 2018 at 8:52 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > DL_FLAG_AUTOREMOVE_CONSUMER/SUPPLIER means "Remove the link
> > > automatically on consumer/supplier driver unbind", that means we should
> > > remove whole the device_link when there is no this driver no matter what
> > > the ref_count of the link is.
> > >
> > > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > > The ref_count of our device_link normally is over 1. When the consumer
> > > device driver is removed, whole the device_link should be removed.
> > > Thus, I add this patch.
> > > ---
> >
> > I will admit to reading about device links for the first time while
> > reviewing this patch, but I don't really get this. Why use a kref at
> > all if we're just going to ignore its value? For instance, I see that
> > if you call device_link_add() with the same supplier and consumer, it
> > uses the kref to return the same link. That machinery is broken with
> > your change. Although I don't see any uses of it, you might also
> > expect a supplier or consumer could do a kref_get() on the link it got
> > back from device_link_add(), and have a reasonable expectation that
> > the link wouldn't be freed out from under it. This would also be
> > broken.
> >
> > Can you explain why your device_links normally have a reference count
> > >1,
>
> I use device link between the smi-larb device and the iommu-consumer
> device. Take a example, smi-larb1 have 4 VDEC ports. From 4/13 in this
> patchset, we use device_link to link the VDEC device and the smi-larb1
> device in the function(mtk_iommu_config). since there are 4 ports, it
> will call device_link_add 4 times.
>
> >
> > and why those additional references can't be cleaned up in an
> > orderly fashion?
>
> If the iommu-consume device(like VDEC above) is removed, It should enter
> device_links_driver_cleanup which only ref_put one time. I guess whole
> the link should be removed at that time.

It seems like Robin had some suggestions about using
mtk_iommu_add_device() rather than the attach_dev() to set the links
up, and then track them for removal in the corresponding
remove_device() callback. Then you wouldn't need this change, right?
