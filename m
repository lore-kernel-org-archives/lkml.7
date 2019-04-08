Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D8EC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830322084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554754161;
	bh=ZeEZb1pZ60/ju3r8ey+U+aCL1uve8ZoE5VVj6YTXkKQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lJxG6oJ3xlAVmgbxSZ+wVbAOOXNFBWbi5eaN8x2nFcWas3j0Wb5ON/nqIT9Mcft4e
	 e46Yxsnxk2otjAcyM7nrQC7tl4PVrErOK9GUgYTKz5yyZSRWw9wTtmutK2Lhvnax6X
	 9tRArcYKVw8kJmZLZLIlu5zEUPp0gEj4yWbsz1/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbfDHUJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726220AbfDHUJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:09:20 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5586421841
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 20:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554754159;
        bh=ZeEZb1pZ60/ju3r8ey+U+aCL1uve8ZoE5VVj6YTXkKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RHIoBzR/hmqXIub0rFs7OZZiZtzWbEh3HQiZfESsS90nalNFm2skb761XEBDUPego
         52dihXSVbbZghkSZZ0BtzaKJlqZoPDndfZGco1xyQjxn1/4WZJyhLoPr6UvmCBm/mg
         z/C5aly7A2m9qv9ZxKc6k91/gbFEyeszD+6QF7t0=
Received: by mail-qk1-f182.google.com with SMTP id y5so8812146qkc.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 13:09:19 -0700 (PDT)
X-Gm-Message-State: APjAAAXpPjEn97eVJ8Pr+1mio1giVfl1IRUk9VScLUHAIxQZjZmFxAxK
        gnH3VMYLSD0NJHLZX6NKZvZ4f4bT4gYW+PbF5Q==
X-Google-Smtp-Source: APXvYqxOjr0OFjB/wBPjDGtGO4BoLY0cK9Ay4jl8gbII/gNM/CbQKHyXwawPyafDOnZV7e2zPTaBCrwB7Clj34gPL/k=
X-Received: by 2002:a37:6441:: with SMTP id y62mr24011951qkb.158.1554754158515;
 Mon, 08 Apr 2019 13:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-3-robh@kernel.org>
 <CAKMK7uE7-XV3cZxS8GT_EDa7yojOLPQi+LqkF85h_0z_JL6gYw@mail.gmail.com>
 <155412649586.24691.809508732198367112@skylake-alporthouse-com> <8736n120jw.fsf@anholt.net>
In-Reply-To: <8736n120jw.fsf@anholt.net>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 8 Apr 2019 15:09:06 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+So-kadir8o8T-YNYkfOYD8vopAS3UWGbSdRVLjH_JGQ@mail.gmail.com>
Message-ID: <CAL_Jsq+So-kadir8o8T-YNYkfOYD8vopAS3UWGbSdRVLjH_JGQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm: Add a drm_gem_objects_lookup helper
To:     Eric Anholt <eric@anholt.net>
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 10:43 AM Eric Anholt <eric@anholt.net> wrote:
>
> Chris Wilson <chris@chris-wilson.co.uk> writes:
>
> > Quoting Daniel Vetter (2019-04-01 14:06:48)
> >> On Mon, Apr 1, 2019 at 9:47 AM Rob Herring <robh@kernel.org> wrote:
> >> > +{
> >> > +       int i, ret = 0;
> >> > +       struct drm_gem_object *obj;
> >> > +
> >> > +       spin_lock(&filp->table_lock);
> >> > +
> >> > +       for (i = 0; i < count; i++) {
> >> > +               /* Check if we currently have a reference on the object */
> >> > +               obj = idr_find(&filp->object_idr, handle[i]);
> >> > +               if (!obj) {
> >> > +                       ret = -ENOENT;
> >
> > Unwind previous drm_gem_object_get(), the caller has no idea how many
> > were processed before the error.
>
> I had the same thought, but the pattern we have is that you're loading
> into a refcounted struct that will free the BOs when you're done,
> anyway.

The real bug here is if allocation of the array fails. The BO array
may be NULL when the count is not. So this V3D cleanup hunk:

for (i = 0; i < exec->bo_count; i++)
  drm_gem_object_put_unlocked(&exec->bo[i]->base.base);
  kvfree(exec->bo);

Needs to be wrapped with 'if (exec->bo)'. We have a similar problem
with fence arrays too.

Thanks to Steven for noticing this copied code in panfrost.

Rob
