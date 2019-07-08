Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44049C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E58520665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbfGHIcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:32:35 -0400
Received: from mga11.intel.com ([192.55.52.93]:22286 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfGHIcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:32:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 01:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="167614241"
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.239.195.234]) ([10.239.195.234])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2019 01:32:31 -0700
Subject: Re: [LKP] [SUNRPC] 0472e47660: fsmark.app_overhead 16.0% regression
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "rong.a.chen@intel.com" <rong.a.chen@intel.com>
Cc:     "lkp@01.org" <lkp@01.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190520055434.GZ31424@shao2-debian>
 <f1abba58-5fd2-5f26-74cc-f72724cfa13f@linux.intel.com>
 <9a07c589f955e5af5acc0fa09a16a3256089e764.camel@hammerspace.com>
 <d796ac23-d5d6-cdfa-89c8-536e9496b551@linux.intel.com>
 <9753a9a4a82943f6aacc2bfb0f93efc5f96bcaa5.camel@hammerspace.com>
 <2bbe636a-14f1-4592-d1f9-a9f765a02939@linux.intel.com>
Message-ID: <81fb0e7d-1879-9267-83da-4671fec50920@linux.intel.com>
Date:   Mon, 8 Jul 2019 16:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <2bbe636a-14f1-4592-d1f9-a9f765a02939@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

    I retest, it still can be reproduced. I test with the following 
parameters, only change "nr_threads", the test results are as the 
following. From the test results, more threads in the test, more 
regression will happen. Could you help to check? Thanks.


In testcase: fsmark
on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @ 3.00GHz 
with 384G memory
with following parameters:

         iterations: 20x
         nr_threads: 1t
         disk: 1BRD_48G
         fs: xfs
         fs2: nfsv4
         filesize: 4M
         test_size: 80G
         sync_method: fsyncBeforeClose
         cpufreq_governor: performance

test-description: The fsmark is a file system benchmark to test 
synchronous write workloads, for example, mail servers workload.
test-url: https://sourceforge.net/projects/fsmark/

commit:
   e791f8e938 ("SUNRPC: Convert xs_send_kvec() to use iov_iter_kvec()")
   0472e47660 ("SUNRPC: Convert socket page send code to use iov_iter()")

e791f8e9380d945e 0472e476604998c127f3c80d291
---------------- ---------------------------
          %stddev     %change         %stddev
              \          |                \
      59.74            -0.7%      59.32        fsmark.files_per_sec 
(nr_threads= 1)
     114.06            -8.1%     104.83        fsmark.files_per_sec 
(nr_threads= 2)
     184.53           -13.1%     160.29        fsmark.files_per_sec 
(nr_threads= 4)
     257.05           -15.5%     217.22        fsmark.files_per_sec 
(nr_threads= 8)
     306.08           -15.5%     258.68        fsmark.files_per_sec 
(nr_threads=16)
     498.34           -22.7%     385.33        fsmark.files_per_sec 
(nr_threads=32)
     527.29           -22.6%     407.96        fsmark.files_per_sec 
(nr_threads=64)



On 5/31/2019 11:27 AM, Xing Zhengjun wrote:
> 
> 
> On 5/31/2019 3:10 AM, Trond Myklebust wrote:
>> On Thu, 2019-05-30 at 15:20 +0800, Xing Zhengjun wrote:
>>>
>>> On 5/30/2019 10:00 AM, Trond Myklebust wrote:
>>>> Hi Xing,
>>>>
>>>> On Thu, 2019-05-30 at 09:35 +0800, Xing Zhengjun wrote:
>>>>> Hi Trond,
>>>>>
>>>>> On 5/20/2019 1:54 PM, kernel test robot wrote:
>>>>>> Greeting,
>>>>>>
>>>>>> FYI, we noticed a 16.0% improvement of fsmark.app_overhead due
>>>>>> to
>>>>>> commit:
>>>>>>
>>>>>>
>>>>>> commit: 0472e476604998c127f3c80d291113e77c5676ac ("SUNRPC:
>>>>>> Convert
>>>>>> socket page send code to use iov_iter()")
>>>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
>>>>>> master
>>>>>>
>>>>>> in testcase: fsmark
>>>>>> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @
>>>>>> 3.00GHz with 384G memory
>>>>>> with following parameters:
>>>>>>
>>>>>>     iterations: 1x
>>>>>>     nr_threads: 64t
>>>>>>     disk: 1BRD_48G
>>>>>>     fs: xfs
>>>>>>     fs2: nfsv4
>>>>>>     filesize: 4M
>>>>>>     test_size: 40G
>>>>>>     sync_method: fsyncBeforeClose
>>>>>>     cpufreq_governor: performance
>>>>>>
>>>>>> test-description: The fsmark is a file system benchmark to test
>>>>>> synchronous write workloads, for example, mail servers
>>>>>> workload.
>>>>>> test-url: https://sourceforge.net/projects/fsmark/
>>>>>>
>>>>>>
>>>>>>
>>>>>> Details are as below:
>>>>>> -------------------------------------------------------------
>>>>>> ----
>>>>>> --------------------------------->
>>>>>>
>>>>>>
>>>>>> To reproduce:
>>>>>>
>>>>>>            git clone https://github.com/intel/lkp-tests.git
>>>>>>            cd lkp-tests
>>>>>>            bin/lkp install job.yaml  # job file is attached in
>>>>>> this
>>>>>> email
>>>>>>            bin/lkp run     job.yaml
>>>>>>
>>>>>> ===============================================================
>>>>>> ====
>>>>>> ======================
>>>>>> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconf
>>>>>> ig/n
>>>>>> r_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>>>>>>      gcc-7/performance/1BRD_48G/4M/nfsv4/xfs/1x/x86_64-rhel-
>>>>>> 7.6/64t/debian-x86_64-2018-04-03.cgz/fsyncBeforeClose/lkp-ivb-
>>>>>> ep01/40G/fsmark
>>>>>>
>>>>>> commit:
>>>>>>      e791f8e938 ("SUNRPC: Convert xs_send_kvec() to use
>>>>>> iov_iter_kvec()")
>>>>>>      0472e47660 ("SUNRPC: Convert socket page send code to use
>>>>>> iov_iter()")
>>>>>>
>>>>>> e791f8e9380d945e 0472e476604998c127f3c80d291
>>>>>> ---------------- ---------------------------
>>>>>>           fail:runs  %reproduction    fail:runs
>>>>>>               |             |             |
>>>>>>               :4           50%           2:4     dmesg.WARNING:a
>>>>>> t#for
>>>>>> _ip_interrupt_entry/0x
>>>>>>             %stddev     %change         %stddev
>>>>>>                 \          |                \
>>>>>>      15118573
>>>>>> ±  2%     +16.0%   17538083        fsmark.app_overhead
>>>>>>        510.93           -
>>>>>> 22.7%     395.12        fsmark.files_per_sec
>>>>>>         24.90           +22.8%      30.57        fsmark.time.ela
>>>>>> psed_
>>>>>> time
>>>>>>         24.90           +22.8%      30.57        fsmark.time.ela
>>>>>> psed_
>>>>>> time.max
>>>>>>        288.00 ±  2%     -
>>>>>> 27.8%     208.00        fsmark.time.percent_of_cpu_this_job_got
>>>>>>         70.03 ±  2%     -
>>>>>> 11.3%      62.14        fsmark.time.system_time
>>>>>>
>>>>>
>>>>> Do you have time to take a look at this regression?
>>>>
>>>>   From your stats, it looks to me as if the problem is increased
>>>> NUMA
>>>> overhead. Pretty much everything else appears to be the same or
>>>> actually performing better than previously. Am I interpreting that
>>>> correctly?
>>> The real regression is the throughput(fsmark.files_per_sec) is
>>> decreased
>>> by 22.7%.
>>
>> Understood, but I'm trying to make sense of why. I'm not able to
>> reproduce this, so I have to rely on your performance stats to
>> understand where the 22.7% regression is coming from. As far as I can
>> see, the only numbers in the stats you published that are showing a
>> performance regression (other than the fsmark number itself), are the
>> NUMA numbers. Is that a correct interpretation?
>>
> We re-test the case yesterday, the test result almost is the same.
> we will do more test and also check the test case itself, if you need
> more information, please let me know, thanks.
> 
>>>> If my interpretation above is correct, then I'm not seeing where
>>>> this
>>>> patch would be introducing new NUMA regressions. It is just
>>>> converting
>>>> from using one method of doing socket I/O to another. Could it
>>>> perhaps
>>>> be a memory artefact due to your running the NFS client and server
>>>> on
>>>> the same machine?
>>>>
>>>> Apologies for pushing back a little, but I just don't have the
>>>> hardware available to test NUMA configurations, so I'm relying on
>>>> external testing for the above kind of scenario.
>>>>
>>> Thanks for looking at this.  If you need more information, please let
>>> me
>>> know.
>>>> Thanks
>>>>     Trond
>>>>
> 

-- 
Zhengjun Xing
