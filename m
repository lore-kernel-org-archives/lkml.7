Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBDEC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D174217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfIBMhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:37:51 -0400
Received: from foss.arm.com ([217.140.110.172]:53444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbfIBMhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:37:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50E27337;
        Mon,  2 Sep 2019 05:37:50 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31B413F246;
        Mon,  2 Sep 2019 05:37:49 -0700 (PDT)
Date:   Mon, 2 Sep 2019 13:37:44 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthew Leach <matthew.leach@arm.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: use x22 to save boot exception level
Message-ID: <20190902123601.GA8488@lakrids.cambridge.arm.com>
References: <20190828173318.12428-1-afd@ti.com>
 <20190829094720.GA44575@lakrids.cambridge.arm.com>
 <511d200c-9294-e562-5ba5-4f061965395d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <511d200c-9294-e562-5ba5-4f061965395d@ti.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2019 at 03:23:53PM -0400, Andrew F. Davis wrote:
> On 8/29/19 5:47 AM, Mark Rutland wrote:
> > On Wed, Aug 28, 2019 at 01:33:18PM -0400, Andrew F. Davis wrote:

> We are seeing is a write-back from L3 cache. Our bootloader writes the
> kernel image with caches on, then after turning off caching but before
> handing off to Linux it clean/invalidates all cache lines by set/way.
> This cleans out the L1/L2 but leaves dirty lines in L3. Our platform
> doesn't really have a good way to clean L3 as it only provides cache
> maintenance operations by VA, not by line, so we would need to clean
> every VA address manually..

Ensuring that the Image is clean to the PoC is required by the arm64
boot protocol, which states that maintenance by VA may be necessary in
the presence of a system cache. See:

https://www.kernel.org/doc/html/latest/arm64/booting.html

... which states:

| The MMU must be off. Instruction cache may be on or off. The address
| range corresponding to the loaded kernel image must be cleaned to the
| PoC. In the presence of a system cache or other coherent masters with
| caches enabled, this will typically require cache maintenance by VA
| rather than set/way operations. 

Please fix your bootloader to meet this requirement. The kernel is not
in a position to fix this up, e.g. as while the MMU is off instruction
fetches could fetch stale data from the PoC.

You only need to clean the kernel Image to the PoC, rather than all of
memory, so you should be able to do that with a loop of DC CVAC
instructions covering the VA range of the kernel Image.

> Also want to point out, although this isn't a problem for most platforms
> what this code does here, with writing to a location as non-cacheable,
> is not architecturally safe as the running cores that do the reads have
> this section marked as cacheable when they read, therefor you have
> mismatched attributes. When this happens like this according to the ARM
> ARM we should do a cache invalidate after the write *and* before the
> 
> I would like to work this fix from the U-Boot side also, but in parallel
> I would like to reduce the mismatched attributes as much as possible on
> the kernel side like done here. So yes, we still will have issue with
> __early_cpu_boot_status, but that only seems to be needed in the failure
> to boot case, I'd like to fix that up as well at some later point.

If you haven't cleaned the Image to the PoC, there's no guarantee that
any portion of it can be safely executed with the MMU off, so I don't
think that makes sense -- please fix your bootloader first.

I am aware that there are potential problems with mismatched attributes,
the primary issue here being unexpected-data-cache-hit. However, were
that to occur no amount of cache maintenance can save us in the presence
of a live cacheable alias. Practically speaking that's mainly a problem
for virtual environments.

Thanks,
Mark.
