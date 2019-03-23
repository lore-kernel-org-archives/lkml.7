Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3CEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21F5218E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 08:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfCWISJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Mar 2019 04:18:09 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:55443 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCWISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Mar 2019 04:18:09 -0400
Received: from [192.168.0.11] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 9811C200009;
        Sat, 23 Mar 2019 08:18:02 +0000 (UTC)
Subject: Re: [PATCH 1/4] arm64, mm: Move generic mmap layout functions to mm
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20190322074225.22282-1-alex@ghiti.fr>
 <20190322074225.22282-2-alex@ghiti.fr> <20190322132127.GA18602@infradead.org>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <72751399-3170-059b-b572-b9b9986ca0fd@ghiti.fr>
Date:   Sat, 23 Mar 2019 04:18:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190322132127.GA18602@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 9:21 AM, Christoph Hellwig wrote:
>> It then introduces a new define ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>> that can be defined by other architectures to benefit from those functions.
> Can you make this a Kconfig option defined in arch/Kconfig or mm/Kconfig
> and selected by the architectures?


Yes, I will do.


>> -#ifndef STACK_RND_MASK
>> -#define STACK_RND_MASK (0x7ff >> (PAGE_SHIFT - 12))	/* 8MB of VA */
>> -#endif
>> -
>> -static unsigned long randomize_stack_top(unsigned long stack_top)
>> -{
>> -	unsigned long random_variable = 0;
>> -
>> -	if (current->flags & PF_RANDOMIZE) {
>> -		random_variable = get_random_long();
>> -		random_variable &= STACK_RND_MASK;
>> -		random_variable <<= PAGE_SHIFT;
>> -	}
>> -#ifdef CONFIG_STACK_GROWSUP
>> -	return PAGE_ALIGN(stack_top) + random_variable;
>> -#else
>> -	return PAGE_ALIGN(stack_top) - random_variable;
>> -#endif
>> -}
>> -
> Maybe the move of this function can be split into another prep patch,
> as it is only very lightly related?
>
>

Ok, that makes sense.

>> +#if defined(HAVE_ARCH_PICK_MMAP_LAYOUT) || \
>> +	defined(ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT)
> Not sure if it is wrіtten down somehwere or just convention, but I
> general see cpp defined statements aligned with spaces to the
> one on the previous line.


Ok, I will fix that.


> Except for these nitpicks this looks very nice to me, thanks for doing
> this work!


Thanks :)

