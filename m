Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31079C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0241620674
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EleOqQer"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732219AbfKTQNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:13:22 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45902 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729412AbfKTQNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0Q9ax8V5NJIBE8fllSDxKWvhzHEQC3WHKUgKprHNDZ0=; b=EleOqQerl3cmHBTwh34R5KoNe
        ypSz0iu+XVeCVjfkg5vRUZsTNtBJxjqlfConKUCXZZjaFcXHCpKr5TEqXQJ7tR/jPmUo+P1JVEPre
        LvYVwVl/u1K9E0nU5mS7bccDJ9s7ND5SbPaFkm39oqzHqfEBbWpYKlVTVAawFhIKubwHGi/k+cFbc
        7MvNw9dsT27pmRNBm1M4p/xL0vc1GevyhC1KpCfJ7ol/oq+xk7PwQQOxVtb53jQ1jV3KiPM4krhuh
        i/eUmGYSVTMi1sl2+ZsyeoSQICWlZKmrBX6Uszo742NDuesGNrMO7d42rxVJz/8HeRmpOrcnyzAPZ
        KlTMuxVhQ==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXSbY-0006sL-6N; Wed, 20 Nov 2019 16:13:20 +0000
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
 <802dc73e-080d-05aa-76fe-165bb4817959@infradead.org>
 <CAMuHMdUyN5FE21C3Bu6S4wrwTxe0xB2ZpPAgryvx_6EX+YkhFw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <736e66f5-85b6-6bbc-f902-9e72d8bc1a4a@infradead.org>
Date:   Wed, 20 Nov 2019 08:13:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUyN5FE21C3Bu6S4wrwTxe0xB2ZpPAgryvx_6EX+YkhFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/19 12:30 AM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Wed, Nov 20, 2019 at 5:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
>>> On Tue, Nov 19, 2019 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>> Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
>>>> SYS_SUPPORTS_SMP and SMP.
>>>>
>>>> kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
>>>> code + data inside topology.c is only built when CONFIG_NUMA is
>>>> set/enabled, so these arch/sh/ configs need to select SMP and
>>>> SYS_SUPPORTS_SMP to build the NUMA support.
>>>>
>>>> Fixes this build error in 3 different SUPERH configs:
>>>>
>>>> mm/page_alloc.o: In function `get_page_from_freelist':
>>>> page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'
>>>>
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>>> Cc: Rich Felker <dalias@libc.org>
>>>> Cc: linux-sh@vger.kernel.org
>>>> ---
>>>> or maybe these should be fixed in the defconfig files?
>>>>
>>>> or alternatively, does it make any sense to support NUMA without SMP?
>>>
>>> I think it does.  From arch/sh/mm/Kconfig config NUMA help:
>>>
>>>         Some SH systems have many various memories scattered around
>>>         the address space, each with varying latencies. This enables
>>>         support for these blocks by binding them to nodes and allowing
>>>         memory policies to be used for prioritizing and controlling
>>>         allocation behaviour.
>>
>> Note that this help text is under:
>> config NUMA
>>         bool "Non-Uniform Memory Access (NUMA) Support"
>>         depends on MMU && SYS_SUPPORTS_NUMA
>>         select ARCH_WANT_NUMA_VARIABLE_LOCALITY
>>
>> but ARCH_WANT_NUMA_VARIABLE_LOCALITY seems to be unimplemented anywhere in
>> the kernel source tree.  I.e., the Kconfig symbol exists in init/Kconfig,
>> but there is no code to support its use.
> 
> It does control (prevent) another option:
> 
> # For architectures that (ab)use NUMA to represent different memory regions
> # all cpu-local but of different latencies, such as SuperH.
> #
> config ARCH_WANT_NUMA_VARIABLE_LOCALITY
>         bool
> 
> config NUMA_BALANCING
>         bool "Memory placement aware NUMA scheduler"
>         depends on ARCH_SUPPORTS_NUMA_BALANCING
>         depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
>         depends on SMP && NUMA && MIGRATION
>         help
>           This option adds support for automatic NUMA aware
> memory/task placement.
>           The mechanism is quite primitive and is based on migrating memory when
>           it has references to the node the task is running on.
> 
>           This system will be inactive on UMA systems.
> 
> The symbol was set by arch/metag, too (which was removed).

I see.  thanks.

-- 
~Randy

