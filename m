Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35917C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A502084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553625456;
	bh=1l+ysp6En4nkTtZQ4FEODgS2kaetAOBB0hZYA/G4Eq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tx7vxZ+rglFkTNC2+zeS48jqMCAzUm2f08/ARIS8ZlsFjwOkg1LDQn2i0/6jRG7MW
	 d4OECE0EamwMqHctE6p3OO1g5bruJZ38Tu5i/E4FcQ5jnKfDxO73WfLoGqMc7R/dER
	 EK62q5P4D8h3lje427vfy+Dzp0A/qeIF1Am6R0LA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfCZShe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:37:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:33676 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731755AbfCZShe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:37:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21C3AAC7E;
        Tue, 26 Mar 2019 18:37:33 +0000 (UTC)
Date:   Tue, 26 Mar 2019 19:37:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190326183731.GV28406@dhcp22.suse.cz>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190326135837.GP28406@dhcp22.suse.cz>
 <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 11:33:17, Yang Shi wrote:
> 
> 
> On 3/26/19 6:58 AM, Michal Hocko wrote:
> > On Sat 23-03-19 12:44:25, Yang Shi wrote:
> > > With Dave Hansen's patches merged into Linus's tree
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308fd01d9fb33a16f64d2fd95f8830a4
> > > 
> > > PMEM could be hot plugged as NUMA node now. But, how to use PMEM as NUMA node
> > > effectively and efficiently is still a question.
> > > 
> > > There have been a couple of proposals posted on the mailing list [1] [2].
> > > 
> > > The patchset is aimed to try a different approach from this proposal [1]
> > > to use PMEM as NUMA nodes.
> > > 
> > > The approach is designed to follow the below principles:
> > > 
> > > 1. Use PMEM as normal NUMA node, no special gfp flag, zone, zonelist, etc.
> > > 
> > > 2. DRAM first/by default. No surprise to existing applications and default
> > > running. PMEM will not be allocated unless its node is specified explicitly
> > > by NUMA policy. Some applications may be not very sensitive to memory latency,
> > > so they could be placed on PMEM nodes then have hot pages promote to DRAM
> > > gradually.
> > Why are you pushing yourself into the corner right at the beginning? If
> > the PMEM is exported as a regular NUMA node then the only difference
> > should be performance characteristics (module durability which shouldn't
> > play any role in this particular case, right?). Applications which are
> > already sensitive to memory access should better use proper binding already.
> > Some NUMA topologies might have quite a large interconnect penalties
> > already. So this doesn't sound like an argument to me, TBH.
> 
> The major rationale behind this is we assume the most applications should be
> sensitive to memory access, particularly for meeting the SLA. The
> applications run on the machine may be agnostic to us, they may be sensitive
> or non-sensitive. But, assuming they are sensitive to memory access sounds
> safer from SLA point of view. Then the "cold" pages could be demoted to PMEM
> nodes by kernel's memory reclaim or other tools without impairing the SLA.
> 
> If the applications are not sensitive to memory access, they could be bound
> to PMEM or allowed to use PMEM (nice to have allocation on DRAM) explicitly,
> then the "hot" pages could be promoted to DRAM.

Again, how is this different from NUMA in general?
-- 
Michal Hocko
SUSE Labs
