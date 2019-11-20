Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19B7C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FBE2071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 19:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Ia+IJ1yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKTTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 14:52:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43820 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKTTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 14:52:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id w6so545511edx.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EiMbJh8v38zaJv5chquKKWl+LfhgsUJpIvrC2X204xU=;
        b=Ia+IJ1yC/SGCZZT73YW5QN5sOik0SZUaNc5bt6W6XLdtaP9OTSbaXvykZlnoLKCERs
         9LWJWZs/BDypHB+qnhDLnFKj0PxrZ7ysEn/lDFCFbGY2ph/kCaQyn0XCed5qFd/thhJ2
         AVmyetS8PbGcfMDzvrJSZ37PuBNAiZOPjzEj8RCG8+nNA+s2fr63DO1Hooja2YsOrhVD
         TJfh8LhK8mNKTg0NqIaMWSU/SxBW/I37ylNsNmA6kL8zKt/KyfHlsFquoK27DAPftldp
         IEoKkHEFYwqFBKrH4tMmN5l/CAdkk/FYO4EdCfBO2QhhQ30QSkJlboRW6+YrsD6JXc29
         zdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EiMbJh8v38zaJv5chquKKWl+LfhgsUJpIvrC2X204xU=;
        b=WAPsKg1i+/0cufswsuMfc1SadYDRbOtS4vAmDljJ/qzNW6yv+kTVnpapkdimryKcaq
         sJBoUmVfs7069TLQuDcEEHfHwmiBqRDC98XEUZ3uyiNdNJersTNIkl8Eink6i8mmN4RF
         Zie91SZ6bjoJk2dOfU71VgTUM80tkey/1FyVUWCvc9Yije/OhrLeVZPBhyT79bYsDOdq
         LtwxjobshI1oc5LopYmNrYe+edIwbZG50HjLHJM3rBnCsfxrCFpM0qG+7rLlZJPnxYZ4
         LcRpnOE/etOBkLZQQX/0thNZ/x5zfs8paKsdNUg40CaqVEUvKas4j5c4EbEQL0MTQ367
         mKxA==
X-Gm-Message-State: APjAAAVDWQyidRLMUGCqTm9zsLOkdcdElNzuAjKQm2uL89aDEtLRUYpJ
        N3LAwyBIVUIrWn5WOAMlEePYCRraji/sZrAtcKgqjg==
X-Google-Smtp-Source: APXvYqxORrW8OJgoNu0IuYlIZ28DHLYRRWsXEk6WNCu7CI3C804tS+sUUWzYWiHSQMX7c5wXXsnpF3BEROW8rY42lLQ=
X-Received: by 2002:a17:906:90b:: with SMTP id i11mr7638851ejd.109.1574279537192;
 Wed, 20 Nov 2019 11:52:17 -0800 (PST)
MIME-Version: 1.0
References: <20191119221006.1021520-1-pasha.tatashin@soleen.com>
 <20191120164307.GA19681@lakrids.cambridge.arm.com> <CA+CK2bAkb7zg6ne=PzA7UrQF49J2Sa7rmyWM3Bqugfe00-36ng@mail.gmail.com>
 <CA+CK2bCX+QGMPzhjj-UmVNb1jG8Z6WNW=L0GiVsTpGrhyqb9tA@mail.gmail.com>
In-Reply-To: <CA+CK2bCX+QGMPzhjj-UmVNb1jG8Z6WNW=L0GiVsTpGrhyqb9tA@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Nov 2019 14:52:06 -0500
Message-ID: <CA+CK2bDvp=RR7A5J097W3tr2QG_cOZgDMno388EXGAYW6+Q1Mg@mail.gmail.com>
Subject: Re: [PATCH] arm64: kernel: memory corruptions due non-disabled PAN
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 2:46 PM Pavel Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> > > I see that with CONFIG_ARM64_SW_TTBR0_PAN=y, this means that we may
> > > leave the stale TTBR0 value installed across a context-switch (and have
> > > reproduced that locally), but I'm having some difficulty reproducing the
> > > corruption that you see.
> >
> > I will send the full test shortly. Note, I was never able to reproduce
> > it in QEMU, only on real hardware. Also, for some unknown reason after
> > kexec I could not reproduce it only during first boot, so it is
> > somewhat fragile, but I am sure it can be reproduced in other cases as
> > well, it is just my reproducer is not tunes for that.
> >
>
> Attached is the test program that I used to reproduce memory corruption.
> Test on board with Broadcom's Stingray SoC.

I forgot to remove from repro.c some of the stuff that I used for debugging:
get_pa() and sched_setaffinity() stuff are not needed.

>
> Without fix:
> # time /tmp/repro
> Corruption: pid 1474 map[0] 1488 cpu 3
> Terminated
>
> real    0m0.088s
> user    0m0.004s
> sys     0m0.071s
>
> With the fix:
>
> # time /tmp/repro
> Test passed, all good
> Terminated
>
> real    1m1.286s
> user    0m0.004s
> sys     0m0.970s
>
>
>
> Pasha
