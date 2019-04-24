Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FA1C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A9A2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 23:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="DdJ69+sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfDXXXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 19:23:01 -0400
Received: from mail.efficios.com ([167.114.142.138]:55470 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbfDXXXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 19:23:01 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 75F6A1DA134;
        Wed, 24 Apr 2019 19:22:58 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id b_oUwa0eRlQh; Wed, 24 Apr 2019 19:22:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C7C501DA12E;
        Wed, 24 Apr 2019 19:22:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C7C501DA12E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556148177;
        bh=bOog4KPRUXXUl6cu2sBdR7LqNalMNhi5xWWV7wTQ04Q=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=DdJ69+sFlewHwDbesfZ/RdWtCHtVb8Ms7bgH9/na9jCq69oIHDBxIeurxEwRYErvC
         NkD5QC6HnT+E1IK4a3RqeT82xp1thJ3Ip7PaN/QvUE8F12qpDSmpUz+oI5ylHp2VTT
         NAmDJAxQI+v8/DxJpZAzdTLns1jh65NfnP5dzCGY3aSuWfUYvseMP3YVw10jt4SvfQ
         pUH/DZiFXpZoRVkhi/U2nMVqWwYGL0QQhsViSx+4UNrqY4ss4lbBgO55AP9V/iY8gt
         lF5f3L5d03dPJI2GHoypjWAbUWR5EcdGvT45xJpKi+LtoWm5GLe1djPx8TbKOHo5qK
         ApND0nypqXQRg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id QXEK4muzn7qh; Wed, 24 Apr 2019 19:22:57 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id A7AB91DA128;
        Wed, 24 Apr 2019 19:22:57 -0400 (EDT)
Date:   Wed, 24 Apr 2019 19:22:57 -0400 (EDT)
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
Message-ID: <2047127593.1305.1556148177478.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190424231717.os4p6fq7fbx6afxa@pburton-laptop>
References: <20190424152502.14246-1-mathieu.desnoyers@efficios.com> <20190424152502.14246-11-mathieu.desnoyers@efficios.com> <20190424220609.4kryfcgsv46iu3ds@pburton-laptop> <2114325810.1301.1556147523476.JavaMail.zimbra@efficios.com> <20190424231717.os4p6fq7fbx6afxa@pburton-laptop>
Subject: Re: [RFC PATCH for 5.2 10/10] rseq/selftests: mips: use break
 instruction for RSEQ_SIG
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/selftests: mips: use break instruction for RSEQ_SIG
Thread-Index: AQHU+rH+AJnCxtNxUESFNInzrhwEUaZL3nOAYM0M9Xb8+at4gJ21bNWN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 24, 2019, at 7:17 PM, Paul Burton paul.burton@mips.com wrote:

> Hi Mathieu,
> 
> On Wed, Apr 24, 2019 at 07:12:03PM -0400, Mathieu Desnoyers wrote:
>> Does the following comment above the forest of #ifdef work for you ?
>> 
>> /*
>>  * RSEQ_SIG uses the break instruction. The instruction pattern is:
>>  *
>>  * On MIPS:
>>  *      0350000d        break     0x350
>>  *
>>  * On nanoMIPS32:
>>  *      00100350        break     0x350
>>  *
>>  * On microMIPS:
>>  *      0000d407        break     0x350
>>  *
>>  * For nanoMIPS32 and microMIPS, the instruction stream is encoded as 16-bit
>>  * halfwords, so the signature halfwords need to be swapped accordingly for
>>  * little-endian.
>>  */
> 
> I'd probably just say nanoMIPS rather than nanoMIPS32, because when we
> get nanoMIPS64 in the future it'll be a superset of nanoMIPS32 & the
> break encoding will be the same.

Done.

> 
> But otherwise it looks good to me :)

Great! I've added your "Suggested-by" tag to the patch.

Thanks,

Mathieu

> 
> Thanks,
>     Paul

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
