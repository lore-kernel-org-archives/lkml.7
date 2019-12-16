Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE22C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 982B620700
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 08:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aM9lg7kO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfLPIH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 03:07:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20885 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbfLPIH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 03:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576483647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MChTIXWynUE7agqmCTTzipxpECKLcpr2EozeeZ4no+M=;
        b=aM9lg7kOshO4rxZ5fVeIpYAfUjohH81RkXwzX5P2Bn9KzNC8OyMzag6YwBO8RQh/hlwdSn
        5D9RbJyD3hM2OEVQnQdTDqOZF5nuqk0dC/9UtOIJuNw68j+Ndc+vpRNXvydb5NW3uVdYG1
        /8hTEcZRzGsqHdiP8fpH6aE/oGh8h+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-hDeFmvPqPzq69MVWDW9Clg-1; Mon, 16 Dec 2019 03:07:21 -0500
X-MC-Unique: hDeFmvPqPzq69MVWDW9Clg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B39E01800D7B;
        Mon, 16 Dec 2019 08:07:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.36.118.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 30B4B26190;
        Mon, 16 Dec 2019 08:07:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3DF82783F; Mon, 16 Dec 2019 09:07:19 +0100 (CET)
Date:   Mon, 16 Dec 2019 09:07:19 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org
Subject: Re: [PATCH v2 1/2] drm/shmem: add support for per object caching
 attributes
Message-ID: <20191216080719.2ahwtraxofydb2db@sirius.home.kraxel.org>
References: <20191211081810.20079-1-kraxel@redhat.com>
 <20191211081810.20079-2-kraxel@redhat.com>
 <0b64e917-48f7-487e-9335-2838b6c62808@suse.de>
 <ed9142da-ce10-7df2-8a85-ba9ad0c26551@suse.de>
 <20191211123635.GY624164@phenom.ffwll.local>
 <20191211131830.iz3a2o4xzmmkjsp7@sirius.home.kraxel.org>
 <20191213095959.GA624164@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213095959.GA624164@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > I suspect for imported dma-bufs we should leave the mmap() to the
> > exporter instead of pulling the pages out of the sgt and map them
> > ourself.
> 
> Uh yes. If we still do that, then yes very much we shouldn't.

Looking again.  drm_gem_dumb_map_offset() throws an error in case
obj->import_attach is not NULL.  So the udl mmap code should not see
imported buffers in the first place, unless I missed some detail ...

> > Hmm.  Ok.  I guess I'm not going to try solve all that properly just for
> > the little virtio fix.
> > 
> > Just curious:  How do you tell your hardware?  Are there bits for that
> > in the gtt, simliar to the caching bits in the x86 page tables?
> 
> Brace for contact ...
> 
> - on amdgpu it's a bit in the gpu pagetable. I think (but not sure, not an
>   expert on these chips) that's the only way.
> 
> - on i915 it's a also a bit in the gpu pagetables, but userspace can
>   override the caching/coherency mode on a per-texture/render target/*BO
>   level in the command stream.
> 
> This is why gpus and dma-api don't mix well, since dma-api's goal is to
> hide all this even from the driver. gpus otoh leak it all the way to
> userspace. The trouble is as old as AGP from 1999 or so, I've become
> somewhat cynic at trying to fix this for real and not just with hacks. The
> disconnect between what we need and what dma-api kernel people want to
> give us is too big to bridge it seems.

Phew.  For vulkan support in virtio-gpu we are going to throw virtual
machines into that mix.  Fun ahead I guess ...

cheers,
  Gerd

