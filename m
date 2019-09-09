Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F40C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C105321920
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 10:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbfIIKG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 06:06:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48224 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbfIIKGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 06:06:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56B3F3090FC2;
        Mon,  9 Sep 2019 10:06:55 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-59.ams2.redhat.com [10.36.117.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8DAA10018F8;
        Mon,  9 Sep 2019 10:06:54 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0588916E19; Mon,  9 Sep 2019 12:06:54 +0200 (CEST)
Date:   Mon, 9 Sep 2019 12:06:53 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/17] drm: add mmap() to drm_gem_object_funcs
Message-ID: <20190909100653.hyo4psakt3ccfwjk@sirius.home.kraxel.org>
References: <20190808134417.10610-1-kraxel@redhat.com>
 <20190808134417.10610-6-kraxel@redhat.com>
 <20190903094859.GQ2112@phenom.ffwll.local>
 <20190906121318.r4nvoacazvwukuun@sirius.home.kraxel.org>
 <CAKMK7uHFS8uW15NMEzN92POD2hyhkvKFgePdjgL=D-noUAkq3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHFS8uW15NMEzN92POD2hyhkvKFgePdjgL=D-noUAkq3Q@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 09 Sep 2019 10:06:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > +               vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
> > +               vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
> > +               vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
> > +       }
> 
> Totally unrelated discussion around HMM lead me to a bit a chase, and
> realizing that we probably want a
> 
>     WARN_ON(!(vma->vm_flags & VM_SPECIAL));
> 
> here, to make sure drivers set at least one of the "this is a special
> vma, don't try to treat it like pagecache/anon memory". Just to be on
> the safe side. Maybe we also want to keep the entire vma->vm_flags
> assignment in the common code, but at least the WARN_ON would be a
> good check I think. Maybe also check for VM_DONTEXPAND while at it

Hmm.  VM_SPECIAL is this:

  #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)

Requiring VM_DONTEXPAND makes sense for sure.  Dunno about the other
ones.  For drm_gem_vram_helper VM_IO + VM_PFNMAP are needed.

But we also have drm_gem_shmem_helper which backs objects with normal
pages.  In fact drm_gem_shmem_mmap does this:

	/* VM_PFNMAP was set by drm_gem_mmap() */
	vma->vm_flags &= ~VM_PFNMAP;
	vma->vm_flags |= VM_MIXEDMAP;

include/linux/mm.h isn't very helpful in explaining how VM_MIXEDMAP
should be used, only saying can be both "struct page" and pfnmap, so I'm
not sure why VM_MIXEDMAP is set here, it should always be "struct page"
for shmem, no?

cheers,
  Gerd

