Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B465DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C24C2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfDDL6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:58:20 -0400
Received: from nat.nue.novell.com ([195.135.221.2]:34277 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727039AbfDDL6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:58:19 -0400
Received: by suse.de (Postfix, from userid 1000)
        id BC97B4812; Thu,  4 Apr 2019 13:58:18 +0200 (CEST)
Date:   Thu, 4 Apr 2019 13:58:18 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, will.deacon@arm.com,
        catalin.marinas@arm.com, mhocko@suse.com,
        mgorman@techsingularity.net, james.morse@arm.com,
        mark.rutland@arm.com, cpandya@codeaurora.org,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        logang@deltatee.com, pasha.tatashin@oracle.com, david@redhat.com,
        cai@lca.pw, Steven Price <steven.price@arm.com>
Subject: Re: [PATCH 2/6] arm64/mm: Enable memory hot remove
Message-ID: <20190404115815.gzk3sgg34eofyxfv@d104.suse.de>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-3-git-send-email-anshuman.khandual@arm.com>
 <ed4ceac4-b92c-47f4-33b0-ed1d0833b40d@arm.com>
 <55278a57-39bc-be27-5999-81d0da37b746@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55278a57-39bc-be27-5999-81d0da37b746@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 11:09:22AM +0530, Anshuman Khandual wrote:
> > Do these need to be __meminit? AFAICS it's effectively redundant with the containing #ifdef, and removal feels like it's inherently a later-than-init thing anyway.
> 
> I was confused here a bit but even X86 does exactly the same. All these functions
> are still labeled __meminit and all wrapped under CONFIG_MEMORY_HOTPLUG. Is there
> any concern to have __meminit here ?

We do not really need it as long as the code is within #ifdef CONFIG_MEMORY_HOTPLUG.
__meminit is being used when functions that are going to be need for hotplug need
to stay around.

/* Used for MEMORY_HOTPLUG */
#define __meminit        __section(.meminit.text) __cold notrace \
                                                  __latent_entropy

#if defined(CONFIG_MEMORY_HOTPLUG)
#define MEM_KEEP(sec)    *(.mem##sec)
#define MEM_DISCARD(sec)
#else
#define MEM_KEEP(sec)
#define MEM_DISCARD(sec) *(.mem##sec)
#endif

So it is kind of redundant to have both.
I will clean it up when reposting [1] and [2].

[1] https://patchwork.kernel.org/patch/10875019/
[2] https://patchwork.kernel.org/patch/10875021/

-- 
Oscar Salvador
SUSE L3
