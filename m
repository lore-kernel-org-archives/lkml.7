Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFDDC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E379204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="E07uIf/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfDSSkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:40:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:39408 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfDSSkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:40:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C50911D99D0;
        Fri, 19 Apr 2019 08:41:23 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id K6PqeuoV0-2L; Fri, 19 Apr 2019 08:41:22 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D83771D99C8;
        Fri, 19 Apr 2019 08:41:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D83771D99C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555677682;
        bh=Kfvl2gKKXyUIOchfw/GXAa75HxEGS1r40caugFbbN4E=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=E07uIf/50VV0plFrXow0fwoqfx3Aj9LzNxJHKzFRUVz3MlT3O9eyw5rL137hCfmws
         V5h2GTXQ/Vy5PSKhQgEF2j0Ul1W0Mq6As6LgRMCL+c4QISgOU1IJK3dtMDMKHDbQ40
         uvAdGHjufGJ+GxbVNknmMr09zXAUbVqnAAuB1+NjpXY53J4LwWrFQALL2iCiyi1vA3
         Rc77vECcWZ0FglgMTrpAy2i6rvKZKJhUI3vjfaJuCSpjfs4kIJJAynUxoVY6ipUyLe
         sSwFTLj5yBj206DmioE5qV5FyNEH6WCnM2F7wdivaZyFG0kouc+WIgV2fKw4nQGcBs
         u7ciYN6CvCbOw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id gaSEuxn_0V1v; Fri, 19 Apr 2019 08:41:22 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B6B9C1D99C1;
        Fri, 19 Apr 2019 08:41:22 -0400 (EDT)
Date:   Fri, 19 Apr 2019 08:41:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Ingo Molnar <mingo@kernel.org>
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
        Joel Fernandes <joelaf@google.com>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <1444419838.71.1555677682502.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190419103847.GA111210@gmail.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com> <20190305194755.2602-4-mathieu.desnoyers@efficios.com> <20190419103847.GA111210@gmail.com>
Subject: Re: [PATCH for 5.1 3/3] rseq/selftests: Adapt number of threads to
 the number of detected cpus
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: Adapt number of threads to the number of detected cpus
Thread-Index: YxJQ2i25qH1y+iSOFfTo74MHmwpaOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 19, 2019, at 6:38 AM, Ingo Molnar mingo@kernel.org wrote:

> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On smaller systems, running a test with 200 threads can take a long
>> time on machines with smaller number of CPUs.
>> 
>> Detect the number of online cpus at test runtime, and multiply that
>> by 6 to have 6 rseq threads per cpu preempting each other.
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Joel Fernandes <joelaf@google.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Dave Watson <davejwatson@fb.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Andi Kleen <andi@firstfloor.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Cc: "H . Peter Anvin" <hpa@zytor.com>
>> Cc: Chris Lameter <cl@linux.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
>> Cc: Paul Turner <pjt@google.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: Josh Triplett <josh@joshtriplett.org>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Maurer <bmaurer@fb.com>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> ---
>>  tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/rseq/run_param_test.sh
>> b/tools/testing/selftests/rseq/run_param_test.sh
>> index 3acd6d75ff9f..e426304fd4a0 100755
>> --- a/tools/testing/selftests/rseq/run_param_test.sh
>> +++ b/tools/testing/selftests/rseq/run_param_test.sh
>> @@ -1,6 +1,8 @@
>>  #!/bin/bash
>>  # SPDX-License-Identifier: GPL-2.0+ or MIT
>>  
>> +NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
>> +
>>  EXTRA_ARGS=${@}
>>  
>>  OLDIFS="$IFS"
>> @@ -28,15 +30,16 @@ IFS="$OLDIFS"
>>  
>>  REPS=1000
>>  SLOW_REPS=100
>> +NR_THREADS=$((6*${NR_CPUS}))
>>  
>>  function do_tests()
>>  {
>>  	local i=0
>>  	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
>>  		echo "Running test ${TEST_NAME[$i]}"
>> -		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
>> +		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS}
>> || exit 1
>>  		echo "Running compare-twice test ${TEST_NAME[$i]}"
>> -		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} ||
>> exit 1
>> +		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@}
>> ${EXTRA_ARGS} || exit 1
>>  		let "i++"
>>  	done
>>  }
> 
> BTW., when trying to build the rseq self-tests I get this build failure:
> 
>  dagon:~/tip/tools/testing/selftests/rseq> make
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ -shared
>  -fPIC rseq.c -lpthread -o
>  /home/mingo/tip/tools/testing/selftests/rseq/librseq.so
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ basic_test.c
>  -lpthread -lrseq -o /home/mingo/tip/tools/testing/selftests/rseq/basic_test
>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
>  basic_percpu_ops_test.c -lpthread -lrseq -o
>  /home/mingo/tip/tools/testing/selftests/rseq/basic_percpu_ops_test
>  /usr/bin/ld: /tmp/ccuHTWnZ.o: in function `rseq_cmpeqv_storev':
>  /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:84: undefined
>  reference to `.L8'
>  /usr/bin/ld: /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:84:
>  undefined reference to `.L49'
>  /usr/bin/ld: /tmp/ccuHTWnZ.o: in function `rseq_cmpnev_storeoffp_load':
>  /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:141: undefined
>  reference to `.L57'
>  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x8): undefined reference to `.L8'
>  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x14): undefined reference to
>  `.L49'
>  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x20): undefined reference to
>  `.L55'
>  collect2: error: ld returned 1 exit status
>  make: *** [Makefile:22:
>  /home/mingo/tip/tools/testing/selftests/rseq/basic_percpu_ops_test] Error 1
> 
> Is this a known problem, or do I miss something from my build environment
> perhaps? Vanilla 64-bit Ubuntu 18.10 (Cosmic).

It works fine with gcc-7 (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3))
but indeed I get the same failure with gcc-8 (gcc version 8.0.1 20180414
(experimental) [trunk revision 259383] (Ubuntu 8-20180414-1ubuntu2)).

Thanks for reporting! I will investigate.

Mathieu


> 
> Thanks,
> 
> 	Ingo

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
