Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E01FC74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F399C21019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 02:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZuX85ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfGKCfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 22:35:54 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:32836 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727622AbfGKCfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 22:35:53 -0400
Received: by mail-io1-f66.google.com with SMTP id z3so9293106iog.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 19:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C1FC0kkhG8SE4KxZI9/vd1vvZYlqKizf2ehICOMyQFw=;
        b=gZuX85ZCmj/43wOQW8QDrAr8gsP1kGWGDwQXP7ruMAHyiaKt3g7NjtaA+MEVdHmPOT
         wKDPWmEBpa83TiEvIwO+ugF++ClLRUvAzQLBP51kB4e6VSC6Snkjk3d4n8a6/wkm9/Ra
         D7155hJwNevtJn/VruKCuIazOesSrERBBV8vHwGFFkNSHxznLmqbfHO6yEdsHe98bC30
         T7PKRJ7+sCT5Xa2XQQwi9kRh5LcipaXeyRjPVyu6OVHm/E8NeQJY6UH3Mv4YtROKhPbf
         uYVC+T7pV39I8wXcfcxdqZB0y5IdoQR5bzuyil6Rc7DsmYrELvsBAixhWonuRgUpjKBt
         FjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C1FC0kkhG8SE4KxZI9/vd1vvZYlqKizf2ehICOMyQFw=;
        b=j0B6FEsYI36XbLw44pMNqXHcvb1lxIHlpPZEpeGXugSOebT6wAEwOyJwJN7BfNruNp
         WWHHbaby6fDLSpDctL2w+2mzfdDF5h9JsQCyA5RkOoXZHwi2au9cODgQy75YKHXgaD7k
         dRHwdTRiRxGsKsbGMwLUamT/FFokKlvDDIqfqV2uZiL7muu+9RbA+c0X+F+lDabzkn4d
         s1eWehx4hZJMlI+88t+Y8nw3Y0r9/Y9+peaAV36OXmpSYF29MojpUCCw/5FJTL/+A5Od
         UTZJwv5mDIFruTFKGqL0NitU1b4DoHrmSmE6M3CUut1ZDM56e7ZMgZ1m6BhikTmqk7Kx
         nKYg==
X-Gm-Message-State: APjAAAWskIrnFeBRbSwzJvFA7y5/7USX0IqyeGvHADxxK68f5mttg1wr
        3p6lKjRQHP6aFdQ1UMsJyur06+6xtGIGLlFQiDk=
X-Google-Smtp-Source: APXvYqySOQ0NQmFWxVA1kPgmyB8lKtJqH6UcCGrrUDZnNcuPCHHrmvDjUvwMLLqlPMPNkYUmdbrvZzQlXxg4BT1y+pw=
X-Received: by 2002:a5d:8e08:: with SMTP id e8mr1665361iod.139.1562812552660;
 Wed, 10 Jul 2019 19:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190702141903.1131-1-kraxel@redhat.com> <20190702141903.1131-9-kraxel@redhat.com>
 <CAPaKu7QP=A2kV_kqcT20Pmc831HviaBJN1RpOFoa=V1g6SmE_g@mail.gmail.com>
 <20190704112534.v7icsuverf7wrbjq@sirius.home.kraxel.org> <CAPaKu7SQS5USJf0Y+K41tuRA=4qZJf5CnTu9EqAPZvz+GJCP2w@mail.gmail.com>
In-Reply-To: <CAPaKu7SQS5USJf0Y+K41tuRA=4qZJf5CnTu9EqAPZvz+GJCP2w@mail.gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 10 Jul 2019 19:35:41 -0700
Message-ID: <CAPaKu7RQo8T81iGtPbtgmv7WtV-uDO9+BsT3vMd=iggZ0Q_Yew@mail.gmail.com>
Subject: Re: [PATCH v6 08/18] drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing
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

On Thu, Jul 4, 2019 at 11:46 AM Chia-I Wu <olvaffe@gmail.com> wrote:
>
> On Thu, Jul 4, 2019 at 4:25 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > >         if (fence)
> > > >                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> > > > +       if (vbuf->objs) {
> > > > +               virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> > > > +               virtio_gpu_array_unlock_resv(vbuf->objs);
> > > > +       }
> > > This is with the spinlock held.  Maybe we should move the
> > > virtio_gpu_array_unlock_resv call out of the critical section.
> >
> > That would bring back the race ...
> Right...
> >
> > > I am actually more concerned about virtio_gpu_array_add_fence, but it
> > > is also harder to move.  Should we add a kref to the object array?
> >
> > Yep, refcounting would be the other way to fix the race.
> >
> > > This bothers me because I recently ran into a CPU-bound game with very
> > > bad lock contention here.
> >
> > Hmm.  Any clue where this comes from?  Multiple threads competing for
> > virtio buffers I guess?  Maybe we should have larger virtqueues?
> The game was single-threaded.  I guess it was the game and Xorg
> competing for virtio buffers.  That was also on an older kernel
> without explicit fences.  The userspace had to create dummy resources
> frequently to do VIRTIO_IOCTL_RESOURCE_WAIT.
>
> I think this is fine for now as far as I am concerned.  I can look
> into this more closely after this series lands.
It was virtio_gpu_dequeue_ctrl_func who wanted to grab the lock to
handle the responses.  I sent a patch for it

  https://patchwork.freedesktop.org/series/63529/

>
>
> >
> > cheers,
> >   Gerd
> >
