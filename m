Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A1C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0ED12084F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 20:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfDHUdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 16:33:05 -0400
Received: from gateway36.websitewelcome.com ([192.185.188.18]:11761 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726930AbfDHUdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 16:33:05 -0400
X-Greylist: delayed 1490 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Apr 2019 16:33:04 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id B5C39400F4939
        for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2019 14:25:35 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id DaYrhycr52qH7DaYrhM2SA; Mon, 08 Apr 2019 15:08:09 -0500
X-Authority-Reason: nr=8
Received: from [189.250.139.70] (port=56318 helo=[192.168.1.76])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hDaYr-001Va3-1V; Mon, 08 Apr 2019 15:08:09 -0500
Subject: Re: [PATCH] perf header: Fix lock/unlock imbalances
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190408173355.GA10501@embeddedor>
 <B581617C-53AD-435A-8352-5E5A74B76B34@fb.com>
 <3867ffda-5d01-412b-ed55-e39ee9db2ceb@embeddedor.com>
 <20190408193555.GA5796@kernel.org>
 <3958468b-e98b-67da-f802-f1a5d5c81d91@embeddedor.com>
 <20190408200050.GD5796@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Message-ID: <7a84fef4-ebf4-e70b-2891-6c8ff8a5d828@embeddedor.com>
Date:   Mon, 8 Apr 2019 15:08:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190408200050.GD5796@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.139.70
X-Source-L: No
X-Exim-ID: 1hDaYr-001Va3-1V
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.76]) [189.250.139.70]:56318
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/19 3:00 PM, Arnaldo Carvalho de Melo wrote:
> Em Mon, Apr 08, 2019 at 02:52:52PM -0500, Gustavo A. R. Silva escreveu:
>>
>>
>> On 4/8/19 2:35 PM, Arnaldo Carvalho de Melo wrote:
>>> Em Mon, Apr 08, 2019 at 01:26:09PM -0500, Gustavo A. R. Silva escreveu:
>>>>
>>>>
>>>> On 4/8/19 1:22 PM, Song Liu wrote:
>>>>>
>>>>>
>>>>>> On Apr 8, 2019, at 10:33 AM, Gustavo A. R. Silva <gustavo@embeddedor.com> wrote:
>>>>>>
>>>>>> Fix lock/unlock imbalances by refactoring the code a bit and adding
>>>>>> calls to up_write() before return.
>>>>>>
>>>>>> Addresses-Coverity-ID: 1444315 ("Missing unlock")
>>>>>> Addresses-Coverity-ID: 1444316 ("Missing unlock")
>>>>>> Fixes: a70a1123174a ("perf bpf: Save BTF information as headers to perf.data")
>>>>>> Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
>>>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>>>
>>>>> Acked-by: Song Liu <songliubraving@fb.com>
>>>>>
>>>>> Thanks for the fix!
>>>>>
>>>>
>>>> Glad to help. :)
>>>
>>> Super cool, using the same idiom as the kernel and living in the kernel
>>> sources has its advantages 8-)
>>>
>>
>> :P
>>
>>> But see below, 
>>>
>>>>>> +++ b/tools/perf/util/header.c
>>>>>> @@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
>>>>>> 		perf_env__insert_bpf_prog_info(env, info_node);
>>>>>> 	}
>>>>>>
>>>>>> +	up_write(&env->bpf_progs.lock);
>>>>>> 	return 0;
>>>>>> out:
>>>>>> 	free(info_linear);
>>>>>> @@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
>>>>>> static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
>>>>>> {
>>>>>> 	struct perf_env *env = &ff->ph->env;
>>>>>> +	struct btf_node *node;
>>>>>> 	u32 count, i;
>>>>>> +	int err = -1;
>>>
>>> Why are you using this 'err' variable? It is only set here and at the
>>> end, i.e. one write, one read. We could as well have that out: block
>>> return -1 straight away.
>>>
>>> Else we could do, see below
>>>
>>>>>>
>>>>>> 	if (ff->ph->needs_swap) {
>>>>>> 		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
>>>>>> @@ -2636,31 +2639,33 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
>>>>>> 	down_write(&env->bpf_progs.lock);
>>>>>>
>>>>>> 	for (i = 0; i < count; ++i) {
>>>>>> -		struct btf_node *node;
>>>>>> 		u32 id, data_size;
>>>>>>
>>>>>> +		node = NULL;
>>>>>> 		if (do_read_u32(ff, &id))
>>>>>> -			return -1;
>>>>>> +			goto out;
>>>>>> 		if (do_read_u32(ff, &data_size))
>>>>>> -			return -1;
>>>>>> +			goto out;
>>>>>>
>>>>>> 		node = malloc(sizeof(struct btf_node) + data_size);
>>>>>> 		if (!node)
>>>>>> -			return -1;
>>>>>> +			goto out;
>>>>>>
>>>>>> 		node->id = id;
>>>>>> 		node->data_size = data_size;
>>>>>>
>>>>>> -		if (__do_read(ff, node->data, data_size)) {
>>>>>> -			free(node);
>>>>>> -			return -1;
>>>>>> -		}
>>>>>> +		if (__do_read(ff, node->data, data_size))
>>>>>> +			goto out;
>>>>>>
>>>>>> 		perf_env__insert_btf(env, node);
>>>>>> 	}
>>>
>>>       err = 0;
>>>
>>>>>>
>>>
>>> out:
>>>
>>>>>> 	up_write(&env->bpf_progs.lock);
>>>
>>>       return err;
>>>
>>> And delete the rest.
>>>
>>> but I see, you used the same pattern in the first #ifdef HAVE_LIBBPF_SUPPORT
>>> block :-)
>>>
>>> Anyway, since we're fixing up that other case, we might as well
>>> streamline this, please check the patch below.
>>>
>>
>> Yeah. This is exactly how I would have coded this from the beginning. But, as you
>> correctly pointed out, I'm using the same pattern as in HAVE_LIBBPF_SUPPORT. :)
>>
>> Just a comment below...
>>
>>>>>> 	return 0;
>>>
>>>>>> +out:
>>>>>> +	up_write(&env->bpf_progs.lock);
>>>>>> +	free(node);
>>>>>> +	return err;
>>>
>>> So, that is what I'm applying, please holler if I introduced some
>>> problem:
>>>
>>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>>> index b9e693825873..2d2af2ac2b1e 100644
>>> --- a/tools/perf/util/header.c
>>> +++ b/tools/perf/util/header.c
>>> @@ -2606,6 +2606,7 @@ static int process_bpf_prog_info(struct feat_fd *ff, void *data __maybe_unused)
>>>  		perf_env__insert_bpf_prog_info(env, info_node);
>>>  	}
>>>  
>>> +	up_write(&env->bpf_progs.lock);
>>>  	return 0;
>>>  out:
>>>  	free(info_linear);
>>> @@ -2623,7 +2624,9 @@ static int process_bpf_prog_info(struct feat_fd *ff __maybe_unused, void *data _
>>>  static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
>>>  {
>>>  	struct perf_env *env = &ff->ph->env;
>>> +	struct btf_node *node = NULL;
>>>  	u32 count, i;
>>> +	int err = -1;
>>>  
>>>  	if (ff->ph->needs_swap) {
>>>  		pr_warning("interpreting btf from systems with endianity is not yet supported\n");
>>> @@ -2636,31 +2639,32 @@ static int process_bpf_btf(struct feat_fd *ff, void *data __maybe_unused)
>>>  	down_write(&env->bpf_progs.lock);
>>>  
>>>  	for (i = 0; i < count; ++i) {
>>> -		struct btf_node *node;
>>>  		u32 id, data_size;
>>>  
>>>  		if (do_read_u32(ff, &id))
>>> -			return -1;
>>> +			goto out;
>>>  		if (do_read_u32(ff, &data_size))
>>> -			return -1;
>>> +			goto out;
>>>  
>>>  		node = malloc(sizeof(struct btf_node) + data_size);
>>>  		if (!node)
>>> -			return -1;
>>> +			goto out;
>>>  
>>>  		node->id = id;
>>>  		node->data_size = data_size;
>>>  
>>> -		if (__do_read(ff, node->data, data_size)) {
>>> -			free(node);
>>> -			return -1;
>>> -		}
>>> +		if (__do_read(ff, node->data, data_size))
>>> +			goto out;
>>>  
>>>  		perf_env__insert_btf(env, node);
>>> +		node = NULL;
>>
>> If we move this assignment to the beginning of the for loop, as in
>> the original patch, we avoid the same assignment while declaring
>> node at the beginning of the function.
> 
> No, we don't, since the common exit path frees node, we better not free
> the last node in the success case, that is why I moved it to the end,
> i.e. after we're done with it, nullify it, so that the last btf_node
> isn't freed in the now uncoditionall free(node); call :-)
> 

Yep. You're right.

So, everything is fine now. :)

Thanks
--
Gustavo
