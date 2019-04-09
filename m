Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7247FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D1DF20883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 06:03:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfDIGDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 02:03:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfDIGDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 02:03:24 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 245A83082291;
        Tue,  9 Apr 2019 06:03:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-65.ams2.redhat.com [10.36.116.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFEA460185;
        Tue,  9 Apr 2019 06:03:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 06C5B16E03; Tue,  9 Apr 2019 08:03:23 +0200 (CEST)
Date:   Tue, 9 Apr 2019 08:03:23 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/qxl: drop prime import/export callbacks
Message-ID: <20190409060323.xrw3fwj3yvcxsx3t@sirius.home.kraxel.org>
References: <20190110081750.11358-1-kraxel@redhat.com>
 <CAPM=9tx8N6jxVzsT-RqtQFrFb9qLK4qUUje+d=fpTYZ6+PnYpg@mail.gmail.com>
 <CAPM=9tyEmn2LXhNmPSOi7JAgBc3QZwNtM+8FT8CWebz4GztaJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyEmn2LXhNmPSOi7JAgBc3QZwNtM+8FT8CWebz4GztaJA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 09 Apr 2019 06:03:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 02:01:33PM +1000, Dave Airlie wrote:
> On Sat, 12 Jan 2019 at 07:13, Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Thu, 10 Jan 2019 at 18:17, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > Also set prime_handle_to_fd and prime_fd_to_handle to NULL,
> > > so drm will not advertive DRM_PRIME_CAP_{IMPORT,EXPORT} to
> > > userspace.
> 
> It's been pointed out to me that disables DRI3 for these devices, I'm
> not sure that is the solution we actually wanted.
> 
> any ideas?

Well.  Lets have a look at where we stand:

 * drm_gem_prime_export() works with qxl, you'll get a dma-buf handle.

 * Other drivers trying to map that dma-buf (drm_gem_map_dma_buf()
   callback) will not work, due to the ->gem_prime_get_sg_table()
   callback not being there.

 * drm_gem_prime_import() will work with buffers from the same qxl
   device, there is a shortcut for this special case.  Otherwise it
   will not work, due to the ->gem_prime_import_sg_table() callback
   not being there.

Bottom line: you can use prime to pass qxl object handles from one
application to another.  But you can't actually export/import qxl
buffer objects from/to other devices.

Problem is that we have no way to signal to userspace that prime can
be used that way.

Setting DRM_PRIME_CAP_{IMPORT,EXPORT} even though the driver can't
do that leads to other problems.  Userspace thinks it can have other
devices (intel vgpu for example) handle the rendering, then import
the rendered buffer into qxl for scanout.

Should we add something like DRM_PRIME_CAP_SAME_DEVICE?

cheers,
  Gerd

