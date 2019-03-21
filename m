Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99B3218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 00:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8iOOEek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfCUAGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 20:06:17 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:51873 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfCUAGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 20:06:17 -0400
Received: by mail-it1-f196.google.com with SMTP id e24so1797900itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 17:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dh9fCMe2mWRn4e3r3SY5rwjfjf9hXTgBN1Jt8Yv2+eU=;
        b=E8iOOEekIO1ptMLiPC7XsMtIT4WVZ0FhFpulfFF0IceuSuAEpfEYOc6fzeW8yoz0EY
         yl+7DoRvvXmYMK0wg9Z73ihtM2NKJkv6onR0afxAvRrbRQbd1m+Uf8VpZjOWdsZup5gq
         7E5JnHyEwtlSAjXgtOleMXLGHckgoiCgOgKxzXa3e+MxM8hubP0uyQfOHphHgZUOgVAs
         xmMHoFnkXjkkdwOb49ZEtwSlA1hrwindh4ZpIf4UDn3NqglmfakEwSulp7gCNeKVXl6p
         FXkrMqdZIK7FTjdAuwtd32uhjYgz0xnXHs82AsLlGc59x6baW5KYe3pXxrDktxKYJ4Ml
         bO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dh9fCMe2mWRn4e3r3SY5rwjfjf9hXTgBN1Jt8Yv2+eU=;
        b=QtNWBrsCX4+MoPjzpOmIWjncC0OXDEwZVIT6ZIrAsQd8PRFjXMIDF1RDW9iRUsnYmU
         hkx4t83zLLgQJR+Vf1nY4edE1sXB4eISN3cyrFjrqeBD2Zhg26aKSuZYWVD7oZwvALFn
         AER2HuJ6T1pxKPcEtUXa50JIRcsmWcsXEf0Vf2POVaz3bhOefTJJkih/p5TuSPqMmMoi
         cD5hllY+Bjm+HOkvmOSFkBuVBopew1D1PjnQkEig0ZHlGHTfRL99fxuPUH7mRS1sB3Gc
         YwIyqGWnLWHk/4Ky4yKl9aPBnvxtVQq3P0lzPVL42qWdDZ1xdnyLk56qYwvfsUO5BirO
         73JQ==
X-Gm-Message-State: APjAAAV17lWoYPEQ4eG3I8au0sBSpcISrI39QsAQyivrrHIN/wpU4bnj
        MEMdU+36iMQGJdgRCpa4YMehXsGhQ0O8xWlJLX8=
X-Google-Smtp-Source: APXvYqzbzFYVcbG0juaVYRJb2UiLITSDjsCg2MDfCM9emG34mUKz5MhZIcWz1/01H9/qQxzDpE59h0djKnsnhM5MBPo=
X-Received: by 2002:a24:32d0:: with SMTP id j199mr777582ita.71.1553126776327;
 Wed, 20 Mar 2019 17:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190320223853.1209-1-alistair.francis@wdc.com> <20190320234858.GA5304@infradead.org>
In-Reply-To: <20190320234858.GA5304@infradead.org>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Wed, 20 Mar 2019 17:04:58 -0700
Message-ID: <CAKmqyKPsoi7F_NNLKcm269=VAgdvsUV7HdF3dtkpMBzaKbHhtA@mail.gmail.com>
Subject: Re: [PATCH] irqchip: plic: Fix priority base offset
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Alistair Francis <Alistair.Francis@wdc.com>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 4:49 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Mar 20, 2019 at 10:39:52PM +0000, Alistair Francis wrote:
> > According to the FU540 and E31 manuals the PLIC source priority
> > address starts at an offset of 0x04 and not 0x00. To aviod confusion
> > update the address and source offset to match the documentation. This
> > causes no difference in functionality.
>
> Well, it starts at 0x00, but the first one is reserved.  If you think
> that is too confusing I'd rather throw in a comment explaining this
> fact rather than making the calculating more complicated.

It doesn't mention that it starts at 0 when you look here:
https://sifive.cdn.prismic.io/sifive%2F834354f0-08e6-423c-bf1f-0cb58ef14061_fu540-c000-v1.0.pdf
(pg. 61).

I agree that it's the same as starting as 0 and reserving the first
one, but this means that the macros are actually at the wrong address
and we need to remember not to use 0. This ends up forgotten and I
have seen bugs in OpenSBI and QEMU as they have a similar
implementation. It's possible some future code update will forget this
as well.

I think it's much clearer to define the correct values and just
subtract 1, the calculation really isn't more complicated.

Alistair
