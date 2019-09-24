Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDAFC432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E625C214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 11:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569325649;
	bh=lpPJaDEbw0P3q5J6o3KIiIKIgeq2DGoh/7b3nGDDn14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G40/8wu0lU23zthhF3QXfeCOPe6fyW3MB5xbsIXRlHForFaggLlCBYkfWCppwMBeS
	 sdvB6Kt66bFh8isiJdtoPYQhNbeCaVWx2W3XUEm6i5iYV7s67rGClTxGlnfhLHqZn6
	 h1hHGJCFuUbDxmYH5LLB346PbibY0VpSUbTUuI4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394906AbfIXLr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 07:47:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:32834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388764AbfIXLr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 07:47:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AA33AB681;
        Tue, 24 Sep 2019 11:47:25 +0000 (UTC)
Date:   Tue, 24 Sep 2019 13:47:25 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] mm/hotplug: Reorder memblock_[free|remove]() calls in
 try_remove_memory()
Message-ID: <20190924114725.GL23050@dhcp22.suse.cz>
References: <1568612857-10395-1-git-send-email-anshuman.khandual@arm.com>
 <20190923105224.GH6016@dhcp22.suse.cz>
 <9b85f517-fee5-650a-4e18-29408ca85804@redhat.com>
 <ef55498f-a410-bb51-389c-7ac09641c51a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef55498f-a410-bb51-389c-7ac09641c51a@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-09-19 09:42:31, Anshuman Khandual wrote:
> 
> 
> On 09/23/2019 04:24 PM, David Hildenbrand wrote:
> > On 23.09.19 12:52, Michal Hocko wrote:
> >> On Mon 16-09-19 11:17:37, Anshuman Khandual wrote:
> >>> In add_memory_resource() the memory range to be hot added first gets into
> >>> the memblock via memblock_add() before arch_add_memory() is called on it.
> >>> Reverse sequence should be followed during memory hot removal which already
> >>> is being followed in add_memory_resource() error path. This now ensures
> >>> required re-order between memblock_[free|remove]() and arch_remove_memory()
> >>> during memory hot-remove.
> >>
> >> This changelog is not really easy to follow. First of all please make
> >> sure to explain whether there is any actual problem to solve or this is
> >> an aesthetic matter. Please think of people reading this changelog in
> >> few years and scratching their heads what you were thinking back then...
> >>
> > 
> > I think it would make sense to just draft the current call sequence in
> > the add and the removal path (instead of describing it) - then it
> > becomes obvious why this is a cosmetic change.
> 
> Does this look okay ?
> 
> mm/hotplug: Reorder memblock_[free|remove]() calls in try_remove_memory()
> 
> Currently during memory hot add procedure, memory gets into memblock before
> calling arch_add_memory() which creates it's linear mapping.
> 
> add_memory_resource() {
>         ..................
>         memblock_add_node()
>         ..................
>         arch_add_memory()
>         ..................
> }
> 
> But during memory hot remove procedure, removal from memblock happens first
> before it's linear mapping gets teared down with arch_remove_memory() which
> is not coherent. Resource removal should happen in reverse order as they
> were added.
> 
> try_remove_memory() {
>         ..................
>         memblock_free()
>         memblock_remove()
>         ..................
>         arch_remove_memory()
>         ..................
> }
> 
> This changes the sequence of resource removal including memblock and linear
> mapping tear down during memory hot remove which will now be the reverse
> order in which they were added during memory hot add. The changed removal
> order looks like the following.
> 
> try_remove_memory() {
>         ..................
>         arch_remove_memory()
>         ..................
>         memblock_free()
>         memblock_remove()
>         ..................
> }

OK, this is better. I would just a note that the inconsistency doesn't
pose any problem now but if somebody makes any assumptions about linear
mappings then it could get subtly broken like your example for arm64
which has found a different solution in the meantime.

-- 
Michal Hocko
SUSE Labs
