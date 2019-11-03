Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC59CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4812086D
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 22:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="JkRxBmtd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfKCWBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 17:01:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55749 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbfKCWBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 17:01:38 -0500
Received: from [IPv6:2607:fb90:4e3e:9032:19ff:fb60:ee73:4ffc] ([IPv6:2607:fb90:4e3e:9032:19ff:fb60:ee73:4ffc])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA3M0uSX030800
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Sun, 3 Nov 2019 14:00:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA3M0uSX030800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1572818461;
        bh=1dtJBXwpbDabMD1Gg7C4v+rSy3ncm7MJY6zt3M5CfrE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=JkRxBmtdjAY24HyqhOIivEXE2Iy7jCjPRKJhBixtEdeiGldzTx8WAbMzoXypJdw/D
         dxFx4qMlsm+nEEakdT3iB24SJ+vhcSD8hbP9AqFCKbwplfAnfQIZy2myP/4UWg6n5h
         cVaVztLhyG6k1Ekks/ImJskOn7V/2V1XugNuNcOsx0ZbtRRpm5hW/o2hhZoOeDFGT3
         Q963QlMVqsUxSmYP9EwUSWJ4l7viUKAFXMZUg2JGPJGiwTcEvCcJbq3m22f3GOzbLx
         G5DumzMxQu5pp06n5MuHIFuhLqdaVOPMsTupd6/RPFvwbloTtEYK2kVtJIg+2Y5G0e
         RwEeORqHSgigA==
Date:   Sun, 03 Nov 2019 14:00:47 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMEGPioV_MTKO9DK6JT5355b7x0py-D_K467etDDnxWSYAbEig@mail.gmail.com>
References: <20190620062246.2665-1-e5ten.arch@gmail.com> <20191029210250.17007-1-e5ten.arch@gmail.com> <CBCA4048-A9C1-42E6-A821-1EE36AE8CDC7@zytor.com> <CAMEGPioV_MTKO9DK6JT5355b7x0py-D_K467etDDnxWSYAbEig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] replace timeconst bc script with an sh script
To:     Ethan Sommer <e5ten.arch@gmail.com>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <john.stultz@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Corey Minyard <cminyard@mvista.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <40DC5B42-6C0D-4A5B-B23E-884ADB0108F0@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 3, 2019 1:56:50 PM PST, Ethan Sommer <e5ten=2Earch@gmail=2Ecom>=
 wrote:
>> Please let me point out, again, that bc *is* part of the basic POSIX
>toolset, and the only tool in that toolset that allows for
>arbitrary-precision arithmetic=2E That being said, GNU as, which we also
>depends on, also contains bigint arithmetic, so it might be possible to
>coax as into outputting ASCII output without manually implementing
>bigints manually=2E
>>
>> Another option would be to use a C program linked with gmp=2E Binutils
>requires gmp, so it doesn't inherently add dependencies, but running it
>though as would probably be easier at least for the LLVM guys=2E
>>
>> I also have written a small, portable C bigint library, but that is a
>lot of code to add to the tree=2E
>I don't know what the requirement is for the level of precision this
>would need to support is, so I don't know if this meets them, but I
>made
>a C program that doesn't use gmp, so while it probably doesn't
>theoretically have the same level of precision as bc, it does match it
>for output on anything up to 15000 (it doesn't stop matching
>timeconst=2Ebc above 15000 I just didn't test any higher)=2E The program =
is
>here: http://ix=2Eio/20Ka
>If this is considered precise enough to be an acceptable replacement
>I will make a new patch to use it in place of timeconst=2Ebc=2E

The point isn't to make it work *now*, but getting it to *stay* work=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
