Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46620C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF8220693
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 16:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbfDYQjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:39:40 -0400
Received: from foss.arm.com ([217.140.101.70]:48166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726380AbfDYQjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 12:39:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 379DE80D;
        Thu, 25 Apr 2019 09:39:39 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B2DB3F557;
        Thu, 25 Apr 2019 09:39:38 -0700 (PDT)
Subject: Re: [RFC PATCH] kprobes/arm64: Blacklist functions called in
 '_sdei_handler'
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1555751217-54310-1-git-send-email-wangxiongfeng2@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d9f89a0d-bb73-7162-9fcf-2bcc2ea4bc66@arm.com>
Date:   Thu, 25 Apr 2019 17:39:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1555751217-54310-1-git-send-email-wangxiongfeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiongfeng Wang,

On 20/04/2019 10:06, Xiongfeng Wang wrote:
> Functions called in '_sdei_handler' are needed to be marked as
> 'nokprobe'.

+ "Because these functions are called in NMI context and neither the arch-code's debug
infrastructure nor kprobes core supports this."


> ---
> When I kprobe 'sdei_smccc_smc',

Heh, when debugging this I put printk()s on the other side.


> the cpu hungs. I am not sure if it is
> becase when SDEI events interrupt EL0, '__sdei_asm_entry_trampoline'
> didn't restore vbar_el1 with kernel vectors.

Yes, we don't expect exceptions from the NMI handler, so VBAR_EL1 is left as whatever its
current state is. Today it could be the EL0 trampoline, the kernel vectors proper, or KVMs
vectors. This may change in the future, all SDEI does with VBAR_EL1 is emulate the
architecture: read it in order to fake up an interrupt on exit.


> Or is it becasue brk
> exception corrupt elr_el1 and trust firmware didn't preserve it for us?

Yes, this too! "5.2.1.1 Client responsibilities" of [0]
| The handler may modify the accessible System registers, but these must be restored
| before the handler completes.

We don't do this, because its extra work, and we don't ever anticipate it being necessary.


> drivers/firmware/arm_sdei.c | 3 +++
> 1 file changed, 3 insertions(+)

Nit: Because this patch only touches this file, the subject prefix should really be
"firmware: arm_sdei:". Running 'git log --online' over a file should give you a hint at
what the expected style is. This lets people spot the patches they need to look at.



> diff --git a/drivers/firmware/arm_sdei.c b/drivers/firmware/arm_sdei.c
> index e6376f9..9cd70d1 100644
> --- a/drivers/firmware/arm_sdei.c
> +++ b/drivers/firmware/arm_sdei.c
> @@ -165,6 +165,7 @@ static int invoke_sdei_fn(unsigned long function_id, unsigned long arg0,
>  
>  	return err;
>  }
> +NOKPROBE_SYMBOL(invoke_sdei_fn);

Ah! These are called via sdei_api_event_context(). Oops.


>  static struct sdei_event *sdei_event_find(u32 event_num)
>  {
> @@ -879,6 +880,7 @@ static void sdei_smccc_smc(unsigned long function_id,
>  {
>  	arm_smccc_smc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
>  }
> +NOKPROBE_SYMBOL(sdei_smccc_smc);
>  
>  static void sdei_smccc_hvc(unsigned long function_id,
>  			   unsigned long arg0, unsigned long arg1,
> @@ -887,6 +889,7 @@ static void sdei_smccc_hvc(unsigned long function_id,
>  {
>  	arm_smccc_hvc(function_id, arg0, arg1, arg2, arg3, arg4, 0, 0, res);
>  }
> +NOKPROBE_SYMBOL(sdei_smccc_hvc);
>  
>  int sdei_register_ghes(struct ghes *ghes, sdei_event_callback *normal_cb,
>  		       sdei_event_callback *critical_cb)


Thanks for making this more robust!

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James


[0]
http://infocenter.arm.com/help/topic/com.arm.doc.den0054a/ARM_DEN0054A_Software_Delegated_Exception_Interface.pdf
