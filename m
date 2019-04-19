Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E630C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3029E2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeYzNFZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfDSTF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:05:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34334 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfDSTFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:05:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id r186so9508029wmf.1;
        Fri, 19 Apr 2019 12:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BJohAaoXGzpnYmzQ88UijR4q+bxIpnP/97TK8bfiKzU=;
        b=BeYzNFZSsrydipZ3BnVjjUqffgNCdp/n1wwBiSCO+5UGWEaSaFMTwSZQwpHUmD0K/C
         ByTJe+2HMrE3nQqY6UkwYCYT0pNhVJZOUwAlsacZh9QV7gf0u62vHPbYBqkPVQjZb5+T
         fBzTQTH57jWAuWkh3SM6xSm1UJucJr0ZKJtwl/rUQ01MXK1eNT8zNgVazjP20/yeofAi
         BgPzRb1Hn+lYHW5OUoKHdjFUQL62vRo3+fz4TRmFZFkQrW0eGZ4L9OHIJf72zN5P0+hA
         LFVMioQaHx3B/JBZsYVyCEIvEHKWbkzCOgehItNCoZ9LInPshaj/6IkXqgNZB9TPBUBR
         Q+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BJohAaoXGzpnYmzQ88UijR4q+bxIpnP/97TK8bfiKzU=;
        b=c4GtJeT+1lD2MPZmiea4sMPf6kqR2DT1a+g2CZ2rI+HbBzp8eiOkvxkF3yTUsdoXAN
         Hl2fPQjcRNm87Liv2aPtxHxHke/T2mZOKRWxuecG/ZoTpx8AzvR6e8ww+KrUlB1qL3dG
         gea0zuK4G73LuZ9Hc0mkJxzy6CD1N1/5ReAowae+FQuc7iEV/If3dRG6vg3eiGSd/VE7
         JNJG/fYyzK/zhweRZsZFrYd9FepIgTesepDL+42pbEr5vWSlL2y74bSiJYijgah7seLR
         4dGj8ghb64DWC0kjd116/bleJLuxMtHOJ/KI5uIIjGGjxWGAz9QbJq15QeryGgaPd7yr
         Wa0w==
X-Gm-Message-State: APjAAAWkcWJPsCaYKbVNHt14LVN2P+zG7kvx/2YC6cJug/xX+dQAf2pI
        m1OZtjDZsgTM5HPhmttHkN51lLcAluW9ElCn0OXl8ZX9gOhgMg==
X-Google-Smtp-Source: APXvYqxcpYIPRcZx/Pq8V/EsXrjbqoNb8F9nY5gnNvNtRECGr6P3gXfXgGGEexb3Qrd/fB9mLgwCI4hLWBiMzBEUw20=
X-Received: by 2002:a1c:804c:: with SMTP id b73mr3473003wmd.116.1555700721530;
 Fri, 19 Apr 2019 12:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190416183841.1577-1-christian.koenig@amd.com> <20190416183841.1577-6-christian.koenig@amd.com>
In-Reply-To: <20190416183841.1577-6-christian.koenig@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 19 Apr 2019 15:05:09 -0400
Message-ID: <CADnq5_OFh0UDvMkt+yTKBLjysuTmB==Lug-=d04E_eUHPn1ENQ@mail.gmail.com>
Subject: Re: [PATCH 05/12] dma-buf: add explicit buffer pinning
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media <linux-media@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 2:39 PM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Add optional explicit pinning callbacks instead of implicitly assume the
> exporter pins the buffer when a mapping is created.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/dma-buf/dma-buf.c | 39 +++++++++++++++++++++++++++++++++++++++
>  include/linux/dma-buf.h   | 37 +++++++++++++++++++++++++++++++------
>  2 files changed, 70 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index a3738fab3927..f23ff8355505 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -630,6 +630,41 @@ void dma_buf_detach(struct dma_buf *dmabuf, struct d=
ma_buf_attachment *attach)
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_detach);
>
> +/**
> + * dma_buf_pin - Lock down the DMA-buf
> + *
> + * @dmabuf:    [in]    DMA-buf to lock down.
> + *
> + * Returns:
> + * 0 on success, negative error code on failure.
> + */
> +int dma_buf_pin(struct dma_buf *dmabuf)
> +{
> +       int ret =3D 0;
> +
> +       reservation_object_assert_held(dmabuf->resv);
> +
> +       if (dmabuf->ops->pin)
> +               ret =3D dmabuf->ops->pin(dmabuf);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_pin);
> +
> +/**
> + * dma_buf_unpin - Remove lock from DMA-buf
> + *
> + * @dmabuf:    [in]    DMA-buf to unlock.
> + */
> +void dma_buf_unpin(struct dma_buf *dmabuf)
> +{
> +       reservation_object_assert_held(dmabuf->resv);
> +
> +       if (dmabuf->ops->unpin)
> +               dmabuf->ops->unpin(dmabuf);
> +}
> +EXPORT_SYMBOL_GPL(dma_buf_unpin);
> +
>  /**
>   * dma_buf_map_attachment_locked - Maps the buffer into _device_ address=
 space
>   * with the reservation lock held. Is a wrapper for map_dma_buf() of the
> @@ -666,6 +701,8 @@ dma_buf_map_attachment_locked(struct dma_buf_attachme=
nt *attach,
>          */
>         if (attach->invalidate)
>                 list_del(&attach->node);
> +       else
> +               dma_buf_pin(attach->dmabuf);
>         sg_table =3D attach->dmabuf->ops->map_dma_buf(attach, direction);
>         if (attach->invalidate)
>                 list_add(&attach->node, &attach->dmabuf->attachments);
> @@ -735,6 +772,8 @@ void dma_buf_unmap_attachment_locked(struct dma_buf_a=
ttachment *attach,
>
>         attach->dmabuf->ops->unmap_dma_buf(attach, sg_table,
>                                                 direction);
> +       if (!attach->invalidate)
> +               dma_buf_unpin(attach->dmabuf);
>  }
>  EXPORT_SYMBOL_GPL(dma_buf_unmap_attachment_locked);
>
> diff --git a/include/linux/dma-buf.h b/include/linux/dma-buf.h
> index ece4638359a8..a615b74e5894 100644
> --- a/include/linux/dma-buf.h
> +++ b/include/linux/dma-buf.h
> @@ -100,14 +100,40 @@ struct dma_buf_ops {
>          */
>         void (*detach)(struct dma_buf *, struct dma_buf_attachment *);
>
> +       /**
> +        * @pin_dma_buf:
> +        *
> +        * This is called by dma_buf_pin and lets the exporter know that =
an
> +        * importer assumes that the DMA-buf can't be invalidated any mor=
e.
> +        *
> +        * This is called with the dmabuf->resv object locked.
> +        *
> +        * This callback is optional.
> +        *
> +        * Returns:
> +        *
> +        * 0 on success, negative error code on failure.
> +        */
> +       int (*pin)(struct dma_buf *);
> +
> +       /**
> +        * @unpin_dma_buf:
> +        *
> +        * This is called by dma_buf_unpin and lets the exporter know tha=
t an
> +       * importer doesn't need to the DMA-buf to stay were it is any mor=
e.

This should read:
* importer doesn't need the DMA-buf to stay were it is anymore.

> +        *
> +        * This is called with the dmabuf->resv object locked.
> +        *
> +        * This callback is optional.
> +        */
> +       void (*unpin)(struct dma_buf *);
> +
>         /**
>          * @map_dma_buf:
>          *
>          * This is called by dma_buf_map_attachment() and is used to map =
a
>          * shared &dma_buf into device address space, and it is mandatory=
. It
> -        * can only be called if @attach has been called successfully. Th=
is
> -        * essentially pins the DMA buffer into place, and it cannot be m=
oved
> -        * any more
> +        * can only be called if @attach has been called successfully.
>          *
>          * This call may sleep, e.g. when the backing storage first needs=
 to be
>          * allocated, or moved to a location suitable for all currently a=
ttached
> @@ -148,9 +174,6 @@ struct dma_buf_ops {
>          *
>          * This is called by dma_buf_unmap_attachment() and should unmap =
and
>          * release the &sg_table allocated in @map_dma_buf, and it is man=
datory.
> -        * It should also unpin the backing storage if this is the last m=
apping
> -        * of the DMA buffer, it the exporter supports backing storage
> -        * migration.
>          *
>          * This is always called with the dmabuf->resv object locked when
>          * no_sgt_cache is true.
> @@ -442,6 +465,8 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags);
>  struct dma_buf *dma_buf_get(int fd);
>  void dma_buf_put(struct dma_buf *dmabuf);
>
> +int dma_buf_pin(struct dma_buf *dmabuf);
> +void dma_buf_unpin(struct dma_buf *dmabuf);
>  struct sg_table *dma_buf_map_attachment_locked(struct dma_buf_attachment=
 *,
>                                                enum dma_data_direction);
>  struct sg_table *dma_buf_map_attachment(struct dma_buf_attachment *,
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
