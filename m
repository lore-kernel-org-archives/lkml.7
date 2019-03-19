Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156A2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC7B2133D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553018202;
	bh=tjp0SsFl9thEqEjmKhXPi8SQ6eM9/xr7wxqxxgMlHsQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YcAT6Tmv3u4jrG33vuiZW8xyMSfLF5HlZf+vJYyapB1Sz4wt0xytQ8fyHpwJ0BQNH
	 cEe7g3rL0lPBpJXHsSONowai8wxxWf0g9oaGCx74Dswc9L00nnHfQU4IKubo58jZO5
	 XbzISOcMvuAnC/AuW9gyrRbhJUH5T1T2bzGeduuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfCSR4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:56:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58536 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfCSR4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:56:41 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C383B3A59;
        Tue, 19 Mar 2019 17:56:38 +0000 (UTC)
Date:   Tue, 19 Mar 2019 10:56:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
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
Subject: Re: [PATCH v6 0/3] iommu/io-pgtable-arm-v7s: Use DMA32 zone for
 page tables
Message-Id: <20190319105637.4949b00b854e955d61c0359d@linux-foundation.org>
In-Reply-To: <CANMq1KBKF9aRj+8t+AQusNLOF5jrHJ4qY5C00AKXkO6e-8wKuQ@mail.gmail.com>
References: <20181210011504.122604-1-drinkcat@chromium.org>
        <CANMq1KAmFKpcxi49wJyfP4N01A80B2d-2RGY2Wrwg0BvaFxAxg@mail.gmail.com>
        <20190111102155.in5rctq5krs4ewfi@8bytes.org>
        <CANMq1KCq7wEYXKLZGCZczZ_yQrmK=MkHbUXESKhHnx5G_CMNVg@mail.gmail.com>
        <789fb2e6-0d80-b6de-adf3-57180a50ec3e@suse.cz>
        <CANMq1KCfhWdWtXP_PRd_LEEcWV8SQg=hOy4V7_grqtL873uUCg@mail.gmail.com>
        <CANMq1KBKF9aRj+8t+AQusNLOF5jrHJ4qY5C00AKXkO6e-8wKuQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Mar 2019 15:41:43 +0800 Nicolas Boichat <drinkcat@chromium.org> wrote:

> On Mon, Feb 25, 2019 at 8:23 AM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > On Thu, Feb 14, 2019 at 1:12 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >
> > > On 1/22/19 11:51 PM, Nicolas Boichat wrote:
> > > > Hi Andrew,
> > > >
> > > > On Fri, Jan 11, 2019 at 6:21 PM Joerg Roedel <joro@8bytes.org> wrote:
> > > >>
> > > >> On Wed, Jan 02, 2019 at 01:51:45PM +0800, Nicolas Boichat wrote:
> > > >> > Does anyone have any further comment on this series? If not, which
> > > >> > maintainer is going to pick this up? I assume Andrew Morton?
> > > >>
> > > >> Probably, yes. I don't like to carry the mm-changes in iommu-tree, so
> > > >> this should go through mm.
> > > >
> > > > Gentle ping on this series, it seems like it's better if it goes
> > > > through your tree.
> > > >
> > > > Series still applies cleanly on linux-next, but I'm happy to resend if
> > > > that helps.
> > >
> > > Ping, Andrew?
> >
> > Another gentle ping, I still don't see these patches in mmot[ms]. Thanks.
> 
> Andrew: AFAICT this still applies cleanly on linux-next/master, so I
> don't plan to resend... is there any other issues with this series?
> 
> This is a regression, so it'd be nice to have it fixed in mainline, eventually.

Sorry, seeing "iommu" and "arm" made these escape my gimlet eye.

I'm only seeing acks on [1/3].  What's the review status of [2/3] and [3/3]?
