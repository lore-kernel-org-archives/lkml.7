Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13524C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD18B2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 17:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H3OftagE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390530AbfIIRMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 13:12:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36040 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbfIIRMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 13:12:25 -0400
Received: by mail-wr1-f67.google.com with SMTP id y19so14783583wrd.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 10:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqdidbzPeA/sgt3s+DYxvSvIwPPs0smJm/TWV8LV8WA=;
        b=H3OftagEfFDm375McT0XbKcLTDfqJHbzZnQHwb0rA1h8doy/xHjSC9X0c5D+htCHWG
         d3hFKxdBvz0XJR1VYgPZ71ZxU6vs2svcVObFBW9pjRVLQne3RWi9X2Wf+RbRqwNl2cai
         G0mBpLKVsMczLpBRdH2Ud7cOoSVlZnkaCnsN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqdidbzPeA/sgt3s+DYxvSvIwPPs0smJm/TWV8LV8WA=;
        b=NbLkEVlLBtfwgXFZGn8oD0ZapQpQ4i28Mn6sOHQFUH4Vb9vCM/RHPecDwlQShAP3L8
         4j14xotCO7vjImM+OvZzsSUPpj0du3t3Zh5kYdjLem+SPX0gjF0WpEokI4RNqqN9Z1mF
         sjv1hCuj9CAiqlN33eitEhxPMCEcsD/Sxh+XGzxKAMjBD6jGRtkmgV6C5lT7u5yBUlHN
         aqu2yoMLwMzH73CEq+XFimxrGCGX43fxF2gw2bCLrVVCRr42lhksVNMpPzEcDIOoPGY9
         qvVglQmRFqjmzDE/Yu2M0zAYtcqjbn62L12icWbeBsoCKSxeYyMwJRDuvFBL3MitURuX
         FJgQ==
X-Gm-Message-State: APjAAAVPpijh+WlhGR33+X8EgXmh9jJrpmZiI9cgA/Wz/4NLL7Cz++8E
        iWZtpnK/dpune/HzuuKAxryk02+3sOEZNjR4vlUrNw==
X-Google-Smtp-Source: APXvYqxRYqXaWD9NPcEGlHG2PQGB7kVycmg6gplz6JAGUJ9RYnlUeXsXl8u0K9fNh8PZ078dfQoUs/gEHoU+sQ2Dst8=
X-Received: by 2002:adf:fa10:: with SMTP id m16mr14700174wrr.322.1568049140887;
 Mon, 09 Sep 2019 10:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190829212417.257397-1-davidriley@chromium.org>
 <20190905220008.75488-1-davidriley@chromium.org> <20190906051847.75mj4772nqwdper6@sirius.home.kraxel.org>
In-Reply-To: <20190906051847.75mj4772nqwdper6@sirius.home.kraxel.org>
From:   David Riley <davidriley@chromium.org>
Date:   Mon, 9 Sep 2019 10:12:09 -0700
Message-ID: <CAASgrz2tPPEiArFb=HaTJwoshrdS9xaOaLYtG1Ah43Rfcb=iSA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: Use vmalloc for command buffer allocations.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 10:18 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > +/* How many bytes left in this page. */
> > +static unsigned int rest_of_page(void *data)
> > +{
> > +     return PAGE_SIZE - offset_in_page(data);
> > +}
>
> Not needed.
>
> > +/* Create sg_table from a vmalloc'd buffer. */
> > +static struct sg_table *vmalloc_to_sgt(char *data, uint32_t size, int *sg_ents)
> > +{
> > +     int nents, ret, s, i;
> > +     struct sg_table *sgt;
> > +     struct scatterlist *sg;
> > +     struct page *pg;
> > +
> > +     *sg_ents = 0;
> > +
> > +     sgt = kmalloc(sizeof(*sgt), GFP_KERNEL);
> > +     if (!sgt)
> > +             return NULL;
> > +
> > +     nents = DIV_ROUND_UP(size, PAGE_SIZE) + 1;
>
> Why +1?

This is part of handling offsets within the vmalloc buffer and to
maintain parity with the !is_vmalloc_addr/existing case (sg_init_one
handles offsets within pages internally).  I had left it in because
this is being used for all sg/descriptor generation and I wasn't sure
if someone in the future might do something like:
buf = vmemdup_user()
offset = find_interesting(buf)
queue(buf + offset)

To respond specifically to your question, if we handle offsets, a
vmalloc_to_sgt(size = PAGE_SIZE + 2) could end up with 3 sg_ents with
the +1 being to account for that extra page.

I'll just remove all support for offsets in v3 of the patch and
comment that functionality will be different based on where the buffer
was originally allocated from.

>
> > +     ret = sg_alloc_table(sgt, nents, GFP_KERNEL);
> > +     if (ret) {
> > +             kfree(sgt);
> > +             return NULL;
> > +     }
> > +
> > +     for_each_sg(sgt->sgl, sg, nents, i) {
> > +             pg = vmalloc_to_page(data);
> > +             if (!pg) {
> > +                     sg_free_table(sgt);
> > +                     kfree(sgt);
> > +                     return NULL;
> > +             }
> > +
> > +             s = rest_of_page(data);
> > +             if (s > size)
> > +                     s = size;
>
> vmalloc memory is page aligned, so:

As per above, will remove with v3.

>
>                 s = min(PAGE_SIZE, size);
>
> > +             sg_set_page(sg, pg, s, offset_in_page(data));
>
> Offset is always zero.

As per above, will remove with v3.
>
> > +
> > +             size -= s;
> > +             data += s;
> > +             *sg_ents += 1;
>
> sg_ents isn't used anywhere.

It's used for outcnt.

>
> > +
> > +             if (size) {
> > +                     sg_unmark_end(sg);
> > +             } else {
> > +                     sg_mark_end(sg);
> > +                     break;
> > +             }
>
> That looks a bit strange.  I guess you need only one of the two because
> the other is the default?

I was being overly paranoid and not wanting to make assumptions about
the initial state of the table.  I'll simplify.
>
> >  static int virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
> >                                              struct virtio_gpu_vbuffer *vbuf,
> >                                              struct virtio_gpu_ctrl_hdr *hdr,
> >                                              struct virtio_gpu_fence *fence)
> >  {
> >       struct virtqueue *vq = vgdev->ctrlq.vq;
> > +     struct scatterlist *vout = NULL, sg;
> > +     struct sg_table *sgt = NULL;
> >       int rc;
> > +     int outcnt = 0;
> > +
> > +     if (vbuf->data_size) {
> > +             if (is_vmalloc_addr(vbuf->data_buf)) {
> > +                     sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
> > +                                          &outcnt);
> > +                     if (!sgt)
> > +                             return -ENOMEM;
> > +                     vout = sgt->sgl;
> > +             } else {
> > +                     sg_init_one(&sg, vbuf->data_buf, vbuf->data_size);
> > +                     vout = &sg;
> > +                     outcnt = 1;
>
> outcnt must be set in both cases.

outcnt is set by vmalloc_to_sgt.

>
> > +static int virtio_gpu_queue_ctrl_buffer(struct virtio_gpu_device *vgdev,
> > +                                     struct virtio_gpu_vbuffer *vbuf)
> > +{
> > +     return virtio_gpu_queue_fenced_ctrl_buffer(vgdev, vbuf, NULL, NULL);
> > +}
>
> Changing virtio_gpu_queue_ctrl_buffer to call
> virtio_gpu_queue_fenced_ctrl_buffer should be done in a separate patch.

Will do.

Thanks,
David
