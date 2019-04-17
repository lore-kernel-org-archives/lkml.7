Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958D5C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C8821773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732788AbfDQQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:17:33 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:47521 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729512AbfDQQRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:17:33 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hGnFR-0004jS-U7 from joseph_myers@mentor.com ; Wed, 17 Apr 2019 09:17:21 -0700
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 17 Apr 2019 17:17:18 +0100
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1hGnFN-0001mB-U1; Wed, 17 Apr 2019 16:17:17 +0000
Date:   Wed, 17 Apr 2019 16:17:17 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     carlos <carlos@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Florian Weimer <fweimer@redhat.com>,
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
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v8)
In-Reply-To: <364803063.586.1555516769056.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1904171601540.32123@digraph.polyomino.org.uk>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <20190416173216.9028-2-mathieu.desnoyers@efficios.com> <364803063.586.1555516769056.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Apr 2019, Mathieu Desnoyers wrote:

> > +/* RSEQ_SIG is a signature required before each abort handler code.
> > +
> > +   It is a 32-bit value that maps to actual architecture code compiled
> > +   into applications and libraries. It needs to be defined for each
> > +   architecture. When choosing this value, it needs to be taken into
> > +   account that generating invalid instructions may have ill effects on
> > +   tools like objdump, and may also have impact on the CPU speculative
> > +   execution efficiency in some cases.  */
> > +
> > +#define RSEQ_SIG 0xd428bc00	/* BRK #0x45E0.  */
> 
> After further investigation, we should probably do the following
> to handle compiling with -mbig-endian on aarch64, which generates
> binaries with mixed code vs data endianness (little endian code,
> big endian data):

First, the comment on RSEQ_SIG should specify whether it is to be 
interpreted in the code or the data endianness.

> For ARM32, the situation is a bit more complex. Only armv6+
> generates mixed-endianness code vs data with -mbig-endian.
> Prior to armv6, the code and data endianness matches. Therefore,
> I plan to #ifdef the reversed endianness handling with:
> 
> #if __ARM_ARCH >= 6 && __ARM_BIG_ENDIAN
> 
> on arm32.

That doesn't work well because BE code (.o files) can be built for v5te 
(for example) and used on a range of different architecture variants with 
both BE32 and BE8 - the choice between BE32 and BE8 is a link-time choice, 
not a compile-time choice.  So if the value for Arm is a compile-time 
constant, it should also work for both BE32 and BE8.

In turn, that suggests to me that RSEQ_SIG should be defined to be a value 
that is always in the code endianness (and whatever corresponding kernel 
code handles RSEQ_SIG values should act accordingly on architectures where 
the two endiannesses can differ).  If the kernel ABI is already fixed in a 
way that prevents such a definition of RSEQ_SIG semantics as using code 
endianness, a value should be chosen for Arm that works for both 
endiannesses.

(Also, installed glibc headers are supposed to work with older compilers, 
and support for __ARM_ARCH was only added in GCC 4.8.  Before that you 
need to test lots of separate macros for different architecture variants 
to determine a version number.)

-- 
Joseph S. Myers
joseph@codesourcery.com
