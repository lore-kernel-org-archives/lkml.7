Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B550C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8C121473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 07:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfDCHWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 03:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfDCHWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 03:22:41 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 56CEB88AA2;
        Wed,  3 Apr 2019 07:22:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B623760FE5;
        Wed,  3 Apr 2019 07:22:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 016B11750B; Wed,  3 Apr 2019 09:22:38 +0200 (CEST)
Date:   Wed, 3 Apr 2019 09:22:38 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev: list all pci memory bars as conflicting apertures
Message-ID: <20190403072238.76gwp6rfumgqiely@sirius.home.kraxel.org>
References: <CGME20190314114511epcas2p2a9669714177b00989bd3195300f7d3a6@epcas2p2.samsung.com>
 <20190314114500.8336-1-kraxel@redhat.com>
 <33cf37dc-8456-0316-0b48-fca7c92caa28@samsung.com>
 <CAKMK7uEs+OaoiEmd9Dp6K_v5Pz4pf197DP8KFkvhNMYXv9tYxA@mail.gmail.com>
 <20190402204325.cqu7fobzekd3ccls@sirius.home.kraxel.org>
 <CAKMK7uHLY1RKUGbqDeHTNnx98y-FLhGWKGcG-o9KDH54=BObAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHLY1RKUGbqDeHTNnx98y-FLhGWKGcG-o9KDH54=BObAg@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Apr 2019 07:22:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 08:48:16AM +0200, Daniel Vetter wrote:
> On Tue, Apr 2, 2019 at 10:43 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Tue, Apr 02, 2019 at 02:09:45PM +0200, Daniel Vetter wrote:
> > > On Mon, Apr 1, 2019 at 4:00 PM Bartlomiej Zolnierkiewicz
> > > <b.zolnierkie@samsung.com> wrote:
> > > >
> > > >
> > > > On 03/14/2019 12:45 PM, Gerd Hoffmann wrote:
> > > > > Simply add all pci memory bars to struct apertures_struct in
> > > > > remove_conflicting_pci_framebuffers(), without depending on the
> > > > > res_id parameter.
> > > > >
> > > > > The plan is to drop the res_id parameter later on.  For now keep the
> > > > > parameter, use it for sanity-checking and warn on inconsistencies.
> > > > >
> > > > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > > > > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > >
> > > > Patch queued for v5.2, thanks.
> > >
> > > Might be good to also stuff this into drm (double merge or topic
> > > branch, whatever you prefer), since that's where all the users are.
> > > Gerd also has some follow-up patches to apply on top of this one iirc.
> >
> > No follow-up patches yet.  Plan is to wait a bit, see if the
> > sanity-checks trigger, and if all goes well go drop the res_id
> > parameter in 5.3 ...
> 
> Hm I thought you had a patch to convert i915 over. Or did that land already?

Ah, *that* one.  Yep, that is still sitting in a branch here.  Didn't
rebase it yet.  But I suspect it will be easier to first drop res_id
and then rebase the i915 patch on top of *that*, so I don't have to
figure which i915 revision needs which res_id ...

cheers,
  Gerd

