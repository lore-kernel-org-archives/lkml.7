Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE092C3A5A3
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E4321874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 06:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567147465;
	bh=BsUr4iBWGVaf2/vVb/vySdKrATJctRsS2mv3PL5m3cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vpHye/T4m4GBb4w8VuyzoPLXX8Ufh6GqXzDOF5vXWu4pQ1GKF/tm3hBs8ndIdkO2o
	 FkHLaXLBj4tlg13NWn/NSM+GX+obe8cQQsTLYVtA2uJ0IPr5RuNT4qQAJtWDgSrKz1
	 /+TwNu95ZLmIFMfGoLMOR8U5yY+EyRkRPFSTvf4A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbfH3GoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 02:44:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:47740 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726510AbfH3GoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 02:44:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 48227ABC4;
        Fri, 30 Aug 2019 06:44:22 +0000 (UTC)
Date:   Fri, 30 Aug 2019 08:44:21 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, rppt@linux.ibm.com,
        anshuman.khandual@arm.com, adobriyan@gmail.com, cai@lca.pw,
        robin.murphy@arm.com, tglx@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH] arm64: numa: check the node id before accessing
 node_to_cpumask_map
Message-ID: <20190830064421.GS28313@dhcp22.suse.cz>
References: <1567131991-189761-1-git-send-email-linyunsheng@huawei.com>
 <20190830055528.GO28313@dhcp22.suse.cz>
 <49b86da7-f114-27c2-463a-9bf5082ac197@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49b86da7-f114-27c2-463a-9bf5082ac197@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 14:35:26, Yunsheng Lin wrote:
> On 2019/8/30 13:55, Michal Hocko wrote:
> > On Fri 30-08-19 10:26:31, Yunsheng Lin wrote:
> >> Some buggy bios may not set the device' numa id, and dev_to_node
> >> will return -1, which may cause global-out-of-bounds error
> >> detected by KASAN.
> > 
> > Why should we workaround a buggy bios like that? Is it so widespread and
> > no BIOS update available? Also, why is this arm64 specific?
> 
> For our case, there is BIOS update available. I just thought it might
> be better to protect from this case when BIOS has not implemented the
> device' numa id setting feature or the feature from BIOS has some bug.
> 
> It is not arm64 specific, right now I only have arm64 board. If it is
> ok to protect this from the buggy BIOS, maybe all other arch can be
> changed too.

If we are to really care then this should be consistent among
architectures IMHO. But I am not really sure this is really worth it.
The code is quite old and I do not really remember any reports. 

> >> This patch changes cpumask_of_node to return cpu_none_mask if the
> >> node is not valid, and sync the cpumask_of_node between the
> >> cpumask_of_node function in numa.h and numa.c.
> > 
> > Why?
> 
> When CONFIG_DEBUG_PER_CPU_MAPS is defined, the cpumask_of_node() in
> numa.c is used, if not, the cpumask_of_node() in numa.h is used.
> 
> I am not sure why there is difference between them, and it is there
> when since the below commit:
> 1a2db300348b ("arm64, numa: Add NUMA support for arm64 platforms.")
> 
> I synced them to keep them consistent whether CONFIG_DEBUG_PER_CPU_MAPS
> is defined.

Such a change should be made in a separate patch with a full
clarification/justification. From the above it is still not clear why
this is needed though.

> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  arch/arm64/include/asm/numa.h | 6 ++++++
> >>  arch/arm64/mm/numa.c          | 2 +-
> >>  2 files changed, 7 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/include/asm/numa.h b/arch/arm64/include/asm/numa.h
> >> index 626ad01..da891ed 100644
> >> --- a/arch/arm64/include/asm/numa.h
> >> +++ b/arch/arm64/include/asm/numa.h
> >> @@ -25,6 +25,12 @@ const struct cpumask *cpumask_of_node(int node);
> >>  /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
> >>  static inline const struct cpumask *cpumask_of_node(int node)
> >>  {
> >> +	if (node >= nr_node_ids || node < 0)
> >> +		return cpu_none_mask;
> >> +
> >> +	if (!node_to_cpumask_map[node])
> >> +		return cpu_online_mask;
> >> +
> >>  	return node_to_cpumask_map[node];
> >>  }
> >>  #endif
> >> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> >> index 4f241cc..3846313 100644
> >> --- a/arch/arm64/mm/numa.c
> >> +++ b/arch/arm64/mm/numa.c
> >> @@ -46,7 +46,7 @@ EXPORT_SYMBOL(node_to_cpumask_map);
> >>   */
> >>  const struct cpumask *cpumask_of_node(int node)
> >>  {
> >> -	if (WARN_ON(node >= nr_node_ids))
> >> +	if (WARN_ON(node >= nr_node_ids || node < 0))
> >>  		return cpu_none_mask;
> >>  
> >>  	if (WARN_ON(node_to_cpumask_map[node] == NULL))
> >> -- 
> >> 2.8.1
> > 

-- 
Michal Hocko
SUSE Labs
