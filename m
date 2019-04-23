Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6156FC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC56204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="nsk0p8eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfDWMgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:36:07 -0400
Received: from mail.efficios.com ([167.114.142.138]:34380 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbfDWMgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:36:06 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 112C01C9998;
        Tue, 23 Apr 2019 08:36:05 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Z4M3JnKGR1fK; Tue, 23 Apr 2019 08:36:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 9834F1C998F;
        Tue, 23 Apr 2019 08:36:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9834F1C998F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556022964;
        bh=Rd3LlGUDLK2cfU5tWtD/3qliE684QQbij918SVFZswo=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nsk0p8eCRSuUi0FaW7gKVcoTOaro+6FUi8FLrzTHKs+6Siss0rOcJPa4OOW6LF1uF
         fV5QChqnaCg+PlUkcJ3z3CFTcnnPhD95TJwqkrYBjY+Yat2rsD0tEn0wtqbrW3/3pf
         acRkdpkBkyDDVUoN+FdsniSHa/5U5WPb0C2X5A65StdZQd1tz8cRaCd4/VkxfGolUp
         ifbMg9Fa30OsLmRVH0Hs4h/WYSYWHmN5NEsVu1jfQ/r5EL5xWerCTjkY/bXcHwfa7j
         teNWavL/rTc/5qQSGaWBd3VokqCmW94ecANa96FeIR+zexKFehMDN+YmA6gCU3D8Ma
         rwQU+wW2FjpIA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 71RnF6UDVH3z; Tue, 23 Apr 2019 08:36:04 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 6FF371C9988;
        Tue, 23 Apr 2019 08:36:04 -0400 (EDT)
Date:   Tue, 23 Apr 2019 08:36:04 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Ramana Radhakrishnan <ramana.gcc@googlemail.com>
Cc:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>, nd <nd@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Will Deacon <Will.Deacon@arm.com>, carlos <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
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
Message-ID: <515545056.862.1556022964232.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAJA7tRZDKHxLDzuggSmNngfxSTD31EX3mv6YQpcnNXrOtF=9qQ@mail.gmail.com>
References: <20190416173216.9028-1-mathieu.desnoyers@efficios.com> <1055153722.1072.1555602067220.JavaMail.zimbra@efficios.com> <79996d13-2ba2-ed7d-b202-e7d38f1fd870@arm.com> <604915684.1299.1555607449814.JavaMail.zimbra@efficios.com> <846db7ef-f75e-53b8-3c4c-461ec730a17e@arm.com> <1531569198.1389.1555611422188.JavaMail.zimbra@efficios.com> <a1bd2595-b7ae-b06b-9c71-802901ed8587@arm.com> <CAJA7tRZDKHxLDzuggSmNngfxSTD31EX3mv6YQpcnNXrOtF=9qQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] glibc: Perform rseq(2) registration at C startup
 and thread creation (v8)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v8)
Thread-Index: ZJbxDlW454V9nz8S8m/nN+sz8LluGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 23, 2019, at 7:59 AM, Ramana Radhakrishnan ramana.gcc@googlemail.com wrote:

> On Tue, Apr 23, 2019 at 12:16 PM Szabolcs Nagy <Szabolcs.Nagy@arm.com> wrote:
>>
>> On 18/04/2019 19:17, Mathieu Desnoyers wrote:
>> > ----- On Apr 18, 2019, at 1:37 PM, Szabolcs Nagy Szabolcs.Nagy@arm.com wrote:
>> >> you have to add a documentation comment somewhere
>> >> explaining if RSEQ_SIG is the value that's passed to
>> >> the kernel and then aarch64 asm code has to use
>> >>
>> >> .inst endianfixup(RSEQ_SIG) // or
>> >> .word RSEQ_SIG
>> >
>> > Using ".word" won't allow objdump to show the instruction it
>> > maps to. It will consider it as data. So .inst is preferred here.
>>
>> is there some specific reason you prefer .inst?
> 
> I believe the reasoning here is that in the disassembly you want to
> see an instruction pattern for an architecture rather than a magic bit
> pattern that appears to be an "inline" literal pool entry.  I would
> support the .inst variant so that the disassembler shows the
> instruction for what it is when debugging. If control reaches the
> marker instruction, something's gone wrong and thus from a user
> friendliness perspective I would prefer to see an instruction that
> clearly indicates that it's undefined .inst directive so that someone
> disassembling this in an assembly view in GDB sees the right thing
> (TM) instead of having to reach for the manual and disassembling this
> by hand.

That's my line of thinking exactly. I might add that having data in a
literal pool within the instruction stream might be unexpected in some
compilation environments, e.g. when compiling with -mno-text-section-literals .

So even though the signature may likely end up being placed in a literal
pool, it's preferable to ensure it is a valid uncommon trap instruction.

Thanks,

Mathieu

> 
>>
>> disassembling a canary value as data (that is
>> never executed, but loaded and compared by the
>> kernel as data) sounds more semantically correct
>> to me than showing it as an instruction.
>>
> 
> 
> 
> Ramana
> 
> 
>> i guess having it as an instruction can avoid
>> issues if some tools dislike .word in .text,
> > but otherwise .word seems better.

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
