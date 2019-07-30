Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EF3C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9722089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="hIlEZn8Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbfG3Nnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:43:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38839 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbfG3Nng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:43:36 -0400
Received: from [IPv6:2601:646:8600:3281:2150:f27a:5e53:9961] ([IPv6:2601:646:8600:3281:2150:f27a:5e53:9961])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6UDh1cu3237618
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 30 Jul 2019 06:43:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6UDh1cu3237618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564494188;
        bh=Xz+bTKiZ7oV4hiNxrEM7y0bnhFIUin6FjG0frsfk9qg=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=hIlEZn8QCL76NhRMk54YYiLudToxmUUJ8dKqwHDJSwklELRfJsfGQbnfJ3grNYfao
         89JsjrjgFi0f3H5UzaF+y6y6EWCOhH4GSoEfRpzoYP7268CKE5aQOH99bJDtfNPhk4
         exyctSNy4Feunb0HOSPrx9/R3QZGT35FLlg6+d6U/F6c5H2Z56uokHCkP0lRImqNId
         VSlz/0qJpi9ySPxW009beCm9/Qbn1WiN+LONGqNziTgjJ891JoO02akaNs2LFjZVWK
         P/WyfYOe7f+ongIvDzhcU+EnKdy9Wu+h7GzwUuB22aRoDGCWVo7bAiK0vtJ83go+0H
         +EgsdkksRAfqQ==
Date:   Tue, 30 Jul 2019 06:42:51 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190730080843.GG31381@hirez.programming.kicks-ass.net>
References: <20190728115140.GA32463@avx2> <20190729094329.GW31381@hirez.programming.kicks-ass.net> <20190729100447.GD31425@hirez.programming.kicks-ass.net> <20190729204417.GA2146@avx2> <20190730080843.GG31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] x86: drop REG_OUT macro from hweight functions
To:     Peter Zijlstra <peterz@infradead.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
CC:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <5DF8B85C-57EF-4AE4-A2EE-863D06D7C55E@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 30, 2019 1:08:43 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Mon, Jul 29, 2019 at 11:44:17PM +0300, Alexey Dobriyan wrote:
>> On Mon, Jul 29, 2019 at 12:04:47PM +0200, Peter Zijlstra wrote:
>> > +#define _ASM_ARG1B	__ASM_FORM_RAW(dil)
>> > +#define _ASM_ARG2B	__ASM_FORM_RAW(sil)
>> > +#define _ASM_ARG3B	__ASM_FORM_RAW(dl)
>> > +#define _ASM_ARG4B	__ASM_FORM_RAW(cl)
>> > +#define _ASM_ARG5B	__ASM_FORM_RAW(r8b)
>> > +#define _ASM_ARG6B	__ASM_FORM_RAW(r9b)
>>=20
>> I preprocessed percpu code once to see what precisely it does because
>> it was easier than wading through forest of macroes=2E
>
>Per cpu is easy, try reading the tracepoint code ;-)

Sometimes it's the =2Es file one ends up wanting to check out=2E=2E=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
