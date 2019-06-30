Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C034DC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E32A20881
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 18:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PyWYVlQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfF3S4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 14:56:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34929 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF3S4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 14:56:48 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so23750295ioo.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 11:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NaLfjipo68BMwPOD4vQyPZ7y9beiaLM//1SyGkkxM5c=;
        b=PyWYVlQnOFkdzGkNDuulU3+I3bDzqoT+eDsFc0z4yLtmvtxmJ/GdhMghXfjmwT1xgC
         TF2ruQzrIphDlACAApiQEeYhyAjvzd9h5mL6OOFa/Fn769cuxA7ZA11qLgAm9Ptvd25U
         E2N2W2Cr9L5yzfU5wHxu3NuDf5NxlhNrNwnyDk/BjYS4VzIFKxj6WXXQTdOHmAE7K2Lz
         pUKulussCCkCqtWGc8E6CqaHrupQk5Ud5w5IS+rn82WIjjS4yMDZAy8HYqKwrsufY/ft
         IAvz9rdJ2/e40j98btngjeo7Uf6fSW4vEpir2BhF1wbT1RI5+UiObopDQkJrgn1PMnfT
         lzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NaLfjipo68BMwPOD4vQyPZ7y9beiaLM//1SyGkkxM5c=;
        b=liEoB8kSxlMaW9SIzIX/wFIQsSXrU8uvxAly8MYWxAKtZNcjByk4udTfLr170Ud+tu
         xSfGvxj2a0YECR9JeYHCZYAqY+lj/AVwyK7AV35m4rFcwswb4QZ9+MgKccoOJ/vqPxf4
         ebn/GOKtHLwwTKOyiCKUnjM0m1u946xESoQHp6u55Bv9IY/fDDOW7SsvkDMOMShxof03
         RBC6BTWD/malVnSq2AYBnAgGWkiLtKD2VmXfDvPSaCheb5k/zxwwGxQyC3Bo9qCQYRWK
         OXQIsDMyIg8w9UdxjMSjMBCdQoIKElQkwUIgX8n5eVbAgXN+JatZ0ioH3Grua6nuzhjG
         MXLQ==
X-Gm-Message-State: APjAAAWKNoTMOTtwflQzU74TMo7oHGVbmAerDV8dpyUD6WlX1VVrQCt0
        TzrF1xM5vmyLo7/rC4PxnmgeqQZoZuwV34J6cNU=
X-Google-Smtp-Source: APXvYqyMps6KCRaoTQcQY5rJRYIy3v+QD9VTGz6/p/YraTOJR2mc+l8GXQaEuQN1N1pOBWeesZMvghGdMdaXry7tnuk=
X-Received: by 2002:a02:9f84:: with SMTP id a4mr18440799jam.20.1561921007426;
 Sun, 30 Jun 2019 11:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190620060726.926-1-kraxel@redhat.com> <20190620060726.926-3-kraxel@redhat.com>
 <CAPaKu7RWpoRkTkoatdYHz6itHZFvUYgaBcQAXnSC2gDc+dFZxQ@mail.gmail.com> <20190628100516.yrtiuxemyt4hvyra@sirius.home.kraxel.org>
In-Reply-To: <20190628100516.yrtiuxemyt4hvyra@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Sun, 30 Jun 2019 11:56:36 -0700
Message-ID: <CAPaKu7QOegd=kzOQMZQcogGSWf1hVqJHuMs-mEX0sRufUhNAcA@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] drm/virtio: switch virtio_gpu_wait_ioctl() to
 gem helper.
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 3:05 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Wed, Jun 26, 2019 at 04:55:20PM -0700, Chia-I Wu wrote:
> > On Wed, Jun 19, 2019 at 11:07 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Use drm_gem_reservation_object_wait() in virtio_gpu_wait_ioctl().
> > > This also makes the ioctl run lockless.
> > The userspace has a BO cache to avoid freeing BOs immediately but to
> > reuse them on next allocations.  The BO cache checks if a BO is busy
> > before reuse, and I am seeing a big negative perf impact because of
> > slow virtio_gpu_wait_ioctl.  I wonder if this helps.
>
> Could help indeed (assuming it checks with NOWAIT).
Yeah, that is the case.
>
> How many objects does userspace check in one go typically?  Maybe it
> makes sense to add an ioctl which checks a list, to reduce the system
> call overhead.
One.  The cache sorts BOs by the time they are freed, and checks only
the first (compatible) BO.  If it is idle, cache hit.  Otherwise,
cache miss.  A new ioctl probably won't help.


>
> > > +       if (args->flags & VIRTGPU_WAIT_NOWAIT) {
> > > +               obj = drm_gem_object_lookup(file, args->handle);
> > Don't we need a NULL check here?
>
> Yes, we do.  Will fix.
>
> thanks,
>   Gerd
>
