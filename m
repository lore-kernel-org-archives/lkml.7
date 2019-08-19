Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A1EC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07CF920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 12:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="fPdFc1wB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbfHSMxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 08:53:52 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43376 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSMxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 08:53:52 -0400
Received: by mail-qt1-f195.google.com with SMTP id b11so1693853qtp.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 05:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isJgkxNUoPWD24MN/1ymy++NXPiB1UY/995lEEO/RNE=;
        b=fPdFc1wBUoJx/F2JB35k17/ZTJhmLKPT2s5eblX4w0A3zMMcZgpRkz97HTW9bCmALB
         c1+Ag910MbvEqBdh1+GQn7WWTO9dNXoZIvpRBK9/LYbYPdkhcJCjPNdT/rC0HruPHNBh
         0WHcEBquZ74QNIOUM7JFEdekhEbjQwYQXxXcx8318t81nHPssREdWXpwpMoP6vRZ5beJ
         zawGCoTGKqs718g8ZPRyjlfC3drIx+454fb7k69H4uL/Uoc2gV3CUR2yI3cvRaALPbCZ
         8mDfEyZ1cgQVQxZBIRkTwAPZDmGpo2bliV/8tBYt4n8Xc0OoScojHWOSQ41B73WHCnob
         +9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isJgkxNUoPWD24MN/1ymy++NXPiB1UY/995lEEO/RNE=;
        b=YjddV9OO/cOrG8VaDCKxWh66YcG37sMaj2hDdwt+RxKjarkfXbnmpB+5uuJzzrGI8T
         2Un00lI1Idy8aisKOVslZpzA8rOtqRUVB48ftK1L3NVvC5tyclnkkoYDaSTqG3p6Aptb
         vtwVK5S2zyO57DI5ODj0M/TWIIu3ewrirfczXq9ngYt7oNLNo7yjPKBlxV9G+NKVG9vG
         RT9Q8BNriS2SomAgXTgmm6CLlzmirFRelfcM6KIduEIBIxBlkbavZxcnxHLqIesRGzE2
         upBRnTSvSdsk9ejCjlP4EIft5nt3LF4xDUfTqmpe7hVP/ONeyYGIiTScWZLKRTYSgW3l
         xaig==
X-Gm-Message-State: APjAAAVTqEp+ZKpKG40c55AD0IJNj2N8ApbPbiCKkoqGDthTECqLFRV2
        ZzxjfYuA/bAl3k/6bW511MFwkdFcysvHQv/F5NN02A==
X-Google-Smtp-Source: APXvYqxMXPnH0ydEry2WZlL7Sg8jqmQvh/EshM0LrxPCKMIxcs9+9ZFGcOdzmHUIgVazDvSIaSSL4mJ0VTBynKEF/cI=
X-Received: by 2002:a0c:fd91:: with SMTP id p17mr10630675qvr.170.1566219228838;
 Mon, 19 Aug 2019 05:53:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190723130513.GA25290@kroah.com> <alpine.DEB.2.21.1907231519430.1659@nanos.tec.linutronix.de>
 <20190723134454.GA7260@kroah.com> <20190724153416.GA27117@kroah.com>
 <alpine.DEB.2.21.1907241746010.1791@nanos.tec.linutronix.de>
 <20190724155735.GC5571@kroah.com> <alpine.DEB.2.21.1907241801320.1791@nanos.tec.linutronix.de>
 <20190724161634.GB10454@kroah.com> <alpine.DEB.2.21.1907242153320.1791@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907242208590.1791@nanos.tec.linutronix.de>
 <20190725062447.GB5647@kroah.com> <CAHbf0-FenMwa6uMqpD_fJZLU3YKviOcMe_pBh8oWmUPoUYk_LA@mail.gmail.com>
In-Reply-To: <CAHbf0-FenMwa6uMqpD_fJZLU3YKviOcMe_pBh8oWmUPoUYk_LA@mail.gmail.com>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Mon, 19 Aug 2019 13:53:37 +0100
Message-ID: <CAHbf0-GpJY6SGz=9yXEh28vvBuHP-c_fKqP6u60Ag3et6FCPrg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to be reserved
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 at 12:09, Mike Lothian <mike@fireburn.co.uk> wrote:
>
> As it's related. I've raised
> https://bugzilla.kernel.org/show_bug.cgi?id=204495 about the
> relocatition I'm seeing since switching back to ld.bfd - is this safe
> to ignore? I'm guessing this is why gold isn't working as it can't do
> them
>
> Cheers
>
> Mike

Sorry am I asking in the wrong place about this?
