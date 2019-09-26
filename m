Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332EEC47E48
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F2A222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569498782;
	bh=X5OS26vbPlPVuGVITlmd71r7oIDgG+pABHbTo9cxj+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rzSlWJl7NxpINFODV6SYGdelvctE1/ilk5TelXuUQQ4f/0EHtDmQNb+ahpjZ7a0YF
	 MAA/AV84CBZTo9G1izt/22IzU4U5Uhbnlofk6rdoRIc59xV6fWF4LXQgFbdxLB7DN9
	 GPfL5SGxhLW7nEwUoBZaa/UxZ9DBDnW4grManNgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfIZLxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 07:53:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:51300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfIZLxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:53:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 06525AEAC;
        Thu, 26 Sep 2019 11:52:58 +0000 (UTC)
Date:   Thu, 26 Sep 2019 13:52:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
Message-ID: <20190926115258.GH20255@dhcp22.suse.cz>
References: <20190926072645.GA20255@dhcp22.suse.cz>
 <C8DA5249-2DEB-47D5-937E-5A774B1CB08B@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C8DA5249-2DEB-47D5-937E-5A774B1CB08B@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26-09-19 07:19:27, Qian Cai wrote:
> 
> 
> > On Sep 26, 2019, at 3:26 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > OK, this is using for_each_online_cpu but why is this a problem? Have
> > you checked what the code actually does? Let's say that online_pages is
> > racing with cpu hotplug. A new CPU appears/disappears from the online
> > mask while we are iterating it, right? Let's start with cpu offlining
> > case. We have two choices, either the cpu is still visible and we update
> > its local node configuration even though it will disappear shortly which
> > is ok because we are not touching any data that disappears (it's all
> > per-cpu). Case when the cpu is no longer there is not really
> > interesting. For the online case we might miss a cpu but that should be
> > tolerateable because that is not any different from triggering the
> > online independently of the memory hotplug. So there has to be a hook
> > from that code path as well. If there is none then this is buggy
> > irrespective of the locking.
> > 
> > Makes sense?
> 
> This sounds to me requires lots of audits and testing. Also, someone who is more
> familiar with CPU hotplug should review this patch.

Thomas is on the CC list.

> Personally, I am no fun of
> operating on an incorrect CPU mask to begin with, things could go wrong really
> quickly...

Do you have any specific arguments? Just think of cpu and memory
hotplugs being independent operations. There is nothing really
inherently binding them together. If the cpu_online_mask really needs a
special treatment here then I would like to hear about that. Handwaving 
doesn't really helps us.

-- 
Michal Hocko
SUSE Labs
