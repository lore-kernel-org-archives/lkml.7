Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28404C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE0920828
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 17:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMRdQRIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbfIEROd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 13:14:33 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36500 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729945AbfIEROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 13:14:33 -0400
Received: by mail-io1-f65.google.com with SMTP id b136so6539246iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 10:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TTCctpkX00mowbNYgM0kIWU2mkTavgxoTs3XunObL/I=;
        b=pMRdQRIl9vuOA+nHETjwUCF9udSp5PW7cTCK4Jh+bPhGYJNF0N3bjjDk7LCt4Uwplm
         iy2tuWxdiYyRLTvt6r4GgT+p9RJMOnyKA+umCVnfV2wiSfDkQlKt/OSAc4Va1sy2/Qqz
         TbDiflxrsy/pVLoa5JUtgrCaOQ5PYAiwrTnu7+WQrZbvVtJuyHmeyJFPjf7E0jyPahOM
         ohpQ5Xqm2Ir1EF+98Iq5lnJBcOE146CeJz4xe6yylI16QWb/Aopse67u3uh3HEqrZuQJ
         IlwiJZNxoKbrn7dGm7qE6sYZrY6deHg0OaeBBJcjs2/p9Q3v8nplXkocXnLvQkGnGeq7
         BOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTCctpkX00mowbNYgM0kIWU2mkTavgxoTs3XunObL/I=;
        b=JYCY8OAuJP+jGTYacafnJees8KosydCUTqlBR1RFzy9WQUnZ30gXMOu4SCkP72eJrm
         lMNu9Yt8xLqId6bfFWZcq8mcQinMR3oc63K8mztywsylo9W5+oA/vcbYn+bl79S0hCw+
         HsyH/iaLVprR7R0cIWpNBR86j10pm575/qUjKT/ljFTD3ElKQ7brEIKT9FpJUp+7+pG/
         87jeK+gu5kMgL4Zj8OvwPfYEfpsJw57bxc27e/1rdZ0AImPOM9RQ287t+45NG/uIe7DI
         wgnpUEL7Nj54UdK5/rWSUXALX0KbTU5jY7Ugf1C/8SwdmBNPQV/ErRfeCFBIpsfTRxLd
         gZog==
X-Gm-Message-State: APjAAAVszgiFWw2qBYVA5zUaawJhuaUc9UFuTKj9JPTMztLhH7EeJgb4
        8PtuwiF8lq3hupwTWo/lvSeyYjrRnf7fWXPRcCE=
X-Google-Smtp-Source: APXvYqyFRrcEUYAzNKAMqPVORab2OGeAkhhkQx1fB9YTAhkq6c0qW9HmWRMVc4oWCScMVD4hVjvX8XxINlOEm6TsfVc=
X-Received: by 2002:a6b:e903:: with SMTP id u3mr5289382iof.241.1567703671793;
 Thu, 05 Sep 2019 10:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190904074828.32502-1-kraxel@redhat.com> <CAPaKu7RWiEr5n_DWcg0H2PPnRs9CUn-ZgQV3NYe8VrdZgEAhTQ@mail.gmail.com>
 <20190905052340.gfwmzkqwcpxtvzvu@sirius.home.kraxel.org>
In-Reply-To: <20190905052340.gfwmzkqwcpxtvzvu@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 5 Sep 2019 10:14:20 -0700
Message-ID: <CAPaKu7RCwP05buzpL-MVYYUOzmWaQqNWjom7RK-2fL8hB2w45Q@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: fix command submission with objects but
 without fence.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
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

On Wed, Sep 4, 2019 at 10:23 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Sep 04, 2019 at 04:10:30PM -0700, Chia-I Wu wrote:
> > On Wed, Sep 4, 2019 at 12:48 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Only call virtio_gpu_array_add_fence if we actually have a fence.
> > >
> > > Fixes: da758d51968a ("drm/virtio: rework virtio_gpu_execbuffer_ioctl fencing")
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > ---
> > >  drivers/gpu/drm/virtio/virtgpu_vq.c | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > > index 595fa6ec2d58..7fd2851f7b97 100644
> > > --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> > > +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> > > @@ -339,11 +339,12 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
> > >                 goto again;
> > >         }
> > >
> > > -       if (fence)
> > > +       if (fence) {
> > >                 virtio_gpu_fence_emit(vgdev, hdr, fence);
> > > -       if (vbuf->objs) {
> > > -               virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> > > -               virtio_gpu_array_unlock_resv(vbuf->objs);
> > > +               if (vbuf->objs) {
> > > +                       virtio_gpu_array_add_fence(vbuf->objs, &fence->f);
> > > +                       virtio_gpu_array_unlock_resv(vbuf->objs);
> > > +               }
> > This leaks when fence == NULL and vbuf->objs != NULL (which can really
> > happen IIRC... not at my desk to check).
>
> Yes, it can happen, for example when flushing dumb buffers.
>
> But I don't think we leak in this case.  The code paths which don't need
> a fence also do not call virtio_gpu_array_lock_resv(), so things are
> balanced.  The actual release of the objs happens in
> virtio_gpu_dequeue_ctrl_func() via virtio_gpu_array_put_free_delayed().
I misread and thought this was in virtio_gpu_dequeue_ctrl_func.  Sorry :(

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>



>
> cheers,
>   Gerd
>
