Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7408C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B760B20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 15:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cL2zdvmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387435AbfDJPrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 11:47:42 -0400
Received: from mail.efficios.com ([167.114.142.138]:34140 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfDJPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 11:47:42 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id CD4B11D683F;
        Wed, 10 Apr 2019 11:47:40 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id CbIXDwyNDyju; Wed, 10 Apr 2019 11:47:40 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 52F371D683C;
        Wed, 10 Apr 2019 11:47:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 52F371D683C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1554911260;
        bh=ZpzrGq3lcSS6nG/bqsnwVl9SgcLX2lfCjmK4c2eAqKw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=cL2zdvmFogL+8wxx4jEJP1iEKF9QEcPiD8rvLAIOhFzC+LMb72VgtmBdeMgmwHQxP
         Nc7kv8o2bUAvhfkLkt86mBMGP1pg89m+9VCYcuEMS7KljEhXBORVgMf0M/BKqbPeuy
         OgR13iauIzzP6Kb4T3w1TpgqqcI8bKGQLWl6Zrjxpyzgv114lzTS7JQK9J+Cy0iRVt
         AsKlWrjHLUYkvNidGNerHO1t7vTbFTaEXZx60u58ob10fI1BB9AMYOVdoyru5NgQxS
         ndyRgFf1KQjzYnaUukNecS7JUDCggd9DJUJ/p7f6Ei+easQtC8y9ud4Dlb/CZTUuF/
         sormvj9g5DPfw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id rAMfGAjTl0ca; Wed, 10 Apr 2019 11:47:40 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 300351D6831;
        Wed, 10 Apr 2019 11:47:40 -0400 (EDT)
Date:   Wed, 10 Apr 2019 11:47:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <andi@firstfloor.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>, x86 <x86@kernel.org>
Message-ID: <608558890.3157.1554911260089.JavaMail.zimbra@efficios.com>
In-Reply-To: <20190410065417.GU11158@hirez.programming.kicks-ass.net>
References: <11513896.2624.1554838336494.JavaMail.zimbra@efficios.com> <913288111.2663.1554842622822.JavaMail.zimbra@efficios.com> <20190410065417.GU11158@hirez.programming.kicks-ass.net>
Subject: Re: rseq/x86: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/x86: choosing rseq code signature
Thread-Index: e/OzUpebIqsLWqeBGlGZ0H4evtXDGQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 10, 2019, at 2:54 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Apr 09, 2019 at 04:43:42PM -0400, Mathieu Desnoyers wrote:
>> +/*
>> + * RSEQ_SIG is used with the following privileged instructions, which trap in
>> user-space:
>> + * x86-32:    0f 01 3d 53 30 05 53      invlpg 0x53053053
>> + * x86-64:    0f 01 3d 53 30 05 53      invlpg 0x53053053(%rip)
>> + */
> 
> Right, and the alternative is: 0f b9 3d $SIG, which decodes to:
> 
>  UD1 $SIG(%rip),%edi
> 
> which will trap unconditionally. The only problem is that gas will not
> actually assemble it, but since we're .byte coding it, it doesn't
> matter.
> 
> UD1 is specified by both AMD and Intel to take a ModR/M, unlike UD0
> where they disagree on the ModR/M.

UD1 is even better from a code emulator perspective. It won't have to
try to emulate invlpg if it sees it.

Byte coding UD1 as your example above gives the following objdump output,
is it expected ?

objdump --version
GNU objdump (GNU Binutils for Debian) 2.28

x86-32:

  14:	0f b9                	ud1    
  16:	3d 53 30 05 53       	cmp    $0x53053053,%eax

x86-64:

   b:	0f b9                	ud1    
   d:	3d 53 30 05 53       	cmp    $0x53053053,%eax

Thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
