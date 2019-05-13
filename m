Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C4FAC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DB19206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557751276;
	bh=dHiY26q4vJivccfdnZgE6SAhdYoYIwxSlhXpZf+/I4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AUWNCXoS5enGJ50L5A+n/VjtcvvEMo4TlTmSiHrkEYG1zrs2LvwvAVt0qmX5gLDkb
	 3LPr2W0Cs02mtsMmJCJaI3Kc1SlWgvtqOsugL+twwtbTxBU2PjVAIoBxFvyP4jSJAN
	 kIkg8LhS+p1CCiGwgQYq0mgX4Hs7CuXP/BHFTAng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbfEMMlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 08:41:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:36310 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728420AbfEMMlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 08:41:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9A2D7AF60;
        Mon, 13 May 2019 12:41:13 +0000 (UTC)
Date:   Mon, 13 May 2019 14:41:12 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, brho@google.com, kernelfans@gmail.com,
        dave.hansen@intel.com, rppt@linux.ibm.com, peterz@infradead.org,
        mpe@ellerman.id.au, mingo@elte.hu, osalvador@suse.de,
        luto@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
Message-ID: <20190513124112.GH24036@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512054829.11899-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 12-05-19 01:48:29, Qian Cai wrote:
> The linux-next commit ("x86, numa: always initialize all possible
> nodes") introduced a crash below during boot for systems with a
> memory-less node. This is due to CPUs that get onlined during SMP boot,
> but that onlining triggers a page fault in bus_add_device() during
> device registration:
> 
> 	error = sysfs_create_link(&bus->p->devices_kset->kobj,
> 
> bus->p is NULL. That "p" is the subsys_private struct, and it should
> have been set in,
> 
> 	postcore_initcall(register_node_type);
> 
> but that happens in do_basic_setup() after smp_init().
> 
> The old code had set this node online via alloc_node_data(), so when it
> came time to do_cpu_up() -> try_online_node(), the node was already up
> and nothing happened.
> 
> Now, it attempts to online the node, which registers the node with
> sysfs, but that can't happen before the 'node' subsystem is registered.
> 
> Since kernel_init() is running by a kernel thread that is in
> SYSTEM_SCHEDULING state, fixed this by skipping registering with sysfs
> during the early boot in __try_online_node().

Relying on SYSTEM_SCHEDULING looks really hackish. Why cannot we simply
drop try_online_node from do_cpu_up? Your v2 remark below suggests that
we need to call node_set_online because something later on depends on
that. Btw. why do we even allocate a pgdat from this path? This looks
really messy.

> Call Trace:
>  device_add+0x43e/0x690
>  device_register+0x107/0x110
>  __register_one_node+0x72/0x150
>  __try_online_node+0x8f/0xd0
>  try_online_node+0x2b/0x50
>  do_cpu_up+0x46/0xf0
>  cpu_up+0x13/0x20
>  smp_init+0x6e/0xd0
>  kernel_init_freeable+0xe5/0x21f
>  kernel_init+0xf/0x180
>  ret_from_fork+0x1f/0x30
> 
> Reported-by: Barret Rhoden <brho@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> 
> v2: Set the node online as it have CPUs. Otherwise, those memory-less nodes will
>     end up being not in sysfs i.e., /sys/devices/system/node/.
> 
>  mm/memory_hotplug.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b236069ff0d8..6eb2331fa826 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1037,6 +1037,18 @@ static int __try_online_node(int nid, u64 start, bool set_node_online)
>  	if (node_online(nid))
>  		return 0;
>  
> +	/*
> +	 * Here is called by cpu_up() to online a node without memory from
> +	 * kernel_init() which guarantees that "set_node_online" is true which
> +	 * will set the node online as it have CPUs but not ready to call
> +	 * register_one_node() as "node_subsys" has not been initialized
> +	 * properly yet.
> +	 */
> +	if (system_state == SYSTEM_SCHEDULING) {
> +		node_set_online(nid);
> +		return 0;
> +	}
> +
>  	pgdat = hotadd_new_pgdat(nid, start);
>  	if (!pgdat) {
>  		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
> -- 
> 2.20.1 (Apple Git-117)

-- 
Michal Hocko
SUSE Labs
