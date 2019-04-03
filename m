Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C1C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7EB20643
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 01:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbfDCBUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:20:02 -0400
Received: from ozlabs.org ([203.11.71.1]:41751 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfDCBUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 21:20:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44YpCT5B81z9sPS;
        Wed,  3 Apr 2019 12:19:49 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
In-Reply-To: <CAK8P3a14of-jJA2q7rki3gHk6gwE-0TCkzHuXZ1+TkemopgfRA@mail.gmail.com>
References: <20190325143521.34928-1-arnd@arndb.de> <20190325144737.703921-1-arnd@arndb.de> <87y34vl6ji.fsf@concordia.ellerman.id.au> <CAK8P3a14of-jJA2q7rki3gHk6gwE-0TCkzHuXZ1+TkemopgfRA@mail.gmail.com>
Date:   Wed, 03 Apr 2019 12:19:49 +1100
Message-ID: <87wokb28cq.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Sun, Mar 31, 2019 at 5:47 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Arnd Bergmann <arnd@arndb.de> writes:
>> > Add the io_uring and pidfd_send_signal system calls to all architectures.
>> >
>> > These system calls are designed to handle both native and compat tasks,
>> > so all entries are the same across architectures, only arm-compat and
>> > the generic tale still use an old format.
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > ---
>> >  arch/alpha/kernel/syscalls/syscall.tbl      | 4 ++++
>> >  arch/arm/tools/syscall.tbl                  | 4 ++++
>> >  arch/arm64/include/asm/unistd.h             | 2 +-
>> >  arch/arm64/include/asm/unistd32.h           | 8 ++++++++
>> >  arch/ia64/kernel/syscalls/syscall.tbl       | 4 ++++
>> >  arch/m68k/kernel/syscalls/syscall.tbl       | 4 ++++
>> >  arch/microblaze/kernel/syscalls/syscall.tbl | 4 ++++
>> >  arch/mips/kernel/syscalls/syscall_n32.tbl   | 4 ++++
>> >  arch/mips/kernel/syscalls/syscall_n64.tbl   | 4 ++++
>> >  arch/mips/kernel/syscalls/syscall_o32.tbl   | 4 ++++
>> >  arch/parisc/kernel/syscalls/syscall.tbl     | 4 ++++
>> >  arch/powerpc/kernel/syscalls/syscall.tbl    | 4 ++++
>>
>> Have you done any testing?
>>
>> I'd rather not wire up syscalls that have never been tested at all on
>> powerpc.
>
> No, I have not. I did review the system calls carefully and added the first
> patch to fix the bug on x86 compat mode before adding the same bug
> on the other compat architectures though ;-)
>
> Generally, my feeling is that adding system calls is not fundamentally
> different from adding other ABIs, and we should really do it at
> the same time across all architectures, rather than waiting for each
> maintainer to get around to reviewing and testing the new calls
> first. This is not a problem on powerpc, but a lot of other architectures
> are less active, which is how we have always ended up with
> different sets of system calls across architectures.

Well it's still something of a problem on powerpc. No one has
volunteered to test io_uring on powerpc, so at this stage it will go in
completely untested.

If there was a selftest in the tree I'd be a bit happier, because at
least then our CI would start testing it as soon as the syscalls were
wired up in linux-next.

And yeah obviously I should test it, but I don't have infinite time
unfortunately.

> The problem here is that this makes it harder for the C library to
> know when a system call is guaranteed to be available. glibc
> still needs a feature test for newly added syscalls to see if they
> are working (they might be backported to an older kernel, or
> disabled), but whenever the minimum kernel version is increased,
> it makes sense to drop those checks and assume non-optional
> system calls will work if they were part of that minimum version.

But that's the thing, if we just wire them up untested they may not
actually work. And then you have the far worse situation where the
syscall exists in kernel version x but does not actually work properly.

See the mess we have with pkeys for example.

> In the future, I'd hope that any new system calls get added
> right away on all architectures when they land (it was a bit
> tricky this time, because I still did a bunch of reworks that
> conflicted with the new calls). Bugs will happen of course, but
> I think adding them sooner makes it more likely to catch those
> bugs early on so we have a chance to fix them properly,
> and need fewer arch specific workarounds (ideally none)
> for system calls.

For syscalls that have a selftest in the tree, and don't rely on
anything arch specific I agree.

I'm a bit more wary of things that are not easily tested and have the
potential to work differently across arches.

cheers
