Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67416CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 358A5214AF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 23:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572735768;
	bh=hSnc0yPJA8Fxvg0HGf9jnQyd2Q40taHnv9Z4Kk4uSHw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vp1SyQ7K6s35lCdgKBTgtPxJuQbNIz88QCAQxDh3PKnJT7A/UTlHFyQ4N4niTwBje
	 abd2caaGyZk7jZ2HUUWH+QIRYf+SChwPBuESLCnWhnyeQCj5RgXtrr21A1/bfP9e4Y
	 TVn5+NF20C/eS5YsdpOWjCPuYUo93BPI8oJn+C8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKBXCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 19:02:36 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38295 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727327AbfKBXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 19:02:36 -0400
Received: by mail-lf1-f67.google.com with SMTP id q28so9652759lfa.5
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KYWG+PndMaavSEZTx4tAuPjrZgeMNS1BkWduXMUhlSE=;
        b=NAZiBqRMuLwp18H/qmyeCQUJQSMxLgfDNPb3RDjIM2NaIkVQsPt1S/xuDnF8dcUBgf
         3fZo55nc7Bm/xxbjy/0YjqR9D8Xzg3aKB55yv1y8UMISn+S9dO18XBNHs4wlB45hKZ6I
         TFCoEmlRYzmfAjujVacuTPfMhwBZ5xf+j+Mkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KYWG+PndMaavSEZTx4tAuPjrZgeMNS1BkWduXMUhlSE=;
        b=BrMC1b+fcDNuCXEabXXc4gWO1X7/HTsyPkAywCqikPuo6AB0h/h2KUy/6wHrZee/Zc
         M7JASNU72OHMC1xAKHYelyn9POtbIUU6GdTJfRRxGQa+K5Ikn/1kEpZ+0ph+t8EEkpEB
         K85E7fkP90+5yvMq1TjOH+/rrwUe5fUG7mYdstF1ztqKWE3uTT4SWSZIQBNbh9xtKLRb
         nhRfqdjbUGNdc35vsGgK2sKVwFHh5MwdG0qev8pWC/gc56bscPMQaTsyEG4+nEt0ScJy
         MkfwUBhxE1v4Q3ZYlHJyHVDZwg5Fo1PV0w22bkxMZP0bo22QwvCRwS04jUH2O8gpKOwt
         9XdA==
X-Gm-Message-State: APjAAAUr5pSaV2lCvvZ68dwtRjMGVWKEUl8FfscWfFOXB1PegLwzlIVa
        ZKuvqLoFRdhz+6YpT1MDD8tfesDJdUc=
X-Google-Smtp-Source: APXvYqwM75tukL+s3RbgyUc/zxcnwoO5IHcJFttDV3lIKx3mHDyuBVCf3qnYLOVPDbrY6lI68knoag==
X-Received: by 2002:a19:3fcd:: with SMTP id m196mr11933626lfa.118.1572735752645;
        Sat, 02 Nov 2019 16:02:32 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id n10sm1369946lfe.86.2019.11.02.16.02.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Nov 2019 16:02:29 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v2so13771195lji.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2019 16:02:29 -0700 (PDT)
X-Received: by 2002:a2e:819a:: with SMTP id e26mr10124866ljg.26.1572735749049;
 Sat, 02 Nov 2019 16:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj1BLz6s9cG9Ptk4ULxrTy=MkF7ZH=HF67d7M5HL1fd_A@mail.gmail.com>
 <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
In-Reply-To: <E590C3AF-1D09-4927-B83F-DD0A6A148B6D@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 2 Nov 2019 16:02:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
Message-ID: <CAHk-=wgzRU9RjkZG0L9_yrnFN69REkrSokTQOGZMUkvdispvuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 11/10] pipe: Add fsync() support [ver #2]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 2, 2019 at 3:30 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> So you allocate memory, vmsplice, and munmap() without reusing it?

You can re-use it as much as you want. Just don't write to it.

So the traditional argument for this was "I do a caching http server".
If you don't ever load the data into user space at all and just push
file data out, you just use splice() from the file to the target. But
if you generate some of the data in memory, and you cache it, you use
vmsplice().

And then it really is very easy to set up: make sure you generate your
caches with a new clean private mmap, and you can throw them out with
munmap (or just over-mmap it with the new cache, of course).

If you don't cache it, then there's no advantage to vmsplice() - just
write() it and forget about it. The whole (and only) point of
vmsplice() is when you want to zero-copy the data, and that's
generally likely only an advantage if you can do it multiple times.

But I don't think anybody actually _did_ any of that. But that's
basically the argument for the three splice operations:
write/vmsplice/splice(). Which one you use depends on the lifetime and
the source of your data. write() is obviously for the copy case (the
source data might not be stable), while splice() is for the "data from
another source", and vmsplace() is "data is from stable data in my
vm".

There's the reverse op, of course, but we never implemented that:
mmap() on the pipe could do the reverse of a vmsplice() (moving from
the pipe to the vm), but it would only work if everything was
page-aligned, which it effectively never is. It's basically a
benchmark-only operation.

And the existence of vmsplice() is because we actually had code to
play games with making write() do a zero-copy but mark the source as
being COW. It was _wonderful_ for benchmarks, and was completely
useless for real world case because in the real world you always took
the COW fault. So vmsplice() is basically a "hey, I know what I'm
doing, and you can just take the page as-is because the source is
stable".

             Linus
