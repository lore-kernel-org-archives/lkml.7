Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B97C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E45420675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 02:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfD2CRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 22:17:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:46408 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbfD2CRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 22:17:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 19:17:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="139632022"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by orsmga006.jf.intel.com with ESMTP; 28 Apr 2019 19:17:02 -0700
Subject: Re: [RFC PATCH v2 00/17] Core scheduling v2
To:     Ingo Molnar <mingo@kernel.org>, Aubrey Li <aubrey.intel@gmail.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20190424140013.GA14594@sinkpad>
 <CAERHkrtVjU4SaHjPGNb140qBiU+wVELGaH6j9Z=cctToZ0qn9g@mail.gmail.com>
 <20190425095508.GA8387@gmail.com>
 <CAERHkrs0=xcx9UUZbZPYq4QbznUqHAuVbTnafSVpZFKwAEFyMA@mail.gmail.com>
 <20190427091716.GC99668@gmail.com>
 <CAERHkruEAVBsh6FphMKqgR2+HjsVVegxjnpOFRNfbrfZDNpc9w@mail.gmail.com>
 <20190427142137.GA72051@gmail.com>
 <CAERHkrtaU=Y-Lxypu_7uBbe-mJtG-3friz=ZLhV53X4FXHcEyA@mail.gmail.com>
 <20190428093304.GA7393@gmail.com>
 <CAERHkrvaSSR1wRECF1AcLOhpmCAH0ecvFEL5MOFjK05F0xSuzA@mail.gmail.com>
 <20190428121721.GA121434@gmail.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <db7c3e51-d013-b3d9-7bce-c247aa2e7144@linux.intel.com>
Date:   Mon, 29 Apr 2019 10:17:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190428121721.GA121434@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/4/28 20:17, Ingo Molnar wrote:
> 
> * Aubrey Li <aubrey.intel@gmail.com> wrote:
> 
>> On Sun, Apr 28, 2019 at 5:33 PM Ingo Molnar <mingo@kernel.org> wrote:
>>> So because I'm a big fan of presenting data in a readable fashion, here
>>> are your results, tabulated:
>>
>> I thought I tried my best to make it readable, but this one looks much better,
>> thanks, ;-)
>>>
>>>  #
>>>  # Sysbench throughput comparison of 3 different kernels at different
>>>  # load levels, higher numbers are better:
>>>  #
>>>
>>>  .--------------------------------------|----------------------------------------------------------------.
>>>  |  NA/AVX     vanilla-SMT    [stddev%] |coresched-SMT   [stddev%]   +/-  |   no-SMT    [stddev%]   +/-  |
>>>  |--------------------------------------|----------------------------------------------------------------|
>>>  |   1/1             508.5    [  0.2% ] |        504.7   [  1.1% ]   0.8% |    509.0    [  0.2% ]   0.1% |
>>>  |   2/2            1000.2    [  1.4% ] |       1004.1   [  1.6% ]   0.4% |    997.6    [  1.2% ]   0.3% |
>>>  |   4/4            1912.1    [  1.0% ] |       1904.2   [  1.1% ]   0.4% |   1914.9    [  1.3% ]   0.1% |
>>>  |   8/8            3753.5    [  0.3% ] |       3748.2   [  0.3% ]   0.1% |   3751.3    [  0.4% ]   0.1% |
>>>  |  16/16           7139.3    [  2.4% ] |       7137.9   [  1.8% ]   0.0% |   7049.2    [  2.4% ]   1.3% |
>>>  |  32/32          10899.0    [  4.2% ] |      10780.3   [  4.4% ]  -1.1% |  10339.2    [  9.6% ]  -5.1% |
>>>  |  64/64          15086.1    [ 11.5% ] |      14262.0   [  8.2% ]  -5.5% |  11168.7    [ 22.2% ] -26.0% |
>>>  | 128/128         15371.9    [ 22.0% ] |      14675.8   [ 14.4% ]  -4.5% |  10963.9    [ 18.5% ] -28.7% |
>>>  | 256/256         15990.8    [ 22.0% ] |      12227.9   [ 10.3% ] -23.5% |  10469.9    [ 19.6% ] -34.5% |
>>>  '--------------------------------------|----------------------------------------------------------------'
>>>
>>> One major thing that sticks out is that if we compare the stddev numbers
>>> to the +/- comparisons then it's pretty clear that the benchmarks are
>>> very noisy: in all but the last row stddev is actually higher than the
>>> measured effect.
>>>
>>> So what does 'stddev' mean here, exactly? The stddev of multipe runs,
>>> i.e. measured run-to-run variance? Or is it some internal metric of the
>>> benchmark?
>>>
>>
>> The benchmark periodically reports intermediate statistics in one second,
>> the raw log looks like below:
>> [ 11s ] thds: 256 eps: 14346.72 lat (ms,95%): 44.17
>> [ 12s ] thds: 256 eps: 14328.45 lat (ms,95%): 44.17
>> [ 13s ] thds: 256 eps: 13773.06 lat (ms,95%): 43.39
>> [ 14s ] thds: 256 eps: 13752.31 lat (ms,95%): 43.39
>> [ 15s ] thds: 256 eps: 15362.79 lat (ms,95%): 43.39
>> [ 16s ] thds: 256 eps: 26580.65 lat (ms,95%): 35.59
>> [ 17s ] thds: 256 eps: 15011.78 lat (ms,95%): 36.89
>> [ 18s ] thds: 256 eps: 15025.78 lat (ms,95%): 39.65
>> [ 19s ] thds: 256 eps: 15350.87 lat (ms,95%): 39.65
>> [ 20s ] thds: 256 eps: 15491.70 lat (ms,95%): 36.89
>>
>> I have a python script to parse eps(events per second) and lat(latency)
>> out, and compute the average and stddev. (And I can draw a curve locally).
>>
>> It's noisy indeed when tasks number is greater than the CPU number.
>> It's probably caused by high frequent load balance and context switch.
> 
> Ok, so it's basically an internal workload noise metric, it doesn't 
> represent the run-to-run noise.
> 
> So it's the real stddev of the workload - but we don't know whether the 
> measured performance figure is exactly in the middle of the runtime 
> probability distribution.
> 
>> Do you have any suggestions? Or any other information I can provide?
> 
> Yeah, so we don't just want to know the "standard deviation" of the 
> measured throughput values, but also the "standard error of the mean".
> 
> I suspect it's pretty low, below 1% for all rows?

Hope my this mail box works for this...

.-------------------------------------------------------------------------------------------------------------.
|NA/AVX vanilla-SMT     [std% / sem%] | coresched-SMT   [std% / sem%]     +/- |  no-SMT [std% / sem%]    +/-  |
|-------------------------------------------------------------------------------------------------------------|
|  1/1        508.5     [ 0.2%/ 0.0%] |         504.7   [ 1.1%/ 0.1%]    -0.8%|   509.0 [ 0.2%/ 0.0%]    0.1% |
|  2/2       1000.2     [ 1.4%/ 0.1%] |        1004.1   [ 1.6%/ 0.2%]     0.4%|   997.6 [ 1.2%/ 0.1%]   -0.3% |
|  4/4       1912.1     [ 1.0%/ 0.1%] |        1904.2   [ 1.1%/ 0.1%]    -0.4%|  1914.9 [ 1.3%/ 0.1%]    0.1% |
|  8/8       3753.5     [ 0.3%/ 0.0%] |        3748.2   [ 0.3%/ 0.0%]    -0.1%|  3751.3 [ 0.4%/ 0.0%]   -0.1% |
| 16/16      7139.3     [ 2.4%/ 0.2%] |        7137.9   [ 1.8%/ 0.2%]    -0.0%|  7049.2 [ 2.4%/ 0.2%]   -1.3% |
| 32/32     10899.0     [ 4.2%/ 0.4%] |       10780.3   [ 4.4%/ 0.4%]    -1.1%| 10339.2 [ 9.6%/ 0.9%]   -5.1% |
| 64/64     15086.1     [11.5%/ 1.2%] |       14262.0   [ 8.2%/ 0.8%]    -5.5%| 11168.7 [22.2%/ 1.7%]  -26.0% |
|128/128    15371.9     [22.0%/ 2.2%] |       14675.8   [14.4%/ 1.4%]    -4.5%| 10963.9 [18.5%/ 1.4%]  -28.7% |
|256/256    15990.8     [22.0%/ 2.2%] |       12227.9   [10.3%/ 1.0%]   -23.5%| 10469.9 [19.6%/ 1.7%]  -34.5% |
'-------------------------------------------------------------------------------------------------------------'

Thanks,
-Aubrey
