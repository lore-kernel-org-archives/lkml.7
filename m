Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F30BC4CEC6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216B320830
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 21:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au3S9WcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbfILVqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 17:46:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35088 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfILVqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 17:46:39 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so57741089ion.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NiZR+n54kDStyi7gn0TCODjC223CXySNQ4QzYgLQl3E=;
        b=Au3S9WcEiw57y0AQRAbf5wuFCqoJIe+2VdZsVE2e6s0BHIIrx52K8kYnnAq0xDT++b
         v6LLSRBThw+1+gBkPcOsZ7X/tXgQkVNqloLOuoS/iG8Apn+JURt/X7lsT7ViS6a6kYwa
         KkUTSZvehBh9c+dFRz0QcX/OZRDVgwkPGwM/MkpXEjGBIyRuQw4iBQVdXXJVnUqkMNto
         42z1NOEIfhoPm5DyAtr/8kU0T1wE0NfTUZGtMVQrtF0gzxsja0j30OWxvu2BpP89jpDJ
         Jh+1PcmSRNYP1sWMCnhLRnypbEPhggXBpW0nH8G1CaEbXJ+OkS0abuEs2iUbUfR1j9YS
         vg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NiZR+n54kDStyi7gn0TCODjC223CXySNQ4QzYgLQl3E=;
        b=qCTpk5iMBkWGE0V1Ju8CSuPViaevuLVK/53ihS7HakdBi2Fxu7Biqhw0xY5s69/sux
         HyNGRmCjuFlu3aeSKRSGuYIPRenPJHE/qCeXAYoKQ/8zFP6oJaSFL0OMukXi2lNctlKr
         HjLPc8sFEZpoE9XBF3ZvNFNmUPRPeeQ+Cdr3r/Pvkm+cbBnQJeB/l2Z7odkWI2NNqUMS
         6u1Gl3itD3TcE353AVEcAyPmbClSn9T4OOllJUs0w/B9HMhxgMXi05cDbvjB2MKSPX0V
         MgBNgW9DwhvlpaEwWD6mInZerj4MTsqGcwZE4kZFQIIulEvrHQnANxAGNVcSdmweslXt
         lkYg==
X-Gm-Message-State: APjAAAUzQT1sdZQlvLZZ+El+o/ZShhqeWgMm/daEAgDiQotHrsE54YC8
        QvnxJajcJqmj8B56CC6aZa2bmMZbOgAP46GShms=
X-Google-Smtp-Source: APXvYqwqasiwTqwYl+8S+TBPDrRVZlt18xiMscbny/PfY5KKeZ1UqdHopMngv1Rw1ZsObWSeAn5PZ/2D1YWLRXpqDr4=
X-Received: by 2002:a5e:c107:: with SMTP id v7mr7363007iol.200.1568324799015;
 Thu, 12 Sep 2019 14:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190912160048.212495-1-davidriley@chromium.org>
In-Reply-To: <20190912160048.212495-1-davidriley@chromium.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 12 Sep 2019 14:46:28 -0700
Message-ID: <CAPaKu7RcJC-rZiYhqGeLeyu45ML6ymiycmWA+RjOq02u=PsK9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Fix warning in virtio_gpu_queue_fenced_ctrl_buffer.
To:     David Riley <davidriley@chromium.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET AND BLOCK DRIVERS" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 9:00 AM David Riley <davidriley@chromium.org> wrote:
>
> Fix warning introduced with commit e1218b8c0cc1
> ("drm/virtio: Use vmalloc for command buffer allocations.")
> from drm-misc-next.
>
> Signed-off-by: David Riley <davidriley@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 9f9b782dd332..80176f379ad5 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -358,7 +358,7 @@ static void virtio_gpu_queue_fenced_ctrl_buffer(struct virtio_gpu_device *vgdev,
>                         sgt = vmalloc_to_sgt(vbuf->data_buf, vbuf->data_size,
>                                              &outcnt);
>                         if (!sgt)
> -                               return -ENOMEM;
> +                               return;
>                         vout = sgt->sgl;
>                 } else {
>                         sg_init_one(&sg, vbuf->data_buf, vbuf->data_size);
> --
> 2.23.0.162.g0b9fbb3734-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
