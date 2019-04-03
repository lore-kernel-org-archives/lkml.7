Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFA6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAD7206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 16:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDCQHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 12:07:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42583 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbfDCQHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 12:07:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 478CB88AAE;
        Wed,  3 Apr 2019 16:07:31 +0000 (UTC)
Received: from redhat.com (ovpn-125-190.rdu2.redhat.com [10.10.125.190])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF99B608A5;
        Wed,  3 Apr 2019 16:07:24 +0000 (UTC)
Date:   Wed, 3 Apr 2019 12:07:22 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, mhocko@suse.com,
        mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com, osalvador@suse.de,
        logang@deltatee.com, david@redhat.com, cai@lca.pw
Subject: Re: [PATCH 6/6] arm64/mm: Enable ZONE_DEVICE
Message-ID: <20190403160722.GB12818@redhat.com>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-7-git-send-email-anshuman.khandual@arm.com>
 <ea5567c7-caad-8a4e-7c6f-cec4b772a526@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ea5567c7-caad-8a4e-7c6f-cec4b772a526@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Apr 2019 16:07:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 02:58:28PM +0100, Robin Murphy wrote:
> [ +Dan, Jerome ]
> 
> On 03/04/2019 05:30, Anshuman Khandual wrote:
> > Arch implementation for functions which create or destroy vmemmap mapping
> > (vmemmap_populate, vmemmap_free) can comprehend and allocate from inside
> > device memory range through driver provided vmem_altmap structure which
> > fulfils all requirements to enable ZONE_DEVICE on the platform. Hence just
> 
> ZONE_DEVICE is about more than just altmap support, no?
> 
> > enable ZONE_DEVICE by subscribing to ARCH_HAS_ZONE_DEVICE. But this is only
> > applicable for ARM64_4K_PAGES (ARM64_SWAPPER_USES_SECTION_MAPS) only which
> > creates vmemmap section mappings and utilize vmem_altmap structure.
> 
> What prevents it from working with other page sizes? One of the foremost
> use-cases for our 52-bit VA/PA support is to enable mapping large quantities
> of persistent memory, so we really do need this for 64K pages too. FWIW, it
> appears not to be an issue for PowerPC.
> 
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> >   arch/arm64/Kconfig | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index db3e625..b5d8cf5 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -31,6 +31,7 @@ config ARM64
> >   	select ARCH_HAS_SYSCALL_WRAPPER
> >   	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
> >   	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
> > +	select ARCH_HAS_ZONE_DEVICE if ARM64_4K_PAGES
> 
> IIRC certain configurations (HMM?) don't even build if you just turn this on
> alone (although of course things may have changed elsewhere in the meantime)
> - crucially, though, from previous discussions[1] it seems fundamentally
> unsafe, since I don't think we can guarantee that nobody will touch the
> corners of ZONE_DEVICE that also require pte_devmap in order not to go
> subtly wrong. I did get as far as cooking up some patches to sort that out
> [2][3] which I never got round to posting for their own sake, so please
> consider picking those up as part of this series.

Correct _do not_ enable ZONE_DEVICE without support for pte_devmap detection.
If you want some feature of ZONE_DEVICE. Like HMM as while DAX does require
pte_devmap, HMM device private does not. So you would first have to split
ZONE_DEVICE into more sub-features kconfig option.

What is the end use case you are looking for ? Persistent memory ?

Cheers,
Jérôme
