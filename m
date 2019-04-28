Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7E6C43218
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6456820874
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 01:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfD1B7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 21:59:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:13492 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfD1B7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 21:59:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Apr 2019 18:59:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,403,1549958400"; 
   d="scan'208";a="319609212"
Received: from genxtest-ykzhao.sh.intel.com (HELO [10.239.143.71]) ([10.239.143.71])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2019 18:59:09 -0700
Subject: Re: [RFC PATCH v5 4/4] x86/acrn: Add hypercall for ACRN guest
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Chen, Jason CJ" <jason.cj.chen@intel.com>
References: <1556067260-9128-1-git-send-email-yakui.zhao@intel.com>
 <1556067260-9128-5-git-send-email-yakui.zhao@intel.com>
 <20190425070712.GA57256@gmail.com>
 <6dd021a9-e2c0-ee84-55fd-3e6dfb4bd944@intel.com>
 <20190425110025.GA16164@zn.tnic>
 <473d145c-4bfd-4ec8-34c3-8a26a78fe40d@intel.com>
 <20190427085816.GB12360@zn.tnic>
From:   "Zhao, Yakui" <yakui.zhao@intel.com>
Message-ID: <e04c43cf-029b-d459-e9d9-1a1f5c403dab@intel.com>
Date:   Sun, 28 Apr 2019 09:56:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20190427085816.GB12360@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019年04月27日 16:58, Borislav Petkov wrote:
> On Fri, Apr 26, 2019 at 11:18:48AM +0800, Zhao, Yakui wrote:
>> It seems that it is seldom used in kernel although the explicit register
>> variable is supported by GCC and makes the code look simpler. And it seems
>> that the explicit register variable is not suppoorted by CLAG.
> 
> The more reason not to do it this way. Also, the "register" variable
> specification is not very widespread in x86 when you look at
> 
> $ git grep -E "register\s.*asm" arch/x86/
> 
> output.

Yes.  The explicit register variable is not very videspread for arch/x86.
So the register variable will be removed for ACRN hypercall.

> 
>> So the explicit register variable will be removed. I will follow the asm
>> code from Borislav. Of course one minor change is that the "movq" is used
>> instead of "mov".
> 
> Does that matter if your destination register is 64-bit?

Thanks for the reminder about the access width.
It is 64-bit register. What I said is the "movq", not "movl".
(I understand that movl is incorrect for 64-bit register).


Thanks
     Yakui

