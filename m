Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABCEC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7AF20828
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfLJSoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:44:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:21350 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfLJSoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:44:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Dec 2019 10:44:14 -0800
X-IronPort-AV: E=Sophos;i="5.69,300,1571727600"; 
   d="scan'208";a="207392978"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.138]) ([10.24.14.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 10 Dec 2019 10:44:14 -0800
Subject: Re: [PATCH] x86/resctrl: fix an imbalance in domain_remove_cpu
To:     Qian Cai <cai@lca.pw>, Ryan Chen <yu.chen.surf@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        John Stultz <john.stultz@linaro.org>, sboyd@kernel.org,
        Tony Luck <tony.luck@intel.com>, tj@kernel.org,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191208041318.3702-1-cai@lca.pw>
 <CADjb_WRmyE3rRN2sLAh9ZOqAg0E3WeCkj9SwSM9dorvx4TGC2A@mail.gmail.com>
 <C9061BAA-DF55-402D-967C-33CF332B10EE@lca.pw>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <37341135-a0db-6d1c-236f-e32461b4c398@intel.com>
Date:   Tue, 10 Dec 2019 10:44:11 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <C9061BAA-DF55-402D-967C-33CF332B10EE@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On 12/10/2019 10:06 AM, Qian Cai wrote:
>> On Dec 10, 2019, at 2:55 AM, Ryan Chen <yu.chen.surf@gmail.com> wrote:
>>
>> Hi Qian,
>>
>> On Sun, Dec 8, 2019 at 12:14 PM Qian Cai <cai@lca.pw> wrote:
>>>
>>> domain_add_cpu() calls domain_setup_mon_state() only when r->mon_capable
>>> is true where it will initialize d->mbm_over. However,
>>> domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
>>> checking r->mon_capable. Hence, it triggers a debugobjects warning when
>>> offlining CPUs because those timer debugobjects are never initialized.
>>>
>> Could you elaborate a little more on the failure symptom?
>> If I understand correctly, the error you described was  due to
>> r->mon_capable set to false while is_mbm_enabled() returns true?
>> Which means on this platform rdt_mon_features is non zero?
>> And in get_rdt_mon_resources() it will invoke rdt_get_mon_l3_config(),
>> however the only possible failure to do not set r->mon_capable is that it
>> failed in dom_data_init() due to kcalloc() failure?  Then the logic in
>> get_rdt_resources() is that it will ignore the return error if rdt allocate
>> feature is supported on this platform?  If this is the case, the r->mon_capable
>> is not an indicator for whether the overflow thread has been created, right?
>> Can we simply remove the check of r->mon_capable in domain_add_cpu() and
>> invoke  domain_setup_mon_state() directly?
> 
> Actually,
> 
> domain_add_cpu r->name = L3, r->alloc_capable = 1, r->mon_capable = 1
> domain_add_cpu r->name = L3DATA, r->alloc_capable = 1, r->mon_capable = 0
> domain_add_cpu r->name = L3CODE, r->alloc_capable = 1, r->mon_capable = 0
> 
> rdt_get_mon_l3_config() will only set r->mon_capable = 1 for L3.
> 
>>> ODEBUG: assert_init not available (active state 0) object type:
>>> timer_list hint: 0x0
>>> WARNING: CPU: 143 PID: 789 at lib/debugobjects.c:484
>>> debug_print_object+0xfe/0x140
>>> Hardware name: HP Synergy 680 Gen9/Synergy 680 Gen9 Compute Module, BIOS
>>> I40 05/23/2018
>>> RIP: 0010:debug_print_object+0xfe/0x140
>>> Call Trace:
>>> debug_object_assert_init+0x1f5/0x240
>>> del_timer+0x6f/0xf0
>>> try_to_grab_pending+0x42/0x3c0
>>> cancel_delayed_work+0x7d/0x150
>>> resctrl_offline_cpu+0x3c0/0x520
>>> cpuhp_invoke_callback+0x197/0x1120
>>> cpuhp_thread_fun+0x252/0x2f0
>>> smpboot_thread_fn+0x255/0x440
>>> kthread+0x1e6/0x210
>>> ret_from_fork+0x3a/0x50
>>>
>>> Fixes: e33026831bdb ("x86/intel_rdt/mbm: Handle counter overflow")
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>> ---
>>> arch/x86/kernel/cpu/resctrl/core.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>>> index 03eb90d00af0..89049b343c7a 100644
>>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>>> @@ -618,7 +618,7 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>>>                if (static_branch_unlikely(&rdt_mon_enable_key))
>>>                        rmdir_mondata_subdir_allrdtgrp(r, d->id);
>>>                list_del(&d->list);
>>> -               if (is_mbm_enabled())
>>> +               if (r->mon_capable && is_mbm_enabled())
>>>                        cancel_delayed_work(&d->mbm_over);
>> Humm, it looks like there are two places within this function
>> invoked cancel_delayed_work(&d->mbm_over),
>> why not adding the check for both of them?
> 
> Here it only check L3, so it will skip correctly for L3DATA and L3CODE
> to not call cancel_delayed_work(). Recalled the above that only L3 will
> have r->capable set.
> 
> if (r == &rdt_resources_all[RDT_RESOURCE_L3]) {
> 	if (is_mbm_enabled() && cpu == d->mbm_work_cpu) {			
> 		cancel_delayed_work(&d->mbm_over);
> 
> Hence, r->mon_capable check seems redundant here.
> 

Thank you very much for catching this. Your change looks like the right
thing to do. As Ryan pointed out this is not obvious at first and
looking back at this commit at a later time may benefit from some more
details. For example, how about:


"A system that supports resource monitoring may have multiple resources
while not all of these resources are capable of monitoring. Monitoring
related state is initialized only for resources that are capable of
monitoring and correspondingly this state should subsequently only be
removed from these resources that are capable of monitoring.

domain_add_cpu() calls domain_setup_mon_state() only when r->mon_capable
is true where it will initialize d->mbm_over. However,
domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
checking r->mon_capable resulting in an attempt to cancel d->mbm_over on
all resources, even those that never initialized d->mbm_over because
they are not capable of monitoring. Hence, it triggers a debugobjects
warning when offlining CPUs because those timer debugobjects are never
initialized.

ODEBUG:..."


Reinette
