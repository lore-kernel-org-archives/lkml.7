Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4850C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885F220835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="c8Yk1ofh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388309AbfDRIkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:40:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35426 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388044AbfDRIkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:40:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so1922074wrn.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 01:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=skwtDJD9rjBC757Fuf+izswt3O0Gl6Gh8+xaj/p0/Tw=;
        b=c8Yk1ofhJWF4O9IC2vM1bVcCmr7c+dnn+9a1M7zDyrIbvdc7cKvTAojow1eR3ul7XD
         GjuTUcdCJ3A6yx4oLchdxcF3cA//5z+h93WYU7RYu42VhEYK+BPGY3hG1K1iqbWni46Y
         wB7g2yA7OS4UC02D2QsROPNx7LOO1JbwYUJJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=skwtDJD9rjBC757Fuf+izswt3O0Gl6Gh8+xaj/p0/Tw=;
        b=uCyMOPPOcWpUlGeEMEniie7VlR5H/wJ1y/0ZZqK+fa+0bPIyLsDqugv4YkabocWil9
         7b4E/Pvys8YTpN182hpMGAbnZ+3lPz/ph9d6mgR+JgTvdBBAtK9a0v1Enosf5k3Bqt6I
         cWMDYtFHai2gyJEi40hBFJR5iCNrmdNTkkWvkgtT6utm7kLkLcyyBWfnMdINOjqaUQs1
         qMfxNCrQPIEjdNrAFBazfBjGApv+yjD7X68524yyFj1ZrxozquKoUXLDsKD4GEjtD6oA
         EJZbcUG/vAt9UOqiQF/Wvy+rgYJTQaXxW2knnVHoO6CwhZ7SADnVhID15zcGUGaYcHGH
         tmeA==
X-Gm-Message-State: APjAAAUcde/1XR6GoU634BrKekAnD2pFf6+1vQBGi5KNYWkFMogI/D0B
        yzmfFC1bHsAG8tub6EF8mA7DXg==
X-Google-Smtp-Source: APXvYqxbgpo3TqiwMefXU/0IbE3MGyWCgheWi0qqGnGg9D4MF1o2jz9zTh5kY/l8BghYa1aYV1xsAA==
X-Received: by 2002:adf:fc0b:: with SMTP id i11mr23417044wrr.145.1555576833887;
        Thu, 18 Apr 2019 01:40:33 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id d4sm1349416wrv.42.2019.04.18.01.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:40:33 -0700 (PDT)
Date:   Thu, 18 Apr 2019 10:40:31 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     "Koenig, Christian" <Christian.Koenig@amd.com>
Cc:     "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 04/12] dma-buf: add optional invalidate_mappings callback
 v5
Message-ID: <20190418084031.GT13337@phenom.ffwll.local>
Mail-Followup-To: "Koenig, Christian" <Christian.Koenig@amd.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20190416183841.1577-1-christian.koenig@amd.com>
 <20190416183841.1577-5-christian.koenig@amd.com>
 <20190417190719.GL13337@phenom.ffwll.local>
 <03a04d1d-9bc0-8f20-0436-b0f0017f0506@gmail.com>
 <20190418080826.GN13337@phenom.ffwll.local>
 <0611f62c-2b81-b85f-a8d9-69c3daf0c635@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0611f62c-2b81-b85f-a8d9-69c3daf0c635@amd.com>
X-Operating-System: Linux phenom 4.19.0-1-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 08:28:51AM +0000, Koenig, Christian wrote:
> Am 18.04.19 um 10:08 schrieb Daniel Vetter:
> > On Wed, Apr 17, 2019 at 09:13:22PM +0200, Christian König wrote:
> >> Am 17.04.19 um 21:07 schrieb Daniel Vetter:
> >>> On Tue, Apr 16, 2019 at 08:38:33PM +0200, Christian König wrote:
> >>>> Each importer can now provide an invalidate_mappings callback.
> >>>>
> >>>> This allows the exporter to provide the mappings without the need to pin
> >>>> the backing store.
> >>>>
> >>>> v2: don't try to invalidate mappings when the callback is NULL,
> >>>>       lock the reservation obj while using the attachments,
> >>>>       add helper to set the callback
> >>>> v3: move flag for invalidation support into the DMA-buf,
> >>>>       use new attach_info structure to set the callback
> >>>> v4: use importer_priv field instead of mangling exporter priv.
> >>>> v5: drop invalidation_supported flag
> >>>>
> >>>> Signed-off-by: Christian König <christian.koenig@amd.com>
> >>>> ---
> >>>>    drivers/dma-buf/dma-buf.c | 37 +++++++++++++++++++++++++++++++++++++
> >>>>    include/linux/dma-buf.h   | 33 +++++++++++++++++++++++++++++++--
> >>>>    2 files changed, 68 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> >>>> index 83c92bfd964c..a3738fab3927 100644
> >>>> --- a/drivers/dma-buf/dma-buf.c
> >>>> +++ b/drivers/dma-buf/dma-buf.c
> >>>> @@ -563,6 +563,8 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
> >>>>    	attach->dev = info->dev;
> >>>>    	attach->dmabuf = dmabuf;
> >>>> +	attach->importer_priv = info->importer_priv;
> >>>> +	attach->invalidate = info->invalidate;
> >>>>    	mutex_lock(&dmabuf->lock);
> >>>> @@ -571,7 +573,9 @@ struct dma_buf_attachment *dma_buf_attach(const struct dma_buf_attach_info *info
> >>>>    		if (ret)
> >>>>    			goto err_attach;
> >>>>    	}
> >>>> +	reservation_object_lock(dmabuf->resv, NULL);
> >>>>    	list_add(&attach->node, &dmabuf->attachments);
> >>>> +	reservation_object_unlock(dmabuf->resv);
> >>>>    	mutex_unlock(&dmabuf->lock);
> >>>> @@ -615,7 +619,9 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct dma_buf_attachment *attach)
> >>>>    					   DMA_BIDIRECTIONAL);
> >>>>    	mutex_lock(&dmabuf->lock);
> >>>> +	reservation_object_lock(dmabuf->resv, NULL);
> >>>>    	list_del(&attach->node);
> >>>> +	reservation_object_unlock(dmabuf->resv);
> >>>>    	if (dmabuf->ops->detach)
> >>>>    		dmabuf->ops->detach(dmabuf, attach);
> >>>> @@ -653,7 +659,16 @@ dma_buf_map_attachment_locked(struct dma_buf_attachment *attach,
> >>>>    	if (attach->sgt)
> >>>>    		return attach->sgt;
> >>>> +	/*
> >>>> +	 * Mapping a DMA-buf can trigger its invalidation, prevent sending this
> >>>> +	 * event to the caller by temporary removing this attachment from the
> >>>> +	 * list.
> >>>> +	 */
> >>>> +	if (attach->invalidate)
> >>>> +		list_del(&attach->node);
> >>> Just noticed this: Why do we need this? invalidate needs the reservation
> >>> lock, as does map_attachment. It should be impssoble to have someone else
> >>> sneak in here.
> >> I was having problems with self triggered invalidations.
> >>
> >> E.g. client A tries to map an attachment, that in turn causes the buffer to
> >> move to a new place and client A is informed about that movement with an
> >> invalidation.
> > Uh, that sounds like a bug in ttm or somewhere else in the exporter. If
> > you evict the bo that you're trying to map, that's bad.
> >
> > Or maybe it's a framework bug, and we need to track whether an attachment
> > has a map or not. That would make more sense ...
> 
> Well neither, as far as I can see this is perfectly normal behavior.
> 
> We just don't want any invalidation send to a driver which is currently 
> making a mapping.
> 
> If you want I can do this in the driver as well, but at least of hand it 
> looks like a good idea to have that in common code.

Hm. This sounds like we'd want to invalidate a specific mapping.

> Tracking the mappings could work as well, but the problem here is that I 
> actually want the lifetime of old and new mappings to overlap for 
> pipelining.

Aside: Overlapping mappings being explicitly allowed should be in the
docs. The current kerneldoc for invalidate leaves that up for
interpretation. This answers one of the questions I had overnight, about
whether we expect ->invalidate to tear down the mapping or not.

Imo a better semantics would be that ->invalidate must tear down the
mapping, but the exporter must delay actual unmap until all fences have
cleared. Otherwise you could end up with fun stuff where the exporter
releases the memory (it wanted to invalidate after all), while the
importer still has a mapping around. That's not going to end well I think.

That would also solve the issue of getting an invalidate while you map, at
least if we filter per attachment.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
