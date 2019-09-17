Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D91C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F6B20862
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbfIQIOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:14:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfIQIOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE6373082B1F;
        Tue, 17 Sep 2019 08:14:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F14F60BF7;
        Tue, 17 Sep 2019 08:14:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D17C317444; Tue, 17 Sep 2019 10:14:48 +0200 (CEST)
Date:   Tue, 17 Sep 2019 10:14:48 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Sean Paul <sean@poorly.run>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Subject: Re: [PATCH 2/8] drm/shmem: switch shmem helper to
 &drm_gem_object_funcs.mmap
Message-ID: <20190917081448.zonghnqa4aoc4bmp@sirius.home.kraxel.org>
References: <20190913122908.784-1-kraxel@redhat.com>
 <20190913122908.784-3-kraxel@redhat.com>
 <197fdced-cf4a-c59a-47fd-aa5dbf8e04a2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <197fdced-cf4a-c59a-47fd-aa5dbf8e04a2@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 17 Sep 2019 08:14:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > -	/* VM_PFNMAP was set by drm_gem_mmap() */
> > -	vma->vm_flags &= ~VM_PFNMAP;
> > -	vma->vm_flags |= VM_MIXEDMAP;
> > +	vma->vm_flags |= (VM_MIXEDMAP|VM_DONTEXPAND);
> 
> I'm finding this a bit hard to follow - but I think here we've lost
> VM_IO and VM_DONTDUMP which used to be set by drm_gem_mmap().

Yep.  Intentional, but I think I better split that off to a separate
patch with a commit message explaining things.

> Also it looks like nothing is fiddling vma->vm_page_prot anymore.

Oops, that one was not intentional.  Will fix.

cheers,
  Gerd

