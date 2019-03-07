Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4678CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D50E20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfCGA4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:56:36 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:59900 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726010AbfCGA4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:56:35 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 302B53742877732435B7;
        Thu,  7 Mar 2019 08:56:33 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.408.0; Thu, 7 Mar 2019
 08:56:29 +0800
Subject: Re: [tip:x86/urgent] x86/mm: Remove unused variable 'cpu'
To:     <hpa@zytor.com>, <linux-kernel@vger.kernel.org>, <cai@lca.pw>,
        <luto@kernel.org>, <tglx@linutronix.de>, <mingo@kernel.org>,
        <linux-tip-commits@vger.kernel.org>, Borislav Petkov <bp@suse.de>
References: <20190228220155.88124-1-cai@lca.pw>
 <tip-3609e31bc8dc03b701390f79c74fc7fe92b95039@git.kernel.org>
From:   Zhangshaokun <zhangshaokun@hisilicon.com>
Message-ID: <5ec9d97d-f225-e9be-58dc-fed582d8e45d@hisilicon.com>
Date:   Thu, 7 Mar 2019 08:56:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <tip-3609e31bc8dc03b701390f79c74fc7fe92b95039@git.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A little confused,
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/cleanups&id=691b9ab6c9676e5868a4787be9041dd990005311

On 2019/3/7 6:33, tip-bot for Qian Cai wrote:
> Commit-ID:  3609e31bc8dc03b701390f79c74fc7fe92b95039
> Gitweb:     https://git.kernel.org/tip/3609e31bc8dc03b701390f79c74fc7fe92b95039
> Author:     Qian Cai <cai@lca.pw>
> AuthorDate: Thu, 28 Feb 2019 17:01:55 -0500
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Wed, 6 Mar 2019 23:24:52 +0100
> 
> x86/mm: Remove unused variable 'cpu'
> 
> The commit a2055abe9c67 ("x86/mm: Pass flush_tlb_info to
> flush_tlb_others() etc") removed the unnecessary cpu parameter from
> uv_flush_tlb_others() but left an unused variable.
> 
> arch/x86/mm/tlb.c: In function 'native_flush_tlb_others':
> arch/x86/mm/tlb.c:688:16: warning: variable 'cpu' set but not used
> [-Wunused-but-set-variable]
>    unsigned int cpu;
>                 ^~~
> 
> Fixes: a2055abe9c67 ("x86/mm: Pass flush_tlb_info to flush_tlb_others() etc")
> Signed-off-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Andyt Lutomirski <luto@kernel.org>
> Cc: dave.hansen@linux.intel.com
> Cc: peterz@infradead.org
> Cc: bp@alien8.de
> Cc: hpa@zytor.com
> Link: https://lkml.kernel.org/r/20190228220155.88124-1-cai@lca.pw
> 
> ---
>  arch/x86/mm/tlb.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index 999d6d8f0bef..bc4bc7b2f075 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -685,9 +685,6 @@ void native_flush_tlb_others(const struct cpumask *cpumask,
>  		 * that UV should be updated so that smp_call_function_many(),
>  		 * etc, are optimal on UV.
>  		 */
> -		unsigned int cpu;
> -
> -		cpu = smp_processor_id();
>  		cpumask = uv_flush_tlb_others(cpumask, info);
>  		if (cpumask)
>  			smp_call_function_many(cpumask, flush_tlb_func_remote,
> 
> .
> 

