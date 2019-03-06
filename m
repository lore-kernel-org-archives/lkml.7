Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB68C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83F2E21773
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdUrwiVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbfCFSjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:39:08 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43711 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfCFSjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:39:07 -0500
Received: by mail-lf1-f68.google.com with SMTP id a130so1801651lfa.10;
        Wed, 06 Mar 2019 10:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vigpWUQ8b8ts8VnG7T2zXXh6BV/41RiIXHkYKoNiGk8=;
        b=fdUrwiVKOg3psmVOsSEaNyWNbrHb8Q9vKwwRZrruHP5Taqb7IDVF6sQ2UioRDHkUl0
         yjMyrVqps5gSidmdj6DOHcz01f35lp8U8oeA3d3OXBhuPmWX82K4vtJM61pTN+UE7bQD
         0jQqsT8QhK2TY78TuV4W2OCUSVKJfeXN3pSgLa4x6BivGSt88dADFnz7zSGKf12ZJbTM
         dITs31ad2MVcvi+GUsLHa3CHev06QBISbLPneb3stElcuPObgvps7oIxQPjsr88cS+w+
         VknfWXZN8TcY4gZqqYXUlC1UxQPcnKREVqluZ9NeN11gASoCu+JFhpOsjj3jS9lxUK6D
         Kcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vigpWUQ8b8ts8VnG7T2zXXh6BV/41RiIXHkYKoNiGk8=;
        b=Pa74e4L+L91G5IdCuD/JX+crdPlPChIcn/pK9Jk/ogZlNt6PNPe22QP+8JubX2p+u5
         xWLFiRGghmpBXiqpJaYmbHriyWsZpXrN1vHqrOMVEbAcYLHpS2TCRyZs4/jDpFfTKV/a
         38AuHddOtbFMNkVQTAsoWx4s0cC3FIPd/k77Ass28Su8i4sYzHnCvOYDGkcp6zzWByro
         t0vq9xStC7r56QZ2TMY/rQe2wQ0nMjNpGCgNDXtstcJb0N7PIaDkqF7zRzN48CxUdCA9
         B2lyOTnFgpdiY/SP1d5EiT4A5h8l1nowAlvwFYvEjKVIkUxfdAMslwk+vfAAr77lg5m6
         5fcw==
X-Gm-Message-State: APjAAAUKf5WJNsxiwUA/sPWISJKULHmbBw1VhcKfgqegqrJBIavdT/oD
        MnjwniXxN2OllW2CDmjZuehJcyV3NU/+VNDm2ni+pA==
X-Google-Smtp-Source: APXvYqzdy5JrzhP2r4sE9XnCletcfwxiDYBr0+FDfBBB+Ul6LWnXBwPUR5SafkYeck3dJUWAJ6H7Yh4XOW3jCwP5eoc=
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr4748618lfi.3.1551897544583;
 Wed, 06 Mar 2019 10:39:04 -0800 (PST)
MIME-Version: 1.0
References: <1551856692-3384-1-git-send-email-jasowang@redhat.com> <1551856692-3384-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1551856692-3384-5-git-send-email-jasowang@redhat.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 7 Mar 2019 00:13:24 +0530
Message-ID: <CAFqt6zYynfCn_SG6w98dHMA5rS6euPb+ihXtQcALE47K0LQb7g@mail.gmail.com>
Subject: Re: [RFC PATCH V2 4/5] vhost: introduce helpers to get the size of
 metadata area
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterx@redhat.com,
        Linux-MM <linux-mm@kvack.org>, aarcange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 12:48 PM Jason Wang <jasowang@redhat.com> wrote:
>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Is the change log left with any particular reason ?
> ---
>  drivers/vhost/vhost.c | 46 ++++++++++++++++++++++++++++------------------
>  1 file changed, 28 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 2025543..1015464 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -413,6 +413,27 @@ static void vhost_dev_free_iovecs(struct vhost_dev *dev)
>                 vhost_vq_free_iovecs(dev->vqs[i]);
>  }
>
> +static size_t vhost_get_avail_size(struct vhost_virtqueue *vq, int num)
> +{
> +       size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +
> +       return sizeof(*vq->avail) +
> +              sizeof(*vq->avail->ring) * num + event;
> +}
> +
> +static size_t vhost_get_used_size(struct vhost_virtqueue *vq, int num)
> +{
> +       size_t event = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> +
> +       return sizeof(*vq->used) +
> +              sizeof(*vq->used->ring) * num + event;
> +}
> +
> +static size_t vhost_get_desc_size(struct vhost_virtqueue *vq, int num)
> +{
> +       return sizeof(*vq->desc) * num;
> +}
> +
>  void vhost_dev_init(struct vhost_dev *dev,
>                     struct vhost_virtqueue **vqs, int nvqs, int iov_limit)
>  {
> @@ -1253,13 +1274,9 @@ static bool vq_access_ok(struct vhost_virtqueue *vq, unsigned int num,
>                          struct vring_used __user *used)
>
>  {
> -       size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> -
> -       return access_ok(desc, num * sizeof *desc) &&
> -              access_ok(avail,
> -                        sizeof *avail + num * sizeof *avail->ring + s) &&
> -              access_ok(used,
> -                       sizeof *used + num * sizeof *used->ring + s);
> +       return access_ok(desc, vhost_get_desc_size(vq, num)) &&
> +              access_ok(avail, vhost_get_avail_size(vq, num)) &&
> +              access_ok(used, vhost_get_used_size(vq, num));
>  }
>
>  static void vhost_vq_meta_update(struct vhost_virtqueue *vq,
> @@ -1311,22 +1328,18 @@ static bool iotlb_access_ok(struct vhost_virtqueue *vq,
>
>  int vq_meta_prefetch(struct vhost_virtqueue *vq)
>  {
> -       size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
>         unsigned int num = vq->num;
>
>         if (!vq->iotlb)
>                 return 1;
>
>         return iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->desc,
> -                              num * sizeof(*vq->desc), VHOST_ADDR_DESC) &&
> +                              vhost_get_desc_size(vq, num), VHOST_ADDR_DESC) &&
>                iotlb_access_ok(vq, VHOST_ACCESS_RO, (u64)(uintptr_t)vq->avail,
> -                              sizeof *vq->avail +
> -                              num * sizeof(*vq->avail->ring) + s,
> +                              vhost_get_avail_size(vq, num),
>                                VHOST_ADDR_AVAIL) &&
>                iotlb_access_ok(vq, VHOST_ACCESS_WO, (u64)(uintptr_t)vq->used,
> -                              sizeof *vq->used +
> -                              num * sizeof(*vq->used->ring) + s,
> -                              VHOST_ADDR_USED);
> +                              vhost_get_used_size(vq, num), VHOST_ADDR_USED);
>  }
>  EXPORT_SYMBOL_GPL(vq_meta_prefetch);
>
> @@ -1343,13 +1356,10 @@ bool vhost_log_access_ok(struct vhost_dev *dev)
>  static bool vq_log_access_ok(struct vhost_virtqueue *vq,
>                              void __user *log_base)
>  {
> -       size_t s = vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX) ? 2 : 0;
> -
>         return vq_memory_access_ok(log_base, vq->umem,
>                                    vhost_has_feature(vq, VHOST_F_LOG_ALL)) &&
>                 (!vq->log_used || log_access_ok(log_base, vq->log_addr,
> -                                       sizeof *vq->used +
> -                                       vq->num * sizeof *vq->used->ring + s));
> +                                 vhost_get_used_size(vq, vq->num)));
>  }
>
>  /* Can we start vq? */
> --
> 1.8.3.1
>
