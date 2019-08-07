Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18284C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59302173C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 01:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfHGBN4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 21:13:56 -0400
Received: from ozlabs.org ([203.11.71.1]:44759 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfHGBN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 21:13:56 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 463D6T4c5rz9sNF;
        Wed,  7 Aug 2019 11:13:52 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "christophe.leroy\@c-s.fr" <christophe.leroy@c-s.fr>,
        "npiggin\@gmail.com" <npiggin@gmail.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Grant McEwan <grant.mcewan@alliedtelesis.co.nz>
Subject: Re: SMP lockup at boot on Freescale/NXP T2080 (powerpc 64)
In-Reply-To: <1565135404.16914.5.camel@alliedtelesis.co.nz>
References: <1564970785.27215.29.camel@alliedtelesis.co.nz> <4525a16cd3e65f89741b50daf2ec259b6baaab78.camel@alliedtelesis.co.nz> <87wofqv8a0.fsf@concordia.ellerman.id.au> <1565135404.16914.5.camel@alliedtelesis.co.nz>
Date:   Wed, 07 Aug 2019 11:13:46 +1000
Message-ID: <87o911vktx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
> On Tue, 2019-08-06 at 21:32 +1000, Michael Ellerman wrote:
>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
>> > On Mon, 2019-08-05 at 14:06 +1200, Chris Packham wrote:
>> > > 
>> > > Hi All,
>> > > 
>> > > I have a custom board that uses the Freescale/NXP T2080 SoC.
>> > > 
>> > > The board boots fine using v4.19.60 but when I use v5.1.21 it
>> > > locks
>> > > up
>> > > waiting for the other CPUs to come online (earlyprintk output
>> > > below).
>> > > If I set maxcpus=0 then the system boots all the way through to
>> > > userland. The same thing happens with 5.3-rc2.
>> > > 
>> > > The defconfig I'm using is 
>> > > https://gist.github.com/cpackham/f24d0b426f3
>> > > de0eaaba17b82c3528a9d it was updated from the working v4.19.60
>> > > defconfig using make olddefconfig.
>> > > 
>> > > Does this ring any bells for anyone?
>> > > 
>> > > I haven't dug into the differences between the working an non-
>> > > working
>> > > versions yet. I'll start looking now.
>> > I've bisected this to the following commit
>> Thanks that's super helpful.
>> 
>> > 
>> > commit ed1cd6deb013a11959d17a94e35ce159197632da
>> > Author: Christophe Leroy <christophe.leroy@c-s.fr>
>> > Date:   Thu Jan 31 10:08:58 2019 +0000
>> > 
>> >     powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
>> >     
>> >     This patch activates CONFIG_THREAD_INFO_IN_TASK which
>> >     moves the thread_info into task_struct.
>> > 
>> > I'll be the first to admit this is well beyond my area of knowledge
>> > so
>> > I'm unsure what about this patch is problematic but I can be fairly
>> > sure that a build immediately before this patch works while a build
>> > with this patch hangs.
>> It makes a pretty fundamental change to the way the kernel stores
>> some
>> information about each task, moving it off the stack and into the
>> task
>> struct.
>> 
>> It definitely has the potential to break things, but I thought we had
>> reasonable test coverage of the Book3E platforms, I have a p5020ds
>> (e5500) that I boot as part of my CI.
>> 
>> Aha. If I take your config and try to boot it on my p5020ds I get the
>> same behaviour, stuck at SMP bringup. So it seems it's something in
>> your
>> config vs corenet64_smp_defconfig that is triggering the bug.
>> 
>> Can you try bisecting what in the config triggers it?
>> 
>> To do that you checkout ed1cd6deb013a11959d17a94e35ce159197632da,
>> then
>> you build/boot with corenet64_smp_defconfig to confirm it works. Then
>> you use tools/testing/ktest/config-bisect.pl to bisect the changes in
>> the .config.
>> 
>
> The difference between a working and non working defconfig is
> CONFIG_PREEMPT specifically CONFIG_PREEMPT=y makes my system hang at
> boot.
>
> Is that now intentionally prohibited on 64-bit powerpc?

It's not prohibitied, but it probably should be because no one really
tests it properly. I have a handful of IBM machines where I boot a
PREEMPT kernel but that's about it.

The corenet configs don't have PREEMPT enabled, which suggests it was
never really supported on those machines.

But maybe someone from NXP can tell me otherwise.

cheers
