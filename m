Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA6DC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC6621883
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfICXij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 19:38:39 -0400
Received: from mga17.intel.com ([192.55.52.151]:39755 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfICXii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:38:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Sep 2019 16:38:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,464,1559545200"; 
   d="scan'208";a="194516778"
Received: from fyin-mobl.ccr.corp.intel.com (HELO [10.239.204.18]) ([10.239.204.18])
  by orsmga002.jf.intel.com with ESMTP; 03 Sep 2019 16:38:37 -0700
Subject: Re: About compiler memory barrier for atomic_set/atomic_read on x86
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, "He, Min" <min.he@intel.com>,
        "Zhao, Yakui" <yakui.zhao@intel.com>
References: <256e8ee2-a23c-28e9-3988-8b77307c001a@intel.com>
 <20190903140614.GR2349@hirez.programming.kicks-ass.net>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
Message-ID: <a9ea1348-b7cb-c589-1be4-51efadaf1271@intel.com>
Date:   Wed, 4 Sep 2019 07:38:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903140614.GR2349@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 9/3/2019 10:06 PM, Peter Zijlstra wrote:
> On Tue, Sep 03, 2019 at 09:23:41PM +0800, Yin, Fengwei wrote:
>> Hi Peter,
>> There is one question regarding following commit:
>>
>> commit 69d927bba39517d0980462efc051875b7f4db185
>> Author: Peter Zijlstra <peterz@infradead.org>
>> Date:   Wed Apr 24 13:38:23 2019 +0200
>>
>>      x86/atomic: Fix smp_mb__{before,after}_atomic()
>>
>>      Recent probing at the Linux Kernel Memory Model uncovered a
>>      'surprise'. Strongly ordered architectures where the atomic RmW
>>      primitive implies full memory ordering and
>>      smp_mb__{before,after}_atomic() are a simple barrier() (such as x86)
>>
>> This change made atomic RmW operations include compiler barrier. And made
>> __smp_mb__before_atomic/__smp_mb__after_atomic not include compiler
>> barrier any more for x86.
>>
>> We face the issue to handle atomic_set/atomic_read which is mapped to
>> WRITE_ONCE/READ_ONCE on x86. These two functions don't include compiler
>> barrier actually (if operator size is less than 8 bytes).
>>
>> Before the commit 69d927bba39517d0980462efc051875b7f4db185, we could use
>> __smp_mb__before_atomic/__smp_mb__after_atomic together with these two
>> functions to make sure the memory order. It can't work after the commit
>> 69d927bba39517d0980462efc051875b7f4db185. I am wandering whether
>> we should make atomic_set/atomic_read also include compiler memory
>> barrier on x86? Thanks.
> 
> No; using smp_mb__{before,after}_atomic() with atomic_{set,read}() is
> _wrong_! And it is documented as such; see Documentation/atomic_t.txt.

Thanks a lot for direct me to this doc. And yes, from this doc:
    - smp_mb__{before,after}_atomic() only apply to the RMW atomic ops
    - non-RMW operations are unordered;

I checked the /Documentation/memory-barriers.txt too. In section
"COMPILER BARRIER", "However, READ_ONCE() and WRITE_ONCE() can be
thought of as weak forms of barrier() that affect only the specific
accesses flagged by the READ_ONCE() or WRITE_ONCE()".

For x86 READ_ONCE/WRITE_ONCE doesn't have compiler barrier if the
operator size is less than 8 bytes. Should we update x86 code?

So, if I use atomic_set/read, to prevent the compiler from moving memory
access around, I should use compiler barrier explicitly. Right?

Regards
Yin, Fengwei

> 

