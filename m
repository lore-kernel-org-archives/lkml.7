Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBFDC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C441206A3
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lxWm2FR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbfHAGLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:11:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46587 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbfHAGLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:11:37 -0400
Received: from [IPv6:2601:646:8600:3281:f549:c2d0:4f21:f394] ([IPv6:2601:646:8600:3281:f549:c2d0:4f21:f394])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x716Ajq54004578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 31 Jul 2019 23:10:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x716Ajq54004578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564639849;
        bh=PwoGlrLtPc8cy99uI495qpN06sk3FfgPsM8QT+Tv5sU=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=lxWm2FR73IGXYoQ6YQvyL9gyaByLePcNsBXO7qaUs/sWiWV8nQQ2cfxPZgd6JooVj
         bx+dc43LjoEk6FvujleRRus0BsIggnrpHzVD0yL/izp4x+x8P9nG8OYDGK1Or/+RQr
         Avb6H6sDqvq+Jaf/jMpECzZHTVvzwDTZwYBztHJaeX1n7rGIzfnYqVPbAP4ZQGO88s
         39f86fxGc97owhZE7/18gUKvNhWHYL6+/Y+pttc0hHDbwj4wyd4F6qBnLTvk1pyKuS
         5AyHkEOnK9APiA8eLycSCsf1jkJSFo5q3S6ENFxRB3+nCVC2bXd65NfE0qHGW5bAIS
         igla0OxIN94zg==
Date:   Wed, 31 Jul 2019 23:10:36 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com> <1d2830aadbe9d8151728a7df5b88528fc72a0095.1564549413.git.joe@perches.com> <20190731171429.GA24222@amd> <ccc7fa72d0f83ddd62067092b105bd801479004b.camel@perches.com> <765E740C-4259-4835-A58D-432006628BAC@zytor.com> <20190731184832.GZ31381@hirez.programming.kicks-ass.net> <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com> <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 31, 2019 4:55:47 PM PDT, Miguel Ojeda <miguel=2Eojeda=2Esandonis@gm=
ail=2Ecom> wrote:
>On Wed, Jul 31, 2019 at 11:01 PM <hpa@zytor=2Ecom> wrote:
>>
>> The standard is moving toward adding this as an attribute with the
>[[fallthrough]] syntax; it is in C++17, not sure when it will be in C
>be if it isn't already=2E
>
>Not yet, but it seems to be coming:
>
>  http://www=2Eopen-std=2Eorg/jtc1/sc22/wg14/www/docs/n2268=2Epdf
>
>However, even if C2x gets it, it will be quite a while until the GCC
>minimum version gets bumped up to that, so=2E=2E=2E
>
>Cheers,
>Miguel

The point was that we should plan ahead in whatever we end up doing=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
