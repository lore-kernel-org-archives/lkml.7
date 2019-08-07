Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8B1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4857F21BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 07:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387551AbfHGH4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 03:56:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:62279 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfHGH43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 03:56:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 00:56:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,356,1559545200"; 
   d="scan'208";a="374318653"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.239.196.126]) ([10.239.196.126])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2019 00:56:25 -0700
Subject: Re: [LKP] [SUNRPC] 0472e47660: fsmark.app_overhead 16.0% regression
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "rong.a.chen@intel.com" <rong.a.chen@intel.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "lkp@01.org" <lkp@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190520055434.GZ31424@shao2-debian>
 <f1abba58-5fd2-5f26-74cc-f72724cfa13f@linux.intel.com>
 <9a07c589f955e5af5acc0fa09a16a3256089e764.camel@hammerspace.com>
 <d796ac23-d5d6-cdfa-89c8-536e9496b551@linux.intel.com>
 <9753a9a4a82943f6aacc2bfb0f93efc5f96bcaa5.camel@hammerspace.com>
 <2bbe636a-14f1-4592-d1f9-a9f765a02939@linux.intel.com>
 <81fb0e7d-1879-9267-83da-4671fec50920@linux.intel.com>
 <DM5PR13MB1851813BBEA446E25C5001C2B8F60@DM5PR13MB1851.namprd13.prod.outlook.com>
 <e29f82e0-6847-b264-300b-130bb31399d1@linux.intel.com>
 <b4e5ab18-6329-f22e-3962-230c965b0b5d@linux.intel.com>
 <491bd283-f607-3111-32ae-07294eda123d@linux.intel.com>
Message-ID: <081447bc-69c5-aa45-8f85-29add0b83c15@linux.intel.com>
Date:   Wed, 7 Aug 2019 15:56:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <491bd283-f607-3111-32ae-07294eda123d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/2019 1:17 PM, Xing Zhengjun wrote:
> 
> 
> On 7/12/2019 2:42 PM, Xing Zhengjun wrote:
>> Hi Trond,
>>
>>      I attached perf-profile part big changes, hope it is useful for 
>> analyzing the issue.
> 
> Ping...

ping...

> 
>>
>>
>> In testcase: fsmark
>> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz 
>> with 384G memory
>> with following parameters:
>>
>>          iterations: 20x
>>          nr_threads: 64t
>>          disk: 1BRD_48G
>>          fs: xfs
>>          fs2: nfsv4
>>          filesize: 4M
>>          test_size: 80G
>>          sync_method: fsyncBeforeClose
>>          cpufreq_governor: performance
>>
>> test-description: The fsmark is a file system benchmark to test 
>> synchronous write workloads, for example, mail servers workload.
>> test-url: https://sourceforge.net/projects/fsmark/
>>
>> commit:
>>    e791f8e938 ("SUNRPC: Convert xs_send_kvec() to use iov_iter_kvec()")
>>    0472e47660 ("SUNRPC: Convert socket page send code to use iov_iter()")
>>
>> e791f8e9380d945e 0472e476604998c127f3c80d291
>> ---------------- ---------------------------
>>           %stddev     %change         %stddev
>>               \          |                \
>>      527.29           -22.6%     407.96        fsmark.files_per_sec
>>        1.97 ± 11%      +0.9        2.88 ±  4% 
>> perf-profile.calltrace.cycles-pp.smp_apic_timer_interrupt.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry 
>>
>>        0.00            +0.9        0.93 ±  4% 
>> perf-profile.calltrace.cycles-pp.tcp_write_xmit.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.xs_sendpages 
>>
>>        2.11 ± 10%      +0.9        3.05 ±  4% 
>> perf-profile.calltrace.cycles-pp.apic_timer_interrupt.cpuidle_enter_state.do_idle.cpu_startup_entry.start_secondary 
>>
>>        5.29 ±  2%      +1.2        6.46 ±  7% 
>> perf-profile.calltrace.cycles-pp.svc_recv.nfsd.kthread.ret_from_fork
>>        9.61 ±  5%      +3.1       12.70 ±  2% 
>> perf-profile.calltrace.cycles-pp.worker_thread.kthread.ret_from_fork
>>        9.27 ±  5%      +3.1       12.40 ±  2% 
>> perf-profile.calltrace.cycles-pp.process_one_work.worker_thread.kthread.ret_from_fork 
>>
>>       34.52 ±  4%      +3.3       37.78 ±  2% 
>> perf-profile.calltrace.cycles-pp.ret_from_fork
>>       34.52 ±  4%      +3.3       37.78 ±  2% 
>> perf-profile.calltrace.cycles-pp.kthread.ret_from_fork
>>        0.00            +3.4        3.41 ±  4% 
>> perf-profile.calltrace.cycles-pp.memcpy_erms.memcpy_from_page._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg 
>>
>>        0.00            +3.4        3.44 ±  4% 
>> perf-profile.calltrace.cycles-pp.memcpy_from_page._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg 
>>
>>        0.00            +3.5        3.54 ±  4% 
>> perf-profile.calltrace.cycles-pp._copy_from_iter_full.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.xs_sendpages 
>>
>>        2.30 ±  5%      +3.7        6.02 ±  3% 
>> perf-profile.calltrace.cycles-pp.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread.kthread 
>>
>>        2.30 ±  5%      +3.7        6.02 ±  3% 
>> perf-profile.calltrace.cycles-pp.rpc_async_schedule.process_one_work.worker_thread.kthread.ret_from_fork 
>>
>>        1.81 ±  4%      +3.8        5.59 ±  4% 
>> perf-profile.calltrace.cycles-pp.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work.worker_thread 
>>
>>        1.80 ±  3%      +3.8        5.59 ±  3% 
>> perf-profile.calltrace.cycles-pp.xprt_transmit.call_transmit.__rpc_execute.rpc_async_schedule.process_one_work 
>>
>>        1.73 ±  4%      +3.8        5.54 ±  4% 
>> perf-profile.calltrace.cycles-pp.xs_tcp_send_request.xprt_transmit.call_transmit.__rpc_execute.rpc_async_schedule 
>>
>>        1.72 ±  4%      +3.8        5.54 ±  4% 
>> perf-profile.calltrace.cycles-pp.xs_sendpages.xs_tcp_send_request.xprt_transmit.call_transmit.__rpc_execute 
>>
>>        0.00            +5.4        5.42 ±  4% 
>> perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.sock_sendmsg.xs_sendpages.xs_tcp_send_request 
>>
>>        0.00            +5.5        5.52 ±  4% 
>> perf-profile.calltrace.cycles-pp.tcp_sendmsg.sock_sendmsg.xs_sendpages.xs_tcp_send_request.xprt_transmit 
>>
>>        0.00            +5.5        5.53 ±  4% 
>> perf-profile.calltrace.cycles-pp.sock_sendmsg.xs_sendpages.xs_tcp_send_request.xprt_transmit.call_transmit 
>>
>>        9.61 ±  5%      +3.1       12.70 ±  2% 
>> perf-profile.children.cycles-pp.worker_thread
>>        9.27 ±  5%      +3.1       12.40 ±  2% 
>> perf-profile.children.cycles-pp.process_one_work
>>        6.19            +3.2        9.40 ±  4% 
>> perf-profile.children.cycles-pp.memcpy_erms
>>       34.53 ±  4%      +3.3       37.78 ±  2% 
>> perf-profile.children.cycles-pp.ret_from_fork
>>       34.52 ±  4%      +3.3       37.78 ±  2% 
>> perf-profile.children.cycles-pp.kthread
>>        0.00            +3.5        3.46 ±  4% 
>> perf-profile.children.cycles-pp.memcpy_from_page
>>        0.00            +3.6        3.56 ±  4% 
>> perf-profile.children.cycles-pp._copy_from_iter_full
>>        2.47 ±  4%      +3.7        6.18 ±  3% 
>> perf-profile.children.cycles-pp.__rpc_execute
>>        2.30 ±  5%      +3.7        6.02 ±  3% 
>> perf-profile.children.cycles-pp.rpc_async_schedule
>>        1.90 ±  4%      +3.8        5.67 ±  3% 
>> perf-profile.children.cycles-pp.call_transmit
>>        1.89 ±  3%      +3.8        5.66 ±  3% 
>> perf-profile.children.cycles-pp.xprt_transmit
>>        1.82 ±  4%      +3.8        5.62 ±  3% 
>> perf-profile.children.cycles-pp.xs_tcp_send_request
>>        1.81 ±  4%      +3.8        5.62 ±  3% 
>> perf-profile.children.cycles-pp.xs_sendpages
>>        0.21 ± 17%      +5.3        5.48 ±  4% 
>> perf-profile.children.cycles-pp.tcp_sendmsg_locked
>>        0.25 ± 18%      +5.3        5.59 ±  3% 
>> perf-profile.children.cycles-pp.tcp_sendmsg
>>        0.26 ± 16%      +5.3        5.60 ±  3% 
>> perf-profile.children.cycles-pp.sock_sendmsg
>>        1.19 ±  5%      +0.5        1.68 ±  3% 
>> perf-profile.self.cycles-pp.get_page_from_freelist
>>        6.10            +3.2        9.27 ±  4% 
>> perf-profile.self.cycles-pp.memcpy_erms
>>
>>
>> On 7/9/2019 10:39 AM, Xing Zhengjun wrote:
>>> Hi Trond,
>>>
>>> On 7/8/2019 7:44 PM, Trond Myklebust wrote:
>>>> I've asked several times now about how to interpret your results. As 
>>>> far as I can tell from your numbers, the overhead appears to be 
>>>> entirely contained in the NUMA section of your results.
>>>> IOW: it would appear to be a scheduling overhead due to NUMA. I've 
>>>> been asking whether or not that is a correct interpretation of the 
>>>> numbers you published.
>>> Thanks for your feedback. I used the same hardware and the same test 
>>> parameters to test the two commits:
>>>     e791f8e938 ("SUNRPC: Convert xs_send_kvec() to use iov_iter_kvec()")
>>>     0472e47660 ("SUNRPC: Convert socket page send code to use 
>>> iov_iter()")
>>>
>>> If it is caused by NUMA, why only commit 0472e47660 throughput is 
>>> decreased? The filesystem we test is NFS, commit 0472e47660 is 
>>> related with the network, could you help to check if have any other 
>>> clues for the regression. Thanks.
>>>
>>
> 

-- 
Zhengjun Xing
