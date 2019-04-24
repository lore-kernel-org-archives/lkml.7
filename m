Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAEDC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8141A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Eu0s3SZO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfDXXMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:12:07 -0400
Received: from mail.efficios.com ([167.114.142.138]:54090 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbfDXXMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:12:07 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D43861DAE14;
        Wed, 24 Apr 2019 19:12:04 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Db0msJWL9guo; Wed, 24 Apr 2019 19:12:03 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C07111DAE0C;
        Wed, 24 Apr 2019 19:12:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C07111DAE0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556147523;
        bh=ZCAFmQCt+L92Y7DrxcXfkE0fr9qPjiRYrC7qrBqSrVI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Eu0s3SZOxJE4RgG0LkOiCoF0fOUsguzFdvC59flW3N9lz9kRlvawf0HQk3Kx28ztm
         APxqmk3rSIsB/mb4QWTtntAS7cvVxDZCk15uwBv+p8g9a4CAQPxu5u+u21kLm3mZLB
         cTv+hH8F0zJUMIGiKjToOdIAlS7b5OwMy7F1FAyOazoIcbk42nf5nzH2+FYs6eFdSV
         LnbVbjvIfjUTydq2/UqMpi7VvMmLAFk6+H4qalbJgjhjOrXgFf/icZD9RYTosM3y0N
         2/MdQ2SA14udmBMjlU3GXP9Jz1xbazZSOnQ02ksB+l3cfA1nZ2uFGIRnQ62cr0+MMf
         NvTQo5BRFvySw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id NyOzT61RHnRg; Wed, 24 Apr 2019 19:12:03 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 984791DAE03;
        Wed, 24 Apr 2019 19:12:03 -0400 (EDT)
Date:   Wed, 24 Apr 2019 19:12:03 -0400 (EDT)
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
Message-ID: <2114325810.1301.1556147523476.JavaMail.zimbra@efficios.com>
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
Thread-Index: AQHU+rH+AJnCxtNxUESFNInzrhwEUaZL3nOAYM0M9XY=
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

Hi Paul,

Thanks for looking into it!

Does the following comment above the forest of #ifdef work for you ?

/*
 * RSEQ_SIG uses the break instruction. The instruction pattern is:
 *
 * On MIPS:
 *      0350000d        break     0x350
 *
 * On nanoMIPS32:
 *      00100350        break     0x350
 *
 * On microMIPS:
 *      0000d407        break     0x350
 *
 * For nanoMIPS32 and microMIPS, the instruction stream is encoded as 16-bit
 * halfwords, so the signature halfwords need to be swapped accordingly for
 * little-endian.
 */

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
