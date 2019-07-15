Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F11C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76748206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbfGOLFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:05:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:64019 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729755AbfGOLFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:05:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 04:05:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,493,1557212400"; 
   d="scan'208";a="194476127"
Received: from liujing-mobl.ccr.corp.intel.com (HELO [10.238.128.226]) ([10.238.128.226])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jul 2019 04:05:18 -0700
Subject: Re: [PATCH v1] KVM: x86: expose AVX512_BF16 feature to guest
To:     Wanpeng Li <kernellwp@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <1562824197-13658-1-git-send-email-jing2.liu@linux.intel.com>
 <305e2a40-93a3-23ed-71a2-d3f2541e837a@redhat.com>
 <CANRm+CzOp6orH+7sqCQjLuxsYRccfq7H-o4QBcgxGfT-=RaJ-w@mail.gmail.com>
From:   Jing Liu <jing2.liu@linux.intel.com>
Message-ID: <332e8951-e6bb-8394-490d-26c8154712b9@linux.intel.com>
Date:   Mon, 15 Jul 2019 19:05:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CANRm+CzOp6orH+7sqCQjLuxsYRccfq7H-o4QBcgxGfT-=RaJ-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/2019 2:06 PM, Wanpeng Li wrote:
> On Sat, 13 Jul 2019 at 18:40, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 11/07/19 07:49, Jing Liu wrote:
>>> AVX512 BFLOAT16 instructions support 16-bit BFLOAT16 floating-point
>>> format (BF16) for deep learning optimization.
>>>
>>> Intel adds AVX512 BFLOAT16 feature in CooperLake, which is CPUID.7.1.EAX[5].
>>>
>>> Detailed information of the CPUID bit can be found here,
>>> https://software.intel.com/sites/default/files/managed/c5/15/\
>>> architecture-instruction-set-extensions-programming-reference.pdf.
>>>
>>> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
>>> ---
>>>
[...]
> /home/kernel/data/kvm/arch/x86/kvm//cpuid.c: In function ‘do_cpuid_7_mask’:
> ./include/linux/kernel.h:819:29: warning: comparison of distinct
> pointer types lacks a cast
>     (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>                               ^
> ./include/linux/kernel.h:833:4: note: in expansion of macro ‘__typecheck’
>     (__typecheck(x, y) && __no_side_effects(x, y))
>      ^
> ./include/linux/kernel.h:843:24: note: in expansion of macro ‘__safe_cmp’
>    __builtin_choose_expr(__safe_cmp(x, y), \
>                          ^
> ./include/linux/kernel.h:852:19: note: in expansion of macro ‘__careful_cmp’
>   #define min(x, y) __careful_cmp(x, y, <)
>                     ^
> /home/kernel/data/kvm/arch/x86/kvm//cpuid.c:377:16: note: in expansion
> of macro ‘min’
>     entry->eax = min(entry->eax, 1);
>                  ^
> 
Thanks for the information.

This warning would be fixed by changing to
entry->eax = min(entry->eax, (u32)1);

@Paolo, sorry for trouble. Would you mind if I re-send?

Jing

