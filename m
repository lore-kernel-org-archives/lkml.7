Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01AEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B198720830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 18:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Sezm0A5a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfDJSFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:05:54 -0400
Received: from mail.efficios.com ([167.114.142.138]:49208 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfDJSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 14:05:54 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id A51B81D5C66;
        Wed, 10 Apr 2019 14:05:51 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id AEw5tMjQb9-3; Wed, 10 Apr 2019 14:05:51 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id F25BF1D5C5D;
        Wed, 10 Apr 2019 14:05:50 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com F25BF1D5C5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554919551;
        bh=1Go0NjDI9JsgjpqV3rlDBXvHzdSqeZpIYtv0Rjq2+7o=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Sezm0A5agPQipPzQvYV4gDtjAxbyFgBBGTT0vS9sSV+TMU5M1/VRQ/S8usfYqsFXn
         hwbJ9h3E1weSd3ndc+bCi/70SWHmPregFHffUGXa3q6K3/dQaEYfv1it0kcvNlGtZE
         6vtNIc/e9eA2sNaAd2DEwpPPbuUo+4H0EWUl3VoNsHH+jqFEhz2IyETVCHIqfxxrXD
         /k8OMR7sb6TAXmat6EqJOQSDjKxCQ/ANFY2bwOjDTy7LVwPVXyGbthzU0134uadgzo
         AY35gGdbW4t9bg+nRxJ1H35n9RD+c/vWF7hFhZXDO463Skh1NNSta9Gy68kCqfxv5w
         g+jMa3xSpVHvA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id t9-Q9zoBEekN; Wed, 10 Apr 2019 14:05:50 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id CEF781D5C50;
        Wed, 10 Apr 2019 14:05:50 -0400 (EDT)
Date:   Wed, 10 Apr 2019 14:05:50 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>, x86 <x86@kernel.org>
Message-ID: <1829916645.3219.1554919550686.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190410175709.GW4038@hirez.programming.kicks-ass.net>
References: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com> <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com> <20190410065417.GU11158@hirez.programming.kicks-ass.net> <608558890.3157.1554911260089.JavaMail.zimbra@efficios.com> <20190410175709.GW4038@hirez.programming.kicks-ass.net>
Subject: Re: rseq/x86: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/x86: choosing rseq code signature
Thread-Index: qfsDH9FH3unER4Ra7fJWzhZ0y+Uuaw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 10, 2019, at 1:57 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Wed, Apr 10, 2019 at 11:47:40AM -0400, Mathieu Desnoyers wrote:
>> ----- On Apr 10, 2019, at 2:54 AM, Peter Zijlstra peterz@infradead.org wrote:
>> 
>> > On Tue, Apr 09, 2019 at 04:43:42PM -0400, Mathieu Desnoyers wrote:
>> >> +/*
>> >> + * RSEQ_SIG is used with the following privileged instructions, which trap in
>> >> user-space:
>> >> + * x86-32:    0f 01 3d 53 30 05 53      invlpg 0x53053053
>> >> + * x86-64:    0f 01 3d 53 30 05 53      invlpg 0x53053053(%rip)
>> >> + */
>> > 
>> > Right, and the alternative is: 0f b9 3d $SIG, which decodes to:
>> > 
>> >  UD1 $SIG(%rip),%edi
>> > 
>> > which will trap unconditionally. The only problem is that gas will not
>> > actually assemble it, but since we're .byte coding it, it doesn't
>> > matter.
>> > 
>> > UD1 is specified by both AMD and Intel to take a ModR/M, unlike UD0
>> > where they disagree on the ModR/M.
>> 
>> UD1 is even better from a code emulator perspective. It won't have to
>> try to emulate invlpg if it sees it.
> 
> Some emulators terminate on UD2, not aware of any special UD1 behaviour.
> 
>> Byte coding UD1 as your example above gives the following objdump output,
>> is it expected ?
>> 
>> objdump --version
>> GNU objdump (GNU Binutils for Debian) 2.28
>> 
>> x86-32:
>> 
>>   14:	0f b9                	ud1
>>   16:	3d 53 30 05 53       	cmp    $0x53053053,%eax
>> 
>> x86-64:
>> 
>>    b:	0f b9                	ud1
>>    d:	3d 53 30 05 53       	cmp    $0x53053053,%eax
> 
> GNU objdump (GNU Binutils for Debian) 2.31.1
> 
>     0f b9 3d 78 56 34 12    ud1    0x12345678(%rip),%edi
> 
> So I suppose your objdump is too old :/

Well at least it decodes _something_ which matches the overall instruction
length of 7 bytes, which I think should be OK. So let's use ud1 unless anyone
objects.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
