Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A07BC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40C025097
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 07:20:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfE3HUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 03:20:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:38341 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbfE3HUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 03:20:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 00:20:30 -0700
X-ExtLoop1: 1
Received: from xingzhen-mobl1.ccr.corp.intel.com (HELO [10.239.196.133]) ([10.239.196.133])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2019 00:20:28 -0700
Subject: Re: [LKP] [SUNRPC] 0472e47660: fsmark.app_overhead 16.0% regression
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "rong.a.chen@intel.com" <rong.a.chen@intel.com>
Cc:     "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "lkp@01.org" <lkp@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190520055434.GZ31424@shao2-debian>
 <f1abba58-5fd2-5f26-74cc-f72724cfa13f@linux.intel.com>
 <9a07c589f955e5af5acc0fa09a16a3256089e764.camel@hammerspace.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <d796ac23-d5d6-cdfa-89c8-536e9496b551@linux.intel.com>
Date:   Thu, 30 May 2019 15:20:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9a07c589f955e5af5acc0fa09a16a3256089e764.camel@hammerspace.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2019 10:00 AM, Trond Myklebust wrote:
> Hi Xing,
> 
> On Thu, 2019-05-30 at 09:35 +0800, Xing Zhengjun wrote:
>> Hi Trond,
>>
>> On 5/20/2019 1:54 PM, kernel test robot wrote:
>>> Greeting,
>>>
>>> FYI, we noticed a 16.0% improvement of fsmark.app_overhead due to
>>> commit:
>>>
>>>
>>> commit: 0472e476604998c127f3c80d291113e77c5676ac ("SUNRPC: Convert
>>> socket page send code to use iov_iter()")
>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git
>>> master
>>>
>>> in testcase: fsmark
>>> on test machine: 40 threads Intel(R) Xeon(R) CPU E5-2690 v2 @
>>> 3.00GHz with 384G memory
>>> with following parameters:
>>>
>>> 	iterations: 1x
>>> 	nr_threads: 64t
>>> 	disk: 1BRD_48G
>>> 	fs: xfs
>>> 	fs2: nfsv4
>>> 	filesize: 4M
>>> 	test_size: 40G
>>> 	sync_method: fsyncBeforeClose
>>> 	cpufreq_governor: performance
>>>
>>> test-description: The fsmark is a file system benchmark to test
>>> synchronous write workloads, for example, mail servers workload.
>>> test-url: https://sourceforge.net/projects/fsmark/
>>>
>>>
>>>
>>> Details are as below:
>>> -----------------------------------------------------------------
>>> --------------------------------->
>>>
>>>
>>> To reproduce:
>>>
>>>           git clone https://github.com/intel/lkp-tests.git
>>>           cd lkp-tests
>>>           bin/lkp install job.yaml  # job file is attached in this
>>> email
>>>           bin/lkp run     job.yaml
>>>
>>> ===================================================================
>>> ======================
>>> compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/n
>>> r_threads/rootfs/sync_method/tbox_group/test_size/testcase:
>>>     gcc-7/performance/1BRD_48G/4M/nfsv4/xfs/1x/x86_64-rhel-
>>> 7.6/64t/debian-x86_64-2018-04-03.cgz/fsyncBeforeClose/lkp-ivb-
>>> ep01/40G/fsmark
>>>
>>> commit:
>>>     e791f8e938 ("SUNRPC: Convert xs_send_kvec() to use
>>> iov_iter_kvec()")
>>>     0472e47660 ("SUNRPC: Convert socket page send code to use
>>> iov_iter()")
>>>
>>> e791f8e9380d945e 0472e476604998c127f3c80d291
>>> ---------------- ---------------------------
>>>          fail:runs  %reproduction    fail:runs
>>>              |             |             |
>>>              :4           50%           2:4     dmesg.WARNING:at#for
>>> _ip_interrupt_entry/0x
>>>            %stddev     %change         %stddev
>>>                \          |                \
>>>     15118573 ±  2%     +16.0%   17538083        fsmark.app_overhead
>>>       510.93           -22.7%     395.12        fsmark.files_per_sec
>>>        24.90           +22.8%      30.57        fsmark.time.elapsed_
>>> time
>>>        24.90           +22.8%      30.57        fsmark.time.elapsed_
>>> time.max
>>>       288.00 ±  2%     -
>>> 27.8%     208.00        fsmark.time.percent_of_cpu_this_job_got
>>>        70.03 ±  2%     -
>>> 11.3%      62.14        fsmark.time.system_time
>>>
>>
>> Do you have time to take a look at this regression?
> 
>  From your stats, it looks to me as if the problem is increased NUMA
> overhead. Pretty much everything else appears to be the same or
> actually performing better than previously. Am I interpreting that
> correctly?
The real regression is the throughput(fsmark.files_per_sec) is decreased 
by 22.7%.
> 
> If my interpretation above is correct, then I'm not seeing where this
> patch would be introducing new NUMA regressions. It is just converting
> from using one method of doing socket I/O to another. Could it perhaps
> be a memory artefact due to your running the NFS client and server on
> the same machine?
> 
> Apologies for pushing back a little, but I just don't have the
> hardware available to test NUMA configurations, so I'm relying on
> external testing for the above kind of scenario.
> 
Thanks for looking at this.  If you need more information, please let me
know.
> Thanks
>    Trond
> 

-- 
Zhengjun Xing
