Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F5BC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1E2206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 05:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392341AbfIFFSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 01:18:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732721AbfIFFSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 01:18:50 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F100F18C891C;
        Fri,  6 Sep 2019 05:18:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-72.ams2.redhat.com [10.36.117.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14E1D60872;
        Fri,  6 Sep 2019 05:18:48 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 42172753F; Fri,  6 Sep 2019 07:18:47 +0200 (CEST)
Date:   Fri, 6 Sep 2019 07:18:47 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Riley <davidriley@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/virtio: Use vmalloc for command buffer
 allocations.
Message-ID: <20190906051847.75mj4772nqwdper6@sirius.home.kraxel.org>
References: <20190829212417.257397-1-davidriley@chromium.org>
 <20190905220008.75488-1-davidriley@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905220008.75488-1-davidriley@chromium.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Fri, 06 Sep 2019 05:18:50 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* How many bytes left in this page. */
> +static unsigned int rest_of_page(void *data)
> +{
> +	return PAGE_SIZE - offset_in_page(data);
> +}

Not needed.

> +/* Create sg_table from a vmalloc'd buffer. */
> +static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
> +{
> +	int nents, ret, s, i;
> +	struct sg_table *sgt;
> +	struct scatterlist *sg;
> +	struct page *pg;
> +
> +	*sg_ents = 0;
> +
> +	sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
> +	if (!sgt)
> +		return NULL;
> +
> +	nents = DIV_ROUND_UP(size, PAGE_SIZE) + 1;

Why +1?

> +	ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
> +	if (ret) {
> +		kfree(sgt);
> +		return NULL;
> +	}
> +
> +	for_each_sg(sgt->sgl, sg, nents, i) {
> +		pg = vmalloc_to_page(data);
> +		if (!pg) {
> +			sg_free_table(sgt);
> +			kfree(sgt);
> +			return NULL;
> +		}
> +
> +		s = rest_of_page(data);
> +		if (s > size)
> +			s = size;

vmalloc memory is page aligned, so:

		s = min(PAGE_SIZE, size);

> +		sg_set_page(sg, pg, s, offset_in_page(data));

Offset is always zero.

> +
> +		size -= s;
> +		data += s;
> +		*sg_ents += 1;

sg_ents isn't used anywhere.

> +
> +		if (size) {
> +			sg_unmark_end(sg);
> +		} else {
> +			sg_mark_end(sg);
> +			break;
> +		}

That looks a bit strange.  I guess you need only one of the two because
the other is the default?

>  static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>  					       struct virtio_gpu_vbuffer *vbuf,
>  					       struct virtio_gpu_ctrl_hdr *hdr,
>  					       struct virtio_gpu_fence *fence)
>  {
>  	struct virtqueue *vq = vgdev->ctrlq.vq;
> +	struct scatterlist *vout = NULL, sg;
> +	struct sg_table *sgt = NULL;
>  	int rc;
> +	int outcnt = 0;
> +
> +	if (vbuf->data_size) {
> +		if (is_vmalloc_addr(vbuf->data_buf)) {
> +			sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
> +					     &outcnt);
> +			if (!sgt)
> +				return -ENOMEM;
> +			vout = sgt->sgl;
> +		} else {
> +			sg_init_one(&sg, vbuf->data_buf, vbuf->data_size);
> +			vout = &sg;
> +			outcnt = 1;

outcnt must be set in both cases.

> +static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
> +					struct virtio_gpu_vbuffer *vbuf)
> +{
> +	return virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL, NULL);
> +}

Changing virtio_gpu_queue_ctrl_buffer to call
virtio_gpu_queue_fenced_ctrl_buffer should be done in a separate patch.

cheers,
  Gerd

