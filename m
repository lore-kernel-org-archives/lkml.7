Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F39C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CF952075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553677265;
	bh=5W/UBvbEs0k+d15uktBNUYnCva1DKMQQWMHXop7I5P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Onb7fRbmyqZgs3GdNTOkE2TS51Nu9SwN97dZTQltsqBmHOr+yiORfYLmoVY/aatp3
	 yYnH1etdKNnseqE2FAtroAZKUarKIN/fY0kCZFhFmIkbHstmxB5f8PU03M1Sr3lzmQ
	 2vRE9pxDlPFjhtnE780i8MPLO6juBPWxgKatnW44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbfC0JBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:01:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48914 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725768AbfC0JBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:01:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 898C5AC86;
        Wed, 27 Mar 2019 09:01:01 +0000 (UTC)
Date:   Wed, 27 Mar 2019 10:01:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190327090100.GD11927@dhcp22.suse.cz>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190326135837.GP28406@dhcp22.suse.cz>
 <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
 <20190326183731.GV28406@dhcp22.suse.cz>
 <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 19:58:56, Yang Shi wrote:
> 
> 
> On 3/26/19 11:37 AM, Michal Hocko wrote:
> > On Tue 26-03-19 11:33:17, Yang Shi wrote:
> > > 
> > > On 3/26/19 6:58 AM, Michal Hocko wrote:
> > > > On Sat 23-03-19 12:44:25, Yang Shi wrote:
> > > > > With Dave Hansen's patches merged into Linus's tree
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c221c0b0308fd01d9fb33a16f64d2fd95f8830a4
> > > > > 
> > > > > PMEM could be hot plugged as NUMA node now. But, how to use PMEM as NUMA node
> > > > > effectively and efficiently is still a question.
> > > > > 
> > > > > There have been a couple of proposals posted on the mailing list [1] [2].
> > > > > 
> > > > > The patchset is aimed to try a different approach from this proposal [1]
> > > > > to use PMEM as NUMA nodes.
> > > > > 
> > > > > The approach is designed to follow the below principles:
> > > > > 
> > > > > 1. Use PMEM as normal NUMA node, no special gfp flag, zone, zonelist, etc.
> > > > > 
> > > > > 2. DRAM first/by default. No surprise to existing applications and default
> > > > > running. PMEM will not be allocated unless its node is specified explicitly
> > > > > by NUMA policy. Some applications may be not very sensitive to memory latency,
> > > > > so they could be placed on PMEM nodes then have hot pages promote to DRAM
> > > > > gradually.
> > > > Why are you pushing yourself into the corner right at the beginning? If
> > > > the PMEM is exported as a regular NUMA node then the only difference
> > > > should be performance characteristics (module durability which shouldn't
> > > > play any role in this particular case, right?). Applications which are
> > > > already sensitive to memory access should better use proper binding already.
> > > > Some NUMA topologies might have quite a large interconnect penalties
> > > > already. So this doesn't sound like an argument to me, TBH.
> > > The major rationale behind this is we assume the most applications should be
> > > sensitive to memory access, particularly for meeting the SLA. The
> > > applications run on the machine may be agnostic to us, they may be sensitive
> > > or non-sensitive. But, assuming they are sensitive to memory access sounds
> > > safer from SLA point of view. Then the "cold" pages could be demoted to PMEM
> > > nodes by kernel's memory reclaim or other tools without impairing the SLA.
> > > 
> > > If the applications are not sensitive to memory access, they could be bound
> > > to PMEM or allowed to use PMEM (nice to have allocation on DRAM) explicitly,
> > > then the "hot" pages could be promoted to DRAM.
> > Again, how is this different from NUMA in general?
> 
> It is still NUMA, users still can see all the NUMA nodes.

No, Linux NUMA implementation makes all numa nodes available by default
and provides an API to opt-in for more fine tuning. What you are
suggesting goes against that semantic and I am asking why. How is pmem
NUMA node any different from any any other distant node in principle?
-- 
Michal Hocko
SUSE Labs
