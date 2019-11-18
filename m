Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E50C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B668C222DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 22:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRJCKVEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKRWxE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 17:53:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21950 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726705AbfKRWxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 17:53:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574117583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vHC8PHwBSVJlfl9mKDf+6eaQiS+n7bl9SU0M3ddw71E=;
        b=dRJCKVEoQoGgWtfMqnejcTnuPK7GtMbn5lm+XNbQgrLif4Fv+QRQQoMJXqPa2lgAln7LUM
        VQ4uil+tWP8/BW01Lws/gWevYApXRsAL7o5uniAIy4ObntXMXwrSq5e5wohrmCX6NplSwk
        nzFRfZjSG5cCuCGX4KYoxD7mKWf0nBs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255--9ChDMr9PF27kXAqmClMKA-1; Mon, 18 Nov 2019 17:53:01 -0500
Received: by mail-wr1-f72.google.com with SMTP id p4so16901764wrw.15
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 14:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kV4v0rcx7ROVmVBnnH/7D38MAqllaJgL/+IcSiWha4Y=;
        b=GF+kTkwwssHa8ZMmzh4B66fYA9UVhxT1Rqt9P1dwxjDF6Jlo0Xu/JobwlspRdQ9KkL
         NApFNtPtokx0vfzLg9b6Sb+QYpj4cueRmosMLoYALkW7WgLYkrRAK1lHYayOmp5fYgKA
         OCahasi/ohfmyGnhCf2XE5oZubVVOcUOEbZkz5H9PGzOkuLGcaIEoUAgRvk0F3G9R0XA
         SuaSvzcJRCocqQjQ/N2cbEXfrbi7/rWgApD7/Jdz3LtsMwgWfljmp+hOgv86AehVEFzS
         L2ZH5a0R7Od0e356N4QW0SaVJ/l5gbVrxzz/8gYLantgcybKLqZ04LL0odpj6/J6rbti
         5WBQ==
X-Gm-Message-State: APjAAAVtMhmWuC+UjJnhtaXUDQ92IVoBCuZF5qBkIE5VlOmAVidDNxgs
        sRcGV0UfbYsau9GOz1q4kC9fJjy0Q9dPd5IB/V2c0ruO/IbaJgtRzKfebMhW1Z0TmHVm9pYPmg7
        BfWwck0k9GyHudDXParbAxDlU
X-Received: by 2002:adf:e58c:: with SMTP id l12mr12079029wrm.156.1574117580796;
        Mon, 18 Nov 2019 14:53:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoa4RK68vgg9+wWmozzqJMUPDZGG+Rrs6vlWToxYLzFwmweqCNkNlr8Ji1jUXVeJjARQlyRQ==
X-Received: by 2002:adf:e58c:: with SMTP id l12mr12079013wrm.156.1574117580573;
        Mon, 18 Nov 2019 14:53:00 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
        by smtp.gmail.com with ESMTPSA id 200sm1025334wme.32.2019.11.18.14.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:52:59 -0800 (PST)
Date:   Mon, 18 Nov 2019 17:52:56 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     jasowang@redhat.com, wei.w.wang@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] virtio_balloon: fix pages_to_free calculation
Message-ID: <20191118175114-mutt-send-email-mst@kernel.org>
References: <CACGdZYJoHSN3vkj_QBz6Txmec9mJMmkH66j2XtqzpUWpfpw4Tg@mail.gmail.com>
 <20191118213811.22017-1-khazhy@google.com>
MIME-Version: 1.0
In-Reply-To: <20191118213811.22017-1-khazhy@google.com>
X-MC-Unique: -9ChDMr9PF27kXAqmClMKA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 01:38:10PM -0800, Khazhismel Kumykov wrote:
> freed_pages was accumulating total freed pages, but was also subtracted
> on each iteration from pages_to_free, which could potentially result in
> attempting to free fewer pages than asked for. This change also makes
> both freed_pages and pages_to_free in terms of "balloon pages", where
> they were mismatched before.

And then patch 2/2 changes it back to both be regular pages.
Which is good, but why do we have to go back and forth
breaking then fixing it back?


>=20
> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
> Cc: Wei Wang <wei.w.wang@intel.com>
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
> ---
>  drivers/virtio/virtio_balloon.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
> index 226fbb995fb0..7cf9540a40b8 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -782,11 +782,8 @@ static unsigned long shrink_balloon_pages(struct vir=
tio_balloon *vb,
>  =09 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
>  =09 * multiple times to deflate pages till reaching pages_to_free.
>  =09 */
> -=09while (vb->num_pages && pages_to_free) {
> -=09=09pages_freed +=3D leak_balloon(vb, pages_to_free) /
> -=09=09=09=09=09VIRTIO_BALLOON_PAGES_PER_PAGE;
> -=09=09pages_to_free -=3D pages_freed;
> -=09}
> +=09while (vb->num_pages && pages_to_free > pages_freed)
> +=09=09pages_freed +=3D leak_balloon(vb, pages_to_free - pages_freed);
>  =09update_balloon_size(vb);
> =20
>  =09return pages_freed;
> --=20
> 2.24.0.432.g9d3f5f5b63-goog

