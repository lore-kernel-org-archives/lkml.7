Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAE2C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA4C217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389911AbfHHKVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:21:01 -0400
Received: from foss.arm.com ([217.140.110.172]:59406 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389773AbfHHKVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:21:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EF2428;
        Thu,  8 Aug 2019 03:21:00 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37F123F694;
        Thu,  8 Aug 2019 03:20:58 -0700 (PDT)
Date:   Thu, 8 Aug 2019 11:20:53 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rob Clark <robdclark@chromium.org>,
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
Message-ID: <20190808102053.GA46901@lakrids.cambridge.arm.com>
References: <20190805211451.20176-1-robdclark@gmail.com>
 <20190806084821.GA17129@lst.de>
 <CAJs_Fx6eh1w7c=crMoD5XyEOMzP6orLhqUewErE51cPGYmObBQ@mail.gmail.com>
 <20190806143457.GF475@lakrids.cambridge.arm.com>
 <CAJs_Fx4h6SWGmDTLBnV4nmWUFAs_Ge1inxd-dW9aDKgKqmc1eQ@mail.gmail.com>
 <20190807123807.GD54191@lakrids.cambridge.arm.com>
 <CAJs_Fx5xU2-dn3iOVqWTzAjpTaQ8BBNP_Gn_iMc-eJpOX+iXoQ@mail.gmail.com>
 <20190807164958.GA44765@lakrids.cambridge.arm.com>
 <20190808075827.GD30308@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190808075827.GD30308@lst.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 09:58:27AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 07, 2019 at 05:49:59PM +0100, Mark Rutland wrote:
> > For arm64, we can tear down portions of the linear map, but that has to
> > be done explicitly, and this is only possible when using rodata_full. If
> > not using rodata_full, it is not possible to dynamically tear down the
> > cacheable alias.
> 
> Interesting.  For this or next merge window I plan to add support to the
> generic DMA code to remap pages as uncachable in place based on the
> openrisc code.  Aѕ far as I can tell the requirement for that is
> basically just that the kernel direct mapping doesn't use PMD or bigger
> mapping so that it supports changing protection bits on a per-PTE basis.
> Is that the case with arm64 + rodata_full?

Yes, with the added case that on arm64 we can also have contiguous
entries at the PTE level, which we also have to disable.

Our kernel page table creation code does that for rodata_full or
DEBUG_PAGEALLOC. See arch/arm64/mmu.c, in map_mem(), where we pass
NO_{BLOCK,CONT}_MAPPINGS down to our pagetable creation code.

Thanks,
Mark.
