Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435C7C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D9821473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 18:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="AIWX6UX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729547AbfEVSbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 14:31:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45673 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfEVSbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 14:31:11 -0400
Received: by mail-ot1-f67.google.com with SMTP id t24so2976228otl.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 11:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ehpW3FmyFNwwgVcU0sf6xcroE4sJqcvHvuK/a3hE4J0=;
        b=AIWX6UX4vTSfazL/tbmSXhq6IE3iXeh+57T/ZszV7RHo3c+MQuXBfNnypjIOsPeQx9
         WU71JNbQoccuY7mOy+ctQiNiGWp5P0Y98tZjczvDtzod6yXP87V4+W3cndPeiS/v1fdu
         DMOs9x08w66R6ZzTlTCE26YItU/6ruqAuAhTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ehpW3FmyFNwwgVcU0sf6xcroE4sJqcvHvuK/a3hE4J0=;
        b=DOsvL11j9dBX4OhfAM1/uBAALN7k3Og9HvlbIFB/8jELdqBkzSBPoCcY1WfRTUzZnw
         II1UuiOAg7NBV4Wd9kOHs4CVFEOZrVLG4vAWu0ZgkBIREksVsp/joyY7hxAWqxzQ/Wup
         q+ttilCqRzinjGwlgHlBNeA17jfpbeuDGelevQ4CdhgSC9GJr3+3MLBo2aDY7LOKqS3C
         DkNPNAiJG1BVbkZD87ozHaf561pBTF60Ux3LFRwR7pO45D+U63khxvK7sVo7gG3kLuwj
         mvz8CPdHaf/JlrL3yf5I2m7qqvxtMaRjOIOdeXUKtObb1qfMLfZ6zJKIfCBKSvcsqoJn
         1y7g==
X-Gm-Message-State: APjAAAWR1Y4zhVKjuAAXK48or/pBIUfMWzulUGdhsOcDbeI9NZlOcUQ0
        AsKjf5YOD10Vf3M/voUjNZtiJENBe/jWbF9ObTJHaw==
X-Google-Smtp-Source: APXvYqx3IiGHo0i8z7yFDpSNCNymJ7phpC9KvQaOQ+mUNdi70By2Li+PCYUroTuATuW8VtF4ZJcbipILRmVjSlC2nEI=
X-Received: by 2002:a9d:6e1a:: with SMTP id e26mr55319767otr.188.1558549870947;
 Wed, 22 May 2019 11:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <1556323269-19670-1-git-send-email-lmark@codeaurora.org> <CAO_48GGanguXbmYDD+p1kK_VkiWdZSTYAD1y-0JQK7hqL_OPPg@mail.gmail.com>
 <d7fb2a6b-f516-b506-247d-0f3d4d59ec8e@gmail.com>
In-Reply-To: <d7fb2a6b-f516-b506-247d-0f3d4d59ec8e@gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 22 May 2019 20:30:59 +0200
Message-ID: <CAKMK7uEaeVW0EMtCUeH+WeUmFnovEySz3kebRUcybLeySb4GSA@mail.gmail.com>
Subject: Re: [PATCH 01/12] dma-buf: add dynamic caching of sg_table
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 7:28 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Am 22.05.19 um 18:17 schrieb Sumit Semwal:
> > Hi Christian,
> >
> > On Sat, 27 Apr 2019 at 05:31, Liam Mark <lmark@codeaurora.org> wrote:
> >> On Tue, 16 Apr 2019, Christian K=C3=B6nig wrote:
> >>
> >>> To allow a smooth transition from pinning buffer objects to dynamic
> >>> invalidation we first start to cache the sg_table for an attachment
> >>> unless the driver explicitly says to not do so.
> >>>
> >>> ---
> >>>   drivers/dma-buf/dma-buf.c | 24 ++++++++++++++++++++++++
> >>>   include/linux/dma-buf.h   | 11 +++++++++++
> >>>   2 files changed, 35 insertions(+)
> >>>
> >>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> >>> index 7c858020d14b..65161a82d4d5 100644
> >>> --- a/drivers/dma-buf/dma-buf.c
> >>> +++ b/drivers/dma-buf/dma-buf.c
> >>> @@ -573,6 +573,20 @@ struct dma_buf_attachment *dma_buf_attach(struct=
 dma_buf *dmabuf,
> >>>        list_add(&attach->node, &dmabuf->attachments);
> >>>
> >>>        mutex_unlock(&dmabuf->lock);
> >>> +
> >>> +     if (!dmabuf->ops->dynamic_sgt_mapping) {
> >>> +             struct sg_table *sgt;
> >>> +
> >>> +             sgt =3D dmabuf->ops->map_dma_buf(attach, DMA_BIDIRECTIO=
NAL);
> >>> +             if (!sgt)
> >>> +                     sgt =3D ERR_PTR(-ENOMEM);
> >>> +             if (IS_ERR(sgt)) {
> >>> +                     dma_buf_detach(dmabuf, attach);
> >>> +                     return ERR_CAST(sgt);
> >>> +             }
> >>> +             attach->sgt =3D sgt;
> >>> +     }
> >>> +
> >>>        return attach;
> >>>
> >>>   err_attach:
> >>> @@ -595,6 +609,10 @@ void dma_buf_detach(struct dma_buf *dmabuf, stru=
ct dma_buf_attachment *attach)
> >>>        if (WARN_ON(!dmabuf || !attach))
> >>>                return;
> >>>
> >>> +     if (attach->sgt)
> >>> +             dmabuf->ops->unmap_dma_buf(attach, attach->sgt,
> >>> +                                        DMA_BIDIRECTIONAL);
> >>> +
> >>>        mutex_lock(&dmabuf->lock);
> >>>        list_del(&attach->node);
> >>>        if (dmabuf->ops->detach)
> >>> @@ -630,6 +648,9 @@ struct sg_table *dma_buf_map_attachment(struct dm=
a_buf_attachment *attach,
> >>>        if (WARN_ON(!attach || !attach->dmabuf))
> >>>                return ERR_PTR(-EINVAL);
> >>>
> >>> +     if (attach->sgt)
> >>> +             return attach->sgt;
> >>> +
> >> I am concerned by this change to make caching the sg_table the default
> >> behavior as this will result in the exporter's map_dma_buf/unmap_dma_b=
uf
> >> calls are no longer being called in
> >> dma_buf_map_attachment/dma_buf_unmap_attachment.
> > Probably this concern from Liam got lost between versions of your
> > patches; could we please request a reply to these points here?
>
> Sorry I indeed never got this mail, but this is actually not an issue
> because Daniel had similar concerns and we didn't made this the default
> in the final version.
>
> >> This seems concerning to me as it appears to ignore the cache maintena=
nce
> >> aspect of the map_dma_buf/unmap_dma_buf calls.
> >> For example won't this potentially cause issues for clients of ION.
> >>
> >> If we had the following
> >> - #1 dma_buf_attach coherent_device
> >> - #2 dma_buf attach non_coherent_device
> >> - #3 dma_buf_map_attachment non_coherent_device
> >> - #4 non_coherent_device writes to buffer
> >> - #5 dma_buf_unmap_attachment non_coherent_device
> >> - #6 dma_buf_map_attachment coherent_device
> >> - #7 coherent_device reads buffer
> >> - #8 dma_buf_unmap_attachment coherent_device
> >>
> >> There wouldn't be any CMO at step #5 anymore (specifically no invalida=
te)
> >> so now at step #7 the coherent_device could read a stale cache line.
> >>
> >> Also, now by default dma_buf_unmap_attachment no longer removes the
> >> mappings from the iommu, so now by default dma_buf_unmap_attachment is=
 not
> >> doing what I would expect and clients are losing the potential sandbox=
ing
> >> benefits of removing the mappings.
> >> Shouldn't this caching behavior be something that clients opt into ins=
tead
> >> of being the default?
>
> Well, it seems you are making incorrect assumptions about the cache
> maintenance of DMA-buf here.
>
> At least for all DRM devices I'm aware of mapping/unmapping an
> attachment does *NOT* have any cache maintenance implications.
>
> E.g. the use case you describe above would certainly fail with amdgpu,
> radeon, nouveau and i915 because mapping a DMA-buf doesn't stop the
> exporter from reading/writing to that buffer (just the opposite actually)=
.
>
> All of them assume perfectly coherent access to the underlying memory.
> As far as I know there is no documented cache maintenance requirements
> for DMA-buf.

I think it is documented. It's just that on x86, we ignore that
because the dma-api pretends there's never a need for cache flushing
on x86, and that everything snoops the cpu caches. Which isn't true
since over 20 ago when AGP happened. The actual rules for x86 dma-buf
are very much ad-hoc (and we occasionally reapply some duct-tape when
cacheline noise shows up somewhere).

I've just filed this away as another instance of the dma-api not
fitting gpus, and I think giving recent discussions that won't improve
anytime soon. So we're stuck with essentially undefined dma-buf
behaviour.
-Daniel

> The IOMMU concern on the other hand is certainly valid and I perfectly
> agree that keeping the mapping time as short as possible is desirable.
>
> Regards,
> Christian.
>
> >> Liam
> >>
> >> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> >> a Linux Foundation Collaborative Project
> >>
> > Best,
> > Sumit.
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



--=20
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
