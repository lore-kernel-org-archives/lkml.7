Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819A7C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E31206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 14:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Dt4u28Bj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbfDYOVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 10:21:35 -0400
Received: from mail.efficios.com ([167.114.142.138]:38316 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfDYOVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 10:21:34 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A26D51D98DD;
        Thu, 25 Apr 2019 10:21:33 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Y57XpTG9ZkeC; Thu, 25 Apr 2019 10:21:32 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D0B661D98D7;
        Thu, 25 Apr 2019 10:21:32 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D0B661D98D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556202092;
        bh=hChOmBoqO3NUzgFtXBDTLegXBKfZ7EYkQrqnF5s/I1w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Dt4u28BjWtCETk37x3nT3EkpvJZv+7swpd9lWV7Rz+vKw8A8KjSr11szUPWEbwPeY
         ujrtud6snk0Feg/rD37fl52ku3+XpWRaYQI9pw2wY7VhY1gdlJZDZKmizKwWFNtODt
         N9dDuIl5/X65gu05uYdHyha/b+cMSEqDM4CJcHykhwnZb4Fdy3cjyNJy6Jm81zxnBp
         RFUx289ieZW0Ak4ld6ahc2wCkM9QDrnwWEZQi/YY60N4esAhcdkzfw4QSCluVcZpC+
         mNDIiVpseNe8KpGOnheIpKKM4qXckhgRljLx8NJOjvxrRHY13Fl7kQojKf2lb8sHJw
         53Mda7pwNBmOQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id F5CD6uwdSYD1; Thu, 25 Apr 2019 10:21:32 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id B09F71D98D0;
        Thu, 25 Apr 2019 10:21:32 -0400 (EDT)
Date:   Thu, 25 Apr 2019 10:21:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Message-ID: <1183307732.352.1556202092390.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190424220609.4kryfcgsv46iu3ds@pburton-laptop>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com> <20190424152502.14246-11-mathieu.desnoyers@efficios.com> <20190424220609.4kryfcgsv46iu3ds@pburton-laptop>
Subject: Re: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break
 instruction for RSEQ_SIG
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: mips: use break instruction for RSEQ_SIG
Thread-Index: AQHU+rH+AJnCxtNxUESFNInzrhwEUaZL3nOAgK8p+5Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 24, 2019, at 6:06 PM, Paul Burton paul.burton@mips.com wrote:

> Hi Mathieu,
> 
> On Wed, Apr 24, 2019 at 11:25:02AM -0400, Mathieu Desnoyers wrote:
>> diff --git a/tools/testing/selftests/rseq/rseq-mips.h
>> b/tools/testing/selftests/rseq/rseq-mips.h
>> index fe3eabcdcbe5..eb53a6adfbbb 100644
>> --- a/tools/testing/selftests/rseq/rseq-mips.h
>> +++ b/tools/testing/selftests/rseq/rseq-mips.h
>> @@ -7,7 +7,11 @@
>>   * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>   */
>>  
>> -#define RSEQ_SIG	0x53053053
>> +/*
>> + * RSEQ_SIG uses the break instruction. The instruction pattern is
>> + *	0350000d        break    0x350
>> + */
>> +#define RSEQ_SIG	0x0350000d
> 
> My apologies for taking a while to get back to you on the various ISAs &
> endian issues here, but I think we'll want this to be something like:
> 
> #if defined(__nanomips__)
> # ifdef __MIPSEL__
> #  define RSEQ_SIG	0x03500010
> # else
> #  define RSEQ_SIG	0x00100350
> # endif
> #elif defined(__mips_micromips)
> # ifdef __MIPSEL__
> #  define RSEQ_SIG	0xd4070000
> # else
> #  define RSEQ_SIG	0x0000d407
> # endif
> #else
> # define RSEQ_SIG	0x0350000d
> #endif
> 
> For plain old MIPS the .word directive will be fine endian-wise, but for
> microMIPS & nanoMIPS we need to take into account that the instruction
> stream is encoded as 16b halfwords & swap those accordingly for little
> endian.

Considering that we have micromips and nanomips already, I guess something
along the lines of "picomips" is not that far away...

I've tried to figure out if we could find a way to have RSEQ_SIG left undefined
if it's not on the plain mips environment, but could not find anything that
would be #defined on plain mips, but #undefined on both micromips and nanomips.

What I'd like to do is e.g.:

#if defined(__nanomips__)
# ifdef __MIPSEL__
#  define RSEQ_SIG	0x03500010
# else
#  define RSEQ_SIG	0x00100350
# endif
#elif defined(__mips_micromips)
# ifdef __MIPSEL__
#  define RSEQ_SIG	0xd4070000
# else
#  define RSEQ_SIG	0x0000d407
# endif
#elif defined(__mips__)
# define RSEQ_SIG	0x0350000d
#else
/* Leave RSEQ_SIG as is. */
#endif

The idea here is to not allow code targeting future MIPS ISA to compile
with the wrong signature.

The delta between compiling without/with -mmicromips on a gcc-8 compiler
is only:

> #define __mips_micromips 1

Some interesting delta when compiling for plain little-endian mips with
gcc-8 compared to the nanomips compiler is:

< #define __mips__ 1
< #define _mips 1
< #define MIPSEL 1

> #define __nanomips__ 1

< #define __mips_isa_rev 2
> #define __mips_isa_rev 6

So let's say we have a picomips introduced in the future, can we rely
on it not defining __mips__ like the nanomips compiler does ? If so,
my "#elif defined(__mips__)" approach would indeed leave RSEQ_SIG undefined
as expected.

Thoughts ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
