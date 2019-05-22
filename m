Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DE6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA7A20868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUu5zsFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfEVQR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:17:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:41643 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfEVQR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:17:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id l25so2591757otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uZnS38EBVW2iZ9H54x1WrqV/ExYc3w2djCQImrBE2rU=;
        b=qUu5zsFe21yO1LFslkcndbSlfgHxFbGHP3Tm5s9PUaMTAj96RfcYznWCAN6qOaRKJM
         PrwXKPvzkwvWLtc7KHpdzkEJ2RzIEkF6J88PWgnIexEyeOo45FpHBoW8gGqtrTxXPDpO
         vqD50PqoWl2gCPIc6AY/egUpD9BdI1QoXV8YG3AbpgxlJrnx+/iAeboIu7xv4d3MGvYI
         4nhMkcO8RDi507eeDFojCOTMi9DCdyU9oe5619UdhQMryeQkI/ZTUC9q3s1wW50i7y70
         fNfcNT3NoR/+E0iRQiZ1PwFEVdI6y+iN66hEjwUUUi7EaQrzQR3Y/REyS7Xz8HPTkx6M
         ZoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uZnS38EBVW2iZ9H54x1WrqV/ExYc3w2djCQImrBE2rU=;
        b=XnQ5FEU1EyrfPAVjZV1ZeeBfK5YnOr3fGHMh7aTAVUKVXEd+nLVr2jHsuTmc4Q1nfr
         T/j4TZNKiUDWQdiz0KvTeFHKFrXeuuVEc4hfK8Sbfgb9MAHSBApV6c+jEZRvOgkMcemk
         MLXFRrBqc3IWCuh+xftMoIQ2TZ0JntbrRaya/Fes5nKvDss4lRmlGqr2t095dwy6+oQj
         8bQsbdMbrvK5Ap18AujwRI7vVLFqj3GqcwRTLEi9AXZOUzthov6oaN7ghNFSwk5q2kxj
         sWwsxr3ii87wMTVS29rGqt2ZTR5ctXSY+DzyfAMF4Zer4pmVnsIpRI/gTb6dYK1aaYgA
         fX7A==
X-Gm-Message-State: APjAAAXjJNOTJyUoMXpi7OkPOpvdFIkQbP7A21Z43X33MSTGIJBNJssI
        pPitsda2nrf+K5AGL+6Qzb87eKxcOnIZEZVqyWwGXQ==
X-Google-Smtp-Source: APXvYqwiHJgKfv3RPGnam7NhQkqAVji6zxMV25gVCjnVXHUAunGHPrKPYNOB99xLvcoSn8B3uey9R/DsH27Z2nWzEr0=
X-Received: by 2002:a9d:32a1:: with SMTP id u30mr36439046otb.371.1558541877365;
 Wed, 22 May 2019 09:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190416183841.1577-1-christian.koenig@amd.com> <1556323269-19670-1-git-send-email-lmark@codeaurora.org>
In-Reply-To: <1556323269-19670-1-git-send-email-lmark@codeaurora.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Wed, 22 May 2019 21:47:46 +0530
Message-ID: <CAO_48GGanguXbmYDD+p1kK_VkiWdZSTYAD1y-0JQK7hqL_OPPg@mail.gmail.com>
Subject: Re: [PATCH 01/12] dma-buf: add dynamic caching of sg_table
To:     Liam Mark <lmark@codeaurora.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

On Sat, 27 Apr 2019 at 05:31, Liam Mark <lmark@codeaurora.org> wrote:
>
> On Tue, 16 Apr 2019, Christian K=C3=B6nig wrote:
>
> > To allow a smooth transition from pinning buffer objects to dynamic
> > invalidation we first start to cache the sg_table for an attachment
> > unless the driver explicitly says to not do so.
> >
> > ---
> >  drivers/dma-buf/dma-buf.c | 24 ++++++++++++++++++++++++
> >  include/linux/dma-buf.h   | 11 +++++++++++
> >  2 files changed, 35 insertions(+)
> >
> > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > index 7c858020d14b..65161a82d4d5 100644
> > --- a/drivers/dma-buf/dma-buf.c
> > +++ b/drivers/dma-buf/dma-buf.c
> > @@ -573,6 +573,20 @@ struct dma_buf_attachment *dma_buf_attach(struct d=
ma_buf *dmabuf,
> >       list_add(&attach->node, &dmabuf->attachments);
> >
> >       mutex_unlock(&dmabuf->lock);
> > +
> > +     if (!dmabuf->ops->dynamic_sgt_mapping) {
> > +             struct sg_table *sgt;
> > +
> > +             sgt =3D dmabuf->ops->map_dma_buf(attach, DMA_BIDIRECTIONA=
L);
> > +             if (!sgt)
> > +                     sgt =3D ERR_PTR(-ENOMEM);
> > +             if (IS_ERR(sgt)) {
> > +                     dma_buf_detach(dmabuf, attach);
> > +                     return ERR_CAST(sgt);
> > +             }
> > +             attach->sgt =3D sgt;
> > +     }
> > +
> >       return attach;
> >
> >  err_attach:
> > @@ -595,6 +609,10 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct=
 dma_buf_attachment *attach)
> >       if (WARN_ON(!dmabuf || !attach))
> >               return;
> >
> > +     if (attach->sgt)
> > +             dmabuf->ops->unmap_dma_buf(attach, attach->sgt,
> > +                                        DMA_BIDIRECTIONAL);
> > +
> >       mutex_lock(&dmabuf->lock);
> >       list_del(&attach->node);
> >       if (dmabuf->ops->detach)
> > @@ -630,6 +648,9 @@ struct sg_table *dma_buf_map_attachment(struct dma_=
buf_attachment *attach,
> >       if (WARN_ON(!attach || !attach->dmabuf))
> >               return ERR_PTR(-EINVAL);
> >
> > +     if (attach->sgt)
> > +             return attach->sgt;
> > +
>
> I am concerned by this change to make caching the sg_table the default
> behavior as this will result in the exporter's map_dma_buf/unmap_dma_buf
> calls are no longer being called in
> dma_buf_map_attachment/dma_buf_unmap_attachment.

Probably this concern from Liam got lost between versions of your
patches; could we please request a reply to these points here?
>
> This seems concerning to me as it appears to ignore the cache maintenance
> aspect of the map_dma_buf/unmap_dma_buf calls.
> For example won't this potentially cause issues for clients of ION.
>
> If we had the following
> - #1 dma_buf_attach coherent_device
> - #2 dma_buf attach non_coherent_device
> - #3 dma_buf_map_attachment non_coherent_device
> - #4 non_coherent_device writes to buffer
> - #5 dma_buf_unmap_attachment non_coherent_device
> - #6 dma_buf_map_attachment coherent_device
> - #7 coherent_device reads buffer
> - #8 dma_buf_unmap_attachment coherent_device
>
> There wouldn't be any CMO at step #5 anymore (specifically no invalidate)
> so now at step #7 the coherent_device could read a stale cache line.
>
> Also, now by default dma_buf_unmap_attachment no longer removes the
> mappings from the iommu, so now by default dma_buf_unmap_attachment is no=
t
> doing what I would expect and clients are losing the potential sandboxing
> benefits of removing the mappings.
> Shouldn't this caching behavior be something that clients opt into instea=
d
> of being the default?
>
> Liam
>
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>

Best,
Sumit.
