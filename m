Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30902C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C46B206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:45:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732463AbfDQRpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:45:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:16227 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbfDQRpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:45:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 10:45:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="292386957"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2019 10:45:13 -0700
Received: from [10.252.12.89] (unknown [10.252.12.89])
        by linux.intel.com (Postfix) with ESMTP id 826EF5803C1;
        Wed, 17 Apr 2019 10:45:10 -0700 (PDT)
Subject: Re: [PATCH v1] perf record: collect user registers set jointly with
 dwarf stacks
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <a83183c0-21f4-02af-1443-1a3fdb5d89c3@linux.intel.com>
 <20190417073952.GF17024@krava> <20190417143542.GA5246@kernel.org>
 <20190417144002.GB2705@krava>
 <60FB78F1-BC48-4172-9669-DD3846F1F0E0@kernel.org>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <d68cd29b-16fe-7117-b2f4-720c72d6c146@linux.intel.com>
Date:   Wed, 17 Apr 2019 20:45:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <60FB78F1-BC48-4172-9669-DD3846F1F0E0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 17.04.2019 18:48, Arnaldo Carvalho de Melo wrote:
> On April 17, 2019 11:40:02 AM GMT-03:00, Jiri Olsa <jolsa@redhat.com> wrote:
>> On Wed, Apr 17, 2019 at 11:35:42AM -0300, Arnaldo Carvalho de Melo
>> wrote:
>>> Em Wed, Apr 17, 2019 at 09:39:52AM +0200, Jiri Olsa escreveu:
>>>> On Mon, Apr 15, 2019 at 06:36:13PM +0300, Alexey Budankov wrote:
>>>>>
>>>>> When dwarf stacks are collected jointly with user specified
>> register
>>>>> set using --user-regs option like below the full register context
>> is
>>>>> still captured on a sample:
>>>>>
>>>>>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP
>> -- matrix.gcc.g.O3
>>>>>
>>>>>   188143843893585 0x6b48 [0x4f8]: PERF_RECORD_SAMPLE(IP, 0x4002):
>> 23828/23828: 0x401236 period: 1363819 addr: 0x7ffedbdd51ac
>>>>>   ... FP chain: nr:0
>>>>>   ... user regs: mask 0xff0fff ABI 64-bit
>>>>>   .... AX    0x53b
>>>>>   .... BX    0x7ffedbdd3cc0
>>>>>   .... CX    0xffffffff
>>>>>   .... DX    0x33d3a
>>>>>   .... SI    0x7f09b74c38d0
>>>>>   .... DI    0x0
>>>>>   .... BP    0x401260
>>>>>   .... SP    0x7ffedbdd3cc0
>>>>>   .... IP    0x401236
>>>>>   .... FLAGS 0x20a
>>>>>   .... CS    0x33
>>>>>   .... SS    0x2b
>>>>>   .... R8    0x7f09b74c3800
>>>>>   .... R9    0x7f09b74c2da0
>>>>>   .... R10   0xfffffffffffff3ce
>>>>>   .... R11   0x246
>>>>>   .... R12   0x401070
>>>>>   .... R13   0x7ffedbdd5db0
>>>>>   .... R14   0x0
>>>>>   .... R15   0x0
>>>>>   ... ustack: size 1024, offset 0xe0
>>>>>    . data_src: 0x5080021
>>>>>    ... thread: stack_test2.g.O:23828
>>>>>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
>>>>>
>>>>> After applying the change suggested in the patch the sample data
>> contain
>>>>> only user specified register values:
>>>>>
>>>>>   $ perf record -g --call-graph dwarf,1024 --user-regs=IP,SP,BP
>> -- matrix.gcc.g.03
>>>>>
>>>>>   188368474305373 0x5e40 [0x470]: PERF_RECORD_SAMPLE(IP, 0x4002):
>> 23839/23839: 0x401236 period: 1260507 addr: 0x7ffd3d85e96c
>>>>>   ... FP chain: nr:0
>>>>>   ... user regs: mask 0x1c0 ABI 64-bit
>>>>>   .... BP    0x401260
>>>>>   .... SP    0x7ffd3d85cc20
>>>>>   .... IP    0x401236
>>>>>   ... ustack: size 1024, offset 0x58
>>>>>    . data_src: 0x5080021
>>>>>    ... thread: stack_test2.g.O:23839
>>>>>    ...... dso: /root/abudanko/stacks/stack_test2.g.O3
>>>>>
>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>
>>>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>> So, there are registers that are needed to do the DWARF unwinding,
>>> right? But at the same time, if the user says only some are needed,
>> he
>>> better know what they're doing and ask for at least the registers
>> needed
>>> for the unwinding process to be successfull, right?
>>
>> yep, that's how understand that
> 
> So we need to document that, stating that specifying a set of registers together with requesting DWARF callchains may break things.

Do you mean break callchains if omitting IP,SP,BP? 
For example like this: 
$ perf record -g --call-graph dwarf,1024 --user-regs=AX,BX,CX -- matrix.gcc.g.O3

~Alexey

> 
> - Arnaldo
> 
> 
> 
> 
> 
