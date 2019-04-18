Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B448FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AF2206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389019AbfDROsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:48:46 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:46778 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733192AbfDROsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:48:46 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=svr-ies-mbx-01.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1hH8L8-0006BE-Gk from joseph_myers@mentor.com ; Thu, 18 Apr 2019 07:48:38 -0700
Received: from digraph.polyomino.org.uk (137.202.0.90) by
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Thu, 18 Apr 2019 15:48:34 +0100
Received: from jsm28 (helo=localhost)
        by digraph.polyomino.org.uk with local-esmtp (Exim 4.90_1)
        (envelope-from <joseph@codesourcery.com>)
        id 1hH8L4-0001wM-5v; Thu, 18 Apr 2019 14:48:34 +0000
Date:   Thu, 18 Apr 2019 14:48:34 +0000
From:   Joseph Myers <joseph@codesourcery.com>
X-X-Sender: jsm28@digraph.polyomino.org.uk
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC:     Will Deacon <will.deacon@arm.com>, carlos <carlos@redhat.com>,
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
In-Reply-To: <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
Message-ID: <alpine.DEB.2.21.1904181445550.5356@digraph.polyomino.org.uk>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <20190416173216.9028-2-mathieu.desnoyers@efficios.com> <364803063.586.1555516769056.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1904171601540.32123@digraph.polyomino.org.uk>
 <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com> <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 svr-ies-mbx-01.mgc.mentorg.com (139.181.222.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2019, Mathieu Desnoyers wrote:

> The approach above should work for arm32 be8 vs be32 linker weirdness.
> 
> For aarch64, I think we can simply do:
> 
> /*
>  * aarch64 -mbig-endian generates mixed endianness code vs data:
>  * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
>  * matches code endianness.
>  */
> #define RSEQ_SIG_CODE   0xd428bc00      /* BRK #0x45E0.  */
> 
> #ifdef __ARM_BIG_ENDIAN
> #define RSEQ_SIG_DATA   0x00bc28d4      /* BRK #0x45E0.  */
> #else
> #define RSEQ_SIG_DATA   RSEQ_SIG_CODE
> #endif
> 
> #define RSEQ_SIG        RSEQ_SIG_DATA
> 
> Feedback is most welcome,

You'll also need __ASSEMBLER__ conditionals in the installed sys/rseq.h 
header so that it only defines constants and doesn't include any C 
declarations in that case, if RSEQ_SIG_CODE is meant to be usable in .S 
files rather than just inline asm in C files.

-- 
Joseph S. Myers
joseph@codesourcery.com
