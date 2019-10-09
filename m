Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B310C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8DC20B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ifDZMaGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731508AbfJIPIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:08:55 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45755 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfJIPIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:08:55 -0400
Received: by mail-ed1-f66.google.com with SMTP id h33so2329883edh.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4dVOT/zwpO/iVlKT34i6lLt8un5vjwtrCBmaYK+BcfI=;
        b=ifDZMaGbzZ5zS8oLCskFTxsRDRy0vcmM6IDugkmp5x82gdumWWGf6drBBSbP2zXj1X
         keZnbytz7jKV9Bc7Px0ObzoVxcVnraGGKYROf0qAcLNCkS7CrVkbKcLA6O1VtlsCeaNB
         k//x58dAPebQUDYg1zX1dmiP1ryeq3hqRi88I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4dVOT/zwpO/iVlKT34i6lLt8un5vjwtrCBmaYK+BcfI=;
        b=ZTLihjdE5nDtlOLnDtRHOFjyAmvIRVy47QzK1i3giMWXkdlREnhE+WnCFDiU+xH55d
         NV1RUgfY9vZSHusHxwchjCBE5CsbpAMZON1kUztnajdpaxdZrACH/EwVRYVPg0q/YNj8
         OubTmC9Ty+GUTOMckRuMyofRGhfKS1CJ4xAF9rhGbGOcWU+7qo1n6eGNabyjDVOGjhoP
         Cy+GgOq6ST/bKYnXWU4+G7QtfblkdGzGy1H5R64YG5KPmnuEuaNVz+X/wVsZDRKd+Dj0
         NAXb2YZzY26NjRqlOxWUhcTkQ9U0znEyrpxj0Jq//4UOd8hXiHh7kWmLLhDE3uH8Cs+6
         yXIQ==
X-Gm-Message-State: APjAAAW2Hb9rZlTQbzWOtIUtp/gBhsVj1FpIYnTKV8vWNH31gAimm6Eb
        nNTMIExR7+WgIKqqvkdkx1WQ27kjDidMcw==
X-Google-Smtp-Source: APXvYqwAn773ovYSm9xgQmDHSA08lcoTrzaJC/T04SOXarbE+OKIesfMCxS2v1+xIhYtlopztK/pPA==
X-Received: by 2002:a05:6402:13d5:: with SMTP id a21mr3540134edx.242.1570633732228;
        Wed, 09 Oct 2019 08:08:52 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id e44sm391862ede.34.2019.10.09.08.08.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 08:08:50 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id y21so3027703wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:08:49 -0700 (PDT)
X-Received: by 2002:a1c:dcd6:: with SMTP id t205mr3094517wmg.10.1570633728709;
 Wed, 09 Oct 2019 08:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
 <CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com>
 <1570522162.19130.38.camel@mhfsdcap03> <CAAFQd5C3U7pZo4SSUJ52Q7E+0FaUoORQFbQC5RhCHBhi=NFYTw@mail.gmail.com>
 <1570628307.19130.53.camel@mhfsdcap03>
In-Reply-To: <1570628307.19130.53.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 10 Oct 2019 00:08:37 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Aj-DDofzQ1vyKT9OcXpf-Udfx4zeWtVGcQf7S-o+mStQ@mail.gmail.com>
Message-ID: <CAAFQd5Aj-DDofzQ1vyKT9OcXpf-Udfx4zeWtVGcQf7S-o+mStQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/mediatek: Move the tlb_sync into tlb_flush
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>,
        anan.sun@mediatek.com, cui.zhang@mediatek.com,
        chao.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 10:38 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2019-10-09 at 16:56 +0900, Tomasz Figa wrote:
> > On Tue, Oct 8, 2019 at 5:09 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > Hi Tomasz,
> > >
> > > Sorry for reply late.
> > >
> > > On Wed, 2019-10-02 at 14:18 +0900, Tomasz Figa wrote:
> > > > Hi Yong,
> > > >
> > > > On Mon, Sep 30, 2019 at 2:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > > >
> > > > > The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> > > > > TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> > > > > framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> > > > > lacked the dom->pgtlock, then it will cause the variable
> > > > > "tlb_flush_active" may be changed unexpectedly, we could see this warning
> > > > > log randomly:
> > > > >
> > > >
> > > > Thanks for the patch! Please see my comments inline.
> > > >
> > > > > mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> > > > > full flush
> > > > >
> > > > > To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
> > > > > And when checking this issue, we find that __arm_v7s_unmap call
> > > > > io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
> > > > > this also is potential unsafe for us. There is no tlb flush queue in the
> > > > > MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
> > > > > If v7s don't always gurarantee the sequence, Thus, In this patch I move
> > > > > the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
> > > > > and we don't care if it is leaf, rearrange the callback functions. Also,
> > > > > the tlb flush/sync was already finished in v7s, then iotlb_sync and
> > > > > iotlb_sync_all is unnecessary.
> > > >
> > > > Performance-wise, we could do much better. Instead of synchronously
> > > > syncing at the end of mtk_iommu_tlb_add_flush(), we could sync at the
> > > > beginning, if there was any previous flush still pending. We would
> > > > also have to keep the .iotlb_sync() callback, to take care of waiting
> > > > for the last flush. That would allow better pipelining with CPU in
> > > > cases like this:
> > > >
> > > > for (all pages in range) {
> > > >    change page table();
> > > >    flush();
> > > > }
> > > >
> > > > "change page table()" could execute while the IOMMU is flushing the
> > > > previous change.
> > >
> > > Do you mean adding a new tlb_sync before tlb_flush_no_sync, like below:
> > >
> > > mtk_iommu_tlb_add_flush_nosync {
> > >    + mtk_iommu_tlb_sync();
> > >    tlb_flush_no_sync();
> > >    data->tlb_flush_active = true;
> > > }
> > >
> > > mtk_iommu_tlb_sync {
> > >         if (!data->tlb_flush_active)
> > >                 return;
> > >         tlb_sync();
> > >         data->tlb_flush_active = false;
> > > }
> > >
> > > This way look improve the flow, But adjusting the flow is not the root
> > > cause of this issue. the problem is "data->tlb_flush_active" may be
> > > changed from mtk_iommu_iotlb_sync which don't have a dom->pglock.
> >
> > That was not the only problem with existing code. Existing code also
> > assumed that add_flush and sync always go in pairs, but that's not
> > true.
>
> Yes. Thus I put the tlb_flush always followed by tlb_sync to make sure
> they always go in pairs.
>
> >
> > My suggestion is to fix the locking in the driver and keep the sync
> > deferred as much as possible, so that performance is not degraded. I
>
> I really didn't get this timeout warning log in previous kernel(Many
> tlb_flush followed by one tlb_sync),

Locking issues typically lead to timing problems (race conditions), so
it might just be that the sequence or timing of calls changed between
kernel versions, enough to trigger the issue.

> But deferring the sync is not
> suggested by our DE, thus I still would like to fix the sequence in this
> patch with putting them together.
>

What's the reason it's not suggested? From my understanding, there
shouldn't be any dependency on hardware design here, it's just a
simple software optimization - we can pipeline other CPU operations
while the IOMMU is flushing the TLB.

Basically, right now:

CPU writes page tables 1
IOMMU flushes 1 | CPU busy waits
CPU writes page tables 2
IOMMU flushes 2 | CPU busy waits
CPU writes page tables 3
IOMMU flushes 3 | CPU busy waits
...

With my suggestion that could be:

CPU writes page tables 1 I
IOMMU flushes 1 | CPU writes page tables 2
IOMMU flushes 1 | CPU busy waits less time
IOMMU flushes 2 | CPU writes page tables 3
IOMMU flushes 2 | CPU busy waits less time
IOMMU flushes 3 | CPU busy waits

It reduces the time the CPU spends on busy waiting rather than doing
something useful. It also reduces the total time of maps and unmaps.

Actually, we can optimize even more. Please consider the case below.

CPU writes PTE for IOVA 0x1000.
IOMMU flushes 0x1000 | CPU busy waits
CPU writes PTE for IOVA 0x2000.
IOMMU flushes 0x2000 | CPU busy waits
CPU writes PTE for IOVA 0x3000.
IOMMU flushes 0x3000 | CPU busy waits
CPU writes PTE for IOVA 0x8000.
IOMMU flushes 0x8000 | CPU busy waits

However, depending on the way the hardware implements TLB flush, the
optimal sequence of operations could be:

CPU writes PTE for IOVA 0x1000.
CPU writes PTE for IOVA 0x2000.
CPU writes PTE for IOVA 0x3000.
IOMMU flushes 0x1000-0x3000 | CPU writes PTE for IOVA 0x8000.
IOMMU flushes 0x1000-0x3000 | CPU busy waits remaining flush time.
IOMMU flushes 0x8000 | CPU busy waits.

What's the algorithmic complexity of the TLB flush operation on
MediaTek IOMMU? If N is the number of pages to flush, is it O(N), O(1)
or something else?

Best regards,
Tomasz
