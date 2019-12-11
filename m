Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAEDC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE15E205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 18:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbfLKSDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 13:03:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:17321 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730334AbfLKSDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:03:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 10:03:12 -0800
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="245373947"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.138]) ([10.24.14.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Dec 2019 10:03:04 -0800
Subject: Re: [PATCH v2] x86/resctrl: fix an imbalance in domain_remove_cpu
To:     Qian Cai <cai@lca.pw>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, hpa@zytor.com, john.stultz@linaro.org,
        sboyd@kernel.org, tony.luck@intel.com, tj@kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
References: <20191211033042.2188-1-cai@lca.pw>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <9e7483f2-75cc-afaa-e1ea-287a970d4579@intel.com>
Date:   Wed, 11 Dec 2019 10:02:56 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191211033042.2188-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On 12/10/2019 7:30 PM, Qian Cai wrote:
> A system that supports resource monitoring may have multiple resources
> while not all of these resources are capable of monitoring. Monitoring
> related state is initialized only for resources that are capable of
> monitoring and correspondingly this state should subsequently only be
> removed from these resources that are capable of monitoring.
> 
> domain_add_cpu() calls domain_setup_mon_state() only when r->mon_capable
> is true where it will initialize d->mbm_over. However,
> domain_remove_cpu() calls cancel_delayed_work(&d->mbm_over) without
> checking r->mon_capable resulting in an attempt to cancel d->mbm_over on
> all resources, even those that never initialized d->mbm_over because
> they are not capable of monitoring. Hence, it triggers a debugobjects
> warning when offlining CPUs because those timer debugobjects are never
> initialized.
> 
> ODEBUG: assert_init not available (active state 0) object type:
> timer_list hint: 0x0
> WARNING: CPU: 143 PID: 789 at lib/debugobjects.c:484
> debug_print_object+0xfe/0x140
> Hardware name: HP Synergy 680 Gen9/Synergy 680 Gen9 Compute Module, BIOS
> I40 05/23/2018
> RIP: 0010:debug_print_object+0xfe/0x140
> Call Trace:
> debug_object_assert_init+0x1f5/0x240
> del_timer+0x6f/0xf0
> try_to_grab_pending+0x42/0x3c0
> cancel_delayed_work+0x7d/0x150
> resctrl_offline_cpu+0x3c0/0x520
> cpuhp_invoke_callback+0x197/0x1120
> cpuhp_thread_fun+0x252/0x2f0
> smpboot_thread_fn+0x255/0x440
> kthread+0x1e6/0x210
> ret_from_fork+0x3a/0x50
> 
> Fixes: e33026831bdb ("x86/intel_rdt/mbm: Handle counter overflow")
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---

Thank you very much.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

