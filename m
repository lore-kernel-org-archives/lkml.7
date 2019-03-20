Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B11C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0403220828
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 00:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bzw2JUtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbfCTAVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 20:21:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46830 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfCTAVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 20:21:00 -0400
Received: by mail-qt1-f193.google.com with SMTP id z25so526296qti.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 17:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zQmCD3sREUOQwH4FPp6CA4aVK08SIwr97WyKhXdZnQg=;
        b=bzw2JUttAidp/yj9zNb21J2mklrB4ORgex6qHvNV60XXoeRTiL2ESkymUJXXScOhHW
         6UfHgZ7wAsXNBOIuWhTM4mjapWTuMJZThYvwqBXaDegUjzFo2hRQvQ7yBG3F8zjRC3lf
         B0uRPP1X7i1Fm7+CpAmtBJ1sVvvD0DbnZr1oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQmCD3sREUOQwH4FPp6CA4aVK08SIwr97WyKhXdZnQg=;
        b=EM4z6XAeX8BZ1FNUUsCaklNtMttt6cTeHVXLbP1lgd690ArZWeqC1KcYw+NKpGVS5A
         hQxCrZmoJFV1ab7b6rZpmTCXvDcfVXKTZddO+8gAsCwWCxnl+YIa2bnkeFgStNwHEro6
         1qd3TmaT+nw4rVTn68cB8oa622r1nsU2qHTo+2LaAwXWSnbCVGZFzopH/y8z+R+VU7XK
         8Vd/QHHHLxVDvyKPl248WOzLrWoZn5d13TJhr7uh4PNo0OxC/Ih3liWxHvm3J/aeFVGM
         e2EW4ody6Xp024ucEACUsa/F440xBFJ96ntLQ5Dr8Ofx7nL3zxy4YyHcrX6+Rr3sV99X
         PPIQ==
X-Gm-Message-State: APjAAAUkkEI6BZrGv7V1qVqSXSm7sfDA9gbCguERti4K14c7SeN950N5
        kDncz0nD+DpXHzQcbJ4C7E2oCOY3D5j6HEStymvZAA==
X-Google-Smtp-Source: APXvYqxe7hcm85vJxzxb+3t+Kp2FxLDCiQS1m2UbUsHfl7Y/EfaBLiyfZcg8Qx2I3W4SsvM+/rsaTGK1MvV+z0Qwo2Q=
X-Received: by 2002:ac8:1884:: with SMTP id s4mr4584119qtj.339.1553041258782;
 Tue, 19 Mar 2019 17:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
 <20190111102155.in5rctq5krs4ewfi@8bytes.org> <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
 <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz> <CANMq1KCfhWdWtXP_PRd_LEEcWV8SQg=hOy4V7_grqtL873uUCg@mail.gmail.com>
 <CANMq1KBKF9aRj+8t+AQusNLOF5jrHJ4qY5C00AKXkO6e-8wKuQ@mail.gmail.com> <20190319105637.4949b00b854e955d61c0359d@linux-foundation.org>
In-Reply-To: <20190319105637.4949b00b854e955d61c0359d@linux-foundation.org>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 20 Mar 2019 08:20:47 +0800
Message-ID: <CANMq1KAWbfNJQt=RaK-+us7eS6ReLFqaEbO3hMPfBy_w3ukj7A@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for page tables
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        iommu@lists.linux-foundation.org,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>, hch@infradead.org,
        Matthew Wilcox <willy@infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, stable@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:56 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 19 Mar 2019 15:41:43 +0800 Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > On Mon, Feb 25, 2019 at 8:23 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > On Thu, Feb 14, 2019 at 1:12 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > >
> > > > On 1/22/19 11:51 PM, Nicolas Boichat wrote:
> > > > > Hi Andrew,
> > > > >
> > > > > On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
> > > > >>
> > > > >> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> > > > >> > Does anyone have any further comment on this series? If not, which
> > > > >> > maintainer is going to pick this up? I assume Andrew Morton?
> > > > >>
> > > > >> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
> > > > >> this should go through mm.
> > > > >
> > > > > Gentle ping on this series, it seems like it's better if it goes
> > > > > through your tree.
> > > > >
> > > > > Series still applies cleanly on linux-next, but I'm happy to resend if
> > > > > that helps.
> > > >
> > > > Ping, Andrew?
> > >
> > > Another gentle ping, I still don't see these patches in mmot[ms]. Thanks.
> >
> > Andrew: AFAICT this still applies cleanly on linux-next/master, so I
> > don't plan to resend... is there any other issues with this series?
> >
> > This is a regression, so it'd be nice to have it fixed in mainline, eventually.
>
> Sorry, seeing "iommu" and "arm" made these escape my gimlet eye.

Thanks for picking them up!

> I'm only seeing acks on [1/3].  What's the review status of [2/3] and [3/3]?

Replied on the notification, [2/3] had a Ack, [3/3] is somewhat controversial.
