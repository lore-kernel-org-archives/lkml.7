Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9224CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B45C2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 11:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfJaLm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 07:42:57 -0400
Received: from mga03.intel.com ([134.134.136.65]:6155 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbfJaLm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 07:42:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Oct 2019 04:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,250,1569308400"; 
   d="scan'208";a="212433151"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga002.jf.intel.com with ESMTP; 31 Oct 2019 04:42:51 -0700
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Dario Faggioli <dfaggioli@suse.com>,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1572437285.git.vpillai@digitalocean.com>
Message-ID: <ac746638-9d6e-dde6-59ef-dc6f4e19caa0@linux.intel.com>
Date:   Thu, 31 Oct 2019 19:42:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <cover.1572437285.git.vpillai@digitalocean.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/10/31 2:33, Vineeth Remanan Pillai wrote:
> Fourth iteration of the Core-Scheduling feature.
> 
> This version was aiming mostly at addressing the vruntime comparison
> issues with v3. The main issue seen in v3 was the starvation of
> interactive tasks when competing with cpu intensive tasks. This issue
> is mitigated to a large extent.
> 
> We have tested and verified that incompatible processes are not
> selected during schedule. In terms of performance, the impact
> depends on the workload:
> - on CPU intensive applications that use all the logical CPUs with
>   SMT enabled, enabling core scheduling performs better than nosmt.
> - on mixed workloads with considerable io compared to cpu usage,
>   nosmt seems to perform better than core scheduling.
> 
> v4 is rebased on top of 5.3.5(dc073f193b70):
> https://github.com/digitalocean/linux-coresched/tree/coresched/v4-v5.3.5

Thanks to post V4 out. Refresh the data on my side. Since we have played
with Aaron's core vruntime patch for a while, no surprise in the result.

Thanks,
-Aubrey

Environment setup
--------------------------
Skylake 8170 server, 2 NUMA nodes, 52 cores, 104 CPUs (HT on)

Case 1:
-------
cgroup1 workload, sysbench CPU mode (non AVX workload)
cgroup2 workload, gemmbench (AVX512 workload)

sysbench throughput result:
.--------------------------------------------------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |  no-SMT [std% / sem%]	 +/-	  cpu% |
|--------------------------------------------------------------------------------------------------------------------------------------|
|  1/1	     1269.1	[ 0.1%/ 0.0%]	  1.9% |       1272.4	[ 0.1%/ 0.0%]	  0.3%	  1.9% |  1272.0 [ 0.1%/ 0.0%]   0.2%	  3.9% |
|  2/2	     2466.9	[ 0.6%/ 0.1%]	  3.9% |       2534.2	[ 0.6%/ 0.1%]	  2.7%	  3.8% |  2511.9 [ 0.2%/ 0.0%]   1.8%	  7.7% |
|  4/4	     4725.2	[ 0.3%/ 0.0%]	  7.7% |       4806.3	[ 0.2%/ 0.0%]	  1.7%	  7.7% |  4786.7 [ 0.9%/ 0.1%]   1.3%	 14.6% |
|  8/8	     9353.4	[ 0.1%/ 0.0%]	 14.6% |       9357.4	[ 0.1%/ 0.0%]	  0.0%	 14.6% |  9352.3 [ 0.1%/ 0.0%]  -0.0%	 30.0% |
| 16/16	    17543.1	[ 1.0%/ 0.1%]	 30.1% |      18120.7	[ 0.2%/ 0.0%]	  3.3%	 30.1% | 17864.8 [ 1.2%/ 0.1%]   1.8%	 60.1% |
| 32/32	    26968.8	[ 3.9%/ 0.4%]	 60.1% |      29448.9	[ 3.5%/ 0.3%]	  9.2%	 59.9% | 25308.1 [10.7%/ 0.9%]  -6.2%	 97.7% |
| 48/48	    30466.2	[10.4%/ 1.0%]	 89.3% |      38624.4	[ 4.2%/ 0.4%]	 26.8%	 89.1% | 26891.2 [14.8%/ 1.0%] -11.7%	 99.5% |
| 64/64	    37909.3	[11.1%/ 1.1%]	 97.7% |      41671.7	[ 8.7%/ 0.9%]	  9.9%	 97.6% | 25898.3 [16.2%/ 1.0%] -31.7%	100.0% |
|128/128    39479.4	[24.6%/ 2.5%]	100.0% |      42119.6	[ 6.3%/ 0.6%]	  6.7%	 99.5% | 26830.1 [16.5%/ 1.1%] -32.0%	100.0% |
|256/256    42602.1	[16.4%/ 1.6%]	100.0% |      40041.3	[ 7.0%/ 0.7%]	 -6.0%	 99.7% | 27634.7 [15.4%/ 1.1%] -35.1%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'

Case 2
------
cgroup1 workload, sysbench MySQL (non AVX workload)
cgroup2 workload, gemmbench (AVX512 workload)

sysbench throughput result:
.--------------------------------------------------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |  no-SMT [std% / sem%]	 +/-	  cpu% |
|--------------------------------------------------------------------------------------------------------------------------------------|
|  1/1	     1018.2	[ 1.0%/ 0.1%]	  1.9% |        915.8	[ 0.9%/ 0.1%]	-10.1%	  1.9% |   994.0 [ 1.4%/ 0.2%]  -2.4%	  3.9% |
|  2/2	     1941.2	[ 0.7%/ 0.1%]	  3.9% |       1746.0	[ 0.5%/ 0.1%]	-10.1%	  3.9% |  1946.2 [ 0.8%/ 0.1%]   0.3%	  7.8% |
|  4/4	     3763.9	[ 0.5%/ 0.0%]	  7.8% |       3426.0	[ 1.5%/ 0.2%]	 -9.0%	  7.8% |  3745.1 [ 1.1%/ 0.1%]  -0.5%	 15.6% |
|  8/8	     7375.5	[ 1.3%/ 0.1%]	 15.5% |       6647.1	[ 1.1%/ 0.1%]	 -9.9%	 16.1% |  7368.4 [ 0.8%/ 0.1%]  -0.1%	 31.1% |
| 16/16	    12990.3	[ 0.6%/ 0.1%]	 31.1% |      10903.7	[ 1.9%/ 0.2%]	-16.1%	 32.0% | 12082.6 [ 4.7%/ 0.5%]  -7.0%	 62.9% |
| 32/32	    18238.1	[ 6.1%/ 0.6%]	 62.1% |      16580.8	[ 3.0%/ 0.3%]	 -9.1%	 62.8% | 21193.6 [ 4.9%/ 0.6%]  16.2%	 97.8% |
| 48/48	    21708.6	[ 8.3%/ 0.8%]	 90.3% |      17064.1	[ 9.5%/ 0.9%]	-21.4%	 90.4% | 18531.4 [16.6%/ 1.8%] -14.6%	 99.5% |
| 64/64	    18636.9	[13.1%/ 1.3%]	 97.9% |      12376.1	[20.9%/ 2.1%]	-33.6%	 96.8% | 20025.8 [14.9%/ 2.4%]   7.5%	100.0% |
|128/128    16204.2	[16.8%/ 1.7%]	 99.4% |       3776.1	[88.7%/ 8.9%]	-76.7%	 97.6% | 20263.5 [12.7%/ 6.8%]  25.1%	100.0% |
|256/256    16730.5	[17.9%/ 1.8%]	 98.9% |       1499.7	[210.3%/21.0%]	-91.0%	 98.4% | 17633.1 [ 7.5%/ 8.9%]   5.4%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'

And for this case, we care about sysbench MySQL latency(ms):
.--------------------------------------------------------------------------------------------------------------------------------------.
|NA/AVX	vanilla-SMT	[std% / sem%]	  cpu% |coresched-SMT	[std% / sem%]	  +/-	  cpu% |  no-SMT [std% / sem%]	 +/-	  cpu% |
|--------------------------------------------------------------------------------------------------------------------------------------|
|  1/1	        1.1	[ 3.7%/ 0.4%]	  1.9% |          1.1	[ 1.0%/ 0.1%]	 -8.9%	  1.9% |     1.1 [ 4.1%/ 0.4%]  -2.0%	  3.9% |
|  2/2	        1.1	[ 0.7%/ 0.1%]	  3.9% |          1.2	[ 0.8%/ 0.1%]	-10.8%	  3.9% |     1.1 [ 0.8%/ 0.1%]   0.2%	  7.8% |
|  4/4	        1.1	[ 0.7%/ 0.1%]	  7.8% |          1.3	[ 3.8%/ 0.4%]	-11.8%	  7.8% |     1.2 [ 2.2%/ 0.2%]  -1.1%	 15.6% |
|  8/8	        1.2	[ 2.2%/ 0.2%]	 15.5% |          1.3	[ 3.0%/ 0.3%]	-11.7%	 16.1% |     1.2 [ 1.8%/ 0.2%]   0.4%	 31.1% |
| 16/16	        1.4	[ 1.5%/ 0.1%]	 31.1% |          2.0	[ 8.2%/ 0.8%]	-45.8%	 32.0% |     1.9 [18.2%/ 1.7%] -33.2%	 62.9% |
| 32/32	        2.4	[ 6.6%/ 0.7%]	 62.1% |          2.6	[ 3.1%/ 0.3%]	 -6.2%	 62.8% |     2.2 [23.5%/ 2.0%]   8.5%	 97.8% |
| 48/48	        2.7	[ 5.3%/ 0.5%]	 90.3% |          3.4	[ 3.5%/ 0.4%]	-26.1%	 90.4% |     6.2 [19.3%/ 3.5%] -128.0%	 99.5% |
| 64/64	        5.9	[13.0%/ 1.3%]	 97.9% |          8.3	[ 9.8%/ 1.0%]	-40.1%	 96.8% |     7.4 [16.6%/ 1.5%] -25.1%	100.0% |
|128/128       17.4	[46.8%/ 4.7%]	 99.4% |        248.0	[146.9%/14.7%]	-1327.8% 97.6% |    11.0 [10.5%/ 0.0%]  36.7%	100.0% |
|256/256       33.5	[67.1%/ 6.7%]	 98.9% |       1279.5	[245.6%/24.6%]	-3716.6% 98.4% |    21.5 [21.5%/ 0.0%]  36.0%	100.0% |
'--------------------------------------------------------------------------------------------------------------------------------------'

Note:
----
64/64:		64 sysbench threads(in one cgroup) and 64 gemmbench threads(in other cgroup) run simultaneously.
Vanilla-SMT:	baseline with HT on
coresched-SMT:	core scheduling enabled
no-SMT:		HT off thru /sys/devices/system/cpu/smt/control
std%:		standard deviation
sem%:		standard error of the mean
±:		improvement/regression against baseline
cpu%:		derived by vmstat.idle and vmstat.iowait
