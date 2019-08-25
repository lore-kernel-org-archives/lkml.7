Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3AEC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87A2206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 19:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbfHYTTu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 15:19:50 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:22691
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728974AbfHYTTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 15:19:50 -0400
X-IronPort-AV: E=Sophos;i="5.64,430,1559512800"; 
   d="scan'208";a="317140672"
Received: from unknown (HELO [192.168.8.118]) ([117.136.0.199])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Aug 2019 21:19:42 +0200
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
From:   Julia Lawall <julia.lawall@lip6.fr>
X-Mailer: iPhone Mail (16F203)
In-Reply-To: <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
Date:   Mon, 26 Aug 2019 03:19:35 +0800
Cc:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <4E9DDF9E-C883-44F0-A3F4-CD49284DB60D@lip6.fr>
References: <20190825130536.14683-1-efremov@linux.com> <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com> <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
To:     Denis Efremov <efremov@linux.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 26 Aug 2019, at 02:59, Denis Efremov <efremov@linux.com> wrote:
> 
> 
> 
>> On 25.08.2019 19:37, Joe Perches wrote:
>>> On Sun, 2019-08-25 at 16:05 +0300, Denis Efremov wrote:
>>> This patch adds coccinelle script for detecting !likely and !unlikely
>>> usage. It's better to use unlikely instead of !likely and vice versa.
>> 
>> Please explain _why_ is it better in the changelog.
>> 
> 
> In my naive understanding the negation (!) before the likely/unlikely
> could confuse the compiler

As a human I am confused. Is !likely(x) equivalent to x or !x?

Julia


> and the initial branch-prediction intent
> could be "falsified". I would say that either you need to move the
> negation under the bracket "!unlikely(cond) -> unlikely(!cond)" or
> you need to use likely instead "!unlikely(cond) -> likely(cond)".
> However, I'm not a compiler expert to state that this is a general
> rule. But, we've got 2 special macro for branch predicting, not one.
> There is also ftrace in-between. I will try to do some simple
> benchmarking.
> 
>> btw: there are relatively few uses like this in the kernel.
>> 
>> $ git grep -P '!\s*(?:un)?likely\s*\(' | wc -l
>> 40
>> 
>> afaict: It may save 2 bytes of x86/64 object code.
>> 
>> For instance:
>> 
>> $ diff -urN kernel/tsacct.lst.old kernel/tsacct.lst.new|less
>> --- kernel/tsacct.lst.old       2019-08-25 09:21:39.936570183 -0700
>> +++ kernel/tsacct.lst.new       2019-08-25 09:22:20.774324886 -0700
>> @@ -24,158 +24,153 @@
>>   15:  48 89 fb                mov    %rdi,%rbx
>>        u64 time, delta;
>> 
>> -       if (!likely(tsk->mm))
>> +       if (unlikely(tsk->mm))
>>   18:  4c 8d ab 28 02 00 00    lea    0x228(%rbx),%r13
>>   1f:  e8 00 00 00 00          callq  24 <__acct_update_integrals+0x24>
>>                        20: R_X86_64_PLT32      __sanitizer_cov_trace_pc-0x4
>>   24:  4c 89 ef                mov    %r13,%rdi
>>   27:  e8 00 00 00 00          callq  2c <__acct_update_integrals+0x2c>
>>                        28: R_X86_64_PLT32      __asan_load8_noabort-0x4
>> -  2c:  4c 8b bb 28 02 00 00    mov    0x228(%rbx),%r15
>> -  33:  4d 85 ff                test   %r15,%r15
>> -  36:  74 34                   je     6c <__acct_update_integrals+0x6c>
>> +  2c:  48 83 bb 28 02 00 00    cmpq   $0x0,0x228(%rbx)
>> +  33:  00 
>> +  34:  75 34                   jne    6a <__acct_update_integrals+0x6a>
>>                return;
> 
> I think it's incorrect to say so in general. For example, on x86/64:
> 
> $ make mrproper
> $ make allyesconfig
> $ make && mv vmlinux vmlinux-000
> $ make coccicheck MODE=patch COCCI=scripts/coccinelle/misc/unlikely.cocci | patch -p1
> $ make 
> $ ./scripts/bloat-o-meter ./vmlinux-000 ./vmlinux
> add/remove: 0/0 grow/shrink: 3/4 up/down: 41/-35 (6)
> Function                                     old     new   delta
> dpaa2_io_service_rearm                       357     382     +25
> intel_pmu_hw_config                         1277    1285      +8
> get_sigframe.isra.constprop                 1657    1665      +8
> csum_partial_copy_from_user                  605     603      -2
> wait_consider_task                          3807    3797     -10
> __acct_update_integrals                      384     373     -11
> pipe_to_sendpage                             459     447     -12
> Total: Before=312759461, After=312759467, chg +0.00%
> 
> It definitely influence the way the compiler optimizes the code.  
> 
>> 
>> And here's a possible equivalent checkpatch test.
>> ---
>> scripts/checkpatch.pl | 18 ++++++++++++++++++
>> 1 file changed, 18 insertions(+)
>> 
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 287fe73688f0..364603ad1a47 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -6529,6 +6529,24 @@ sub process {
>>                 "Using $1 should generally have parentheses around the comparison\n" . $herecurr);
>>        }
>> 
>> +# !(likely|unlikely)(condition) use should be (unlikely|likely)(condition)
>> +        if ($perl_version_ok &&
>> +            $line =~ /(\!\s*((?:un)?likely))\s*$balanced_parens/) {
>> +            my $match = $1;
>> +            my $type =  $2;
>> +            my $reverse;
>> +            if ($type eq "likely") {
>> +                $reverse = "unlikely";
>> +            } else {
>> +                $reverse = "likely";
>> +            }
>> +            if (WARN("LIKELY_MISUSE",
>> +                 "Prefer $reverse over $match\n" . $herecurr) &&
>> +                $fix) {
>> +                $fixed[$fixlinenr] =~ s/\Q$match\E\s*\(/$reverse(/;
>> +            }
>> +        }
>> +
>> # whine mightly about in_atomic
>>        if ($line =~ /\bin_atomic\s*\(/) {
>>            if ($realfile =~ m@^drivers/@) {
>> 
>> 

