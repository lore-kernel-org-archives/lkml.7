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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA7C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26979206E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSHIWLXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGBNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:31:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44868 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:31:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id e3so8306210wrs.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:to:cc:message-id:user-agent:date;
        bh=4VPnLBfnP+yE8XWhPk6Z0NZmIvwwW0UIFWDe0blP3PA=;
        b=SSHIWLXSCz2J4XKgqcuB4HuhMgP+BgSjUvlvTI1SfIECDv8eAnmm7cP4x6cRFpdbRd
         e+z2Qtim/Mny+j7W4rH6z1xj4EWXisZqMg5DdWH/AVWl1rbE26SK5Ern1cohCsDP/qBE
         /SYTm60q5UUSpE5YlgVQciF57ibUm+YAddrQEFsjiS3BSooSXp/9lfufr4CgL6tRF+vM
         qShTZpZ847UuD/66QU6Dt84odNmrjud0aJrMXVondjAUKB4QHvPBwlo/x0j1jxreVUge
         D29IP3CehKILhPMAWtxsPXahwDBbpwfIGD6r+h47ZFwVIVG2aBSTLrTCx+tg/SUaJJo+
         ssuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:to:cc:message-id:user-agent
         :date;
        bh=4VPnLBfnP+yE8XWhPk6Z0NZmIvwwW0UIFWDe0blP3PA=;
        b=OWYak9dqurEr6EZif5sJCI6ej1f0DV8aSZT+kIwPnJtE9hxjUIl7BLSVEMkbZf3q4y
         GkbbxSFtYCVo8pAkxE2qU/O0CCzipSIbzAuiBHt4UQBwGnKA2zmSfBwRHDrYkPnWG03A
         J9/b0lirqAjdJO546pZSl1pk2KzjH4nUO0ZxMSwfK4JKivZf6Kl+pbtyjlZuNzD1GY6h
         gf2GS06YsThcL9VS27PLpCM+c6XcZDfieyzlUm+yURQataCoSQEoK7dzV2I+S+6YQsdh
         7XkYX/a1l9uyB8rRWdIft8HvIdR5wIUSLIOoyOvgNCQiPu7Kh7US6P/aLqEU5izUp8vx
         JfvA==
X-Gm-Message-State: APjAAAWoPASVNR4XNcqB0uaeR19PyGfr45rK4DlBCIGV80+Pdg6BNapt
        cyBQKbn5XPc1cOnaHzv4Hd0LxHnV
X-Google-Smtp-Source: APXvYqwq06G0czPEPLmYLoGzD2jqc2jTMs8sD6Gj1glkXKfoUr2VN70FHXc0dZ5zI3VGNbqDHyFU3Q==
X-Received: by 2002:adf:e5c2:: with SMTP id a2mr1799223wrn.91.1562074291836;
        Tue, 02 Jul 2019 06:31:31 -0700 (PDT)
Received: from localhost ([151.237.18.226])
        by smtp.gmail.com with ESMTPSA id b8sm2412981wmh.46.2019.07.02.06.31.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 02 Jul 2019 06:31:31 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190702095918.12852-1-ihor.matushchak@foobox.net>
References: <20190702095918.12852-1-ihor.matushchak@foobox.net>
Subject: Re: [PATCH] virtio-mmio: add error check for platform_get_irq
From:   "Ivan T. Ivanov" <iivanov.xz@gmail.com>
To:     Ihor Matushchak <ihor.matushchak@foobox.net>, mst@redhat.com
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, ihor.matushchak@foobox.net
Message-ID: <156207429000.5051.5975712347598980745@silver>
User-Agent: alot/0.8.1
Date:   Tue, 02 Jul 2019 16:31:30 +0300
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Quoting Ihor Matushchak (2019-07-02 12:59:18)
> in vm_find_vqs() irq has a wrong type
> so, in case of no IRQ resource defined,
> wrong parameter will be passed to request_irq()
>=20
> Signed-off-by: Ihor Matushchak <ihor.matushchak@foobox.net>
> ---
>  drivers/virtio/virtio_mmio.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index f363fbeb5ab0..60dde8ed163b 100644
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
> +               dev_err(&vdev->dev, "no IRQ resource defined\n");
> +               return -ENODEV;

Don't overwrite error code value. Just return it as it is.

Regards,
Ivan

