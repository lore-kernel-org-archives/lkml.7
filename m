Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E30C282E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E38B222AD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rGEPcJMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfDSSUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:20:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:37808 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfDSSUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:20:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 98B831D9689;
        Fri, 19 Apr 2019 10:40:25 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ISjcRtWWO78x; Fri, 19 Apr 2019 10:40:24 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8943E1D9684;
        Fri, 19 Apr 2019 10:40:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8943E1D9684
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555684824;
        bh=lo6hjHYasJMVdRkc7hwcdvaayH4dUYnQiuxm8gsRYiQ=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rGEPcJMpZ3fuFTYXQQiPP3xmkGubz7KsrpyXWxYHgCF7OacPx0ntB57p9cFuH0ZSJ
         IrKYvHoblpU8C7+sud0zb4HNXYbVrEhsSMsuEhifdiHqgMoedfzamAQyzS9IgFXj/D
         P418mFZ7U4jEc+MrM6EETYl0v3ZppOJc5RDMn7v0JXo2UO3VLg+pzb8XOgqs0mpUbo
         qx2vVbzTvVgoNiRwqXe21u09XR18vQQT4s2ply0D8SrZGfPFwDiuLzCC3jp6XIMSXI
         IVsAa45vBqMvhR8u8O/3JSaS+a5tCE08NCCxeWfuqGXT0iNXLQJNILIvd/pNLxE40O
         U8wYxPuUMykpw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id PRfw7WDhiQzN; Fri, 19 Apr 2019 10:40:24 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 693871D967D;
        Fri, 19 Apr 2019 10:40:24 -0400 (EDT)
Date:   Fri, 19 Apr 2019 10:40:24 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     shuah <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Chris Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <580328197.148.1555684824260.JavaMail.zimbra@efficios.com>
In-Reply-To: <6ba0796c-8a96-f797-265c-37bfb9b4bb71@kernel.org>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com> <20190305194755.2602-4-mathieu.desnoyers@efficios.com> <20190419103847.GA111210@gmail.com> <1444419838.71.1555677682502.JavaMail.zimbra@efficios.com> <1266612341.87.1555678507226.JavaMail.zimbra@efficios.com> <614774674.134.1555681346941.JavaMail.zimbra@efficios.com> <1863599735.141.1555681723685.JavaMail.zimbra@efficios.com> <6ba0796c-8a96-f797-265c-37bfb9b4bb71@kernel.org>
Subject: Re: [PATCH for 5.1 3/3] rseq/selftests: Adapt number of threads to
 the number of detected cpus
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: Adapt number of threads to the number of detected cpus
Thread-Index: BBJGXWsArGxE3dGmCFFgAgyerCH71g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 19, 2019, at 10:17 AM, shuah shuah@kernel.org wrote:

> On 4/19/19 7:48 AM, Mathieu Desnoyers wrote:
>> ----- On Apr 19, 2019, at 9:42 AM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>>> ----- On Apr 19, 2019, at 8:55 AM, Mathieu Desnoyers
>>> mathieu.desnoyers@efficios.com wrote:
>>>
>>>> ----- On Apr 19, 2019, at 8:41 AM, Mathieu Desnoyers
>>>> mathieu.desnoyers@efficios.com wrote:
>>>>
>>>>> ----- On Apr 19, 2019, at 6:38 AM, Ingo Molnar mingo@kernel.org wrote:
>>>>>
>>>>>> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>>>>>
>>>>>>> On smaller systems, running a test with 200 threads can take a long
>>>>>>> time on machines with smaller number of CPUs.
>>>>>>>
>>>>>>> Detect the number of online cpus at test runtime, and multiply that
>>>>>>> by 6 to have 6 rseq threads per cpu preempting each other.
>>>>>>>
>>>>>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>>>> Cc: Shuah Khan <shuah@kernel.org>
>>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>>> Cc: Joel Fernandes <joelaf@google.com>
>>>>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>>>>>> Cc: Dave Watson <davejwatson@fb.com>
>>>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>>>> Cc: Andi Kleen <andi@firstfloor.org>
>>>>>>> Cc: linux-kselftest@vger.kernel.org
>>>>>>> Cc: "H . Peter Anvin" <hpa@zytor.com>
>>>>>>> Cc: Chris Lameter <cl@linux.com>
>>>>>>> Cc: Russell King <linux@arm.linux.org.uk>
>>>>>>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>>>>>>> Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
>>>>>>> Cc: Paul Turner <pjt@google.com>
>>>>>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>>>>>> Cc: Josh Triplett <josh@joshtriplett.org>
>>>>>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>>>>>> Cc: Ben Maurer <bmaurer@fb.com>
>>>>>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>>>>>> ---
>>>>>>>   tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
>>>>>>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/tools/testing/selftests/rseq/run_param_test.sh
>>>>>>> b/tools/testing/selftests/rseq/run_param_test.sh
>>>>>>> index 3acd6d75ff9f..e426304fd4a0 100755
>>>>>>> --- a/tools/testing/selftests/rseq/run_param_test.sh
>>>>>>> +++ b/tools/testing/selftests/rseq/run_param_test.sh
>>>>>>> @@ -1,6 +1,8 @@
>>>>>>>   #!/bin/bash
>>>>>>>   # SPDX-License-Identifier: GPL-2.0+ or MIT
>>>>>>>   
>>>>>>> +NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
>>>>>>> +
>>>>>>>   EXTRA_ARGS=${@}
>>>>>>>   
>>>>>>>   OLDIFS="$IFS"
>>>>>>> @@ -28,15 +30,16 @@ IFS="$OLDIFS"
>>>>>>>   
>>>>>>>   REPS=1000
>>>>>>>   SLOW_REPS=100
>>>>>>> +NR_THREADS=$((6*${NR_CPUS}))
>>>>>>>   
>>>>>>>   function do_tests()
>>>>>>>   {
>>>>>>>   	local i=0
>>>>>>>   	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
>>>>>>>   		echo "Running test ${TEST_NAME[$i]}"
>>>>>>> -		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
>>>>>>> +		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS}
>>>>>>> || exit 1
>>>>>>>   		echo "Running compare-twice test ${TEST_NAME[$i]}"
>>>>>>> -		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} ||
>>>>>>> exit 1
>>>>>>> +		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@}
>>>>>>> ${EXTRA_ARGS} || exit 1
>>>>>>>   		let "i++"
>>>>>>>   	done
>>>>>>>   }
>>>>>>
>>>>>> BTW., when trying to build the rseq self-tests I get this build failure:
>>>>>>
>>>>>>   dagon:~/tip/tools/testing/selftests/rseq> make
>>>>>>   gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ -shared
>>>>>>   -fPIC rseq.c -lpthread -o
>>>>>>   /home/mingo/tip/tools/testing/selftests/rseq/librseq.so
>>>>>>   gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ basic_test.c
>>>>>>   -lpthread -lrseq -o /home/mingo/tip/tools/testing/selftests/rseq/basic_test
>>>>>>   gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
>>>>>>   basic_percpu_ops_test.c -lpthread -lrseq -o
>>>>>>   /home/mingo/tip/tools/testing/selftests/rseq/basic_percpu_ops_test
>>>>>>   /usr/bin/ld: /tmp/ccuHTWnZ.o: in function `rseq_cmpeqv_storev':
>>>>>>   /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:84: undefined
>>>>>>   reference to `.L8'
>>>>>>   /usr/bin/ld: /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:84:
>>>>>>   undefined reference to `.L49'
>>>>>>   /usr/bin/ld: /tmp/ccuHTWnZ.o: in function `rseq_cmpnev_storeoffp_load':
>>>>>>   /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:141: undefined
>>>>>>   reference to `.L57'
>>>>>>   /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x8): undefined reference to `.L8'
>>>>>>   /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x14): undefined reference to
>>>>>>   `.L49'
>>>>>>   /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x20): undefined reference to
>>>>>>   `.L55'
>>>>>>   collect2: error: ld returned 1 exit status
>>>>>>   make: *** [Makefile:22:
>>>>>>   /home/mingo/tip/tools/testing/selftests/rseq/basic_percpu_ops_test] Error 1
>>>>>>
>>>>>> Is this a known problem, or do I miss something from my build environment
>>>>>> perhaps? Vanilla 64-bit Ubuntu 18.10 (Cosmic).
>>>>>
>>>>> It works fine with gcc-7 (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3))
>>>>> but indeed I get the same failure with gcc-8 (gcc version 8.0.1 20180414
>>>>> (experimental) [trunk revision 259383] (Ubuntu 8-20180414-1ubuntu2)).
>>>>>
>>>>> Thanks for reporting! I will investigate.
>>>>
>>>> It looks like gcc-8 optimize away the target of asm goto labels when
>>>> there are more than one of them on x86-64. I'll try to come up with
>>>> a simpler reproducer.
>>>
>>> It appears to be related to gcc-8 mishandling combination of
>>> asm goto and thread-local storage input operands on x86-64.
>>> Here is a simple reproducer:
>>>
>>> __thread int var;
>>>   
>>> static int fct(void)
>>> {
>>>         asm goto (      "jmp %l[testlabel]\n\t"
>>>                         : : [var] "m" (var) : : testlabel);
>>>         return 0;
>>> testlabel:
>> 
>> FWIW, if I add an empty
>> 
>>     asm volatile ("");
>> 
>> here after the label, gcc-8 -O2 builds "something" which is
>> a bogus assembler (an endless loop) :
>> 
>> main:
>> .LFB24:
>>          .cfi_startproc
>> .L2:
>>          subq    $8, %rsp
>>          .cfi_def_cfa_offset 16
>> #APP
>> # 6 "test-asm-goto.c" 1
>>          jmp .L2
>> 
>> # 0 "" 2
>> #NO_APP
>>          movl    %fs:var@tpoff, %edx
>>          leaq    .LC0(%rip), %rsi
>>          movl    $1, %edi
>>          xorl    %eax, %eax
>>          call    __printf_chk@PLT
>>          xorl    %eax, %eax
>>          addq    $8, %rsp
>>          .cfi_def_cfa_offset 8
>>          ret
>>          .cfi_endproc
>> 
>> Thoughts ?
>> 
> 
> Didn't see problems when I tested it before applying it to
> linux-kselftest next.
> 
> I have gcc version 7.3.0 (Ubuntu 7.3.0-27ubuntu1~18.04)

It really appears to be an optimization bug in gcc-8. Considering that
bogus compilers are released in the wild, we can hardly justify using
the compiler feature that triggers the bogus behavior, even if it gets
fixed in the future.

I've prepared a patch that changes the way the __rseq_abi fields are
passed to the inline asm. I pass the address of the __rseq_abi TLS
as a register input operand rather than each individual field as "m"
operand.

I will submit it in a separate thread.

By the way, it affects both x86-32 (building with gcc-8 -m32) and x86-64.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
