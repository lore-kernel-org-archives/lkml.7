Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B17C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33A220640
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfJBHL7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:11:59 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:4795 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfJBHL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:11:58 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 46jnPl5wHGz9v0tb;
        Wed,  2 Oct 2019 09:11:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id e2yIw6Fj-kKw; Wed,  2 Oct 2019 09:11:55 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 46jnPl56CTz9v0tZ;
        Wed,  2 Oct 2019 09:11:55 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id 348AA64F; Wed,  2 Oct 2019 09:13:04 +0200 (CEST)
Received: from 37.173.255.220 ([37.173.255.220]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 02 Oct 2019 09:13:04 +0200
Date:   Wed, 02 Oct 2019 09:13:04 +0200
Message-ID: <20191002091304.Horde.44CFpqD3KN1HHZOT0U8wSQ7@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Daniel Axtens <dja@axtens.net>
Cc:     gor@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        dvyukov@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, glider@google.com,
        aryabinin@virtuozzo.com, x86@kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real
 shadow memory
References: <20191001065834.8880-1-dja@axtens.net>
 <20191001065834.8880-2-dja@axtens.net> <20191001101707.GA21929@pc636>
 <87zhik2b5x.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87zhik2b5x.fsf@dja-thinkpad.axtens.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> a écrit :

> Hi,
>
>>>  	/*
>>>  	 * Find a place in the tree where VA potentially will be
>>>  	 * inserted, unless it is merged with its sibling/siblings.
>>> @@ -741,6 +752,10 @@ merge_or_add_vmap_area(struct vmap_area *va,
>>>  		if (sibling->va_end == va->va_start) {
>>>  			sibling->va_end = va->va_end;
>>>
>>> +			kasan_release_vmalloc(orig_start, orig_end,
>>> +					      sibling->va_start,
>>> +					      sibling->va_end);
>>> +
>> The same.
>
> The call to kasan_release_vmalloc() is a static inline no-op if
> CONFIG_KASAN_VMALLOC is not defined, which I thought was the preferred
> way to do things rather than sprinkling the code with ifdefs?
>
> The complier should be smart enough to eliminate all the
> orig_state/orig_end stuff at compile time because it can see that it's
> not used, so there's no cost in the binary.
>


Daniel,

You are entirely right in your way to do i, that's fully in line with  
Linux kernel codying style  
https://www.kernel.org/doc/html/latest/process/coding-style.html#conditional-compilation

Christophe

