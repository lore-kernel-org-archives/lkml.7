Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963E1C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F97A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfD2HyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:54:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727498AbfD2HyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:54:15 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5AD6F309266F;
        Mon, 29 Apr 2019 07:54:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D21FD600C2;
        Mon, 29 Apr 2019 07:54:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F157311AAA; Mon, 29 Apr 2019 09:54:13 +0200 (CEST)
Date:   Mon, 29 Apr 2019 09:54:13 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>
Subject: Re: [Spice-devel] [PATCH] Revert "drm/qxl: drop prime import/export
 callbacks"
Message-ID: <20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org>
References: <20190426053324.26443-1-kraxel@redhat.com>
 <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Mon, 29 Apr 2019 07:54:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 04:21:37PM +0200, Daniel Vetter wrote:
> On Fri, Apr 26, 2019 at 7:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > This reverts commit f4c34b1e2a37d5676180901fa6ff188bcb6371f8.
> >
> > Simliar to commit a0cecc23cfcb Revert "drm/virtio: drop prime
> > import/export callbacks".  We have to do the same with qxl,
> > for the same reasons (it breaks DRI3).
> >
> > Drop the WARN_ON_ONCE().
> >
> > Fixes: f4c34b1e2a37d5676180901fa6ff188bcb6371f8
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Maybe we need some helpers for virtual drivers which only allow
> self-reimport and nothing else at all?

The current gem prime helpers handle this reasonable well,
I don't see a need for that.

More useful would be some way to signal this self-reimport capability
to userspace somehow.  See DRM_PRIME_CAP_LOCAL patch.

Right now I have the choice to set DRM_PRIME_CAP_{IMPORT,EXPORT}, in
which case some userspace assumes it can do cross-driver export/import
and trips over that not working.  Or I do not set
DRM_PRIME_CAP_{IMPORT,EXPORT}, which breaks DRI3 ...

> I think there's qxl, virgl,

export is implemented for virgl, and import should be possible too.

qxl/bochs is simliar to vmgfx, it could be done but dma-bufs would
basically be bounce buffers (need copy from/to vram) so probably not
worth the effort.

cheers,
  Gerd

