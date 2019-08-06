Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69557C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA7020717
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732793AbfHFLiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:38:54 -0400
Received: from verein.lst.de ([213.95.11.211]:55736 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfHFLix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:38:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B5702227A81; Tue,  6 Aug 2019 13:38:48 +0200 (CEST)
Date:   Tue, 6 Aug 2019 13:38:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>, Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190806113848.GB20215@lst.de>
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de> <20190806093816.GY7444@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806093816.GY7444@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 11:38:16AM +0200, Daniel Vetter wrote:
> I just read through all the arch_sync_dma_for_device/cpu functions and
> none seem to use the struct *dev argument. Iirc you've said that's on the
> way out?

Not actively on the way out yet, but now that we support all
architectures it becomes pretty clear we don't need it.  So yes, we
could eventually remove it.  But..

> That dev parameter is another holdup for the places where we do not yet
> know what the new device will be (e.g. generic dma-buf exporters like
> vgem). And sprinkling a fake dev or passing NULL is a bit silly.

This is where it becomes interesting.  Because while we don't need the
dev argument for the low-level arch API, we do need it at the driver
API level, given that in some systems both dma coherent and non-coherent
devices exist, and we need to decide based on that.

> Add a HAVE_ARCH_SYNC_DMA and the above refactor (assuming it's ok to roll
> out everywhere) and we should indeed be able to use this. We still need to
> have all the others for x86 and all that. Plus I guess we should roll out
> the split into invalidate and flush.

Well, we'll still need a defined API for buffer ownership vs device.
Just exporting arch_sync_dma_for_{device,cpu} is not the right
abstraction level.  Note that these two functions are always present,
just stubbed out for architectures that do not support non-cache
coherent devices (plus the arm false negative that is easily fixable).
