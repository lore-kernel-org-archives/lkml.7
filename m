Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128CC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67FD218A0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 18:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIf/ee9k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGDS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 14:56:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42536 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfGDS4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 14:56:11 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so14501214ior.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dVPI54F8WztxoPvvjrKlk6t2iT7s82kVikoygRX/3n8=;
        b=DIf/ee9k2Z3dPthl5Ioi3W+zUz0Naw3h98O8/cIJvOQr2OguAQaYQ9/kWMGcp8zUI8
         MAT9owEMUZvzIHfO94gDHaf7rjxGpW8Z4FlIsOhETeickK9dOPi7j0OwJgMph6sSg9CW
         HWKDxvhqH4+zwwXhEQzOyKGxFLSohHnGiAo9nxOHWGhA2iZbGTYfSWuR+73+PhMJtyIb
         /LvwizkK5g44YnpbwLdy+qB+qFZIoY4meT65RCjC1K/RMNS9+qHgrhcuUB7+FCkx5Hld
         vXQs1+iaUhtVDJH1hFaxqm9343a0RehxmKCxkdm+UssSPkqKaHjitzLG8uyJPFXXNFs/
         jd0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dVPI54F8WztxoPvvjrKlk6t2iT7s82kVikoygRX/3n8=;
        b=t7R9Ak8fAZD+S/8Z/gCXAIrhNJrPfMLzeXmnfMZ2Am+RJunHfHbYn+BtoFxnoN2unm
         5LoLMAd0xK+RYXcn2iJPvOIR1bjgnsGOE7CykmZjbnfFr2IeyMBz6ai9tB2yLTyG2xJt
         pCU3IZcxSd235N4m02EnQ1ai7H8yL5DCHNCM2r6JIQ9Gz5hR6SiYjKTiaIwpa6UAd3Ay
         /71/czRBHMqO6N4Ap89gFeMxbfVxZikZGFfZlm1UmypQ3YFtYnvpyE01afGt+6JpPf3w
         Sy5/Ceo3gFWFNePStCNlqTfOcKV2KokxZ6LhSe0WeSdcYuGNXy9pxrPfZ4tvlfR3VSWn
         A7qg==
X-Gm-Message-State: APjAAAVXSR7H9MqT03w0qMe8mh3slMELN5KSTvHeDAAx53RsB6TFvG0U
        ieihoWwAa5ehy694IEMxFNtv5fEToGwXXHDuzoE=
X-Google-Smtp-Source: APXvYqyuufs960P1/vdGPNwzz71qxLDK4zx/ys1xqg1z6vid7XwTdQRhtt9ehbnzPiPsMMVOwUiY5nfaXOyov9XPTsE=
X-Received: by 2002:a05:6602:104:: with SMTP id s4mr39095774iot.200.1562266570329;
 Thu, 04 Jul 2019 11:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-15-kraxel@redhat.com>
 <CAPaKu7T3GvYVMueYgJFhADFSFEVbHEdaupw8=mq_+i150a1mLA@mail.gmail.com> <20190704114756.eavkszsgsyymns3m@sirius.home.kraxel.org>
In-Reply-To: <20190704114756.eavkszsgsyymns3m@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 4 Jul 2019 11:55:59 -0700
Message-ID: <CAPaKu7SXJwDg1uE0qDOYNS6J44UuQUh6m5rpJ3hBtW2tqYmMKA@mail.gmail.com>
Subject: Re: [PATCH v6 14/18] drm/virtio: rework virtio_gpu_transfer_from_host_ioctl
 fencing
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 4, 2019 at 4:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Jul 03, 2019 at 01:05:12PM -0700, Chia-I Wu wrote:
> > On Tue, Jul 2, 2019 at 7:19 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Switch to the virtio_gpu_array_* helper workflow.
> > (just repeating my question on patch 6)
> >
> > Does this fix the obj refcount issue?  When was the issue introduced?
>
> obj refcount should be fine in both old and new code.
>
> old code:
>   drm_gem_object_lookup
>   drm_gem_object_put_unlocked
>
> new code:
>   virtio_gpu_array_from_handles
>   virtio_gpu_array_put_free (in virtio_gpu_dequeue_ctrl_func).
>
> Or did I miss something?
In the old code, drm_gem_object_put_unlocked is called before the vbuf
using the object is retired.  Isn't that what object array wants to
fix?

We get away with that because the host only sees  hw_res_handles, and
executes the commands in order.

Maybe it was me who missed something..?

>
> cheers,
>   Gerd
>
