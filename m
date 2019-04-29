Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E40ABC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949712075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Yvz5MKIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfD2Hkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:40:53 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38838 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfD2Hkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:40:53 -0400
Received: by mail-ed1-f68.google.com with SMTP id w11so1519762edl.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 00:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cR/Ec4vlE+X0Q9Ok0IFawlzdAj+EmfR3ChCRLcZ/ulo=;
        b=Yvz5MKIw4ZC5qQmsVZshla4AGaxfZIkBuWlgR8PFsij1idit2Hg9pf2BY9X4YfNeP3
         0q/OaZHtVMvHVNJgHFZHNFVsd0ifJTRDRyvokNYW0ozxAb1Va4b1IMM0D/HUCYlZsuXw
         R7XvyxOE825SE4PFlQvLU61RelsDsB9+qbxZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=cR/Ec4vlE+X0Q9Ok0IFawlzdAj+EmfR3ChCRLcZ/ulo=;
        b=tBXCF+v6q675VTAV5RrDNRErS/a+R7AqVKBd0Df3yQQVrux6/q81ubMqBPIgCH+c79
         F46GP2vg1NQZVt2r3IXpqaGbKwbhQRBibs0YohuGQvpBIeRZO+/5+yRMtIxBhAhtzFX8
         PorqkpvFTM+GJhlXocRCRKFuuhWFpd9k++abPm0IifKJo+YBM2BuMq/l9lDFpz4bNOyz
         KauDJJl23EKPHfVKqZUPB3ut91Yo+hXCzuA5vr+n76Ph3T2wYZUR35HA06JyBHHbzQm6
         CA7r4f500/OUsylWNEttWgE5TIUGOY+JjEeHuqvMbqJR/cW6VYut8kudQcwjFOkxUzGg
         1vgw==
X-Gm-Message-State: APjAAAWJ4EGffLyaIZzpQfT4d5nYCAww1djoc/PyYmibNUZVqsZImhsl
        TjYjeoSwJg02Uh27vP9n0VJntw==
X-Google-Smtp-Source: APXvYqyamfeC0VDCz3uc3J7R7UkR4tbLJux/+a07AHsJfdjm2ugURBFwopOn5nLJ9FRLCID5f7b7Rw==
X-Received: by 2002:aa7:dc44:: with SMTP id g4mr37840116edu.268.1556523650136;
        Mon, 29 Apr 2019 00:40:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id u10sm8782904edj.22.2019.04.29.00.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Apr 2019 00:40:49 -0700 (PDT)
Date:   Mon, 29 Apr 2019 09:40:47 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Hellstrom <thomas@shipmail.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>
Subject: Re: [PATCH] Revert "drm/qxl: drop prime import/export callbacks"
Message-ID: <20190429074047.GJ3271@phenom.ffwll.local>
Mail-Followup-To: Thomas Hellstrom <thomas@shipmail.org>,
        Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>
References: <20190426053324.26443-1-kraxel@redhat.com>
 <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
 <8ae152fe-7811-4de3-e26f-350650a8f992@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae152fe-7811-4de3-e26f-350650a8f992@shipmail.org>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 05:42:23PM +0200, Thomas Hellstrom wrote:
> On 4/26/19 4:21 PM, Daniel Vetter wrote:
> > On Fri, Apr 26, 2019 at 7:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > > This reverts commit f4c34b1e2a37d5676180901fa6ff188bcb6371f8.
> > > 
> > > Simliar to commit a0cecc23cfcb Revert "drm/virtio: drop prime
> > > import/export callbacks".  We have to do the same with qxl,
> > > for the same reasons (it breaks DRI3).
> > > 
> > > Drop the WARN_ON_ONCE().
> > > 
> > > Fixes: f4c34b1e2a37d5676180901fa6ff188bcb6371f8
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > Maybe we need some helpers for virtual drivers which only allow
> > self-reimport and nothing else at all? I think there's qxl, virgl,
> > vmwgfx and maybe also vbox one who could use this ... Just a quick
> > idea.
> > -Daniel
> 
> I think vmwgfx could, in theory, support the full range of operations,
> at least for reasonably recent device versions. However, it wouldn't be
> terribly efficient since the exported dma-buf sglist would basically be a
> bounce-buffer.

Yeah not sure that makes sense to support really ...
-Daniel

> 
> /Thomas
> 
> 
> > > ---
> > >   drivers/gpu/drm/qxl/qxl_drv.c   |  4 ++++
> > >   drivers/gpu/drm/qxl/qxl_prime.c | 12 ++++++++++++
> > >   2 files changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
> > > index 578d867a81d5..f33e349c4ec5 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_drv.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_drv.c
> > > @@ -255,10 +255,14 @@ static struct drm_driver qxl_driver = {
> > >   #if defined(CONFIG_DEBUG_FS)
> > >          .debugfs_init = qxl_debugfs_init,
> > >   #endif
> > > +       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
> > > +       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
> > >          .gem_prime_export = drm_gem_prime_export,
> > >          .gem_prime_import = drm_gem_prime_import,
> > >          .gem_prime_pin = qxl_gem_prime_pin,
> > >          .gem_prime_unpin = qxl_gem_prime_unpin,
> > > +       .gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
> > > +       .gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
> > >          .gem_prime_vmap = qxl_gem_prime_vmap,
> > >          .gem_prime_vunmap = qxl_gem_prime_vunmap,
> > >          .gem_prime_mmap = qxl_gem_prime_mmap,
> > > diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
> > > index 8b448eca1cd9..114653b471c6 100644
> > > --- a/drivers/gpu/drm/qxl/qxl_prime.c
> > > +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> > > @@ -42,6 +42,18 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
> > >          qxl_bo_unpin(bo);
> > >   }
> > > 
> > > +struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
> > > +{
> > > +       return ERR_PTR(-ENOSYS);
> > > +}
> > > +
> > > +struct drm_gem_object *qxl_gem_prime_import_sg_table(
> > > +       struct drm_device *dev, struct dma_buf_attachment *attach,
> > > +       struct sg_table *table)
> > > +{
> > > +       return ERR_PTR(-ENOSYS);
> > > +}
> > > +
> > >   void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
> > >   {
> > >          struct qxl_bo *bo = gem_to_qxl_bo(obj);
> > > --
> > > 2.18.1
> > > 
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
