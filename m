Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03A3C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B601E217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558523819;
	bh=IjJD96H5gnVkn+9lf9Q8u4xc0z3AeLdJDFr0/UTSBSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GuhCAc0E3AFdbZldC3BjxeaGPM24DJIxevB0UU553hDYL/01F+bSsYGNcIDTGj+7A
	 D4ucLtedygS1NNAdMsEw4T+bEpkoaM3dVNGct/+mcoFZUwB7QHB7HTbIJL27JxkmuK
	 fnh+lpI2Xj6PE1VDuiHTDEukW/MRo2jeB8+5sD4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbfEVLQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:16:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:41430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727464AbfEVLQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:16:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4097FADE3;
        Wed, 22 May 2019 11:16:56 +0000 (UTC)
Date:   Wed, 22 May 2019 13:16:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        brho@google.com, Dave Hansen <dave.hansen@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ingo Molnar <mingo@elte.hu>,
        Oscar Salvador <osalvador@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190522111655.GA4374@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
 <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw>
 <20190513140448.GJ24036@dhcp22.suse.cz>
 <1557760846.6132.25.camel@lca.pw>
 <20190513153143.GK24036@dhcp22.suse.cz>
 <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTt9XA9_Y6q8wVHkE9_i+b0ZXCAj__zYU0DU9XUkM3F4Ew@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-05-19 15:12:16, Pingfan Liu wrote:
> On Mon, May 13, 2019 at 11:31 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Mon 13-05-19 11:20:46, Qian Cai wrote:
> > > On Mon, 2019-05-13 at 16:04 +0200, Michal Hocko wrote:
> > > > On Mon 13-05-19 09:43:59, Qian Cai wrote:
> > > > > On Mon, 2019-05-13 at 14:41 +0200, Michal Hocko wrote:
> > > > > > On Sun 12-05-19 01:48:29, Qian Cai wrote:
> > > > > > > The linux-next commit ("x86, numa: always initialize all possible
> > > > > > > nodes") introduced a crash below during boot for systems with a
> > > > > > > memory-less node. This is due to CPUs that get onlined during SMP boot,
> > > > > > > but that onlining triggers a page fault in bus_add_device() during
> > > > > > > device registration:
> > > > > > >
> > > > > > >       error = sysfs_create_link(&bus->p->devices_kset->kobj,
> > > > > > >
> > > > > > > bus->p is NULL. That "p" is the subsys_private struct, and it should
> > > > > > > have been set in,
> > > > > > >
> > > > > > >       postcore_initcall(register_node_type);
> > > > > > >
> > > > > > > but that happens in do_basic_setup() after smp_init().
> > > > > > >
> > > > > > > The old code had set this node online via alloc_node_data(), so when it
> > > > > > > came time to do_cpu_up() -> try_online_node(), the node was already up
> > > > > > > and nothing happened.
> > > > > > >
> > > > > > > Now, it attempts to online the node, which registers the node with
> > > > > > > sysfs, but that can't happen before the 'node' subsystem is registered.
> > > > > > >
> > > > > > > Since kernel_init() is running by a kernel thread that is in
> > > > > > > SYSTEM_SCHEDULING state, fixed this by skipping registering with sysfs
> > > > > > > during the early boot in __try_online_node().
> > > > > >
> > > > > > Relying on SYSTEM_SCHEDULING looks really hackish. Why cannot we simply
> > > > > > drop try_online_node from do_cpu_up? Your v2 remark below suggests that
> > > > > > we need to call node_set_online because something later on depends on
> > > > > > that. Btw. why do we even allocate a pgdat from this path? This looks
> > > > > > really messy.
> > > > >
> > > > > See the commit cf23422b9d76 ("cpu/mem hotplug: enable CPUs online before
> > > > > local
> > > > > memory online")
> > > > >
> > > > > It looks like try_online_node() in do_cpu_up() is needed for memory hotplug
> > > > > which is to put its node online if offlined and then hotadd_new_pgdat()
> > > > > calls
> > > > > build_all_zonelists() to initialize the zone list.
> > > >
> > > > Well, do we still have to followthe logic that the above (unreviewed)
> > > > commit has established? The hotplug code in general made a lot of ad-hoc
> > > > design decisions which had to be revisited over time. If we are not
> > > > allocating pgdats for newly added memory then we should really make sure
> > > > to do so at a proper time and hook. I am not sure about CPU vs. memory
> > > > init ordering but even then I would really prefer if we could make the
> > > > init less obscure and _documented_.
> > >
> > > I don't know, but I think it is a good idea to keep the existing logic rather
> > > than do a big surgery
> >
> > Adding more hacks just doesn't make the situation any better.
> >
> > > unless someone is able to confirm it is not breaking NUMA
> > > node physical hotplug.
> >
> > I have a machine to test whole node offline. I am just busy to prepare a
> > patch myself. I can have it tested though.
> >
> I think the definition of "node online" is worth of rethinking. Before
> patch "x86, numa: always initialize all possible nodes", online means
> either cpu or memory present. After this patch, only node owing memory
> as present.
> 
> In the commit log, I think the change's motivation should be "Not to
> mention that it doesn't really make much sense to consider an empty
> node as online because we just consider this node whenever we want to
> iterate nodes to use and empty node is obviously not the best
> candidate."
> 
> But in fact, we already have for_each_node_state(nid, N_MEMORY) to
> cover this purpose.

I do not really think we want to spread N_MEMORY outside of the core MM.
It is quite confusing IMHO.
. 
> Furthermore, changing the definition of online may
> break something in the scheduler, e.g. in task_numa_migrate(), where
> it calls for_each_online_node.

Could you be more specific please? Why should numa balancing consider
nodes without any memory?

> By keeping the node owning cpu as online, Michal's patch can avoid
> such corner case and keep things easy. Furthermore, if needed, the
> other patch can use for_each_node_state(nid, N_MEMORY) to replace
> for_each_online_node is some space.

Ideally no code outside of the core MM should care about what kind of
memory does the node really own. The external code should only care
whether the node is online and thus usable or offline and of no
interest.
-- 
Michal Hocko
SUSE Labs
