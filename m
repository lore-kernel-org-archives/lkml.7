Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E877DC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE56421823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BxzFDejE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfLFKHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:07:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53899 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726102AbfLFKHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575626851;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wc1Uv6Nj7IUv6CX0rM0U3pEdROrdD6V3JPm9xjrxf2s=;
        b=BxzFDejEJcZGsF+SZFlnJqQBxChvKaJufogYLXDJpYE8SE4bSRnifFpRBHMXR5rmBJWO6F
        ZuSPbCg7G43avF54j7npeaMccQI9PHIqQhx3bZa9ZDkabdi7Gyvu+iQhRogaeBK68IaFYB
        fx1+XNJI9EeeT846TYSM0vSNFaJdUDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-CmzEfi7tP9evyYLm71Htdg-1; Fri, 06 Dec 2019 05:07:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E96A0107ACC4;
        Fri,  6 Dec 2019 10:07:25 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4CD15D6A3;
        Fri,  6 Dec 2019 10:07:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D155616E18; Fri,  6 Dec 2019 11:07:24 +0100 (CET)
Date:   Fri, 6 Dec 2019 11:07:24 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, robh@kernel.org,
        intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drm: call drm_gem_object_funcs.mmap with fake
 offset
Message-ID: <20191206100724.ukzdyaym3ltcyfaa@sirius.home.kraxel.org>
References: <20191127092523.5620-1-kraxel@redhat.com>
 <20191127092523.5620-2-kraxel@redhat.com>
 <20191128113930.yhckvneecpvfhlls@sirius.home.kraxel.org>
 <20191205221523.GN624164@phenom.ffwll.local>
MIME-Version: 1.0
In-Reply-To: <20191205221523.GN624164@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: CmzEfi7tP9evyYLm71Htdg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 11:15:23PM +0100, Daniel Vetter wrote:
> On Thu, Nov 28, 2019 at 12:39:30PM +0100, Gerd Hoffmann wrote:
> > On Wed, Nov 27, 2019 at 10:25:22AM +0100, Gerd Hoffmann wrote:
> > > The fake offset is going to stay, so change the calling convention fo=
r
> > > drm_gem_object_funcs.mmap to include the fake offset.  Update all use=
rs
> > > accordingly.
> > >=20
> > > Note that this reverts 83b8a6f242ea ("drm/gem: Fix mmap fake offset
> > > handling for drm_gem_object_funcs.mmap") and on top then adds the fak=
e
> > > offset to  drm_gem_prime_mmap to make sure all paths leading to
> > > obj->funcs->mmap are consistent.
> > >=20
> > > v3: move fake-offset tweak in drm_gem_prime_mmap() so we have this co=
de
> > >     only once in the function (Rob Herring).
> >=20
> > Now this series fails in Intel CI.  Can't see why though.  The
> > difference between v2 and v3 is just the place where vma->vm_pgoff gets
> > updated, and no code between the v2 and v3 location touches vma ...
>=20
> Looks like unrelated flukes, this happens occasionally. If you're paranoi=
d
> hit the retest button on patchwork to double-check.
> -Daniel

Guess you kicked CI?  Just got CI mails, now reporting success, without
doing anything.  So I'll go push v3 to misc-next.

cheers,
  Gerd

