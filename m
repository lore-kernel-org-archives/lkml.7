Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0E2C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5892086C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566221689;
	bh=hKfeHuAsZv5gzXScdBCBmBovA3PHWMaHm8gHzstZO+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XmxnGV90oiXwYhL/3vaOzsiWxjWjGPi8CqA3PG5/Cn9eK90JCanS3egkHab4ecGgP
	 cekoWR+KvgYkKwN4QisRtrvX/kUHNw8b5dT5aAaiaoYQ7fbnjicSHvB2iNVAlYTfnK
	 UMOYP0tvr6fttwzJNgEhR+WYW9Qd2MAuAu/ChI44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfHSNes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727301AbfHSNes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:34:48 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF452085A;
        Mon, 19 Aug 2019 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566221687;
        bh=hKfeHuAsZv5gzXScdBCBmBovA3PHWMaHm8gHzstZO+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAkOdid7IAxnHFy+Few0/wS0kb50BeKhhXaCcF0XKsC019eIDOW2udcMISL+o/l3R
         ytR1sMp8Nsjgu4b0yXw8FGZLKBi1JGA9RLTfRtzvlGHN6i8A6mmT35uy8k1NFnMitj
         B/nGRJ+H6Z7TWGEGUN0zll1eIQ/FKo+Nlu22qki8=
Date:   Mon, 19 Aug 2019 14:34:42 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        wsd_upstream@mediatek.com, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: kasan: fix phys_to_virt() false positive on
 tag-based kasan
Message-ID: <20190819133441.ejomv6cprdcz7hh6@willie-the-truck>
References: <20190819114420.2535-1-walter-zh.wu@mediatek.com>
 <20190819125625.bu3nbrldg7te5kwc@willie-the-truck>
 <20190819132347.GB9927@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819132347.GB9927@lakrids.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 02:23:48PM +0100, Mark Rutland wrote:
> On Mon, Aug 19, 2019 at 01:56:26PM +0100, Will Deacon wrote:
> > On Mon, Aug 19, 2019 at 07:44:20PM +0800, Walter Wu wrote:
> > > __arm_v7s_unmap() call iopte_deref() to translate pyh_to_virt address,
> > > but it will modify pointer tag into 0xff, so there is a false positive.
> > > 
> > > When enable tag-based kasan, phys_to_virt() function need to rewrite
> > > its original pointer tag in order to avoid kasan report an incorrect
> > > memory corruption.
> > 
> > Hmm. Which tree did you see this on? We've recently queued a load of fixes
> > in this area, but I /thought/ they were only needed after the support for
> > 52-bit virtual addressing in the kernel.
> 
> I'm seeing similar issues in the virtio blk code (splat below), atop of
> the arm64 for-next/core branch. I think this is a latent issue, and
> people are only just starting to test with KASAN_SW_TAGS.
> 
> It looks like the virtio blk code will round-trip a SLUB-allocated pointer from
> virt->page->virt, losing the per-object tag in the process.
> 
> Our page_to_virt() seems to get a per-page tag, but this only makes
> sense if you're dealing with the page allocator, rather than something
> like SLUB which carves a page into smaller objects giving each object a
> distinct tag.
> 
> Any round-trip of a pointer from SLUB is going to lose the per-object
> tag.

Urgh, I wonder how this is supposed to work?

If we end up having to check the KASAN shadow for *_to_virt(), then why
do we need to store anything in the page flags at all? Andrey?

Will
