Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D92C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2828120B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 07:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wy+fMCn6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfJIH5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:57:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33039 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJIH5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 03:57:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id c4so1168710edl.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3E0V0aOu3g2aASZWIE15ppPWG2zpJ6BIMHadxXwPGJM=;
        b=Wy+fMCn6bQNsAvH2t7CAUcAbS0cogbGpbonr79/Lnr7QOUcYd/LWBCJdHdu1K1Arbl
         phmWYeGx0sM1IHdel9vQN+wNn7Mo71abv6iR6p7CudVLWdWKI4H06xYrhZNYC8yAziOc
         pRb6FXFj/rsG4B4qjhfvNcor1b2INvR9lRefc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3E0V0aOu3g2aASZWIE15ppPWG2zpJ6BIMHadxXwPGJM=;
        b=bZLqQWjlNhaw2tt5d5qVVSsD+TE57nuSygJrlq/HRGAnh2TIjyS+0dR1gJ/rL6nvKs
         fzNVFfHxzxkRZ/44WAeBC1OPDnQgLZS1HExAuIgqgx51CgTOGhkgJhGw25wEiMTRjcg0
         SRI26N8JkoKkheI9x5QB45JpHnP2pP3P3RUEgCvP8r7YJdydzVnGLBH5dZCEF4Ty1y8h
         ZMvadnXvWcbJ7hSsU2Yh8M9NTXitQh+e0BmJR/ByKgfGVVwdUz36Ef0qmIm69H6Mssir
         /jiB0x0u1fkOG8Hc3BlaBDxJ/NsEeQ5pXPqmhA70Z6OBmLHY/NgUyrmyet42ey9a7+1x
         v+XQ==
X-Gm-Message-State: APjAAAU5F3vtWfMxbGSwYixg8Z/Z/mBizOZIaH3x63XhuZlIN8U6mJxr
        8N4XRzSGiNoGes4h2Z971kOSIeBnLVnRqQ==
X-Google-Smtp-Source: APXvYqzSGcaYUyj8ZUSL8WROrF+2Ns9IxjkS3IDPXJayrzuRPTGfPdvxRoRxJHj7eWw72M5Xm0uKmg==
X-Received: by 2002:aa7:ce94:: with SMTP id y20mr1702820edv.189.1570607824982;
        Wed, 09 Oct 2019 00:57:04 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id r18sm241227edx.94.2019.10.09.00.57.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2019 00:57:03 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id 3so1347164wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 00:57:03 -0700 (PDT)
X-Received: by 2002:a1c:a516:: with SMTP id o22mr1631005wme.116.1570607822816;
 Wed, 09 Oct 2019 00:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <1569822142-14303-1-git-send-email-yong.wu@mediatek.com>
 <CAAFQd5C+FM3n-Ww4C+qDD1QZOGZrqEYw4EvYECfadGcDH0fmew@mail.gmail.com> <1570522162.19130.38.camel@mhfsdcap03>
In-Reply-To: <1570522162.19130.38.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 9 Oct 2019 16:56:50 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C3U7pZo4SSUJ52Q7E+0FaUoORQFbQC5RhCHBhi=NFYTw@mail.gmail.com>
Message-ID: <CAAFQd5C3U7pZo4SSUJ52Q7E+0FaUoORQFbQC5RhCHBhi=NFYTw@mail.gmail.com>
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

On Tue, Oct 8, 2019 at 5:09 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> Hi Tomasz,
>
> Sorry for reply late.
>
> On Wed, 2019-10-02 at 14:18 +0900, Tomasz Figa wrote:
> > Hi Yong,
> >
> > On Mon, Sep 30, 2019 at 2:42 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > The commit 4d689b619445 ("iommu/io-pgtable-arm-v7s: Convert to IOMMU API
> > > TLB sync") help move the tlb_sync of unmap from v7s into the iommu
> > > framework. It helps add a new function "mtk_iommu_iotlb_sync", But it
> > > lacked the dom->pgtlock, then it will cause the variable
> > > "tlb_flush_active" may be changed unexpectedly, we could see this warning
> > > log randomly:
> > >
> >
> > Thanks for the patch! Please see my comments inline.
> >
> > > mtk-iommu 10205000.iommu: Partial TLB flush timed out, falling back to
> > > full flush
> > >
> > > To fix this issue, we can add dom->pgtlock in the "mtk_iommu_iotlb_sync".
> > > And when checking this issue, we find that __arm_v7s_unmap call
> > > io_pgtable_tlb_add_flush consecutively when it is supersection/largepage,
> > > this also is potential unsafe for us. There is no tlb flush queue in the
> > > MediaTek M4U HW. The HW always expect the tlb_flush/tlb_sync one by one.
> > > If v7s don't always gurarantee the sequence, Thus, In this patch I move
> > > the tlb_sync into tlb_flush(also rename the function deleting "_nosync").
> > > and we don't care if it is leaf, rearrange the callback functions. Also,
> > > the tlb flush/sync was already finished in v7s, then iotlb_sync and
> > > iotlb_sync_all is unnecessary.
> >
> > Performance-wise, we could do much better. Instead of synchronously
> > syncing at the end of mtk_iommu_tlb_add_flush(), we could sync at the
> > beginning, if there was any previous flush still pending. We would
> > also have to keep the .iotlb_sync() callback, to take care of waiting
> > for the last flush. That would allow better pipelining with CPU in
> > cases like this:
> >
> > for (all pages in range) {
> >    change page table();
> >    flush();
> > }
> >
> > "change page table()" could execute while the IOMMU is flushing the
> > previous change.
>
> Do you mean adding a new tlb_sync before tlb_flush_no_sync, like below:
>
> mtk_iommu_tlb_add_flush_nosync {
>    + mtk_iommu_tlb_sync();
>    tlb_flush_no_sync();
>    data->tlb_flush_active = true;
> }
>
> mtk_iommu_tlb_sync {
>         if (!data->tlb_flush_active)
>                 return;
>         tlb_sync();
>         data->tlb_flush_active = false;
> }
>
> This way look improve the flow, But adjusting the flow is not the root
> cause of this issue. the problem is "data->tlb_flush_active" may be
> changed from mtk_iommu_iotlb_sync which don't have a dom->pglock.

That was not the only problem with existing code. Existing code also
assumed that add_flush and sync always go in pairs, but that's not
true.

My suggestion is to fix the locking in the driver and keep the sync
deferred as much as possible, so that performance is not degraded. I
changed my mind, though. I think we would need to make more changes to
the driver to make it implement the flushing efficiently, so let's go
with the current simple approach for now and improve incrementally.

>
> Currently the synchronisation of the tlb_flush/tlb_sync flow are
> controlled by the variable "data->tlb_flush_active".
>
> In this patch putting the tlb_flush/tlb_sync together looks make
> the flow simpler:
> a) Don't need the sensitive variable "tlb_flush_active".
> b) Remove mtk_iommu_iotlb_sync, Don't need add lock in it.
> c) Simplify the tlb_flush_walk/tlb_flush_leaf.
> is it ok?
>

Okay, let's do so as a first step to fix the issue. Then we can
optimize in follow up patches.

> >
> > >
> > > Besides, there are two minor changes:
> > > a) Use writel for the register F_MMU_INV_RANGE which is for triggering the
> > > HW work. We expect all the setting(iova_start/iova_end...) have already
> > > been finished before F_MMU_INV_RANGE.
> > > b) Reduce the tlb timeout value from 100000us to 1000us. the original value
> > > is so long that affect the multimedia performance.
> >
> > By definition, timeout is something that should not normally happen.
> > Too long timeout affecting multimedia performance would suggest that
> > the timeout was actually happening, which is the core problem, not the
> > length of the timeout. Could you provide more details on this?
>
> As description above, this issue is because there is no dom->pgtlock in
> the mtk_iommu_iotlb_sync. I have tried that the issue will disappear
> after adding lock in it.
>
> Although the issue is fixed after this patch, I still would like to
> reduce the timeout value for somehow error happen in the future. 100ms
> is unnecessary for us. It looks a minor improvement rather than fixing
> the issue. I will use a new patch for it.
>

Okay, makes sense.

Best regards,
Tomasz
