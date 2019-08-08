Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEA7C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37DDC216C8
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 20:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404504AbfHHUNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 16:13:48 -0400
Received: from mga17.intel.com ([192.55.52.151]:22061 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404145AbfHHUNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 16:13:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 13:13:47 -0700
X-IronPort-AV: E=Sophos;i="5.64,362,1559545200"; 
   d="scan'208";a="186460450"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.251.6.227]) ([10.251.6.227])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 08 Aug 2019 13:13:46 -0700
Subject: Re: [PATCH V2 09/10] x86/resctrl: Pseudo-lock portions of multiple
 resources
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <c0095fd15488d87be06deddf43abb4a2834dc7e6.1564504902.git.reinette.chatre@intel.com>
 <20190807152511.GB24328@zn.tnic>
 <e9145623-bf5a-b96c-d802-7b61caa406e0@intel.com>
 <20190808084416.GC20745@zn.tnic>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <a69981df-80f5-d8cf-e118-2ee639dcdb77@intel.com>
Date:   Thu, 8 Aug 2019 13:13:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808084416.GC20745@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On 8/8/2019 1:44 AM, Borislav Petkov wrote:
> On Wed, Aug 07, 2019 at 12:23:29PM -0700, Reinette Chatre wrote:
>> I do not fully understand this proposal. All those goto labels take care
>> of the the different failures that can be encountered during the
>> initialization of the pseudo-lock region. Each initialization failure is
>> associated with a goto where it jumps to the cleanup path. The
>> initialization starts with the constraining of the c-states
>> (initializing plr->pm_reqs), but if I move that I think it will not
>> reduce the goto labels, just change the order because of the other
>> initialization done (plr->size, plr->line_size, plr->cpu).
> 
> Here's one possible way to do it, pasting the whole function here as it
> is easier to read it this way than an incremental diff ontop.
> 
> You basically cache all attributes in local variables and assign them to
> the plr struct only on success, at the end. This way, no goto labels and
> the C-states constraining, i.e., the most expensive operation, happens
> last, only after all the other simpler checks have succeeded. And you
> don't have to call pseudo_lock_cstates_relax() prematurely, when one of
> those easier checks fail.
> 
> Makes sense?

It does. This looks much better. Thank you very much.

> 
> Btw, I've marked the cpu_online() check with "CPU hotplug
> lock?!?" question because I don't see you holding that lock with
> get_online_cpus()/put_online_cpus().

There is a locking order dependency between cpu_hotplug_lock and
rdtgroup_mutex (cpu_hotplug_lock before rdtgroup_mutex) that has to be
maintained. To do so in this flow you will find cpus_read_lock() in
rdtgroup_schemata_write(), so quite a distance from where it is needed.

Perhaps I should add a comment at the location where the lock is
required to document where the lock is obtained?

> static int pseudo_lock_l2_l3_portions_valid(struct pseudo_lock_region *plr,
> 					    struct pseudo_lock_portion *l2_p,
> 					    struct pseudo_lock_portion *l3_p)
> {
> 	unsigned int l2_size, l3_size, size, line_size, cpu;
> 	struct rdt_domain *l2_d, *l3_d;
> 
> 	l2_d = rdt_find_domain(l2_p->r, l2_p->d_id, NULL);
> 	if (IS_ERR_OR_NULL(l2_d)) {
> 		rdt_last_cmd_puts("Cannot locate L2 cache domain\n");
> 		return -1;
> 	}
> 
> 	l3_d = rdt_find_domain(l3_p->r, l3_p->d_id, NULL);
> 	if (IS_ERR_OR_NULL(l3_d)) {
> 		rdt_last_cmd_puts("Cannot locate L3 cache domain\n");
> 		return -1;
> 	}
> 
> 	if (!cpumask_subset(&l2_d->cpu_mask, &l3_d->cpu_mask)) {
> 		rdt_last_cmd_puts("L2 and L3 caches need to be in same hierarchy\n");
> 		return -1;
> 	}
> 
> 	l2_size = rdtgroup_cbm_to_size(l2_p->r, l2_d, l2_p->cbm);
> 	l3_size = rdtgroup_cbm_to_size(l3_p->r, l3_d, l3_p->cbm);
> 
> 	if (l2_size > l3_size) {
> 		rdt_last_cmd_puts("L3 cache portion has to be same size or larger than L2 cache portion\n");
> 		return -1;
> 	}
> 
> 	size = l2_size;
> 
> 	l2_size = get_cache_line_size(cpumask_first(&l2_d->cpu_mask), l2_p->r->cache_level);
> 	l3_size = get_cache_line_size(cpumask_first(&l3_d->cpu_mask), l3_p->r->cache_level);
> 	if (l2_size != l3_size) {
> 		rdt_last_cmd_puts("L2 and L3 caches have different coherency cache line sizes\n");
> 		return -1;
> 	}
> 
> 	line_size = l2_size;
> 
> 	cpu = cpumask_first(&l2_d->cpu_mask);
> 
> 	/*
> 	 * CPU hotplug lock?!?
> 	 */
> 	if (!cpu_online(cpu)) {
> 		rdt_last_cmd_printf("CPU %u associated with cache not online\n", cpu);
> 		return -1;
> 	}
> 
> 	if (!get_cache_inclusive(cpu, l3_p->r->cache_level)) {
> 		rdt_last_cmd_puts("L3 cache not inclusive\n");
> 		return -1;
> 	}
> 
> 	/*
> 	 * All checks passed, constrain C-states:
> 	 */
> 	if (pseudo_lock_cstates_constrain(plr, &l2_d->cpu_mask)) {
> 		rdt_last_cmd_puts("Cannot limit C-states\n");
> 		pseudo_lock_cstates_relax(plr);
> 		return -1;
> 	}
> 
> 	plr->line_size	= line_size;
> 	plr->size	= size;
> 	plr->cpu	= cpu;
> 
> 	return 0;
> }
> 

Thank you very much

Reinette
