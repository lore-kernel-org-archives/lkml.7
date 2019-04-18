Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84946C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560F520675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="UgPfO/Hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbfDRPhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:37:18 -0400
Received: from mail.efficios.com ([167.114.142.138]:34284 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbfDRPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:37:16 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0F70B18C8B7;
        Thu, 18 Apr 2019 11:37:15 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 3DdFlkPAnvEo; Thu, 18 Apr 2019 11:37:14 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8E6D618C8A9;
        Thu, 18 Apr 2019 11:37:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8E6D618C8A9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555601834;
        bh=5CMv8qZ4HwVF1Sby94Lwmwtanm6tpBExDcR+pw5Yp9I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=UgPfO/HdRk9boDHYIYKV0205n+o9hxiYvEVDidcKGgnECP2f25NCj3LME6PNfe+Gr
         ygTYf1jML7YKga50vr3MDxWj01pVC6ClGH6v4iPEMbeZbmWt6XF4xA7VlTXHx6BNWV
         5Th5AMmjUuNPbSzPON9EHVC7t+jKcF5i1AMf8lvWzokM04EKYjnBh858smyhGJT/Dl
         HsNJx08Y3ad53mk8pWRHXRRUCS3LGyQxHIxtdiVFdBHjtsJedFc0/2W+0hmpe7TGmU
         QeriboGzfSy/++Hv8vAPejrZMVMLBwU4v2JYKG00iRdeCRPcsJVDJLPzN12Wzt7kiQ
         IvA1ewIhP7T6Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id RQ2OYkA4kz9M; Thu, 18 Apr 2019 11:37:14 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 744C918C8A2;
        Thu, 18 Apr 2019 11:37:14 -0400 (EDT)
Date:   Thu, 18 Apr 2019 11:37:14 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Will Deacon <will.deacon@arm.com>, carlos <carlos@redhat.com>,
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
Message-ID: <1515751456.1060.1555601834395.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1904181445550.5356@digraph.polyomino.org.uk>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <20190416173216.9028-2-mathieu.desnoyers@efficios.com> <364803063.586.1555516769056.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1904171601540.32123@digraph.polyomino.org.uk> <1770787324.668.1555530989646.JavaMail.zimbra@efficios.com> <1066731871.915.1555593471194.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1904181445550.5356@digraph.polyomino.org.uk>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v8)
Thread-Index: F1wC+FMSeBMlyzfAdd3W2xxk4GueFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 18, 2019, at 10:48 AM, Joseph Myers joseph@codesourcery.com wrote:

> On Thu, 18 Apr 2019, Mathieu Desnoyers wrote:
> 
>> The approach above should work for arm32 be8 vs be32 linker weirdness.
>> 
>> For aarch64, I think we can simply do:
>> 
>> /*
>>  * aarch64 -mbig-endian generates mixed endianness code vs data:
>>  * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
>>  * matches code endianness.
>>  */
>> #define RSEQ_SIG_CODE   0xd428bc00      /* BRK #0x45E0.  */
>> 
>> #ifdef __ARM_BIG_ENDIAN
>> #define RSEQ_SIG_DATA   0x00bc28d4      /* BRK #0x45E0.  */
>> #else
>> #define RSEQ_SIG_DATA   RSEQ_SIG_CODE
>> #endif
>> 
>> #define RSEQ_SIG        RSEQ_SIG_DATA
>> 
>> Feedback is most welcome,
> 
> You'll also need __ASSEMBLER__ conditionals in the installed sys/rseq.h
> header so that it only defines constants and doesn't include any C
> declarations in that case, if RSEQ_SIG_CODE is meant to be usable in .S
> files rather than just inline asm in C files.

Good point!

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
