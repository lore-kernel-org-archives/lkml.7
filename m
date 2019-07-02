Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E95C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802B720989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 18:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esnMLw+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfGBSTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 14:19:03 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55328 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBSTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 14:19:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so1769911wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 11:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:cc:from:to:message-id:user-agent:date;
        bh=hEU9uNz0FeGZ4kxd0wEk8UwwTQ62JJQ9s9qQBcddhu8=;
        b=esnMLw+keGA9XQ1HnEGydaI33kpqF5YM1dm7n0bfiBl9pmdyO8Rpf2wVb2Q0LyQAG6
         ojJP0je2Mn4GBBA1POXJM/7B+f1QTkpFQHBd5sxMqR3wKlM+/5QlIKQH+P5LDEuubdCw
         qCUgX6AJAJtnBqcUd+FCwkV5HyrzK3Z0PFgxi16Vv02uYkHTu8KC/GWSZE7wAbc2vn4T
         mAwkchonzA8mVk5QG0XZ+BbJWuyUlQWyGVuaAm4I1q2rVtBLq4SKeIGmvV/yHqG+hize
         5jKrejWvpx27Nyas5LRbgWflefO2/1+BejN4ydwX/yjbJuwptj5ro1k4cbKucCByCuZg
         sqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:cc:from:to:message-id:user-agent
         :date;
        bh=hEU9uNz0FeGZ4kxd0wEk8UwwTQ62JJQ9s9qQBcddhu8=;
        b=qy8Si4pUa2vr4Cllny64qo8Cqqjgez03XJnVb5OjyivWt42opuXcRoC2TMtPVucCPB
         Fl+QuOSW8GOdTyQbHqogr9ZjFoGpPQxhyH/wKpJKmtwSa8238n0TdEoO1B6RdcFd4Jr3
         cgYqOlIy+VewFYYupyKozNo0v60/wUTBr4CcBjCWUYGLoedSuBkchqIlNa19bXstT0Iw
         VVheGfjXf83uL9Y0I+zxgWH9wm7XKfbI1uExK2jWQihyFQLDeVo1aFsfKy6e69rHulkE
         amSskSIjgRosB0yfpVKI09e4ZxCwsXyW5cK3gCvpsSQqLU8GJxSYqjQk11K+u62IcOp1
         h0Vw==
X-Gm-Message-State: APjAAAVimChk3bA9R4lpBQnY0pKnQFL8cdVU3acMIgeUs9RJDYbjj95n
        kvE+hzSM6rM6JsGvJmQ7E4c=
X-Google-Smtp-Source: APXvYqw5bkzt/DpFLQmrKZqj9GKK+Oiol3+jSArs3mFrvRB2JmQZAOboaUNt0oDpWHQ0ot8Pzea0Hw==
X-Received: by 2002:a05:600c:2243:: with SMTP id a3mr4150010wmm.83.1562091540477;
        Tue, 02 Jul 2019 11:19:00 -0700 (PDT)
Received: from localhost ([151.237.18.226])
        by smtp.gmail.com with ESMTPSA id f7sm3496945wrp.55.2019.07.02.11.18.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 11:18:59 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190702144818.32648-1-ihor.matushchak@foobox.net>
References: <156207429000.5051.5975712347598980745@silver> <20190702144818.32648-1-ihor.matushchak@foobox.net>
Subject: Re: [PATCH v2] virtio-mmio: add error check for platform_get_irq
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ihor.matushchak@foobox.net
From:   "Ivan T. Ivanov" <iivanov.xz@gmail.com>
To:     Ihor Matushchak <ihor.matushchak@foobox.net>, mst@redhat.com
Message-ID: <156209153842.6607.13027564854773685120@silver>
User-Agent: alot/0.8.1
Date:   Tue, 02 Jul 2019 21:18:58 +0300
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ihor Matushchak (2019-07-02 17:48:18)
> in vm_find_vqs() irq has a wrong type
> so, in case of no IRQ resource defined,
> wrong parameter will be passed to request_irq()
>=20
> Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>


Reviewed-by: Ivan T. Ivanov <iivanov.xz@gmail.com>

Thanks!

> ---
> Changes in v2:
> Don't overwrite error code value.
>=20
>  drivers/virtio/virtio_mmio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index f363fbeb5ab0..e09edb5c5e06 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -463,9 +463,14 @@ static int vm_find_vqs(struct virtio_device *vdev, u=
nsigned nvqs,
>                        struct irq_affinity *desc)
>  {
>         struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev);
> -       unsigned int irq =3D platform_get_irq(vm_dev->pdev, 0);
> +       int irq =3D platform_get_irq(vm_dev->pdev, 0);
>         int i, err, queue_idx =3D 0;
> =20
> +       if (irq < 0) {
> +               dev_err(&vdev->dev, "Cannot get IRQ resource\n");
> +               return irq;
> +       }
> +
>         err =3D request_irq(irq, vm_interrupt, IRQF_SHARED,
>                         dev_name(&vdev->dev), vm_dev);
>         if (err)
> --=20
> 2.17.1
>=20
