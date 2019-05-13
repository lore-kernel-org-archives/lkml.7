Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F38C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F9F2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfEMQqk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:46:40 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:61776 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728347AbfEMQqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:46:39 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16543216-1500050 
        for multiple; Mon, 13 May 2019 17:46:32 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Daniel Vetter <daniel@ffwll.ch>,
        Steven Price <steven.price@arm.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <0b7f0b7f-3e14-f5bb-368a-08037c2a8529@arm.com>
Cc:     David Airlie <airlied@linux.ie>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
References: <20190513143244.16478-1-steven.price@arm.com>
 <20190513143921.GP17751@phenom.ffwll.local>
 <155775884217.2165.11223399053598674062@skylake-alporthouse-com>
 <0b7f0b7f-3e14-f5bb-368a-08037c2a8529@arm.com>
Message-ID: <155776599144.2165.15056323416635154840@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] drm/panfrost: Use drm_gem_dump_map_offset()
Date:   Mon, 13 May 2019 17:46:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Price (2019-05-13 16:14:01)
> On 13/05/2019 15:47, Chris Wilson wrote:
> > Quoting Daniel Vetter (2019-05-13 15:39:21)
> >> On Mon, May 13, 2019 at 03:32:44PM +0100, Steven Price wrote:
> >>> panfrost_ioctl_mmap_bo() contains a reimplementation of
> >>> drm_gem_dump_map_offset() but with a bug - it allows mapping imported
> >>> objects (without going through the exporter). Fix this by switching to
> >>> use the generic drm_gem_dump_map_offset() function instead which has the
> >>> bonus of simplifying the code.
> >>
> >> gem_dumb stuff is for kms drivers, panfrost is a render driver. We're
> >> generally trying to separate these two worlds somewhat cleanly.
> >>
> >> I think it'd be good to have a non-dumb version of this in the core, and
> >> use that. Or upgrade the dumb version to be that helper for everyone (and
> >> drop the _dumb).
> 
> I'm slightly confused by what you think is the best course of action here.
> 
> I can create a patch dropping the '_dumb' from drm_gem_dump_map_offset()
> if that's the objection. Or do you want a helper function with two
> callers (the 'dump' and the 'shmem' versions)?
> 
> > More specifically, since panfrost is using the drm_gem_shmem helper and
> > vm_ops, it too can provide the wrapper as it is the drm_gem_shmem layer
> > that implies that trying to mmap an imported object is an issue as that
> > is not a universal problem.
> mmap'ing an imported object isn't a problem as such. But rather than
> going behind the exporter's back we would need to call dma_buf_mmap() to
> ensure that the exporter can do whatever is necessary.
> 
> I could add a wrapper in drm_gem_shmem_helper, but I'm not sure what the
> benefit of a wrapper here is?

No, my point is that the pagefaulting is being provided by drm_gem_shmem
and that is relying on direct access to struct page, hence that is
imposing the restriction that it can only handle its own shmem objects.
The driver should not guess the helper, but ask the helper if it can
perform an mmap of this object, and since this object is not an shmem
object it will say no.

Different drivers can use their HW to fault in indirect access to dmabuf
(treating the dmabuf as a conveyance of a sglist and not struct page)
and so do not need to different/reject foreign objects from their
specialised mmap routines and are oblivious to them.
-Chris
