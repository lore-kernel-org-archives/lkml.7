Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0CDEC282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE8020645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="G/PIlST+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfDSSzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:55:05 -0400
Received: from mail.efficios.com ([167.114.142.138]:40826 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727204AbfDSSzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:55:03 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 3D9121D9CD4;
        Fri, 19 Apr 2019 08:55:08 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id VnzTiYJp4iNa; Fri, 19 Apr 2019 08:55:07 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 75BF81D9CCC;
        Fri, 19 Apr 2019 08:55:07 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 75BF81D9CCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555678507;
        bh=19GsHfwLIKcL8HEWFKtwwkQ/IHuxdkjNzq2OLCNfc88=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=G/PIlST+0u29YwsijHCyB/6akd6bRZ2ui6RXdHxgb0Nytv1vyaf6PSm6mtGLpMqUc
         MGvEruT8V1LEzs3TAL7MCm/uP4mNj26gJRxoS2idyET/HGx6K3ZzoQm5w1Ghual5JF
         mDw1gPDKGiXra4reE9gxQ6uMvIJ69BgRu6Id5G6Vc6cedAWxJSmA+fsyo/ivwdndmf
         KBoXKG3Cunn8PoanUbEoszoP4h4zQWyeIid3nIfYzCXKBQSfofTS0auXXzhw8lFI7w
         RPB6SG/wTvbeECanZOB3jBTHbEJod/k+IVQlL1D91K0MYI+TibCJZUopWVc7chuBc6
         m3xaIw6f+uoZw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id URA9x8IfWFyo; Fri, 19 Apr 2019 08:55:07 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 4D8C71D9CC6;
        Fri, 19 Apr 2019 08:55:07 -0400 (EDT)
Date:   Fri, 19 Apr 2019 08:55:07 -0400 (EDT)
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
Message-ID: <1266612341.87.1555678507226.JavaMail.zimbra@efficios.com>
In-Reply-To: <1444419838.71.1555677682502.JavaMail.zimbra@efficios.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com> <20190305194755.2602-4-mathieu.desnoyers@efficios.com> <20190419103847.GA111210@gmail.com> <1444419838.71.1555677682502.JavaMail.zimbra@efficios.com>
Subject: Re: [PATCH for 5.1 3/3] rseq/selftests: Adapt number of threads to
 the number of detected cpus
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: Adapt number of threads to the number of detected cpus
Thread-Index: YxJQ2i25qH1y+iSOFfTo74MHmwpaOcIwymvL
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 19, 2019, at 8:41 AM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 19, 2019, at 6:38 AM, Ingo Molnar mingo@kernel.org wrote:
> 
>> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> 
>>> On smaller systems, running a test with 200 threads can take a long
>>> time on machines with smaller number of CPUs.
>>> 
>>> Detect the number of online cpus at test runtime, and multiply that
>>> by 6 to have 6 rseq threads per cpu preempting each other.
>>> 
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> Cc: Shuah Khan <shuah@kernel.org>
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Joel Fernandes <joelaf@google.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>> Cc: Dave Watson <davejwatson@fb.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Andi Kleen <andi@firstfloor.org>
>>> Cc: linux-kselftest@vger.kernel.org
>>> Cc: "H . Peter Anvin" <hpa@zytor.com>
>>> Cc: Chris Lameter <cl@linux.com>
>>> Cc: Russell King <linux@arm.linux.org.uk>
>>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>>> Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
>>> Cc: Paul Turner <pjt@google.com>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Cc: Josh Triplett <josh@joshtriplett.org>
>>> Cc: Steven Rostedt <rostedt@goodmis.org>
>>> Cc: Ben Maurer <bmaurer@fb.com>
>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> ---
>>>  tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/tools/testing/selftests/rseq/run_param_test.sh
>>> b/tools/testing/selftests/rseq/run_param_test.sh
>>> index 3acd6d75ff9f..e426304fd4a0 100755
>>> --- a/tools/testing/selftests/rseq/run_param_test.sh
>>> +++ b/tools/testing/selftests/rseq/run_param_test.sh
>>> @@ -1,6 +1,8 @@
>>>  #!/bin/bash
>>>  # SPDX-License-Identifier: GPL-2.0+ or MIT
>>>  
>>> +NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
>>> +
>>>  EXTRA_ARGS=${@}
>>>  
>>>  OLDIFS="$IFS"
>>> @@ -28,15 +30,16 @@ IFS="$OLDIFS"
>>>  
>>>  REPS=1000
>>>  SLOW_REPS=100
>>> +NR_THREADS=$((6*${NR_CPUS}))
>>>  
>>>  function do_tests()
>>>  {
>>>  	local i=0
>>>  	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
>>>  		echo "Running test ${TEST_NAME[$i]}"
>>> -		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
>>> +		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS}
>>> || exit 1
>>>  		echo "Running compare-twice test ${TEST_NAME[$i]}"
>>> -		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} ||
>>> exit 1
>>> +		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@}
>>> ${EXTRA_ARGS} || exit 1
>>>  		let "i++"
>>>  	done
>>>  }
>> 
>> BTW., when trying to build the rseq self-tests I get this build failure:
>> 
>>  dagon:~/tip/tools/testing/selftests/rseq> make
>>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ -shared
>>  -fPIC rseq.c -lpthread -o
>>  /home/mingo/tip/tools/testing/selftests/rseq/librseq.so
>>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ basic_test.c
>>  -lpthread -lrseq -o /home/mingo/tip/tools/testing/selftests/rseq/basic_test
>>  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./
>>  basic_percpu_ops_test.c -lpthread -lrseq -o
>>  /home/mingo/tip/tools/testing/selftests/rseq/basic_percpu_ops_test
>>  /usr/bin/ld: /tmp/ccuHTWnZ.o: in function `rseq_cmpeqv_storev':
>>  /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:84: undefined
>>  reference to `.L8'
>>  /usr/bin/ld: /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:84:
>>  undefined reference to `.L49'
>>  /usr/bin/ld: /tmp/ccuHTWnZ.o: in function `rseq_cmpnev_storeoffp_load':
>>  /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:141: undefined
>>  reference to `.L57'
>>  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x8): undefined reference to `.L8'
>>  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x14): undefined reference to
>>  `.L49'
>>  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x20): undefined reference to
>>  `.L55'
>>  collect2: error: ld returned 1 exit status
>>  make: *** [Makefile:22:
>>  /home/mingo/tip/tools/testing/selftests/rseq/basic_percpu_ops_test] Error 1
>> 
>> Is this a known problem, or do I miss something from my build environment
>> perhaps? Vanilla 64-bit Ubuntu 18.10 (Cosmic).
> 
> It works fine with gcc-7 (gcc version 7.3.0 (Ubuntu 7.3.0-16ubuntu3))
> but indeed I get the same failure with gcc-8 (gcc version 8.0.1 20180414
> (experimental) [trunk revision 259383] (Ubuntu 8-20180414-1ubuntu2)).
> 
> Thanks for reporting! I will investigate.

It looks like gcc-8 optimize away the target of asm goto labels when
there are more than one of them on x86-64. I'll try to come up with
a simpler reproducer.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
