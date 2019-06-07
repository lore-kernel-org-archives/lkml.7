Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE693C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BAA208C0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 23:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzvx8yjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbfFGXkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 19:40:46 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41350 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729810AbfFGXkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 19:40:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id s24so1379834plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nGU1cHVksPdzJ27l4WiOPkJRPpZpUroiBndbB+8Stj8=;
        b=Jzvx8yjVWIMjVeu9Ly1QaYnH/7d+iTVN/G5iSXG4yHrXEWzsLAoe/q1B2FRzv6MpzZ
         kpDBofFIPg9z5Dx+3e6ObpQ3KZp4I7YRXUuRabEDP/tWxBkE7vZxmhaWPbiE1CMNZ35I
         XpvHnylLRBIqSb9mdFIMJgjquKN97YTW3pp5hujJBBPzWHIorb/ZcByNQOOhcQ2Tyqx/
         RBjfqiclvRqpyIpEVieCXmS2nF7xJVozuQnunsKbLBeWCtSbEGLtV+yArLI8dKnBrBmY
         5s0K+KUx3OM5ZhiTkyrI7w0kLiJ9fUS0i9L+UQX52D5AjQSKelKOyNMo1BkangCOiKVk
         z4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nGU1cHVksPdzJ27l4WiOPkJRPpZpUroiBndbB+8Stj8=;
        b=qN7KCA3aBx+FoMuzX4RaN1KP4xNQpL+WiojzNZnWtZqpDG92CB3g89v6i9HyM/nHwQ
         IgLFgg5Fp6iOwR5cV3pwkoN/3G2LhK3GAXicnve9aft6C7gsIlNt6NLPJMYQ0wZdJOMX
         gv7AFE22em1x+aRCPk+AtjOJxB9dF2VkVs7CrZIZYv16gPf7IYNMo3uwPP7IokC7lY9Q
         9IJNbdhRxS1gPW8Wy9oUGNzLGM8EppqUby15pqud7DfBwhkilbntfZo7rDyEmSrFIph/
         +O6hns6jFyG+FJj0iHjL6zBInfJvsRO3lP7cQHoS5V3UAFEA3T/Uht33ogsHh6ZRdzyl
         RFkg==
X-Gm-Message-State: APjAAAU0Okz0gKSRWm0KcY+7I4V9DRwDpCAVk3UWQFT3mNDNUmGYXS4/
        w9/VywSZTOe7IwwluUQw6O9YPOmoqdS24KSB029HO42UOXU=
X-Google-Smtp-Source: APXvYqxrDjMnQGZQ3bm0rZvzkIe2bESbq/JlHbpyuGKYduGgSELZq0dIY3i/AU/W+H6W6n4ItH/YTPkoi1Mo5a+WqdY=
X-Received: by 2002:a17:902:6b07:: with SMTP id o7mr37395316plk.180.1559950845545;
 Fri, 07 Jun 2019 16:40:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190515210202.21169-1-richard@nod.at> <CAO1O6sdU=kAYS2sTKwiagxrbg+fMer9nvbwA9C4LoFMgH7e1dQ@mail.gmail.com>
 <1644731533.84685.1559938164477.JavaMail.zimbra@nod.at> <CAO1O6scuNXfgtaex_Ty4-5=DmBV43Sg28ntkzNgB5T2KwfXG3g@mail.gmail.com>
 <1342653998.84700.1559940592644.JavaMail.zimbra@nod.at>
In-Reply-To: <1342653998.84700.1559940592644.JavaMail.zimbra@nod.at>
From:   Emil Lenngren <emil.lenngren@gmail.com>
Date:   Sat, 8 Jun 2019 01:40:38 +0200
Message-ID: <CAO1O6seVp0wBVE6AKmu+EYhoghxbErNuK1F=Y5ewzD=CRro24g@mail.gmail.com>
Subject: Re: [PATCH] ubifs: Add support for zstd compression.
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michele Dionisio <michele.dionisio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Den fre 7 juni 2019 kl 22:49 skrev Richard Weinberger <richard@nod.at>:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Emil Lenngren" <emil.lenngren@gmail.com>
> > An: "richard" <richard@nod.at>
> > CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "Sebastian Andrzej Sie=
wior" <sebastian@breakpoint.cc>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>, "Michele Dionisio" <michele.dionisio@gm=
ail.com>
> > Gesendet: Freitag, 7. Juni 2019 22:27:09
> > Betreff: Re: [PATCH] ubifs: Add support for zstd compression.
> >> So I'm not sure what is the best choice for the default filesystem.
> >
> > My idea was at the end, i.e. it will only be used when LZO and ZLIB
> > are not selected to be included for UBIFS, for example when someone
> > compiles a minimal kernel who knows exactly which compression
> > algorithms will be used on that system.
>
> BTW: you can always select the compressor using the compr=3D mount option=
.
> Also for the default filesystem.

Yep that's what I'm using while I'm testing.

> Putting it at the end does not harm but IMHO the use is little.
> But for the sake of completes, I agree with you. Can you send a follow-up
> patch?

Ok

>
> > I did a single test today and compared lzo and zstd and on that test
> > lzo had faster decompression speed but resulted in larger space. I'll
> > do more tests later.
>
> Can you please share more details? I'm interested what CPU this was.

ARM Cortex-A7. The kernel is compiled with gcc 7.3.1. Next week I'll
test some more.
I have a question about how the decompression is done while reading.
When a large file is read from the filesystem (assuming not in any
cache), is it the case that first a chunk is read from flash, that
chunk is then decompressed, later next chunk is read from flash, that
one is then decompressed and so on, or can the decompression be done
in parallel while reading the next chunk from flash?

/Emil
