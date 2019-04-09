Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75263C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0F320880
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 04:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtU2eedT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfDIEBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 00:01:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43346 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfDIEBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 00:01:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id c20so9410760qkc.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 21:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4u8fidm5D/opMYz7YM2gWO+UekfpbAquXOxV/eIlKgk=;
        b=gtU2eedTWqSRvZn7ZCVXsaVeVFV7MIJTrZLf1Q2wuOrmyj7qOBmUWqDuhxqGSEp0Ik
         pQEYp9mm18X8MaRh7TQfSBji4+ey/0R6xohEExXcHHGqbtC55/95Csp3S2xrxavENJXX
         WZW+kgSXj/hYWNsAkyPAfjxlkHSIY/umaiVAGgQ/NHyhQcgV9u+WxwjuEYNnFlj2wk8R
         VTiE/d9JRLbkQj8q46tRMwlDMTFNJcO33nBalhNnZ+nMJigV0bcH9Kh2LfCd2TM7or9S
         8MWfAKuL0VqhwV0u1SBg6KDrmVR2LSJzgdXykV/o0gCmrZ92CZbFR7TmC/YkOMGJFGB1
         5psA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4u8fidm5D/opMYz7YM2gWO+UekfpbAquXOxV/eIlKgk=;
        b=gQOO/5lBEzReKNA82M9uE/n4UbUnNPVHHNet3iD2RgPVOzNdl3ktWvGTWF7k6OcMIK
         MW1D/Dn/7jeQEzq4ciXMVFvhWsqalFlXDy/WcWL8rhWXj2L5riA1o/0KEq8+5Z9ASNWC
         Htm6QdzE+Q0CVIYLCEVA7VoianJJXhzqA749aEBfXH2AWNc24tvDj6IzS7tw4IodtGh4
         j41Kvyfc0tENByPImSScLzC26reDZ75Lp+s1DlnNwwSZL2B+K8goUWO/w+CaSnyQFJtO
         AWjKyJIU4dN+M4JGAaoHs8YE0fTRX8jmIihdeVOIJsk1uoFA2P7O9eh3r5jnm0vlyqJ9
         o0Kw==
X-Gm-Message-State: APjAAAWlMRVHd4wX1VZ3kv0/WPFqeu3rOcjrax3cNwBicudJU5G2jZ15
        KxNN8F9WFUDUj2J913M1rxCsPfWA7B0oE2Zq3JY=
X-Google-Smtp-Source: APXvYqzGUVzEZARAVQsaCKjmqLL+SspArRjqUdatG4scWs0EZoAOmQOEFfR1Nmp9uDtiNnjdtTUw9VQyU2yMduFN9jw=
X-Received: by 2002:a05:620a:1591:: with SMTP id d17mr25699490qkk.39.1554782505387;
 Mon, 08 Apr 2019 21:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190110081750.11358-1-kraxel@redhat.com> <CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
In-Reply-To: <CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Tue, 9 Apr 2019 14:01:33 +1000
Message-ID: <CAPM=9tyEmn2LXhNmPSOi7JAgBc3QZwNtM+8FT8CWebz4GztaJA@mail.gmail.com>
Subject: Re: [PATCH] drm/qxl: drop prime import/export callbacks
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2019 at 07:13, Dave Airlie <airlied@gmail.com> wrote:
>
> On Thu, 10 Jan 2019 at 18:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> > so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> > userspace.

It's been pointed out to me that disables DRI3 for these devices, I'm
not sure that is the solution we actually wanted.

any ideas?
Dave.

> >
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>
> Reviewed-by: Dave Airlie <airlied@redhat.com>
> > ---
> >  drivers/gpu/drm/qxl/qxl_drv.c   |  4 ----
> >  drivers/gpu/drm/qxl/qxl_prime.c | 14 --------------
> >  2 files changed, 18 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > index 13c8a662f9..ccb090f3ab 100644
> > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > @@ -250,14 +250,10 @@ static struct drm_driver qxl_driver = {
> >  #if defined(CONFIG_DEBUG_FS)
> >         .debugfs_init = qxl_debugfs_init,
> >  #endif
> > -       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> > -       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> >         .gem_prime_export = drm_gem_prime_export,
> >         .gem_prime_import = drm_gem_prime_import,
> >         .gem_prime_pin = qxl_gem_prime_pin,
> >         .gem_prime_unpin = qxl_gem_prime_unpin,
> > -       .gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
> > -       .gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
> >         .gem_prime_vmap = qxl_gem_prime_vmap,
> >         .gem_prime_vunmap = qxl_gem_prime_vunmap,
> >         .gem_prime_mmap = qxl_gem_prime_mmap,
> > diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> > index a55dece118..df65d3c1a7 100644
> > --- a/drivers/gpu/drm/qxl/qxl_prime.c
> > +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> > @@ -38,20 +38,6 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
> >         WARN_ONCE(1, "not implemented");
> >  }
> >
> > -struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
> > -{
> > -       WARN_ONCE(1, "not implemented");
> > -       return ERR_PTR(-ENOSYS);
> > -}
> > -
> > -struct drm_gem_object *qxl_gem_prime_import_sg_table(
> > -       struct drm_device *dev, struct dma_buf_attachment *attach,
> > -       struct sg_table *table)
> > -{
> > -       WARN_ONCE(1, "not implemented");
> > -       return ERR_PTR(-ENOSYS);
> > -}
> > -
> >  void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
> >  {
> >         WARN_ONCE(1, "not implemented");
> > --
> > 2.9.3
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
