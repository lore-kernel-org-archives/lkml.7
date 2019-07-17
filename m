Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE04C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80DA2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 08:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="s80NVPKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfGQIMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 04:12:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53136 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfGQIMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 04:12:19 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H89Csd029424;
        Wed, 17 Jul 2019 08:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=mpjya3Lap+ZyvSIITTGtisS8qHruXjjl3vkeQTXCh/A=;
 b=s80NVPKzItHCxLnLJU4/xUQ99WKWLt2cg/r1U7tWkUeuJs5xpfHmHRcBOjOfCwOUq0va
 P/1fKVUh/eLT/pv2gYEapFBFwMzFgObROFks2had3y7dSdgRR8mSbhsg9ip2amW2FppS
 DquGBMlJyGb/UU/AJ9mXbDr6gbdG9GbQ38ZiPU1ZyjBcU/OFIP5um89zITBil+uOejZF
 oSHCYAAuW40xP6r7J9kOvI0u7jTWZhqwbwqIrhWiOI4oXVKq9bHMk23JKwGVobd7BJss
 UT2ernRLTvqH3dSXGro1/LWfjNMSLBVPXQYI1iOduGfgEYN0uJAjsBwLTWbcevUuWGk4 Pw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78ps04v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 08:11:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H87isD117366;
        Wed, 17 Jul 2019 08:11:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tsmcc8rcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 08:11:24 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H8BLuA009883;
        Wed, 17 Jul 2019 08:11:21 GMT
Received: from [10.175.27.185] (/10.175.27.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 08:11:21 +0000
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <20190717080725.GK3402@hirez.programming.kicks-ass.net>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Message-ID: <b0a3406c-5de7-20e0-0f09-dbb7222426e2@oracle.com>
Date:   Wed, 17 Jul 2019 10:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190717080725.GK3402@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=944
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=995 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/19 10:07 AM, Peter Zijlstra wrote:
> On Tue, Jul 16, 2019 at 09:33:50PM +0200, Vegard Nossum wrote:
>> ------------[ cut here ]------------
>> General protection fault in user access. Non-canonical address?
>> WARNING: CPU: 0 PID: 5039 at arch/x86/mm/extable.c:126
>> ex_handler_uaccess+0x5d/0x70
[...]
> 
> 
>    https://lkml.kernel.org/r/57754f11-2c65-a2c8-2f6d-bfab0d2f8b53@etsukata.com
> 
> Does something like the below help?
> 
> diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
> index c8d0f05721a1..80ad4ccb7025 100644
> --- a/kernel/stacktrace.c
> +++ b/kernel/stacktrace.c
> @@ -226,12 +226,16 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size)
>   		.store	= store,
>   		.size	= size,
>   	};
> +	mm_segment_t fs;
>   
>   	/* Trace user stack if not a kernel thread */
>   	if (current->flags & PF_KTHREAD)
>   		return 0;
>   
> +	fs = get_fs();
> +	set_fs(USER_DS);
>   	arch_stack_walk_user(consume_entry, &c, task_pt_regs(current));
> +	set_fs(fs);
>   	return c.len;
>   }
>   #endif
> 

Yes.


Vegard
