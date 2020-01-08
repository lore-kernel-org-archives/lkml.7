Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1131C33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6DE2070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 02:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgAHCby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:31:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:47674 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725812AbgAHCby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 21:31:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2020 18:31:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,408,1571727600"; 
   d="scan'208";a="254073993"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jan 2020 18:31:52 -0800
Subject: Re: [ext4] b1b4705d54: filebench.sum_bytes_mb/s -20.2% regression
To:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
References: <20191224005915.GW2760@shao2-debian>
 <20200107134106.GD25547@quack2.suse.cz> <20200107165708.GA3619@mit.edu>
 <20200107172824.GK25547@quack2.suse.cz>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <fde1ad11-c9b0-4393-a123-3f7625c819fa@intel.com>
Date:   Wed, 8 Jan 2020 10:31:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200107172824.GK25547@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/20 1:28 AM, Jan Kara wrote:
> On Tue 07-01-20 11:57:08, Theodore Y. Ts'o wrote:
>> On Tue, Jan 07, 2020 at 02:41:06PM +0100, Jan Kara wrote:
>>> Hello,
>>>
>>> On Tue 24-12-19 08:59:15, kernel test robot wrote:
>>>> FYI, we noticed a -20.2% regression of filebench.sum_bytes_mb/s due to commit:
>>>>
>>>>
>>>> commit: b1b4705d54abedfd69dcdf42779c521aa1e0fbd3 ("ext4: introduce direct I/O read using iomap infrastructure")
>>>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>>>
>>>> in testcase: filebench
>>>> on test machine: 8 threads Intel(R) Core(TM) i7-4770 CPU @ 3.40GHz with 8G memory
>>>> with following parameters:
>>>>
>>>> 	disk: 1HDD
>>>> 	fs: ext4
>>>> 	test: fivestreamreaddirect.f
>>>> 	cpufreq_governor: performance
>>>> 	ucode: 0x27
>>> I was trying to reproduce this but I failed with my test VM. I had SATA SSD
>>> as a backing store though so maybe that's what makes a difference. Maybe
>>> the new code results in somewhat more seeks because the five threads which
>>> compete in submitting sequential IO end up being more interleaved?
>> A "-20.2% regression" should be read as a "20.2% performance
>> improvement" is zero-day kernel speak.
> Are you sure? I can see:
>
>       58.30 ±  2%     -20.2%      46.53        filebench.sum_bytes_mb/s
>
> which implies to me previously the throughput was 58 MB/s and after the
> commit it was 46 MB/s?
>
> Anyway, in my testing that commit made no difference in that benchmark
> whasoever (getting around 97 MB/s for each thread before and after the
> commit).
>   
> 								Honza

We're sorry for the misunderstanding, "-20.2%" means the change of 
filebench.sum_bytes_mb/s,
"regression" means the explanation of this change from LKP.

Best Regards,
Rong Chen
