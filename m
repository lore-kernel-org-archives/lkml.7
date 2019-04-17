Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E9C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA8F206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="CpzeGPzQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732663AbfDQP7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:59:32 -0400
Received: from mail.efficios.com ([167.114.142.138]:59930 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbfDQP7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:59:31 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 070421D77E3;
        Wed, 17 Apr 2019 11:59:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id DIEi-4633uHk; Wed, 17 Apr 2019 11:59:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 56ECF1D77DC;
        Wed, 17 Apr 2019 11:59:29 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 56ECF1D77DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555516769;
        bh=dnR8YugPKegltgLqamxAPBl6gUcWSxmEPI9eF8Ze/fk=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CpzeGPzQ154KXht4CSM6lwrJPfHzxaOGxQHhzWReRjVER7NWYY+GKd7+ZY4EDvOBi
         M+T4mtRttkXUncF62CjiWdVFbja7Gg6KqgD6+X2Db42Od4DWwZ8hn+5nMZPzpcK+qa
         6psWb+L9ewV49cEdBer5XUuVbpzaIlj9FKPo6lMcrWRc1c4LSM7xne+TUiFC/lfU8/
         WV5pU5UFw2vmfwoSWsG2ugynxVxBxAxK2L5RkVL+xb1uMpQvCLK2Jc1qamw1DNMW7K
         7jowo7CK5MYY+Y9E2gMhD8XH5QNIob7AD95ozgKvoEJ0rhDmtdeWEYxypsoHsDdR1P
         ij2Yqua2lYi0A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id JT5xUcD0TKEO; Wed, 17 Apr 2019 11:59:29 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 3E3961D77D5;
        Wed, 17 Apr 2019 11:59:29 -0400 (EDT)
Date:   Wed, 17 Apr 2019 11:59:29 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     carlos <carlos@redhat.com>, Will Deacon <will.deacon@arm.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <364803063.586.1555516769056.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190416173216.9028-2-mathieu.desnoyers@efficios.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <20190416173216.9028-2-mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v8)
Thread-Index: SE1CutRP0aDD1UrXyGqfkCvIJpHajA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 16, 2019, at 1:32 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

[...]
> diff --git a/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
> b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
> new file mode 100644
> index 0000000000..b02471a89a
> --- /dev/null
> +++ b/sysdeps/unix/sysv/linux/aarch64/bits/rseq.h
> @@ -0,0 +1,32 @@
> +/* Restartable Sequences Linux aarch64 architecture header.
> +
> +   Copyright (C) 2019 Free Software Foundation, Inc.
> +
> +   The GNU C Library is free software; you can redistribute it and/or
> +   modify it under the terms of the GNU Lesser General Public
> +   License as published by the Free Software Foundation; either
> +   version 2.1 of the License, or (at your option) any later version.
> +
> +   The GNU C Library is distributed in the hope that it will be useful,
> +   but WITHOUT ANY WARRANTY; without even the implied warranty of
> +   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> +   Lesser General Public License for more details.
> +
> +   You should have received a copy of the GNU Lesser General Public
> +   License along with the GNU C Library; if not, see
> +   <http://www.gnu.org/licenses/>.  */
> +
> +#ifndef _SYS_RSEQ_H
> +# error "Never use <bits/rseq.h> directly; include <sys/rseq.h> instead."
> +#endif
> +
> +/* RSEQ_SIG is a signature required before each abort handler code.
> +
> +   It is a 32-bit value that maps to actual architecture code compiled
> +   into applications and libraries. It needs to be defined for each
> +   architecture. When choosing this value, it needs to be taken into
> +   account that generating invalid instructions may have ill effects on
> +   tools like objdump, and may also have impact on the CPU speculative
> +   execution efficiency in some cases.  */
> +
> +#define RSEQ_SIG 0xd428bc00	/* BRK #0x45E0.  */

After further investigation, we should probably do the following
to handle compiling with -mbig-endian on aarch64, which generates
binaries with mixed code vs data endianness (little endian code,
big endian data):

#ifdef __ARM_BIG_ENDIAN
#define RSEQ_SIG 0x00bc28d4	/* BRK #0x45E0.  */
#else
#define RSEQ_SIG 0xd428bc00	/* BRK #0x45E0.  */
#endif

Else mismatch between code endianness for the generated
signatures and data endianness for the RSEQ_SIG parameter
passed to the rseq registration will trigger application
segmentation faults when the kernel try to abort rseq
critical sections.

For ARM32, the situation is a bit more complex. Only armv6+
generates mixed-endianness code vs data with -mbig-endian.
Prior to armv6, the code and data endianness matches. Therefore,
I plan to #ifdef the reversed endianness handling with:

#if __ARM_ARCH >= 6 && __ARM_BIG_ENDIAN

on arm32.

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
