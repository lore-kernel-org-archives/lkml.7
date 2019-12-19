Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E54C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449F424672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 14:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4JdQxLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfLSOaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 09:30:17 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34571 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfLSOaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 09:30:15 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so5205705qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 06:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0yYV/zgiGoFwELUZOcLeBECeRrqa1TZpxKzwpeVoiM=;
        b=X4JdQxLB8A+xTSDcWAFSXvHAsV/pLYvfJ/9CRK25ABgDGZhLlUNXsFVT7NELZzD2xc
         xyiH63onBkOj2Vc5LVvsXgNy+c0QnawRjs2Wa7mv43P7vl7dLWB+V2XrpFJycD8gF0c/
         6ZeRZwpFojktTqadOnqqrO4nQBjLmKxim1e6Fp5XlR3TMcp/Hmg6hRC+fCA4eu0xG0St
         jXcBdBo74M0MPEd0Uc92fsWcYlOzykcDaKYA++0lM4jsh0NOD47Yh89ftDpMUlU7Nu7o
         kH5+GdBoZIkndyX2iPcAT4xAHCYTfsl52oJaXjVG48eWgFiDOQ9h2fGCAoGRh2+PtvSJ
         XFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0yYV/zgiGoFwELUZOcLeBECeRrqa1TZpxKzwpeVoiM=;
        b=mUUX0mJHFrUwMNQJQAGH5duC3x4T40ArrZzQX5njjWXGJJemH2NEYWA+elbFncfjk+
         1bU9HAtqLo6kj8rgOOEe2Ukrk0x+ex4t3q68yrAw/ImMeTvgGxGrHjcJnWtlmCulONgm
         BrnQuf0pQvpzgK7SizfBSpKlwpnuIMgg2DEaM2D7YziU853sHactT8RyogU/LV8t/Ict
         wVQLNAjlvO2vixs5L772LfYfcnQUmJ+14bkoMeZPiKCtqQjMQH93PI7sztJKTdKDeJtK
         6oAfXLzMyqT5JQ+DsBKC24Yc1cFoBWLL0HqhHnQ+tLkvCBFXJ7WMplGdGzpCkdp939RE
         Yl/w==
X-Gm-Message-State: APjAAAVLSiebaotzJeku9msHB9AhC2Du7AWWEd97CC2V6ODq5SolrjWA
        u7D1v3EnwMi01Sjo73ozJNIzaIBaF+9xYIuuknB8xSzDM6A=
X-Google-Smtp-Source: APXvYqx2rbIcbJPMtKA8mB0LRxssvTcYJ7Y3aCPioQXeqEB2WqVQOig7co6LAUz4OQZd1ryt9r5uOcZQIwZorIPSu2c=
X-Received: by 2002:aed:2465:: with SMTP id s34mr7287340qtc.158.1576765813772;
 Thu, 19 Dec 2019 06:30:13 -0800 (PST)
MIME-Version: 1.0
References: <20191208232734.225161-1-Jason@zx2c4.com> <CACT4Y+bsJVmgbD-WogwU=LfWiPN1JgjBrwx4s8Y14hDd7vqqhQ@mail.gmail.com>
 <CAHmME9o0AparjaaOSoZD14RAW8_AJTfKfcx3Y2ndDAPFNC-MeQ@mail.gmail.com>
 <CACT4Y+Zssd6OZ2-U4kjw18mNthQyzPWZV_gkH3uATnSv1SVDfA@mail.gmail.com>
 <CAHmME9oM=YHMZyg23WEzmZAof=7iv-A01VazB3ihhR99f6X1cg@mail.gmail.com>
 <CACT4Y+aCEZm_BA5mmVTnK2cR8CQUky5w1qvmb2KpSR4-Pzp4Ow@mail.gmail.com>
 <CAHmME9rYstVLCBOgdMLqMeVDrX1V-f92vRKDqWsREROWdPbb6g@mail.gmail.com>
 <CAHmME9qUWr69o0r+Mtm8tRSeQq3P780DhWAhpJkNWBfZ+J5OYA@mail.gmail.com>
 <CACT4Y+YfBDvQHdK24ybyyy5p07MXNMnLA7+gq9axq-EizN6jhA@mail.gmail.com>
 <CAHmME9qcv5izLz-_Z2fQefhgxDKwgVU=MkkJmAkAn3O_dXs5fA@mail.gmail.com>
 <CACT4Y+arVNCYpJZsY7vMhBEKQsaig_o6j7E=ib4tF5d25c-cjw@mail.gmail.com> <CAHmME9ofmwig2=G+8vc1fbOCawuRzv+CcAE=85spadtbneqGag@mail.gmail.com>
In-Reply-To: <CAHmME9ofmwig2=G+8vc1fbOCawuRzv+CcAE=85spadtbneqGag@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 19 Dec 2019 15:30:02 +0100
Message-ID: <CACT4Y+awD47=Q3taT_-yQPfQ4uyW-DRpeWBbSHcG6_=b20PPwg@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: WireGuard secure network tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2019 at 12:38 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> On Thu, Dec 19, 2019 at 12:19 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > Ahh, cool, okay. Netlink, device creation, and basic packet structure
> > > is a good start. What about the crypto, though?
> >
> > It depends. What exactly we need there?
> > syzkaller uses comparison operand interception which allows it e.g. to
> > guess signatures/checksums in some cases.
>
> I don't think you'll have too much luck with WireGuard here. Fuzzing
> your way to a valid handshake message involves guessing the 4th
> preimage of some elliptic curve scalar multiplication, with some
> random/changing data mixed in there every time you make a new try.
> There's a condensed protocol description here which should be less bad
> to glance at than the academic paper:
> https://www.wireguard.com/protocol/#first-message-initiator-to-responder
> . The fuzzers I've written for the crypto bits of WireGuard always
> involve taking a complete handshake implementation and mutating things
> from there. So maybe the "outer packet" won't be too fruitful without
> a bunch of work. At the very least, we can generate packets that have
> the right field sizes and such, and that should test the first level
> of error cases I guess.

Yes, properly formed packets will probably require some procedural support.
I can't say right away which exactly extension mechanism in syzkaller
is the best for this.
But there is another one I forgot to mention - custom pseudo syscalls.
For the generic fuzzer engine they look like normal syscalls that
accept/return something:
https://github.com/google/syzkaller/blob/36650b4b2c942bc382314dce384d311fbadd1208/sys/linux/vnet.txt#L26
but the actual implementation is our custom C code that can do
anything (augment data, form packets, call multiple syscalls, take
result of one syscall, do something with it and use as argument for
another, etc):
https://github.com/google/syzkaller/blob/36650b4b2c942bc382314dce384d311fbadd1208/executor/common_linux.h#L972-L1023
These make doing a complex thing trivial for fuzzer, but the more is
hardcoded there, the less randomness we get from fuzzing (though that
presudo-syscall can also accept some additional randomness and use it
in some way).



> However, there's still a decent amount of surface on the "inner
> packet". For this, we can set up a pair of wireguard interfaces that
> are preconfigured to talk to each other (in common_linux.h, right? Or
> do you have some Go file that'd be easier to do that initialization
> in?), and then syzkaller will figure out itself how to send nasty IP
> packets through them with send/recv and such. There's a bit of surface
> here because sending packets provokes the aforementioned handshake,
> and also moves around the timer state machine. The receiver also needs
> to do some minimal parsing of the received packet to check
> "allowedips". So, good fodder for fuzzing.

Yes, there is this location to pre-create some net devices in right states:
https://github.com/google/syzkaller/blob/79b211f74b08737aeb4934c6ff69a263b3c38013/executor/common_linux.h#L668
(not in Go, but in C because eventually it will become part of C reproducers).
For example it creates vcan0 device and then syscall descriptions know
this name and use it.
