Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0927E206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 15:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfC2PZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 11:25:05 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:36276 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbfC2PZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 11:25:05 -0400
Received: from [192.168.122.135] (helo=_)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1h9tNA-0000Td-Q4; Fri, 29 Mar 2019 15:24:48 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Mar 2019 15:24:48 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jann Horn <jannh@google.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>
Subject: Re: [PATCH 2/2] x86: fix __user annotations
In-Reply-To: <20190329133956.GE21152@zn.tnic>
References: <20190328212321.92463-1-jannh@google.com>
 <20190328212321.92463-2-jannh@google.com> <20190329133956.GE21152@zn.tnic>
Message-ID: <e2dcebe0a663bdf5496e444509f3e45f@codethink.co.uk>
X-Sender: ben.dooks@codethink.co.uk
User-Agent: Roundcube Webmail/1.1.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-03-29 13:39, Borislav Petkov wrote:
> On Thu, Mar 28, 2019 at 10:23:21PM +0100, Jann Horn wrote:
>> Fix __user annotations in various places across the x86 tree:
>> 
>>  - cast to wrong pointer type in __user_atomic_cmpxchg_inatomic()
>>  - generic_load_microcode() deals with a pointer that can be either a
>>    kernel pointer or a user pointer; change the code to pass it around 
>> as
>>    a __user pointer, and add explicit casts to convert between __user 
>> and
>>    __kernel
>>  - save_xstate_epilog() has missing __user in explicit casts
>>  - setup_sigcontext() and x32_setup_rt_frame() rely on the cast 
>> performed
>>    by put_user_ex() on its first argument, but sparse requires __force 
>> for
>>    casting __user pointers to unsigned long
>>  - xen_hvm_config() has missing __user
>> 
>> This patch removes all sparse warnings about the asn:1 address space
>> (__user) in arch/x86/ for my kernel config.
>> 
>> Signed-off-by: Jann Horn <jannh@google.com>
>> ---
>> This patch requires the previous one, "[PATCH 1/2] kernel.h: use
>> parentheses around argument in u64_to_user_ptr()", otherwise
>> xen_hvm_config() breaks. Can we take both together through the x86 
>> tree,
>> or does the first one have to go through akpm's tree?
> 
> I don't see why not, unless akpm has objections.
> 
> However,
> 
>>  arch/x86/include/asm/uaccess.h        |  3 +--
>>  arch/x86/include/asm/uaccess_64.h     |  2 +-
> 
> This chunk is being discussed here already:
> 
> https://lkml.kernel.org/r/20190228185027.2480-1-ben.dooks@codethink.co.uk
> 
> and I'd like to take Ben's v2 when Ben adds Linus' explanation.

I'll sort that out in a bit, thanks for reviewing.

