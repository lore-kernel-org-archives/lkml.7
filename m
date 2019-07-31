Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7459C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A281B214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="zlXYJ0r/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbfGaSZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:25:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40665 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfGaSZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:25:38 -0400
Received: from [10.171.236.151] ([192.55.54.60])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6VIOeaT3787495
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 31 Jul 2019 11:24:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6VIOeaT3787495
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564597482;
        bh=txRshuHUqdGB6iKaTei8z8eRN2RTKp9cz6Id4MSwGeU=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=zlXYJ0r/PFIFBLEfb9vMBPc2VftRX7kfgBKiEgS27XUiJ7S08HzLMdX/qsyeLkAZe
         IJDdG1OZfnbypfq9wXnSAxz0yikDPM5nUNOYVB/xkN1ywgGTtAh2Jsuof56M3JwmVH
         6hswTxuObNkyHUVlfkxKJIywo1XGow4wS1JbMRe5yZWnx374rhXnZ3rkbvm5M4o1aU
         AsBSec8oWalwnGNR0ob2d0JK8mmFVokYVF/cC9/tXkkmLyMP54vmZR4CvDyyGlrdUx
         M+uF5MD14CMukJZvYxsCSh9LgjttCrGnXRE4lzClxQY4nzoGb5Dtol3rLsEeh5mN2I
         /y5yJp3+Wq2mg==
Date:   Wed, 31 Jul 2019 11:24:36 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com> <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com> <20190731171429.GA24222@amd> <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use
To:     Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 31, 2019 10:51:37 AM PDT, Joe Perches <joe@perches=2Ecom> wrote:
>On Wed, 2019-07-31 at 19:14 +0200, Pavel Machek wrote:
>> On Tue 2019-07-30 22:35:18, Joe Perches wrote:
>> > Reserve the pseudo keyword 'fallthrough' for the ability to convert
>the
>> > various case block /* fallthrough */ style comments to appear to be
>an
>> > actual reserved word with the same gcc case block missing
>fallthrough
>> > warning capability=2E
>>=20
>> Acked-by: Pavel Machek <pavel@ucw=2Ecz>
>>=20
>> > +/*
>> > + * Add the pseudo keyword 'fallthrough' so case statement blocks
>> > + * must end with any of these keywords:
>> > + *   break;
>> > + *   fallthrough;
>> > + *   goto <label>;
>> > + *   return [expression];
>> > + *
>> > + *  gcc:
>https://gcc=2Egnu=2Eorg/onlinedocs/gcc/Statement-Attributes=2Ehtml#Statem=
ent-Attributes
>> > + */
>> > +#if __has_attribute(__fallthrough__)
>> > +# define fallthrough                  =20
>__attribute__((__fallthrough__))
>> > +#else
>> > +# define fallthrough                    do {} while (0)  /*
>fallthrough */
>> > +#endif
>> > +
>>=20
>> Will various checkers (and gcc) recognize, that comment in a macro,
>> and disable the warning accordingly?
>
>Current non-gcc tools:  I doubt it=2E
>
>And that's unlikely as the comments are supposed to be stripped
>before the macro expansion phase=2E
>
>gcc 7+, which by now probably most developers actually use, will
>though
>and likely that's sufficient=2E
>
>> Explanation that the comment is "magic" might not be a bad idea=2E
>
>The comment was more for the reader=2E
>
>cheers, Joe

If the comments are stripped, how would the compiler see them to be able t=
o issue a warning? I would guess that it is retained or replaced with some =
other magic token=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
