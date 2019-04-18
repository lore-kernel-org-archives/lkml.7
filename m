Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C7CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ED8020869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 15:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="oyga4m08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389451AbfDRPb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 11:31:59 -0400
Received: from mail.efficios.com ([167.114.142.138]:33698 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRPb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 11:31:58 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 10A0318C70B;
        Thu, 18 Apr 2019 11:31:57 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id Q59LoxcTY1DJ; Thu, 18 Apr 2019 11:31:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 65FAD18C701;
        Thu, 18 Apr 2019 11:31:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 65FAD18C701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555601516;
        bh=Q0ENr6tvZZ8CFWvNyjR34BQxJmDe12agR1pmn4b8EUI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=oyga4m08fTOVY6MCCRgq3wQ5KokbAV2rUW7trr9ep9ystA5l+q4WvjCj95IUcIgfE
         7r1El6J95PkyI7PgtreHXE+ihtuVCLlY+N3Ddh8SdcNwOrhf8DK3RltI7ZM1ugugZu
         X9QnVzQLXos76hUrlVVW4/VLpXDkDgm7+1dSEhwKcWng13eYEOyAveELM9BHo9G0gG
         iSAJ/Ylm9ScdHoeBIuL0zLpRpAgl7ip0svqsppAHKHJSlSKamqYa6ERzKxm50JtK1u
         g+wzYKv39mGw827zI4ZsaTVsy22ucrC+TthB+o7jwbrV8josLlt9OaOoRVxPtScTr1
         45+RePwAYUwQw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id v7XT5fqFeT21; Thu, 18 Apr 2019 11:31:56 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 43A0718C6FA;
        Thu, 18 Apr 2019 11:31:56 -0400 (EDT)
Date:   Thu, 18 Apr 2019 11:31:56 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Alan Modra <amodra@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Carlos O'Donell <codonell@redhat.com>,
        Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Meissner <meissner@linux.ibm.com>,
        Peter Bergner <bergner@vnet.ibm.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        heiko carstens <heiko.carstens@de.ibm.com>,
        gor <gor@linux.ibm.com>, schwidefsky <schwidefsky@de.ibm.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Message-ID: <836018684.1056.1555601516134.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190409092948.GA14424@bubble.grove.modra.org>
References: <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com> <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com> <87y34o4xt3.fsf@oldenburg2.str.redhat.com> <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com> <877ec4pam2.fsf@linux.ibm.com> <ce9fbc66-5eb9-0fa9-99fa-5abfe00ddfc2@redhat.com> <877ec3yffq.fsf@concordia.ellerman.id.au> <20190409092948.GA14424@bubble.grove.modra.org>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup
 and thread creation (v7)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: glibc: Perform rseq(2) registration at C startup and thread creation (v7)
Thread-Index: tb6ujxePzM1jYDms2xneqI8KQYPvrg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 9, 2019, at 5:29 AM, Alan Modra amodra@gmail.com wrote:

> On Tue, Apr 09, 2019 at 02:23:53PM +1000, Michael Ellerman wrote:
>> I'd much rather we use a trap with a specific immediate value. Otherwise
>> someone's going to waste time one day puzzling over why userspace is
>> doing mtmsr.
> 
> It's data.  We have other data in executable sections.  Anyone who
> wonders about odd disassembly just hasn't realized they are
> disassembling data.
> 
>> It would also complicate things if we ever wanted to emulate mtmsr.
> 
> No, because it won't be executed.  If I understand correctly, the only
> reason to choose an illegal, trap or privileged insn is to halt
> execution earlier rather than later when a program goes off in the
> weeds.
> 
>> If we want something that is a trap rather than a nop then use 0x0fe50553.
>> 
>> That's "compare the value in r5 with 0x553 and then trap unconditionally".
>> 
>> It shows up in objdump as:
>> 
>>     10000000:	53 05 e5 0f 	twui    r5,1363
>> 
>> 
>> The immediate can be anything, I chose that value to mimic the x86 value
>> Mathieu mentioned.
>> 
>> There's no reason that instruction would ever be generated because the
>> immediate value serves no purpose. So it satisfies the "very unlikely
>> to appear" criteria AFAICS.
> 
> Yes, looks fine to me, except that in VLE mode (do we care?)
> ".long 0x0fe50553" disassembles as
>   0:	0f e5       	se_cmphl r5,r30
>   2:	05 53       	se_mullw r3,r5
> No illegal/trap/privileged insn there.
> 
> ".long 0x0fe5000b" might be better to cover VLE.

Can you share with us the objdump output of ".long 0x0fe5000b" in
VLE mode ? VLE mode support does not appear to be available in typical
toolchains. Also, is VLE mode only for powerpc 32 be, or also for
powerpc 64 be/le ?

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
