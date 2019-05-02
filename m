Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D4DC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23FE6214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbfEBMaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:30:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:58882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbfEBMaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:30:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7D4BCAD45;
        Thu,  2 May 2019 12:30:02 +0000 (UTC)
Subject: Re: [PATCH] mod_devicetable.h: reduce sizeof(struct of_device_id) by
 80 bytes
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Mattias Jacobsson <2pi@mok.nu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190425203101.9403-1-linux@rasmusvillemoes.dk>
 <CAK8P3a1Fu64YhQzvSEy8j3oZ3XwUN81fY+K6Z6ksHhqDWzbxNA@mail.gmail.com>
 <73918e46-e3c8-edc4-c941-e650c05519c8@rasmusvillemoes.dk>
From:   Jeff Mahoney <jeffm@suse.com>
Message-ID: <67f54ca8-f4bd-5388-1067-35cd192cf37e@suse.com>
Date:   Thu, 2 May 2019 08:29:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:67.0)
 Gecko/20100101 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <73918e46-e3c8-edc4-c941-e650c05519c8@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/19 5:41 AM, Rasmus Villemoes wrote:
> On 26/04/2019 11.27, Arnd Bergmann wrote:
>> On Thu, Apr 25, 2019 at 10:31 PM Rasmus Villemoes
>> <linux@rasmusvillemoes.dk> wrote:
>>>
>>> For an arm imx_v6_v7_defconfig kernel, .rodata becomes 70K smaller;
>>> .init.data shrinks by another ~13K, making the whole kernel image
>>> about 83K, or 0.3%, smaller.
>>>
>>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>>
>> The space savings are nice, but I wonder if the format of these
>> structures is part of the ABI or not. I have some vague recollection
>> of that, but it's possible that it's no longer true in this century.
>>
>> scripts/mod/file2alias.c processes the structures into a different
>> format and seems to be written specifically to avoid problems
>> with changes like the one you did. Can anyone confirm that
>> this is true before we apply the patch?
> 
> I can't confirm it, of course, but I did do some digging around and
> couldn't find anything other than file2alias, which as you mention is
> prepared for such a change. I also couldn't find any specific reason for
> the 128 (it's not a #define, so at least originally it didn't seem to be
> tied to some external consumer) - Jeff, do you remember why you chose
> that back when you did 5e6557722e69?

I had been wondering why I'd been included on this thread.  I completely 
forgot that I wrote this code nearly 15 years ago. :)

It was probably as simple as there not being a real limit for how long 
the compatible string could be and wanting to make it flexible.  I was 
targetting a powerpc mac notebook I had at the time -- not tight memory 
embedded systems, so sorry for that.

> But we cannot really know whether there is some userspace tool that
> parses the .ko ELF objects the same way that file2alias does, doing
> pattern matching on the symbol names etc. I cannot see why anybody would
> _do_ that (the in-tree infrastructure already generates the
> MODULE_ALIAS() from which modules.alias gets generated), but the only
> way of knowing, I think, is to try to apply the patch and see if anybody
> complains.

The size is part of the ABI, though.  module-init-tools has a copy of 
the same struct and uses that size to walk an array of of_device_id when 
a module as more than one.  If you shrink it, that will certainly break.

file2alias does the right things only because it's tightly coupled to 
the kernel version it's being used with.  It still directly accesses the 
structure definitions in the headers.

-Jeff

-- 
Jeff Mahoney
SUSE Labs
