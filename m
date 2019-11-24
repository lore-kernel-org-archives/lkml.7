Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA47AC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 16:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97449207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 16:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mD9+QwO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfKXQZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 11:25:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfKXQZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 11:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lEjoxWNG4GP3F7qPycSi9+5U4/aPjTVHFyvcqq6SznI=; b=mD9+QwO27OzdnzGzIJ5kAYRBG
        93b5yfRQV3yvZ3O0eVPLJtC/x4chCCNrIdLrjfNE45v5/WFtWqynKMmcXke7e8T//idZ7WI7jmbxV
        S6HmYnPhWM6UDei5nGSl5BXKxE2I7Th27jTNqWlulE2WE9zNnbG2aM/tPdD9gau+HNy+7nXN0JmLm
        /VSIczBAqAaEo2vSQNpZb3783KBXP0or1PRnFslOooXEFkBZXJQYzZaZlYT7t4Ft4kZX7avdrnive
        k/l6xHAHJvan2movNuARFbmfVukQk5idgjWZ1dfyN+RXC5VPIC6Z4zMTQDl5Fz/nWnKgfRGxWfP1R
        wxUdsJEgA==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iYuh2-0001uu-Jj; Sun, 24 Nov 2019 16:25:00 +0000
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com>
 <f45f983d-8ff1-a800-2706-d71413ae1824@infradead.org>
Message-ID: <d6eac4c0-a44b-6209-42a7-8eb535e6f437@infradead.org>
Date:   Sun, 24 Nov 2019 08:24:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f45f983d-8ff1-a800-2706-d71413ae1824@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 1:12 PM, Randy Dunlap wrote:
> On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
>> Hi Randy,
>>
>> On Tue, Nov 19, 2019 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>> From: Randy Dunlap <rdunlap@infradead.org>
>>> Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
>>> SYS_SUPPORTS_SMP and SMP.
>>>
>>> kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
>>> code + data inside topology.c is only built when CONFIG_NUMA is
>>> set/enabled, so these arch/sh/ configs need to select SMP and
>>> SYS_SUPPORTS_SMP to build the NUMA support.
>>>
>>> Fixes this build error in 3 different SUPERH configs:
>>>
>>> mm/page_alloc.o: In function `get_page_from_freelist':
>>> page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>>> Cc: Rich Felker <dalias@libc.org>
>>> Cc: linux-sh@vger.kernel.org
>>> ---
>>> or maybe these should be fixed in the defconfig files?
>>>
>>> or alternatively, does it make any sense to support NUMA without SMP?
>>
>> I think it does.  From arch/sh/mm/Kconfig config NUMA help:
>>
>>         Some SH systems have many various memories scattered around
>>         the address space, each with varying latencies. This enables
>>         support for these blocks by binding them to nodes and allowing
>>         memory policies to be used for prioritizing and controlling
>>         allocation behaviour.
> 
> Yes, I saw that and suspected it also.
> 
> I was (and still am) hoping that a SuperH maintainer comments on
> this and on how they are currently building kernels for these
> failing configs.  Maybe they have some patches that aren't in-tree yet?
> 

Yoshinori-san,
Can you share with us how you build kernels for SUPERH configs that set
CONFIG_NUMA but do not set CONFIG_SMP?  Do you have any patches for this?


> 
>> Probably the NUMA-core is too server/x86-centric, by assuming NUMA is
>> used only on systems with multiple CPUs, each with their own RAM.

Yes, I looked at all of that code for a couple of days and got nowhere
with trying to separate NUMA from SMP.

thanks.
-- 
~Randy

