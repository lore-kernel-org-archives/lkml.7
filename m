Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91907C04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6361B2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 14:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557756293;
	bh=aUAOUQmvO4x+HNaHFnjhkK7unWjertFMu6KRFOGoWeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PVmRbFc6IKFQycF53YYAot0hRS9bOdyLJFfozH6ccFJg//54DFeffXTYoOONMxBVJ
	 MEs9tBWRrKQdYk7qXJXB6p/k1kJIaB8ijnfhkTJo946o3mmBiIBBqjvBR9oMXIoI8v
	 t5fDhjv1ArOnPxon/dei0zCA0VLqDVlg1ZSg2gNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbfEMOEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 10:04:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:55872 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729875AbfEMOEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 10:04:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DAEDAAD0A;
        Mon, 13 May 2019 14:04:49 +0000 (UTC)
Date:   Mon, 13 May 2019 16:04:48 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, brho@google.com, kernelfans@gmail.com,
        dave.hansen@intel.com, rppt@linux.ibm.com, peterz@infradead.org,
        mpe@ellerman.id.au, mingo@elte.hu, osalvador@suse.de,
        luto@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190513140448.GJ24036@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
 <20190513124112.GH24036@dhcp22.suse.cz>
 <1557755039.6132.23.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557755039.6132.23.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13-05-19 09:43:59, Qian Cai wrote:
> On Mon, 2019-05-13 at 14:41 +0200, Michal Hocko wrote:
> > On Sun 12-05-19 01:48:29, Qian Cai wrote:
> > > The linux-next commit ("x86, numa: always initialize all possible
> > > nodes") introduced a crash below during boot for systems with a
> > > memory-less node. This is due to CPUs that get onlined during SMP boot,
> > > but that onlining triggers a page fault in bus_add_device() during
> > > device registration:
> > > 
> > > 	error = sysfs_create_link(&bus->p->devices_kset->kobj,
> > > 
> > > bus->p is NULL. That "p" is the subsys_private struct, and it should
> > > have been set in,
> > > 
> > > 	postcore_initcall(register_node_type);
> > > 
> > > but that happens in do_basic_setup() after smp_init().
> > > 
> > > The old code had set this node online via alloc_node_data(), so when it
> > > came time to do_cpu_up() -> try_online_node(), the node was already up
> > > and nothing happened.
> > > 
> > > Now, it attempts to online the node, which registers the node with
> > > sysfs, but that can't happen before the 'node' subsystem is registered.
> > > 
> > > Since kernel_init() is running by a kernel thread that is in
> > > SYSTEM_SCHEDULING state, fixed this by skipping registering with sysfs
> > > during the early boot in __try_online_node().
> > 
> > Relying on SYSTEM_SCHEDULING looks really hackish. Why cannot we simply
> > drop try_online_node from do_cpu_up? Your v2 remark below suggests that
> > we need to call node_set_online because something later on depends on
> > that. Btw. why do we even allocate a pgdat from this path? This looks
> > really messy.
> 
> See the commit cf23422b9d76 ("cpu/mem hotplug: enable CPUs online before local
> memory online")
> 
> It looks like try_online_node() in do_cpu_up() is needed for memory hotplug
> which is to put its node online if offlined and then hotadd_new_pgdat() calls
> build_all_zonelists() to initialize the zone list.

Well, do we still have to followthe logic that the above (unreviewed)
commit has established? The hotplug code in general made a lot of ad-hoc
design decisions which had to be revisited over time. If we are not
allocating pgdats for newly added memory then we should really make sure
to do so at a proper time and hook. I am not sure about CPU vs. memory
init ordering but even then I would really prefer if we could make the
init less obscure and _documented_.
 
-- 
Michal Hocko
SUSE Labs
