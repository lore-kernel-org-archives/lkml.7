Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7199EC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC0A208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Emhed+tl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbfF3Smh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 14:42:37 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:47068 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3Smg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 14:42:36 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so9851460iol.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 11:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QDSijjS1xXueLHNMMqTIhyO9jX2UJsvp3nUT87AqiGI=;
        b=Emhed+tl7EdEvirZ/81+czghnaAYl79gEfihBwTiJ97+LKwiG68+VS+CHihBWaEOQV
         zwwiuyIkcDRa3FgNnZKTDxe8BL2qflZc2MbNjhc6vQTUvLQlbAg7l6G+d98WxHi67oku
         CgSpPUfNxpAkz7iYWZ+R9dwslRE4Ly0uUTpWF4RoXt9nwklOA9OKSMbeE6n4RTaIh+5D
         vNx6PJInFmhrIiLqZnehfguHPOB02XFHM8OtdfdSFOYXYtqz96BY7NRq7yr+92b+ZQoO
         aQunq3wV+kRdpmRaQjqlZaUViaHUttS94Al/radLkStdbTl22SlZnqcxXeBc7WbEMkEG
         J9kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QDSijjS1xXueLHNMMqTIhyO9jX2UJsvp3nUT87AqiGI=;
        b=BmRZdB9J6c7AfJYaNXJkxkMxguTiXMHEwz7SB3AEVcWGQDD2PqnM/gx4xPdiz3oqgZ
         eDHMVQhAabsw+m8QvNl/Kk/MPB9bDEIafoisX1RfyKpR5udsOHLLA2p0puV1Dd/ISZIo
         T9BJtAeXugrfwkVd/SBmcRJUH3mGiH7zVLoQ1u3HK6QCBPwrql4uLkCn2t7hvhE36F3k
         wItSoTocQs4aXPZUkBXf6o8c3u9E6XXA963zh5gwFYq/1dEAw1LC34/+r+HMgSmOnZQf
         3KQKczIJVuU+rgOK3KMj5Ft7XVW7HUTeW0p1uUFq4SjISgWa5icpV9ozKqv121rMN9K/
         Zwvw==
X-Gm-Message-State: APjAAAUwiVoWRVpwMtbApC7Y8IaKB0mxhhTPkXPDQkKVRiITsNRYsGKE
        8IoIGS3rJ/3EcHV8tEdIgeBlOCIw2oirXQZp8Vs=
X-Google-Smtp-Source: APXvYqzT+F08H19tgi6gFVBhegfk1wEZEmFvDGusVakOA4QAtP5eqstzg7IKQKCsgYDvO760yw11fqmH1p4BEZO8acw=
X-Received: by 2002:a5d:948f:: with SMTP id v15mr13272701ioj.93.1561920155877;
 Sun, 30 Jun 2019 11:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190620060726.926-1-kraxel@redhat.com> <20190620060726.926-12-kraxel@redhat.com>
 <CAPaKu7QXCMMKR50Oiv=CefUA4S+S3KgpJ2FKTd1WA1H2_ORqXg@mail.gmail.com> <20190628104907.vign7lmgftrwfisv@sirius.home.kraxel.org>
In-Reply-To: <20190628104907.vign7lmgftrwfisv@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sun, 30 Jun 2019 11:42:25 -0700
Message-ID: <CAPaKu7Skvc6UW+amOz4F8AAW95kXQzMhEJn-v=7kdGqu1dbtxA@mail.gmail.com>
Subject: Re: [PATCH v4 11/12] drm/virtio: switch from ttm to gem shmem helpers
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 3:49 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > >  static inline struct virtio_gpu_object*
> > >  virtio_gpu_object_ref(struct virtio_gpu_object *bo)
>
> > The last users of these two helpers are removed with this patch.  We
> > can remove them.
>
> patch 12/12 does that.
I meant virtio_gpu_object_ref/unref, which are still around after patch 12.
>
> > > +       bo = gem_to_virtio_gpu_obj(&shmem_obj->base);
> > > +       bo->base.base.funcs = &virtio_gpu_gem_funcs;
> > Move this to virtio_gpu_create_object.
>
> Fixed.
>
> > > +       ret = drm_gem_shmem_pin(&obj->base.base);
> > The bo is attached for its entire lifetime, at least currently.  Maybe
> > we can use drm_gem_shmem_get_pages_sgt (and get rid of obj->pages).
>
> Already checked this.
> We can't due to the iommu quirks.
>
> cheers,
>   Gerd
>
