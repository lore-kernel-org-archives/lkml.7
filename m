Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B17C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713E82171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 20:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555704238;
	bh=KYdBbUNaIUF/5+XVcGqJIjyaSkRQ4Lj/DHWgd1kb0mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K2GB3nnAKwYiWaBvBm9Rdfjxe5SraAWTUyAqrRFJp4PDzqHJykA9XYe7pr+sY7SP5
	 YIKdp31bxVlqkrr3ElKfU7vmVWP1xAd7PQiPYPCMkYfhL6z3PFsyUZfGC7V9UtQCck
	 +EH/rAEAN81yqEo483sQW39HpRPwko+k2V049bhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfDSUD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:03:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39736 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbfDSUD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 16:03:56 -0400
Received: by mail-wm1-f65.google.com with SMTP id n25so7379857wmk.4;
        Fri, 19 Apr 2019 13:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sbYwzWLaexgk1cs84aQsE4e32SI8lj7TZ3WnXMFi0Qs=;
        b=QQgcJSSjaT/mHeCMAQ2gV34njs6B2wjdNujdpT4uFHAbGdNjF01CIZRPYhYL9XWi3x
         z/IGJMf9AmABJStUBBQYR2EUPjv6bEsT8fa1brShDfw+/pWEPFH99jbtLdj7aq2wGjOB
         JlYvg4fapxuYd8xLddOGyAl/puYZGLFk+ChMqFQtYiWhcjITRz906bsWipZ6xcQ3Wial
         ybB0KB+5F+eY6DoddpALQsitlWj4X+pb2JWNHg1t1r714jYK1W7utebni3OciDC9tDqk
         oT07aJ3h1eRxylmRDtS8tDwI04dnj2bE3cbYPwP2Hrw8v44hahJ9ukPe2Zf6vmXdk4lT
         TSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sbYwzWLaexgk1cs84aQsE4e32SI8lj7TZ3WnXMFi0Qs=;
        b=MQCkYDYcCXgqafIOCvJdjXzh4gjVGrquh05VJmERh5RuHVmr0vQLWGsFoVxDRcoTmX
         kwCW6GykF0SzTbotzY2nHuSiqtyWPn/8wKNRcJm1bBAEIauT3fsoS8xi7ow+Tt16M4Db
         wr2clYNNrpqqjMrqUBQo/zj3KG2Laax6XOB34jZkjzYTa+zY+FDr+KjjQR7f9Jw3aCgv
         CaRzqMvHY/fJCIK223IDvqu7iMmn1od9ZoZRRVTphTV8nWM0RxuvrxIfufiq8IL2Qh1D
         s4kbf3MRyjMCPkL0Yj+JKWiBba2ykwQjot9hLdXGAqpS7smlDwpZHRItoQptGlYstu+U
         AVMQ==
X-Gm-Message-State: APjAAAVn97ws0xtOlx9JK3tXdLKxb7Vfp6qPZGaNNBWYJymb1IJncZar
        25VDKDxX+EZAG/nSO9DpR6Q/0sy+
X-Google-Smtp-Source: APXvYqzZ5q+XHm2fUuPXqdlt+Bhy3SUOU05UEOaHdDdTIxxpYhSkQfTNqbWh+ifXZVGrTkl21/ePzQ==
X-Received: by 2002:a1c:6a0d:: with SMTP id f13mr2160889wmc.76.1555670330993;
        Fri, 19 Apr 2019 03:38:50 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y9sm8579099wrn.18.2019.04.19.03.38.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 03:38:50 -0700 (PDT)
Date:   Fri, 19 Apr 2019 12:38:47 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH for 5.1 3/3] rseq/selftests: Adapt number of threads to
 the number of detected cpus
Message-ID: <20190419103847.GA111210@gmail.com>
References: <20190305194755.2602-1-mathieu.desnoyers@efficios.com>
 <20190305194755.2602-4-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305194755.2602-4-mathieu.desnoyers@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On smaller systems, running a test with 200 threads can take a long
> time on machines with smaller number of CPUs.
> 
> Detect the number of online cpus at test runtime, and multiply that
> by 6 to have 6 rseq threads per cpu preempting each other.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Dave Watson <davejwatson@fb.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Andi Kleen <andi@firstfloor.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Chris Lameter <cl@linux.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Maurer <bmaurer@fb.com>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  tools/testing/selftests/rseq/run_param_test.sh | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
> index 3acd6d75ff9f..e426304fd4a0 100755
> --- a/tools/testing/selftests/rseq/run_param_test.sh
> +++ b/tools/testing/selftests/rseq/run_param_test.sh
> @@ -1,6 +1,8 @@
>  #!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0+ or MIT
>  
> +NR_CPUS=`grep '^processor' /proc/cpuinfo | wc -l`
> +
>  EXTRA_ARGS=${@}
>  
>  OLDIFS="$IFS"
> @@ -28,15 +30,16 @@ IFS="$OLDIFS"
>  
>  REPS=1000
>  SLOW_REPS=100
> +NR_THREADS=$((6*${NR_CPUS}))
>  
>  function do_tests()
>  {
>  	local i=0
>  	while [ "$i" -lt "${#TEST_LIST[@]}" ]; do
>  		echo "Running test ${TEST_NAME[$i]}"
> -		./param_test ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
> +		./param_test ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
>  		echo "Running compare-twice test ${TEST_NAME[$i]}"
> -		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} ${@} ${EXTRA_ARGS} || exit 1
> +		./param_test_compare_twice ${TEST_LIST[$i]} -r ${REPS} -t ${NR_THREADS} ${@} ${EXTRA_ARGS} || exit 1
>  		let "i++"
>  	done
>  }

BTW., when trying to build the rseq self-tests I get this build failure:

  dagon:~/tip/tools/testing/selftests/rseq> make
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ -shared -fPIC rseq.c -lpthread -o /home/mingo/tip/tools/testing/selftests/rseq/librseq.so
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ basic_test.c -lpthread -lrseq -o /home/mingo/tip/tools/testing/selftests/rseq/basic_test
  gcc -O2 -Wall -g -I./ -I../../../../usr/include/ -L./ -Wl,-rpath=./ basic_percpu_ops_test.c -lpthread -lrseq -o /home/mingo/tip/tools/testing/selftests/rseq/basic_percpu_ops_test
  /usr/bin/ld: /tmp/ccuHTWnZ.o: in function `rseq_cmpeqv_storev':
  /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:84: undefined reference to `.L8'
  /usr/bin/ld: /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:84: undefined reference to `.L49'
  /usr/bin/ld: /tmp/ccuHTWnZ.o: in function `rseq_cmpnev_storeoffp_load':
  /home/mingo/tip/tools/testing/selftests/rseq/./rseq-x86.h:141: undefined reference to `.L57'
  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x8): undefined reference to `.L8'
  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x14): undefined reference to `.L49'
  /usr/bin/ld: /tmp/ccuHTWnZ.o:(__rseq_failure+0x20): undefined reference to `.L55'
  collect2: error: ld returned 1 exit status
  make: *** [Makefile:22: /home/mingo/tip/tools/testing/selftests/rseq/basic_percpu_ops_test] Error 1

Is this a known problem, or do I miss something from my build environment 
perhaps? Vanilla 64-bit Ubuntu 18.10 (Cosmic).

Thanks,

	Ingo
