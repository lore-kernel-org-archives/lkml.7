Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3632C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5CE218B8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 07:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbfHHH6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 03:58:32 -0400
Received: from verein.lst.de ([213.95.11.211]:44262 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731588AbfHHH6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 03:58:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3D39168B02; Thu,  8 Aug 2019 09:58:27 +0200 (CEST)
Date:   Thu, 8 Aug 2019 09:58:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Rob Clark <robdclark@chromium.org>, Christoph Hellwig <hch@lst.de>,
        Rob Clark <robdclark@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drm: add cache support for arm64
Message-ID: <20190808075827.GD30308@lst.de>
References: <20190805211451.20176-1-robdclark@gmail.com> <20190806084821.GA17129@lst.de> <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com> <20190806143457.GF475@lakrids.cambridge.arm.com> <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com> <20190807123807.GD54191@lakrids.cambridge.arm.com> <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com> <20190807164958.GA44765@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190807164958.GA44765@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:49:59PM +0100, Mark Rutland wrote:
> I'm fairly confident that the linear/direct map cacheable alias is not
> torn down when pages are allocated. The gneeric page allocation code
> doesn't do so, and I see nothing the shmem code to do so.

It is not torn down anywhere.

> For arm64, we can tear down portions of the linear map, but that has to
> be done explicitly, and this is only possible when using rodata_full. If
> not using rodata_full, it is not possible to dynamically tear down the
> cacheable alias.

Interesting.  For this or next merge window I plan to add support to the
generic DMA code to remap pages as uncachable in place based on the
openrisc code.  Aѕ far as I can tell the requirement for that is
basically just that the kernel direct mapping doesn't use PMD or bigger
mapping so that it supports changing protection bits on a per-PTE basis.
Is that the case with arm64 + rodata_full?

> > My understanding is that a cacheable alias is "ok", with some
> > caveats.. ie. that the cacheable alias is not accessed.  
> 
> Unfortunately, that is not true. You'll often get away with it in
> practice, but that's a matter of probability rather than a guarantee.
> 
> You  cannot prevent a CPU from accessing a VA arbitrarily (e.g. as the
> result of wild speculation). The ARM ARM (ARM DDI 0487E.a) points this
> out explicitly:

Well, if we want to fix this properly we'll have to remap in place
for dma_alloc_coherent and friends.
