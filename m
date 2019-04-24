Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C367C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144252148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Z65Z2ecO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733119AbfDXRDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:03:02 -0400
Received: from mail.efficios.com ([167.114.142.138]:39754 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfDXRDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:03:01 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CC7AB1DAAE6;
        Wed, 24 Apr 2019 13:02:59 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id yNASwfcFOYXs; Wed, 24 Apr 2019 13:02:59 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 75F621DAADF;
        Wed, 24 Apr 2019 13:02:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 75F621DAADF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556125379;
        bh=DPZxSR6wYKJnzekC6sgrLt8hlX9/r4//uloKdoG3rCc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Z65Z2ecOVrs5AYVi+2oZhJCtp57WyBQsC1D3s1U5WPpHO39pLlAw2/R91pN8mFecy
         XWPTMW34QEbvnQdhm+mJWud5p0GsFMI8a/gKUVgteJZZfBqKMjg487isP6iaYTwggr
         hTfA1ZkgUgwQnBCLbKYMJCmbf+ps+v2PX6RyPkbh2TvgvX+uxsTcgJ3kAthDu+EvP6
         Yxx4Fb9Dxo4b6AOMQ/JIVccnUpYYutZnCsehdnzbGc0wdd+jCHMjE7eL3bj6MqHiFU
         eNcUvkWDxX8RhCQe+xRSopaMNjl1RhSRcaYafOI1NGE79mUJIS1INtZM+E7/eizsFG
         4kvv5wIYOj77Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id L4OG3F3Nyf9m; Wed, 24 Apr 2019 13:02:59 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 5860E1DAAD8;
        Wed, 24 Apr 2019 13:02:59 -0400 (EDT)
Date:   Wed, 24 Apr 2019 13:02:59 -0400 (EDT)
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
Message-ID: <2087640779.608.1556125379269.JavaMail.zimbra@efficios.com>
In-Reply-To: <697611694.604.1556125254852.JavaMail.zimbra@efficios.com>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com> <20190424152502.14246-9-mathieu.desnoyers@efficios.com> <20190424164538.GC18611@fuggles.cambridge.arm.com> <20190424165150.GF21101@lakrids.cambridge.arm.com> <697611694.604.1556125254852.JavaMail.zimbra@efficios.com>
Subject: Re: [RFC PATCH for 5.2 08/10] rseq/selftests: aarch64 code
 signature: handle big-endian environment
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: aarch64 code signature: handle big-endian environment
Thread-Index: OBjeHUeE7gQ5xyWKTP757DExutwbEyS+nxVk
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 24, 2019, at 1:00 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> ----- On Apr 24, 2019, at 12:51 PM, Mark Rutland mark.rutland@arm.com wrote:
> 
>> On Wed, Apr 24, 2019 at 05:45:38PM +0100, Will Deacon wrote:
>>> On Wed, Apr 24, 2019 at 11:25:00AM -0400, Mathieu Desnoyers wrote:
>>> > +/*
>>> > + * aarch64 -mbig-endian generates mixed endianness code vs data:
>>> > + * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
>>> > + * matches code endianness.
>>> > + */
>>> > +#define RSEQ_SIG_CODE	0xd428bc00	/* BRK #0x45E0.  */
>>> > +
>>> > +#ifdef __AARCH64EB__
>>> > +#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
>>> 
>>> It would be neater to implement swab32 and use that with RSEQ_SIG_CODE,
>> 
>> If possible, marginally neater than that would be using
>> le32_to_cpu(RSEQ_SIG_CODE), without any ifdeffery necessary.
>> 
>> It looks like that's defined in tools/include/linux/kernel.h, but I'm
>> not sure if that gets pulled into your include path.
> 
> Considering that those RSEQ_SIG* define will end up in public bits/rseq.h
> headers within glibc, I'm tempted to keep the amount of dependencies on
> external headers to a minimum, if it's OK with you.

Also, I'm not sure the le32_to_cpu() approach would work in __ASSEMBLER__
builds.

Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
