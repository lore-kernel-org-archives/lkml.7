Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2834C31E44
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 05:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B103D2189F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 05:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfFQFpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 01:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfFQFpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 01:45:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9D02C83F45;
        Mon, 17 Jun 2019 05:45:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 031907BE7A;
        Mon, 17 Jun 2019 05:45:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EB88B11AAF; Mon, 17 Jun 2019 07:45:00 +0200 (CEST)
Date:   Mon, 17 Jun 2019 07:45:00 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Sam Bobroff <sbobroff@linux.ibm.com>
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        virtualization@lists.linux-foundation.org
Subject: Re: [EXTERNAL] Re: [PATCH 1/1] drm/bochs: Fix connector leak during
 driver unload
Message-ID: <20190617054500.73am3e5yv5uzpga7@sirius.home.kraxel.org>
References: <93b363ad62f4938d9ddf3e05b2a61e3f66b2dcd3.1558416473.git.sbobroff@linux.ibm.com>
 <20190521081029.dexgf7e7d3b7wxdw@sirius.home.kraxel.org>
 <20190617012033.GA1151@tungsten.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617012033.GA1151@tungsten.ozlabs.ibm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Jun 2019 05:45:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 11:20:34AM +1000, Sam Bobroff wrote:
> On Tue, May 21, 2019 at 10:10:29AM +0200, Gerd Hoffmann wrote:
> >   Hi,
> > 
> > The bug is in the driver, so ...
> > 
> > > Bisecting the issue for commits to drivers/gpu/drm/bochs/ points to:
> > > 6579c39594ae ("drm/bochs: atomic: switch planes to atomic, wire up helpers.")
> > > ... but the issue also seems to be due to a change in the generic drm code
> > 
> > ... this one is the culprit and should be listed.
> > 
> > > (reverting it separately fixes the issue):
> > > 846c7dfc1193 ("drm/atomic: Try to preserve the crtc enabled state in drm_atomic_remove_fb, v2.")
> > > ... so I've included both in the commit.  Is that the right thing to do?
> > 
> > That only triggers the driver bug.
> > 
> > I'll fix it up on commit,
> >   Gerd
> 
> Sorry if I misunderstood, but were you going to take the patch and fix
> it up or would you like me to post a v2?

Patch is in drm-misc-next, I fixed it on commit.

cheers,
  Gerd

