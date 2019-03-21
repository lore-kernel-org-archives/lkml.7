Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964F1C10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA8F2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:28:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfCUJ26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:28:58 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:55345 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728022AbfCUJ25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:28:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04389;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TNGmJqv_1553160524;
Received: from ali-6c96cfe0d157.local(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0TNGmJqv_1553160524)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Mar 2019 17:28:54 +0800
Subject: Re: [PATCH] bpf: do not restore dst_reg when cur_state is freed
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <eec7905a71d207f7612e9d86e1bf59c43efc65a4.1553156792.git.xuyu@linux.alibaba.com>
 <fe7367c5-b172-709f-1ba2-61136a74081e@iogearbox.net>
From:   Yu Xu <xuyu@linux.alibaba.com>
Message-ID: <b51889f6-6696-4e51-d63f-e5c70e109710@linux.alibaba.com>
Date:   Thu, 21 Mar 2019 17:28:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <fe7367c5-b172-709f-1ba2-61136a74081e@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 4:50 PM, Daniel Borkmann wrote:
> On 03/21/2019 09:31 AM, Xu Yu wrote:
>> Syzkaller hit 'KASAN: use-after-free Write in sanitize_ptr_alu' bug.
>> Call trace:
>>    dump_stack+0xbf/0x12e
>>    print_address_description+0x6a/0x280
>>    kasan_report+0x237/0x360
>>    sanitize_ptr_alu+0x85a/0x8d0
>>    adjust_ptr_min_max_vals+0x8f2/0x1ca0
>>    adjust_reg_min_max_vals+0x8ed/0x22e0
>>    do_check+0x1ca6/0x5d00
>>    bpf_check+0x9ca/0x2570
>>    bpf_prog_load+0xc91/0x1030
>>    __se_sys_bpf+0x61e/0x1f00
>>    do_syscall_64+0xc8/0x550
>>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> Fault injection trace:
>>    kfree+0xea/0x290
>>    free_func_state+0x4a/0x60
>>    free_verifier_state+0x61/0xe0
>>    push_stack+0x216/0x2f0	          <- inject failslab
>>    sanitize_ptr_alu+0x2b1/0x8d0
>>    adjust_ptr_min_max_vals+0x8f2/0x1ca0
>>    adjust_reg_min_max_vals+0x8ed/0x22e0
>>    do_check+0x1ca6/0x5d00
>>    bpf_check+0x9ca/0x2570
>>    bpf_prog_load+0xc91/0x1030
>>    __se_sys_bpf+0x61e/0x1f00
>>    do_syscall_64+0xc8/0x550
>>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
>>
>> When kzalloc() fails in push_stack(), free_verifier_state() will free
>> current verifier state. As push_stack() returns, dst_reg was restored
>> if ptr_is_dst_reg is false. However, as member of the cur_state, dst_reg
>> is also freed, and error occurs when dereferencing dst_reg.
>>
>> Simply fix it by checking whether cur_state is NULL before retoring
>> dst_reg.
>>
>> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
>> ---
>>   kernel/bpf/verifier.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index ce166a0..018ce4f 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3368,7 +3368,7 @@ static int sanitize_ptr_alu(struct bpf_verifier_env *env,
>>   		*dst_reg = *ptr_reg;
>>   	}
>>   	ret = push_stack(env, env->insn_idx + 1, env->insn_idx, true);
>> -	if (!ptr_is_dst_reg)
>> +	if (!ptr_is_dst_reg && env->cur_state)
>>   		*dst_reg = tmp;
> 
> Good catch, test should be more obvious rewritten as:
> 
>    if (!ptr_is_dst_reg && ret)
> 
> Could you resubmit with that?

sure, will send patch v2 later.

thanks,
Yu

> 
>>   	return !ret ? -EFAULT : 0;
>>   }
>>
> 
> Thanks,
> Daniel
> 
