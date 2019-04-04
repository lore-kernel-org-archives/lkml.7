Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9986AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7228420855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfDDPT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:19:27 -0400
Received: from charybdis-ext.suse.de ([195.135.221.2]:19580 "EHLO suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726694AbfDDPT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:19:27 -0400
Received: by suse.de (Postfix, from userid 1000)
        id CB30D481E; Thu,  4 Apr 2019 17:19:25 +0200 (CEST)
Date:   Thu, 4 Apr 2019 17:19:25 +0200
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
Message-ID: <20190404151923.2zmf25wnwevb3dlh@d104.suse.de>
References: <1554265806-11501-1-git-send-email-anshuman.khandual@arm.com>
 <1554265806-11501-3-git-send-email-anshuman.khandual@arm.com>
 <ed4ceac4-b92c-47f4-33b0-ed1d0833b40d@arm.com>
 <55278a57-39bc-be27-5999-81d0da37b746@arm.com>
 <20190404115815.gzk3sgg34eofyxfv@d104.suse.de>
 <0c2b5096-a6df-b4ac-ac3b-3fec274837d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2b5096-a6df-b4ac-ac3b-3fec274837d3@arm.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 06:33:09PM +0530, Anshuman Khandual wrote:
> Sure. Will remove them from the proposed functions next time around.

Just need to make sure that the function is not calling directly or indirectly
another __meminit function, then it is safe to remove it.

E.g: 

sparse_add_one_section() is wrapped around CONFIG_MEMORY_HOTPLUG, but the
__meminit must stay because it calls sparse_index_init(),
sparse_init_one_section() and sparse_mem_map_populate(), all three marked as
__meminit because they are also used out of hotplug scope, during early boot.

-- 
Oscar Salvador
SUSE L3
