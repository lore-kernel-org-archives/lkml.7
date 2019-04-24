Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859D0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514E02148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="uH0nPsdq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733065AbfDXRA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:00:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:38992 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfDXRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:00:57 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9DB081DAA44;
        Wed, 24 Apr 2019 13:00:55 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id NS6s5Twc3ZW5; Wed, 24 Apr 2019 13:00:55 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 2A4271DAA3F;
        Wed, 24 Apr 2019 13:00:55 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2A4271DAA3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556125255;
        bh=Ex/Bez+rbJXKFeKiO+tud5TSRCa9wwv9WZfRFYB+rpU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=uH0nPsdquveZSmK71XqKTTshkDN2apTeJjhgmdE8bOSuEnyP+nA6mI6k3KZCKnFNm
         qk0379wSp0C5Dtusi6wYQrCtilibk+BFPUm6ivfXv/YTSmdfT7mhfIprKg8cKiUatu
         IO9lmP4/kGiXTjiIC5J8ad645I+aI+t3QOKVnUo7KmR1qULq4xcIzbdgOuQjnH9SZV
         /olZknLqAKk5JfedVeS0reeah2CKPEYwKh1L2TdSFWkcmU+oLReJx6NbOEw8sLK9NR
         l2bCEz+zByLWgvFyk1I4oM1rK30jKx8Zt7Ltfr5E6NmzJXnn6fjL81Q9nwPuCIbOms
         97UpKKFQ38Img==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id pdPlonkO4ApW; Wed, 24 Apr 2019 13:00:55 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 0A13C1DAA38;
        Wed, 24 Apr 2019 13:00:55 -0400 (EDT)
Date:   Wed, 24 Apr 2019 13:00:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>, shuah <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
Message-ID: <697611694.604.1556125254852.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190424165150.GF21101@lakrids.cambridge.arm.com>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com> <20190424152502.14246-9-mathieu.desnoyers@efficios.com> <20190424164538.GC18611@fuggles.cambridge.arm.com> <20190424165150.GF21101@lakrids.cambridge.arm.com>
Subject: Re: [RFC PATCH for 5.2 08/10] rseq/selftests: aarch64 code
 signature: handle big-endian environment
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: aarch64 code signature: handle big-endian environment
Thread-Index: OBjeHUeE7gQ5xyWKTP757DExutwbEw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 24, 2019, at 12:51 PM, Mark Rutland mark.rutland@arm.com wrote:

> On Wed, Apr 24, 2019 at 05:45:38PM +0100, Will Deacon wrote:
>> On Wed, Apr 24, 2019 at 11:25:00AM -0400, Mathieu Desnoyers wrote:
>> > +/*
>> > + * aarch64 -mbig-endian generates mixed endianness code vs data:
>> > + * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
>> > + * matches code endianness.
>> > + */
>> > +#define RSEQ_SIG_CODE	0xd428bc00	/* BRK #0x45E0.  */
>> > +
>> > +#ifdef __AARCH64EB__
>> > +#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
>> 
>> It would be neater to implement swab32 and use that with RSEQ_SIG_CODE,
> 
> If possible, marginally neater than that would be using
> le32_to_cpu(RSEQ_SIG_CODE), without any ifdeffery necessary.
> 
> It looks like that's defined in tools/include/linux/kernel.h, but I'm
> not sure if that gets pulled into your include path.

Considering that those RSEQ_SIG* define will end up in public bits/rseq.h
headers within glibc, I'm tempted to keep the amount of dependencies on
external headers to a minimum, if it's OK with you.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
