Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951F1C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D64120675
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ccmwmu4K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfEFVye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:54:34 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33593 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:54:34 -0400
Received: by mail-vs1-f68.google.com with SMTP id z145so9116359vsc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q8k4deF6LUSg0XMhZjIJsMDswCGChCG8LHJ6aCWS2+c=;
        b=Ccmwmu4KNXWaEjBHmOG8b3/Kt1J4Hyn+xX+ENKhZtIRrAZ25NJeBgAX99FQpDkzSQR
         Di1Vlgs8raV+O31O3C/y+HHwzVHNkMhOeXy1aZVu7yst0FzKfuH93SE3fxCGrHUMmMSf
         RXC9W7RvHmGAn0XChsIbR/1xqUtoRDv6gJcNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q8k4deF6LUSg0XMhZjIJsMDswCGChCG8LHJ6aCWS2+c=;
        b=G8Ftde9MP5GkfroIJE/b/QKqKHFzH9AOg/yp1QTTn/I7ty05U95aDpmEr7oGmNlU8C
         Sn5tO2giUyFoeNA+LGbw9K7u8hCcrTyCHyM7w0t0jCzedoL1OtRbnveOb8S65wSWSxkh
         0Ffgkzk80efHcVC+fJKtjuJsuECuSLls7fsot3V/Q7sW5xxU3s2w+rJoj8+wHjg/OpKq
         pEGtGW7SnqkuoZr3bVutePcYbUmilyrrGDqAbmNrcjG1Ahtv64u2BOdLzADJdX7TFAlZ
         1IyeTAwYXARST/ghaLjY/UT3H8x/65gNowBgRNFWOZ8OfeOx4pNShqwo22AF6xL+Os9r
         x+tw==
X-Gm-Message-State: APjAAAUN6av8P/qMGww80kmL5dBQ2XIGwGo8FszirWoMhjmhcTa5D4F+
        tVUoDCmw6sO8Ic2ZaHC1wPcCKJAPgIU=
X-Google-Smtp-Source: APXvYqwvybiNpSVy04fRd1eR5M8pFCYD0QCQaopQ3BtKqj96pnT4BSnQeO0N4p1mCBNKsjI5qNQcLA==
X-Received: by 2002:a67:fa4a:: with SMTP id j10mr4681169vsq.99.1557179672117;
        Mon, 06 May 2019 14:54:32 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id r67sm2952998vkd.39.2019.05.06.14.54.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:54:31 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id l17so3551687vke.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:54:30 -0700 (PDT)
X-Received: by 2002:a1f:6604:: with SMTP id a4mr4576099vkc.13.1557179670399;
 Mon, 06 May 2019 14:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190506191950.9521-1-jmoreira@suse.de>
In-Reply-To: <20190506191950.9521-1-jmoreira@suse.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 6 May 2019 14:54:19 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ40OaniqR+rwu2npRNM4hGjbZoReWF=vhE99hB1Dqbow@mail.gmail.com>
Message-ID: <CAGXu5jJ40OaniqR+rwu2npRNM4hGjbZoReWF=vhE99hB1Dqbow@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] x86/crypto: Fix crypto function casts
To:     Joao Moreira <jmoreira@suse.de>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 6, 2019 at 12:20 PM Joao Moreira <jmoreira@suse.de> wrote:
> It is possible to indirectly invoke functions with prototypes that do not
> match those of the respectively used function pointers by using void types.
> This feature is frequently used as a way of relaxing function invocation,
> making it possible that different data structures are passed to different
> functions through the same pointer.
>
> Despite the benefits, this can lead to a situation where functions with a
> given prototype are invoked by pointers with a different prototype, what is
> undesirable as it may prevent the use of heuristics such as prototype
> matching-based Control-Flow Integrity, which can be used to prevent
> ROP-based attacks.
>
> One way of fixing this situation is through the use of helper functions
> with prototypes that match the one in the respective invoking pointer.
>
> Given the above, the current efforts to improve the Linux security, and the
> upcoming kernel support to compilers with CFI features, fix the prototype
> casting of x86/crypto algorithms camellia, cast6, serpent and twofish with
> the use of a macro that generates the helper function.
>
> This patch does not introduce semantic changes to the cryptographic
> algorithms, yet, if someone finds relevant, the affected algorithms were
> tested with the help of tcrypt.ko without any visible harm.

Awesome; thanks for working on this! I'm looking through the patches
now and pondering solutions to the RFC in twofish. I'll send notes in
a bit...

-- 
Kees Cook
