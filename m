Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F79C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94BCB2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 21:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="F0zZsJVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbfGaVB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 17:01:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55015 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfGaVB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 17:01:59 -0400
Received: from [10.171.236.151] ([192.55.54.60])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6VL18h23835409
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 31 Jul 2019 14:01:09 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6VL18h23835409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564606870;
        bh=J4m+H7cdshvin9EGtiYO5Wa6yJDmrnfiy/VAp1iSDaM=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=F0zZsJVdaTBQUP8fo5GcPrrvJ96pbX3GPo8JR1MZr9WqTreh23E82R9SF61F1k6x/
         SHWZn9HOTL5MhVIQCU1j+ZzkxXfhHq4WIBodbfT69UPheDb7/S+SXdJJGzBv9CtYsT
         Ao6r6CxIsqdYIt+GxEDw5ikOmA6jl7rW8XbDvAHNLr0z/dUuWZxNhWvcE5M+EAmRe9
         5934YHB1ipMSeg2PjkR1khGp3uajQMjfdDWPYJSAAUMveyilGCsswsyDYCng7GlEbW
         Qi/4NdMqBLVW9PVKd70nW9RJ/4dTBiitVuEz1M9elF+Je6O+otXDwfwM0ToxMPeJme
         UQ4fFGAhfP48A==
Date:   Wed, 31 Jul 2019 14:01:05 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com> <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com> <20190731171429.GA24222@amd> <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com> <765E740C-4259-4835-A58D-432006628BAC@zytor.com> <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 31, 2019 11:48:32 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> w=
rote:
>On Wed, Jul 31, 2019 at 11:24:36AM -0700, hpa@zytor=2Ecom wrote:
>> >> > +/*
>> >> > + * Add the pseudo keyword 'fallthrough' so case statement
>blocks
>> >> > + * must end with any of these keywords:
>> >> > + *   break;
>> >> > + *   fallthrough;
>> >> > + *   goto <label>;
>> >> > + *   return [expression];
>> >> > + *
>> >> > + *  gcc:
>>https://gcc=2Egnu=2Eorg/onlinedocs/gcc/Statement-Attributes=2Ehtml#State=
ment-Attributes
>> >> > + */
>> >> > +#if __has_attribute(__fallthrough__)
>> >> > +# define fallthrough                 =20
>__attribute__((__fallthrough__))
>> >> > +#else
>> >> > +# define fallthrough                    do {} while (0)  /*
>fallthrough */
>> >> > +#endif
>> >> > +
>
>> If the comments are stripped, how would the compiler see them to be
>> able to issue a warning? I would guess that it is retained or
>replaced
>> with some other magic token=2E
>
>Everything that has the warning (GCC-7+/CLANG-9) has that attribute=2E

The standard is moving toward adding this as an attribute with the [[fallt=
hrough]] syntax; it is in C++17, not sure when it will be in C be if it isn=
't already=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
