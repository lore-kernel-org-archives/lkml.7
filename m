Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB664C10F0D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3A220854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 07:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f5okvv0Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfCSHl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 03:41:56 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46038 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCSHl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 03:41:56 -0400
Received: by mail-qt1-f194.google.com with SMTP id v20so21018308qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 00:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AKuHIe0ez2D49edy2KdVchoqrAYgE3HPWmIWLCE09Ec=;
        b=f5okvv0YSXxOiGUhQw4iUOiBvM7CzNsYObuRbwBbb5LZOQ22iMLJe/k0BWAt1X4JF+
         vJejcZXJLYJ7IKLJb0R1XafrsZfg4HbSbgSVVMjygdD/NM1WQiu0EI0zFNMZ6pEXQFxR
         O0XuP2fLYqaGOOVqUlpYfmFxEegaKF1d6aEtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AKuHIe0ez2D49edy2KdVchoqrAYgE3HPWmIWLCE09Ec=;
        b=Q6Gre1Fxx9T63aswrvmoyqMYMDIt3au9c2Hkpfx7jTMWzU4JcnHOgsU1ThgyAYccwT
         1P1Y7ej71Gzd5MS6lvgIJHN239Wx6MEQb0X8btj9vnwvnnKEBZ5QVDPJHUAU9zbdVaaq
         LValUafEwmmUwQnmnz/+8KkzNP4hQEQzrta1Cw6ZcLVIkm/2WUnzq2JZENKHpnSxnXJV
         Mx88T79We7i23Tz9xoqAqI9yeETj6e9oriJ3EeakWJQa2YPTuy8tFZoyKY3GF0c78xaH
         dtuyQkpBJ3RbeV1LhDQD3K5X24bFJD5vBLq365dU5+0hmQtZAdQaziTc/NBr4YrmX5hB
         e1QQ==
X-Gm-Message-State: APjAAAVXo+SYMCJPHAlUgc0Gmj3O+OFm+wnG/ifZqKJhPjYFR+9Rk/eZ
        2jhns5WJyi5X0fT+BtRljx596UwCYid3+eU5vrbXog==
X-Google-Smtp-Source: APXvYqyTzjT1x47abBKr7srSawj1xAGftoqEUHu5HMf3q6pGjpDjpfkE6S5BUwrjCQsPa7PeAuixzWkMplru36AMRRI=
X-Received: by 2002:a0c:9319:: with SMTP id d25mr706464qvd.99.1552981314960;
 Tue, 19 Mar 2019 00:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <20181210011504.122604-1-drinkcat@chromium.org>
 <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
 <20190111102155.in5rctq5krs4ewfi@8bytes.org> <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
 <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz> <CANMq1KCfhWdWtXP_PRd_LEEcWV8SQg=hOy4V7_grqtL873uUCg@mail.gmail.com>
In-Reply-To: <CANMq1KCfhWdWtXP_PRd_LEEcWV8SQg=hOy4V7_grqtL873uUCg@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 19 Mar 2019 15:41:43 +0800
Message-ID: <CANMq1KBKF9aRj+8t+AQusNLOF5jrHJ4qY5C00AKXkO6e-8wKuQ@mail.gmail.com>
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

On Mon, Feb 25, 2019 at 8:23 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> On Thu, Feb 14, 2019 at 1:12 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 1/22/19 11:51 PM, Nicolas Boichat wrote:
> > > Hi Andrew,
> > >
> > > On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
> > >>
> > >> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> > >> > Does anyone have any further comment on this series? If not, which
> > >> > maintainer is going to pick this up? I assume Andrew Morton?
> > >>
> > >> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
> > >> this should go through mm.
> > >
> > > Gentle ping on this series, it seems like it's better if it goes
> > > through your tree.
> > >
> > > Series still applies cleanly on linux-next, but I'm happy to resend if
> > > that helps.
> >
> > Ping, Andrew?
>
> Another gentle ping, I still don't see these patches in mmot[ms]. Thanks.

Andrew: AFAICT this still applies cleanly on linux-next/master, so I
don't plan to resend... is there any other issues with this series?

This is a regression, so it'd be nice to have it fixed in mainline, eventually.

Thanks,

> > > Thanks!
> > >
> > >> Regards,
> > >>
> > >>         Joerg
> > >
> >
