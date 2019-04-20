Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF1EC282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F6421479
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 02:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Pbu4x3EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfDTC2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 22:28:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:58302 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDTC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 22:28:13 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C74711D9997;
        Fri, 19 Apr 2019 22:28:10 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id I_wPYGz7c6Ta; Fri, 19 Apr 2019 22:28:09 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D8B8F1D9990;
        Fri, 19 Apr 2019 22:28:09 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D8B8F1D9990
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555727289;
        bh=TupeHBU59ibOei9RAOkaZEgMj6S5MPat7rMLbN2Ggc8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Pbu4x3EC4Poea5sN0TzMlUoWkrKvKKsJGDmN674JxVG7vOjo00UwA4Jj5E8ql7cX/
         bxbK88xvZFk4QeHPn9lk9HJhmGQHLCYhBbHh1/kn0/mBEnjcKyUEYHCh2N3oCPV9yt
         TWc6RgLIFxzRVYAufxvVDFBtrZXHVRYWZtrDVXKE48QphMgqa4oc+q2A9PQAafg2tt
         7iuk1V8T7aB166lt4IZxIz6PgtAlyixVu+ms2fJPIlWwlCmo4p7kIbpgnynBg7K+jG
         ZZ7HD8BTshlxqWsPX2fJ5QkYZinimHxKlMg3yDKWMa0B8fiX5qT6lIBnbMq+uIweoF
         H0chmDwgAkH1Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id uiGc65aIrWhr; Fri, 19 Apr 2019 22:28:09 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B88BA1D9989;
        Fri, 19 Apr 2019 22:28:09 -0400 (EDT)
Date:   Fri, 19 Apr 2019 22:28:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Lameter <cl@linux.com>, shuah <shuah@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Dave Watson <davejwatson@fb.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Russell King <linux@arm.linux.org.uk>,
        Paul Turner <pjt@google.com>, Ben Maurer <bmaurer@fb.com>,
        Joel Fernandes <joelaf@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits <linux-tip-commits@vger.kernel.org>
Message-ID: <1655257247.250.1555727289505.JavaMail.zimbra@efficios.com>
In-Reply-To: <1950499847.215.1555708401414.JavaMail.zimbra@efficios.com>
References: <20190419145327.12736-1-mathieu.desnoyers@efficios.com> <tip-3c0f67279fb57568b436dece3aa20651aa6c5a05@git.kernel.org> <CAHk-=wieuxm+B-Bmhcy+Sszqs6h=iTNMEP=TeSBFKxtnEsKHUg@mail.gmail.com> <1950499847.215.1555708401414.JavaMail.zimbra@efficios.com>
Subject: Re: [tip:core/rseq] rseq/selftests/x86: Work around bogus gcc-8
 optimisation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: core/rseq] rseq/selftests/x86: Work around bogus gcc-8 optimisation
Thread-Index: 2gmq457gCH9wUFVmC+16zGNn1BTfLDnsbvYf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 19, 2019, at 5:13 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 19, 2019, at 2:53 PM, Linus Torvalds torvalds@linux-foundation.org
> wrote:
> 
>> On Fri, Apr 19, 2019 at 11:46 AM tip-bot for Mathieu Desnoyers
>> <tipbot@zytor.com> wrote:
>>>
>>> rseq/selftests/x86: Work around bogus gcc-8 optimisation
>>>
>>> At least the following versions of gcc-8:
>>>
>>>  - gcc version 8.0.1 20180414 (experimental) [trunk revision 259383] (Ubuntu
>>>  8-20180414-1ubuntu2)
>>>  - gcc 8.2.0-7ubuntu1 (Ubuntu 18.10 (Cosmic)),
>>>
>>> generate broken assembler with asm goto that have a thread-local storage
>>> "m" input operand on both x86-32 and x86-64. For instance:
>> 
>> Is there a gcc bugzilla for this? Shouldn't that be mentioned here?
> 
> My google-fu did not find any match, so I don't think so. I'll open one
> shortly.
> 
>> 
>> Also, we use "asm goto" together with "m" all the time in the kernel.
>> In fact, it's the most common case, with the RMWcc ops being generated
>> with that. I realize that we don't use the gcc thread-local storage
>> for them (we often do use our *own* thread-local storage), but it
>> would be good to have that gcc bugzilla to see why it can only affect
>> those user level "__thread" cases.
> 
> Indeed, it would be good to investigate and understand all problematic
> scenarios triggering this bug.

I've opened a ticket on gcc's bugzilla:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=90193

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
