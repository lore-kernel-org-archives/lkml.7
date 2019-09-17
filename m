Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C6C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A0B21670
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731009AbfIQIe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:34:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfIQIe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:34:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE30A8980E0;
        Tue, 17 Sep 2019 08:34:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D2571001281;
        Tue, 17 Sep 2019 08:34:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5B01B17444; Tue, 17 Sep 2019 10:34:25 +0200 (CEST)
Date:   Tue, 17 Sep 2019 10:34:25 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH 4/8] drm/ttm: factor out ttm_bo_mmap_vma_setup
Message-ID: <20190917083425.kwwqyn463gn3mghf@sirius.home.kraxel.org>
References: <20190913122908.784-1-kraxel@redhat.com>
 <20190913122908.784-5-kraxel@redhat.com>
 <88d5a253-ef9e-c998-6353-5ba8680129f2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88d5a253-ef9e-c998-6353-5ba8680129f2@suse.de>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Tue, 17 Sep 2019 08:34:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2019 at 03:05:34PM +0200, Thomas Zimmermann wrote:

> > +void ttm_bo_mmap_vma_setup(struct ttm_buffer_object *bo, struct vm_area_struct *vma)
> > +{
> > +	vma->vm_ops = &ttm_bo_vm_ops;
> > +
> > +	/*
> > +	 * Note: We're transferring the bo reference to
> > +	 * vma->vm_private_data here.
> > +	 */
> > +
> > +	vma->vm_private_data = bo;
> > +
> > +	/*
> > +	 * We'd like to use VM_PFNMAP on shared mappings, where
> > +	 * (vma->vm_flags & VM_SHARED) != 0, for performance reasons,
> > +	 * but for some reason VM_PFNMAP + x86 PAT + write-combine is very
> > +	 * bad for performance. Until that has been sorted out, use
> > +	 * VM_MIXEDMAP on all mappings. See freedesktop.org bug #75719
> > +	 */
> > +	vma->vm_flags |= VM_MIXEDMAP;
> > +	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
> > +}
> > +EXPORT_SYMBOL(ttm_bo_mmap_vma_setup);
> 
> To me, this function looks like an internal helper that should rather
> remain internal.

Well, I'm moving that to a helper exactly to avoid drm gem ttm helpers
messing with ttm internals.  To not them initialize vm_flags for
example, and to avoid exporting ttm_bo_vm_ops.  Also to make sure ttm bo
vma's are initialized the same way no matter which code path was taken
to mmap the object.

> As mentioned in my reply to patch 5, maybe re-using
> ttm_fbdev_mmap() could help.

No, the check in that function prevents that from working.

cheers,
  Gerd

