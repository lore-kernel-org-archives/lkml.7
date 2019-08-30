Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5D2C3A5A4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F97A22CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567163626;
	bh=9y2VmupNH+/+qh2MlRvehZIBZ4DFy26Gs70ndhExX2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j5QtfAeWVPgRRPDwtCAj51du1MDUiG7b8qhvmV+sSN7C7aiPRRFX44X5GlUrOH750
	 dAzPX0D67uD5hPF55v+Qu+yTduRkookaQeSLV0zvu/Hkv1+Q1/mBo121b/bHkHaPrw
	 DtwYn+ATExFX1dMQAiJhpOCU2VgekzThvOabSOFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfH3LNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 07:13:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:36672 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726660AbfH3LNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 07:13:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3D05CAF11;
        Fri, 30 Aug 2019 11:13:44 +0000 (UTC)
Date:   Fri, 30 Aug 2019 13:13:43 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, adobriyan@gmail.com, cai@lca.pw,
        robin.murphy@arm.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] arm64: numa: check the node id before accessing
 node_to_cpumask_map
Message-ID: <20190830111343.GD28313@dhcp22.suse.cz>
References: <1567131991-189761-1-git-send-email-linyunsheng@huawei.com>
 <20190830055528.GO28313@dhcp22.suse.cz>
 <49b86da7-f114-27c2-463a-9bf5082ac197@huawei.com>
 <20190830064421.GS28313@dhcp22.suse.cz>
 <740cae36-f1a9-4d20-e4ea-3100076de533@huawei.com>
 <20190830083925.GV28313@dhcp22.suse.cz>
 <20839f55-dc99-d2bf-7c60-c37f38232044@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20839f55-dc99-d2bf-7c60-c37f38232044@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 17:49:46, Yunsheng Lin wrote:
> On 2019/8/30 16:39, Michal Hocko wrote:
> > On Fri 30-08-19 16:08:14, Yunsheng Lin wrote:
[...]
> >> It seems the cpumask_of_node with CONFIG_DEBUG_PER_CPU_MAPS is used
> >> to catch the erorr case and give a warning to user when node id is not
> >> valid.
> > 
> > Yeah the config help text
> > config DEBUG_PER_CPU_MAPS
> >         bool "Debug access to per_cpu maps"
> >         depends on DEBUG_KERNEL
> >         depends on SMP
> >         help
> >           Say Y to verify that the per_cpu map being accessed has
> >           been set up. This adds a fair amount of code to kernel memory
> >           and decreases performance.
> > 
> >           Say N if unsure.
> > 
> > suggests that this is intentionally hidden behind a config so a normal
> > path shouldn't really duplicate it. If those checks make sense in
> > general then the config option should be dropped I think.
> 
> It seems cpumask_of_node with CONFIG_DEBUG_PER_CPU_MAPS on may be used to
> debug some early use of cpumask_of_node problem, see below:
> 
> /*
>  * Allocate node_to_cpumask_map based on number of available nodes
>  * Requires node_possible_map to be valid.
>  *
>  * Note: cpumask_of_node() is not valid until after this is done.
>  * (Use CONFIG_DEBUG_PER_CPU_MAPS to check this.)
>  */
> static void __init setup_node_to_cpumask_map(void)
> {
> 	int node;
> 
> 	/* setup nr_node_ids if not done yet */
> 	if (nr_node_ids == MAX_NUMNODES)
> 		setup_nr_node_ids();
> 
> 	/* allocate and clear the mapping */
> 	for (node = 0; node < nr_node_ids; node++) {
> 		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
> 		cpumask_clear(node_to_cpumask_map[node]);
> 	}
> 
> 	/* cpumask_of_node() will now work */
> 	pr_debug("Node to cpumask map for %u nodes\n", nr_node_ids);
> }
> 
> So I prefer to keep it as two implementations for arm64 and x86, but
> ensure the two implementations be consistent. It can be cleaned up later
> when there is no use at all.
> 
> Is it ok with you?

I am not really sure what you are asking here TBH. You want both
CONFIG_DEBUG_PER_CPU_MAPS implementations to use the same (duplicated) code?
If that is the case then no objections from me. I would obviously
preferred a shared code but that might be a larger change indeed and can
be done later.

-- 
Michal Hocko
SUSE Labs
