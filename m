Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF692C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3680223D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 21:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WWkbe8sU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfKSVMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 16:12:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50934 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfKSVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 16:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oO1hG0Lmbof4di3DIu400FA2poHa74+TJlpIPPqEm5U=; b=WWkbe8sUEU2F9jXyY3qN7lJVm
        Q9YuEHV8OhQ9khPCP4iwQrEvCcVqV2dWYN8l7kS+zURJtkpQmJhUM+ICDvjU88ohYzKtY/sbDLyAS
        /XCan0cjPpQPB1PrdwGkPxjTNza/P52EI+LBO9wjtsR/C0Pbee6jnrlf7aEcEz2rlefnFW0kDuTP0
        25eyW2ldSj8QWZ42kTcMllYvj0+6uF4gTf9XhX1jt1ri0835By7fLIUj8pgFHS64ZQEqiMD1wqq0Z
        Rd/QsykSowzkEYad9BwBi32L+3jwgrprOisOS47qX9q3OxjKybZxhtXtn/gQF/hfg54GJkZDTeJ6X
        CfgSs/JTA==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iXAnt-0007Hk-Dh; Tue, 19 Nov 2019 21:12:53 +0000
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
Message-ID: <f45f983d-8ff1-a800-2706-d71413ae1824@infradead.org>
Date:   Tue, 19 Nov 2019 13:12:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
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

Yes, I saw that and suspected it also.

I was (and still am) hoping that a SuperH maintainer comments on
this and on how they are currently building kernels for these
failing configs.  Maybe they have some patches that aren't in-tree yet?


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

I didn't see any issue there but I will check it again.

thanks.
-- 
~Randy

