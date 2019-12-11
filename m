Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E910C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C30B21556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfLKT2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:28:48 -0500
Received: from mga14.intel.com ([192.55.52.115]:38007 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727002AbfLKT2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:28:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2019 11:18:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,302,1571727600"; 
   d="scan'208";a="238664618"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.215.77]) ([10.254.215.77])
  by fmsmga004.fm.intel.com with ESMTP; 11 Dec 2019 11:18:38 -0800
Subject: Re: [PATCH] x86/resctrl: Check monitoring static key in MBM overflow
 handler
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        tony.luck@intel.com, fenghua.yu@intel.com,
        reinette.chatre@intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, pei.p.jia@intel.com,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <1576086103-11640-1-git-send-email-xiaochen.shen@intel.com>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <d0a154d3-a7f6-827b-f785-e776c350cf2d@intel.com>
Date:   Thu, 12 Dec 2019 03:18:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1576086103-11640-1-git-send-email-xiaochen.shen@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am sorry I sent out a wrong version of patch.
Please ignore this patch. I will resend soon.


On 12/12/2019 1:41, Xiaochen Shen wrote:
> Currently, there are three static keys in resctrl file system:
> rdt_mon_enable_key and rdt_alloc_enable_key indicate if monitoring
> feature and allocation feature is enabled respectively. rdt_enable_key
> is enabled when either monitoring feature or allocation feature is
> enabled.
> 
> If no monitoring feature is supported (either hardware doesn't support
> monitoring feature or the feature is disabled by kernel command line
> option "rdt="), rdt_enable_key is still enabled but rdt_mon_enable_key
> is disabled.
> 
> MBM is a monitoring feature. MBM overflow handler intends to check if
> monitoring feature is not enabled for fast return. So the accurate check
> here is to check rdt_mon_enable_key instead of rdt_enable_key.
> 
> Fixes: e33026831bdb ("x86/intel_rdt/mbm: Handle counter overflow")
> Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h | 1 +
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 4 ++--
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index e49b77283924..181c992f448c 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -57,6 +57,7 @@ static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
>   }
>   
>   DECLARE_STATIC_KEY_FALSE(rdt_enable_key);
> +DECLARE_STATIC_KEY_FALSE(rdt_mon_enable_key);
>   
>   /**
>    * struct mon_evt - Entry in the event list of a resource
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index 397206f23d14..773124b0e18a 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -514,7 +514,7 @@ void mbm_handle_overflow(struct work_struct *work)
>   
>   	mutex_lock(&rdtgroup_mutex);
>   
> -	if (!static_branch_likely(&rdt_enable_key))
> +	if (!static_branch_likely(&rdt_mon_enable_key))
>   		goto out_unlock;
>   
>   	d = get_domain_from_cpu(cpu, &rdt_resources_all[RDT_RESOURCE_L3]);
> @@ -543,7 +543,7 @@ void mbm_setup_overflow_handler(struct rdt_domain *dom, unsigned long delay_ms)
>   	unsigned long delay = msecs_to_jiffies(delay_ms);
>   	int cpu;
>   
> -	if (!static_branch_likely(&rdt_enable_key))
> +	if (!static_branch_likely(&rdt_mon_enable_key))
>   		return;
>   	cpu = cpumask_any(&dom->cpu_mask);
>   	dom->mbm_work_cpu = cpu;
> 

-- 
Best regards,
Xiaochen
