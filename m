Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771BCC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40615206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbfDDGJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:09:17 -0400
Received: from ozlabs.org ([203.11.71.1]:54533 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbfDDGJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:09:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44ZXZh4x7Tz9sNj;
        Thu,  4 Apr 2019 17:09:00 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jens Axboe <axboe@kernel.dk>, Will Deacon <will.deacon@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
In-Reply-To: <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
References: <20190325143521.34928-1-arnd@arndb.de> <20190325144737.703921-1-arnd@arndb.de> <87tvff24a1.fsf@concordia.ellerman.id.au> <20190403111134.GA7159@fuggles.cambridge.arm.com> <9d673dfd-0051-3676-653e-6376430d73dd@kernel.dk>
Date:   Thu, 04 Apr 2019 17:08:59 +1100
Message-ID: <87imvu1ev8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> writes:
> On 4/3/19 5:11 AM, Will Deacon wrote:
>> On Wed, Apr 03, 2019 at 01:47:50PM +1100, Michael Ellerman wrote:
>>> Arnd Bergmann <arnd@arndb.de> writes:
>>>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>>>> index b18abb0c3dae..00f5a63c8d9a 100644
>>>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>>>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>>>> @@ -505,3 +505,7 @@
>>>>  421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
>>>>  422	32	futex_time64			sys_futex			sys_futex
>>>>  423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
>>>> +424	common	pidfd_send_signal		sys_pidfd_send_signal
>>>> +425	common	io_uring_setup			sys_io_uring_setup
>>>> +426	common	io_uring_enter			sys_io_uring_enter
>>>> +427	common	io_uring_register		sys_io_uring_register
>>>
>>> Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
>>>
>>> Lightly tested.
>>>
>>> The pidfd_test selftest passes.
>> 
>> That reports pass for me too, although it fails to unshare the pid ns, which I
>> assume is benign.

If you run it as root it should work?

>>> Ran the io_uring example from fio, which prints lots of:
>> 
>> How did you invoke that? I had a play with the tests in:
>
> It's t/io_uring from the fio repo:
>
> git://git.kernel.dk/fio
>
> and you just run it ala:
>
> # make t/io_uring
> # t/io_uring /dev/some_device

Yeah that's all I did.

>> will@autoplooker:~/liburing/test$ ./io_uring_register 
>> RELIMIT_MEMLOCK: 67108864 (67108864)
>> [   35.477875] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000070
>> [   35.478969] Mem abort info:
>> [   35.479296]   ESR = 0x96000004
>> [   35.479785]   Exception class = DABT (current EL), IL = 32 bits
>> [   35.480528]   SET = 0, FnV = 0
>> [   35.480980]   EA = 0, S1PTW = 0
>> [   35.481345] Data abort info:
>> [   35.481680]   ISV = 0, ISS = 0x00000004
>> [   35.482267]   CM = 0, WnR = 0
>> [   35.482618] user pgtable: 4k pages, 48-bit VAs, pgdp = (____ptrval____)
>> [   35.483486] [0000000000000070] pgd=0000000000000000
>> [   35.484041] Internal error: Oops: 96000004 [#1] PREEMPT SMP
>> [   35.484788] Modules linked in:
>> [   35.485311] CPU: 113 PID: 3973 Comm: io_uring_regist Not tainted 5.1.0-rc3-00012-g40b114779944 #1
>> [   35.486712] Hardware name: linux,dummy-virt (DT)
>> [   35.487450] pstate: 20400005 (nzCv daif +PAN -UAO)
>> [   35.488228] pc : link_pwq+0x10/0x60
>> [   35.488794] lr : apply_wqattrs_commit+0xe0/0x118
>> [   35.489550] sp : ffff000017e2bbc0
>
> Huh, this looks odd, it's crashing inside the wq setup.

Looks like you found a bug :)

cheers
