Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2298C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA9D26451
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 06:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfEaG1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 02:27:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:5659 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaG1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 02:27:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 23:27:42 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 30 May 2019 23:27:42 -0700
Received: from [10.251.91.204] (abudanko-mobl.ccr.corp.intel.com [10.251.91.204])
        by linux.intel.com (Postfix) with ESMTP id 2AC025807D6;
        Thu, 30 May 2019 23:27:39 -0700 (PDT)
Subject: Re: [PATCH v5] perf record: collect user registers set jointly with
 dwarf stacks
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e7fd37b1-af22-0d94-a0dc-5895e803bbfe@linux.intel.com>
 <20190530194111.GA6540@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3dc0c67e-9ea3-b9f5-1aa2-e87603b29c37@linux.intel.com>
Date:   Fri, 31 May 2019 09:27:38 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530194111.GA6540@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30.05.2019 22:41, Arnaldo Carvalho de Melo wrote:
> Em Thu, May 30, 2019 at 10:03:36PM +0300, Alexey Budankov escreveu:
>>
>> When dwarf stacks are collected jointly with user specified register
>> set using --user-regs option like below the full register context is
>> captured on a sample:
>>
>>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3
>>
>>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
>>   ... FP chain: nr:0
>>   ... user regs: mask 0xff0fff ABI 64-bit
>>   .... AX    0x53b
>>   .... BX    0x7ffedbdd3cc0
>>   .... CX    0xffffffff
>>   .... DX    0x33d3a
>>   .... SI    0x7f09b74c38d0
>>   .... DI    0x0
>>   .... BP    0x401260
>>   .... SP    0x7ffedbdd3cc0
>>   .... IP    0x401236
>>   .... FLAGS 0x20a
>>   .... CS    0x33
>>   .... SS    0x2b
>>   .... R8    0x7f09b74c3800
>>   .... R9    0x7f09b74c2da0
>>   .... R10   0xfffffffffffff3ce
>>   .... R11   0x246
>>   .... R12   0x401070
>>   .... R13   0x7ffedbdd5db0
>>   .... R14   0x0
>>   .... R15   0x0
>>   ... ustack: size 1024, offset 0xe0
>>    . data_src: 0x5080021
>>    ... thread: stack_test2.g.O:23828
>>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
>>
>> After applying the change suggested in the patch the sample data contain
>> only user specified register values. IP and SP registers (DWARF_MINIMAL_REGS)
>> are collected anyways regardless of the --user-regs value provided from
>> the command line:
> 
> Applied, changed the subject and description to:
> 
> perf record: Allow mixing --user-regs with --call-graph=dwarf
> 
> When DWARF stacks were requested and at the same time that the user
> specifies a register set using the --user-regs option the full register
> context was being captured on samples:
> 
>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP -- stack_test2.g.O3
> 
>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002): 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
>   ... FP chain: nr:0
>   ... user regs: mask 0xff0fff ABI 64-bit
>   .... AX    0x53b
>   .... BX    0x7ffedbdd3cc0
>   .... CX    0xffffffff
>   .... DX    0x33d3a
>   .... SI    0x7f09b74c38d0
>   .... DI    0x0
>   .... BP    0x401260
>   .... SP    0x7ffedbdd3cc0
>   .... IP    0x401236
>   .... FLAGS 0x20a
>   .... CS    0x33
>   .... SS    0x2b
>   .... R8    0x7f09b74c3800
>   .... R9    0x7f09b74c2da0
>   .... R10   0xfffffffffffff3ce
>   .... R11   0x246
>   .... R12   0x401070
>   .... R13   0x7ffedbdd5db0
>   .... R14   0x0
>   .... R15   0x0
>   ... ustack: size 1024, offset 0xe0
>    . data_src: 0x5080021
>    ... thread: stack_test2.g.O:23828
>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
> 
> I.e. the --user-regs=IP,SP,BP was being ignored, being overridden by the
> needs of --call-graph=dwarf.
> 
> After applying the change in this patch the sample data contains the
> user specified register, but making sure that at least the minimal set
> of register needed for DWARF unwinding (DWARF_MINIMAL_REGS) is
> requested.
> 
> The user is warned that DWARF unwinding may not work if extra registers
> end up being needed.
> 
>   -g call-graph dwarf,K                         full_regs
>   --user-regs=user_regs                         user_regs
>   -g call-graph dwarf,K --user-regs=user_regs   user_regs + DWARF_MINIMAL_REGS
> <REST remains the same>
> 

Sounds better. Thanks!

~Alexey
