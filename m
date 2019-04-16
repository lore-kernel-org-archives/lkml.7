Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED81C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AE820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 21:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbfDPVT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 17:19:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:51104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728277AbfDPVT3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 17:19:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DE1EAAC1B;
        Tue, 16 Apr 2019 21:19:27 +0000 (UTC)
Subject: Re: [PATCH] slab: remove store_stackinfo()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org, luto@kernel.org,
        jpoimboe@redhat.com, sean.j.christopherson@intel.com,
        penberg@kernel.org, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190416142258.18694-1-cai@lca.pw>
 <902fed9c-9655-a241-677d-5fa11b6c95a1@suse.cz>
 <alpine.DEB.2.21.1904162040570.1780@nanos.tec.linutronix.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <235d7500-8235-c7d4-0d6f-4d069133bd8d@suse.cz>
Date:   Tue, 16 Apr 2019 23:19:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1904162040570.1780@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/2019 8:50 PM, Thomas Gleixner wrote:
> On Tue, 16 Apr 2019, Vlastimil Babka wrote:
> 
>> On 4/16/19 4:22 PM, Qian Cai wrote:
>>> store_stackinfo() does not seem used in actual SLAB debugging.
>>> Potentially, it could be added to check_poison_obj() to provide more
>>> information, but this seems like an overkill due to the declining
>>> popularity of the SLAB, so just remove it instead.
>>>
>>> Signed-off-by: Qian Cai <cai@lca.pw>
>>
>> I've acked Thomas' version already which was narrower, but no objection
>> to remove more stuff on top of that. Linus (and I later in another
>> thread) already pointed out /proc/slab_allocators. It only takes a look
>> at add_caller() there to not regret removing that one.
> 
> The issue why I was looking at this was a krobot complaint about the kernel
> crashing in that stack store function with my stackguard series applied. It
> was broken before the stackguard pages already, it just went unnoticed.
> 
> As you explained, nobody is caring about DEBUG_SLAB + DEBUG_PAGEALLOC
> anyway, so I'm happy to not care about krobot tripping over it either.
> 
> So we have 3 options:
> 
>    1) I ignore it and merge the stack guard series w/o it
> 
>    2) I can carry the minimal fix or Qian's version in the stackguard
>       branch
> 
>    3) We ship that minimal fix to Linus right now and then everyone can
>       base their stuff on top independently.

I think #3 is overkill for something that was broken for who knows how long and
nobody noticed. I'd go with 2) and perhaps Qian's version as nobody AFAIK uses
the caller+cpu as well as the stack trace.

For Qian's version also:
Acked-by: Vlastimil Babka <vbabka@suse.cz>

> #3 is probably the right thing to do.
> 
> Thanks,
> 
> 	tglx
> 

