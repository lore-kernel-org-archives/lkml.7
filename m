Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF98CC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4889820833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Lx3e2sDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfDONhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:37:24 -0400
Received: from mail.efficios.com ([167.114.142.138]:41780 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbfDONhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:37:23 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 355431810C3;
        Mon, 15 Apr 2019 09:37:22 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id XiHIcA4Aq8MH; Mon, 15 Apr 2019 09:37:21 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 891DA1810BF;
        Mon, 15 Apr 2019 09:37:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 891DA1810BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1555335441;
        bh=6W8UOxj+5vWBjrJvO0dDS19EwvcULP0VSPJvBnO8b1A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Lx3e2sDRktIwYLHJ93/3F4SYOEqCIGSUVPSj3/kD3aD7A27jBYC4o0L7J+Prnxf1s
         kN5GYBvLUfeFE992Ve8iiiu1kDSK35QQbWmGlk1wzHNxuh47IgG2NeTInxBijOa00W
         frbLlvgb8bdumrTnSWaU/9nYYyZ5yJ8jNyaOYDS8495+xuRqIRYuEL1D3yee5K4Rxr
         OSKR7+56c12eaTKa4cbJrIPPawjsDemJ5/HuWPpooVYlM36dRmsi5vIpA6qreZf0Jm
         BGjt5v9Z0Kda9Qrdj749rJD2Yga86950G7dupVTQbjICNKJ8nDoWp79mldOeyoNe0G
         OkbFClka4JPMA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id NkulOQjzQ8zE; Mon, 15 Apr 2019 09:37:21 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 697851810A8;
        Mon, 15 Apr 2019 09:37:21 -0400 (EDT)
Date:   Mon, 15 Apr 2019 09:37:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     peter maydell <peter.maydell@linaro.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        carlos <carlos@redhat.com>,
        richard earnshaw <richard.earnshaw@arm.com>
Message-ID: <71495082.295.1555335441325.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAFEAcA8YP5vvZpa_5dvv00koupsry9_3x2EB0cjvE6vtoi8sog@mail.gmail.com>
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com> <1933578130.3292.1554928159928.JavaMail.zimbra@efficios.com> <20190411164219.GE29081@fuggles.cambridge.arm.com> <1469455003.811.1555005112414.JavaMail.zimbra@efficios.com> <CAFEAcA849mmSds9euyvR2uLWqEeA2eedkmcq1O4pT6-S0oK8BA@mail.gmail.com> <936773156.261.1555333890988.JavaMail.zimbra@efficios.com> <CAFEAcA8YP5vvZpa_5dvv00koupsry9_3x2EB0cjvE6vtoi8sog@mail.gmail.com>
Subject: Re: rseq/arm32: choosing rseq code signature
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3794 (ZimbraWebClient - FF66 (Linux)/8.8.12_GA_3794)
Thread-Topic: rseq/arm32: choosing rseq code signature
Thread-Index: VZEg1Ag6Z/BBTTsrujcfED6/RqHFqg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 15, 2019, at 9:30 AM, peter maydell peter.maydell@linaro.org wrote:

> On Mon, 15 Apr 2019 at 14:11, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> ----- On Apr 11, 2019, at 3:55 PM, peter maydell peter.maydell@linaro.org wrote:
>>
>> > On Thu, 11 Apr 2019 at 18:51, Mathieu Desnoyers
>> > <mathieu.desnoyers@efficios.com> wrote:
>> >>  * This translates to the following instruction pattern in the T16 instruction
>> >>  * set:
>> >>  *
>> >>  * little endian:
>> >>  * def3        udf    #243      ; 0xf3
>> >>  * e7f5        b.n    <7f5>
>> >>  *
>> >>  * big endian:
>> >>  * e7f5        b.n    <7f5>
>> >>  * def3        udf    #243      ; 0xf3
>> >
>> > Do we really care about big-endian instruction-ordering for Thumb?
>> > It requires (AIUI) either an ARMv7R CPU which implements and sets
>> > SCTLR.IE to 1, or a v6-or-earlier CPU using BE32, and it's going to
>> > be even rarer than normal BE8 big-endian...
>>
>> I don't think we care enough about it to look for a trick to
>> turn the branch into something else (which would not branch away from the
>> udf instruction), but considering this signature will be ABI, it's good to
>> be thorough documentation-wise and cover all existing cases.
> 
> I think if you want to document it it would be helpful to
> readers to make it clear that this is the ultra-rare
> big-endian-instruction-order "big endian Thumb", not the only
> moderately-rare little-endian-instructions-big-endian-data
> "big endian Thumb".

I'm actually very much concerned about environments with big endian
data and little endian code. Which gcc compiler flags do I need to
use to test it ?

I'm concerned about a signature mismatch between what is passed to
the rseq system call ("data-endian signature") and what is generated
in the code ("instruction-endian signature").

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
