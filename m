Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C28C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5F9216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 12:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbfHAMkg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 08:40:36 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55739 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730319AbfHAMkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 08:40:35 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17788023-1500050 
        for multiple; Thu, 01 Aug 2019 13:40:29 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
From:   Chris Wilson <chris@chris-wilson.co.uk>
User-Agent: alot/0.6
To:     David Airlie <airlied@linux.ie>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Eric Anholt <eric@anholt.net>,
        Eric Biggers <ebiggers@google.com>,
        Imre Deak <imre.deak@intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190717211542.30482-1-robdclark@gmail.com>
 <20190719092153.GJ15868@phenom.ffwll.local>
 <20190731192331.GT104440@art_vandelay>
In-Reply-To: <20190731192331.GT104440@art_vandelay>
Message-ID: <156466322613.6045.7313079853087889718@skylake-alporthouse-com>
Subject: Re: [PATCH] drm/vgem: fix cache synchronization on arm/arm64
Date:   Thu, 01 Aug 2019 13:40:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sean Paul (2019-07-31 20:23:31)
> On Fri, Jul 19, 2019 at 11:21:53AM +0200, Daniel Vetter wrote:
> > On Wed, Jul 17, 2019 at 02:15:37PM -0700, Rob Clark wrote:
> > > From: Rob Clark <robdclark@chromium.org>
> > > 
> > > drm_cflush_pages() is no-op on arm/arm64.  But instead we can use
> > > dma_sync API.
> > > 
> > > Fixes failures w/ vgem_test.
> > > 
> > > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > > ---
> > > An alternative approach to the series[1] I sent yesterday
> > > 
> > > On the plus side, it keeps the WC buffers and avoids any drm core
> > > changes.  On the minus side, I don't think it will work (at least
> > > on arm64) prior to v5.0[2], so the fix can't be backported very
> > > far.
> > 
> > Yeah seems a lot more reasonable.
> > 
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Applied to drm-misc-fixes, thanks!

But it didn't actually fix the failures in CI.
-Chris
