Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DB5C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A94C20693
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="EBKdCto7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbfDRIIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:08:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34510 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfDRIIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:08:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id a6so1061533edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wxG+RZta+9XvMhokOt8uuMHvhmxktY7iLWZC4ljhQm8=;
        b=EBKdCto7iKhp3e+PjZUSFGHh7Dp1zvcNMX5g39WvYnsCHKmsv8zfaADwSoV7VL27J+
         EXWdOfKfM0QJI0d4qBfW2m+hRaDnC6SYtr3FsHQW0ovB+LktztwoZMPXRUmsKDdSh1BK
         /CQqcAvf5h/koz+G1IVLsOJJWO/1ofmKh/9As=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wxG+RZta+9XvMhokOt8uuMHvhmxktY7iLWZC4ljhQm8=;
        b=AewTxlT/waBEk12LRatmhdcly1iQX/M482uyK6Uzml0BHBwtZsN+91D31iigXbCpuD
         60ZVYYxLLyu56whl/BxJTsDW69rx6f/0H90aZayIIHaV9bL1GLSoTT9Ojs0B0dxoXOay
         WRv2Ngt006KI4As0w7ZXoIDJHYJpBfJQ2t7TSixjRUILV1pzeevgXBFyCjQ41GSh55YW
         04cAqTHkxdI5E67v/nSzP1oMcRAkjPrw7PLsXvWNABWeoXSv2b3WMPZMZ7iOMmLcId3I
         HBSA/6CmPkiRIwA04WoNsODlkNPuzPtr6FOds03I0JLxhRZ+tDkKT9n6ISePNi16t7JN
         QThQ==
X-Gm-Message-State: APjAAAXg5djgmRJ8fQKw5x8I4m9Mvef+wW8OzIEaNnhDsfhoF26mFxY7
        mREEnn4THQl2uBqy0wLMOG60sg==
X-Google-Smtp-Source: APXvYqzx15cDDQZDb6elKOpUDSkixppXCvtSq7N3REdXGSLuLRG1GEYir82c5a5RZu+/tO6gmMXJUA==
X-Received: by 2002:a17:906:4f19:: with SMTP id t25mr22109407eju.165.1555574909878;
        Thu, 18 Apr 2019 01:08:29 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id s11sm253826ejq.59.2019.04.18.01.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:08:28 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:08:26 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     christian.koenig@amd.com
Cc:     sumit.semwal@linaro.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 04/12] dma-buf: add optional invalidate_mappings callback
 v5
Message-ID: <20190418080826.GN13337@phenom.ffwll.local>
Mail-Followup-To: christian.koenig@amd.com, sumit.semwal@linaro.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-5-christian.koenig@amd.com>
 <20190417190719.GL13337@phenom.ffwll.local>
 <03a04d1d-9bc0-8f20-0436-b0f0017f0506@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03a04d1d-9bc0-8f20-0436-b0f0017f0506@gmail.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 09:13:22PM +0200, Christian König wrote:
> Am 17.04.19 um 21:07 schrieb Daniel Vetter:
> > On Tue, Apr 16, 2019 at 08:38:33PM +0200, Christian König wrote:
> > > Each importer can now provide an invalidate_mappings callback.
> > > 
> > > This allows the exporter to provide the mappings without the need to pin
> > > the backing store.
> > > 
> > > v2: don't try to invalidate mappings when the callback is NULL,
> > >      lock the reservation obj while using the attachments,
> > >      add helper to set the callback
> > > v3: move flag for invalidation support into the DMA-buf,
> > >      use new attach_info structure to set the callback
> > > v4: use importer_priv field instead of mangling exporter priv.
> > > v5: drop invalidation_supported flag
> > > 
> > > Signed-off-by: Christian König <christian.koenig@amd.com>
> > > ---
> > >   drivers/dma-buf/dma-buf.c | 37 +++++++++++++++++++++++++++++++++++++
> > >   include/linux/dma-buf.h   | 33 +++++++++++++++++++++++++++++++--
> > >   2 files changed, 68 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> > > index 83c92bfd964c..a3738fab3927 100644
> > > --- a/drivers/dma-buf/dma-buf.c
> > > +++ b/drivers/dma-buf/dma-buf.c
> > > @@ -563,6 +563,8 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
> > >   	attach->dev = info->dev;
> > >   	attach->dmabuf = dmabuf;
> > > +	attach->importer_priv = info->importer_priv;
> > > +	attach->invalidate = info->invalidate;
> > >   	mutex_lock(&dmabuf->lock);
> > > @@ -571,7 +573,9 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
> > >   		if (ret)
> > >   			goto err_attach;
> > >   	}
> > > +	reservation_object_lock(dmabuf->resv, NULL);
> > >   	list_add(&attach->node, &dmabuf->attachments);
> > > +	reservation_object_unlock(dmabuf->resv);
> > >   	mutex_unlock(&dmabuf->lock);
> > > @@ -615,7 +619,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
> > >   					   DMA_BIDIRECTIONAL);
> > >   	mutex_lock(&dmabuf->lock);
> > > +	reservation_object_lock(dmabuf->resv, NULL);
> > >   	list_del(&attach->node);
> > > +	reservation_object_unlock(dmabuf->resv);
> > >   	if (dmabuf->ops->detach)
> > >   		dmabuf->ops->detach(dmabuf, attach);
> > > @@ -653,7 +659,16 @@ dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
> > >   	if (attach->sgt)
> > >   		return attach->sgt;
> > > +	/*
> > > +	 * Mapping a DMA-buf can trigger its invalidation, prevent sending this
> > > +	 * event to the caller by temporary removing this attachment from the
> > > +	 * list.
> > > +	 */
> > > +	if (attach->invalidate)
> > > +		list_del(&attach->node);
> > Just noticed this: Why do we need this? invalidate needs the reservation
> > lock, as does map_attachment. It should be impssoble to have someone else
> > sneak in here.
> 
> I was having problems with self triggered invalidations.
> 
> E.g. client A tries to map an attachment, that in turn causes the buffer to
> move to a new place and client A is informed about that movement with an
> invalidation.

Uh, that sounds like a bug in ttm or somewhere else in the exporter. If
you evict the bo that you're trying to map, that's bad.

Or maybe it's a framework bug, and we need to track whether an attachment
has a map or not. That would make more sense ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
