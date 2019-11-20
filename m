Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D77C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0F62240D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 04:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VUnuKS5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbfKTE2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:28:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37322 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfKTE2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 23:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yu4n6/tEL2AFJsRGfMz4C4atvIlSsvhf/Lmp2bLntMc=; b=VUnuKS5YRRS7eRm+/Fm0SDCMw
        0uKV6G5yyekW0u6X/JT1KfgfxLvWsRKZTSM9zZ5jTKuggonDCYrVDnZOoUpU8V/Mvno/MhB4Q5foq
        vJyb7Eh6RfAPiBpfFjVlvl84IG08ldoRajIo4tjQr8jvEMRqLRikXD0Kd9MLR951lFfr+f7vmx+Ap
        T1G1x3cZTG0ukVDOhTuIDu3rgpYlqw1SrQR2Uybhm3TjU9aqdBHBuQKaEc87IT1vg8L6E7KfYs/xF
        hSngmoKCrgQ/hW0Xfw94yqU9eZWBRpcz2WMFCEr5KurhwzGQVwGIQudHgCR14vhlwVyC9H3JhdQsY
        lCmBtsN8w==;
Received: from [2603:3004:32:9a00::f45c]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXHaz-00075M-97; Wed, 20 Nov 2019 04:28:01 +0000
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <802dc73e-080d-05aa-76fe-165bb4817959@infradead.org>
Date:   Tue, 19 Nov 2019 20:27:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Tue, Nov 19, 2019 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
>> SYS_SUPPORTS_SMP and SMP.
>>
>> kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
>> code + data inside topology.c is only built when CONFIG_NUMA is
>> set/enabled, so these arch/sh/ configs need to select SMP and
>> SYS_SUPPORTS_SMP to build the NUMA support.
>>
>> Fixes this build error in 3 different SUPERH configs:
>>
>> mm/page_alloc.o: In function `get_page_from_freelist':
>> page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> ---
>> or maybe these should be fixed in the defconfig files?
>>
>> or alternatively, does it make any sense to support NUMA without SMP?
> 
> I think it does.  From arch/sh/mm/Kconfig config NUMA help:
> 
>         Some SH systems have many various memories scattered around
>         the address space, each with varying latencies. This enables
>         support for these blocks by binding them to nodes and allowing
>         memory policies to be used for prioritizing and controlling
>         allocation behaviour.

Note that this help text is under:
config NUMA
	bool "Non-Uniform Memory Access (NUMA) Support"
	depends on MMU && SYS_SUPPORTS_NUMA
	select ARCH_WANT_NUMA_VARIABLE_LOCALITY

but ARCH_WANT_NUMA_VARIABLE_LOCALITY seems to be unimplemented anywhere in
the kernel source tree.  I.e., the Kconfig symbol exists in init/Kconfig,
but there is no code to support its use.


> Probably the NUMA-core is too server/x86-centric, by assuming NUMA is
> used only on systems with multiple CPUs, each with their own RAM.
> 
> AFAIK, none of the SoCs below are SMP:
> 
>> --- lnx-54-rc8.orig/arch/sh/Kconfig
>> +++ lnx-54-rc8/arch/sh/Kconfig
>> @@ -508,6 +508,8 @@ config CPU_SUBTYPE_SH7722
>>         select CPU_SHX2
>>         select ARCH_SHMOBILE
>>         select ARCH_SPARSEMEM_ENABLE
>> +       select SYS_SUPPORTS_SMP
>> +       select SMP
>>         select SYS_SUPPORTS_NUMA
>>         select SYS_SUPPORTS_SH_CMT
>>         select PINCTRL
>> @@ -518,6 +520,8 @@ config CPU_SUBTYPE_SH7366
>>         select CPU_SHX2
>>         select ARCH_SHMOBILE
>>         select ARCH_SPARSEMEM_ENABLE
>> +       select SYS_SUPPORTS_SMP
>> +       select SMP
>>         select SYS_SUPPORTS_NUMA
>>         select SYS_SUPPORTS_SH_CMT
> 
> BTW, you didn't have the issue with CPU_SHX3 and CPU_SUBTYPE_SH7785?
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
~Randy
