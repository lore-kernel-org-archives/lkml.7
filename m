Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B346C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2360A214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 23:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="FCWOt1t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfKGXWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:22:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38327 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfKGXWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 18:22:19 -0500
Received: from [IPv6:2601:646:8600:3281:ac8f:6015:6ba:e227] ([IPv6:2601:646:8600:3281:ac8f:6015:6ba:e227])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA7NKMfg1367689
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Nov 2019 15:20:24 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA7NKMfg1367689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1573168824;
        bh=uNbQFowrRqXhBohKSrYXwjHjXr0oEl9bBD2nzLbcE5E=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=FCWOt1t03s3DFteQ7ZNBuBfQ6XW7w3dh85SeSEmvgIlxenCdJLqOSnnAPFkCemjt4
         2yWbEWVQb/Hr2UbzJ1SPURxnbdxAgYizRXFP2ERM8cud/scsuuo3wA9+PKG8lbiVxY
         y37q+eWs9DTcSLFGlbKZYfsOgdZsI44s5W5quuOcFXa5uXAiexAi9N10t2UQUTQtAU
         oI5hz5XJOSKxPTw9rr+z9VBkKJMNJhD4XFnbtCe0t+5zbYII8rDqt7CJ3F9BY6QOBP
         ZE9u60ykiPMR7lET3Lj8LfafmW5fcCZz8WMhVIbZbb1+2df7Lv9e+w9K8SBWZNAWVQ
         L1OpxcGNF2qdA==
Date:   Thu, 07 Nov 2019 15:20:15 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.1911072223000.27903@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de> <CAMzpN2juuUyLuQ-tiV7hKZvG4agsHKP=rRAt_V4sZhpZW7cv9g@mail.gmail.com> <CAHk-=wiGO=+mmEb-sfCsD5mxmL5++gdwkFj_aXcfz1R41MJnEg@mail.gmail.com> <CAMzpN2gt4qM41=96GpNHL-kbgBsjD-zphq+5oK0BXqoCFN4F4Q@mail.gmail.com> <alpine.DEB.2.21.1911072223000.27903@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
From:   hpa@zytor.com
Message-ID: <8D806995-2FC5-4CE0-89D7-165D461D5242@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 7, 2019 1:32:15 PM PST, Thomas Gleixner <tglx@linutronix=2Ede> =
wrote:
>On Thu, 7 Nov 2019, Brian Gerst wrote:
>> On Thu, Nov 7, 2019 at 2:54 PM Linus Torvalds
>> <torvalds@linux-foundation=2Eorg> wrote:
>> >
>> > On Thu, Nov 7, 2019 at 11:24 AM Brian Gerst <brgerst@gmail=2Ecom>
>wrote:
>> > >
>> > > Here is a different idea:  We already map the TSS virtually in
>> > > cpu_entry_area=2E  Why not page-align the IO bitmap and remap it to
>the
>> > > task's bitmap on task switch?  That would avoid all copying on
>task
>> > > switch=2E
>> >
>> > We map the tss _once_, statically, percpu, without ever changing
>it,
>> > and then we just (potentially) change a couple of fields in it on
>> > process switch=2E
>> >
>> > Your idea isn't horrible, but it would involve a TLB flush for the
>> > page when the io bitmap changes=2E Which is almost certainly more
>> > expensive than just copying the bitmap intelligently=2E
>> >
>> > Particularly since I do think that the copy can basically be done
>> > effectively never, assuming there really aren't multiple concurrent
>> > users of ioperm() (and iopl)=2E
>>=20
>> There wouldn't have to be a flush on every task switch=2E  If we make
>it
>> so that tasks that don't use a bitmap just unmap the pages in the
>> cpu_entry_area and set tss=2Eio_bitmap_base to outside the segment
>> limit, we would only have to flush when switching from a task using
>> the bitmap (because the next task uses a different bitmap or we are
>> unmapping it)=2E  If the previous task doesn't have a bitmap the pages
>> in cpu_entry_area were unmapped and can't be in the TLB, so no flush
>> is needed=2E
>
>Funny=2E I was just debating exactly this with Peter Ziljstra over IRC :)
>=20
>> Going a step further, we could track which task is mapped to the
>> current cpu like proposed above, and only flush when a different task
>> needs the IO bitmap, or when the bitmap is being freed on task exit=2E
>
>Yes=2E
>
>But, we really should check what aside of DoSemu is using this still=2E
>None
>of my machines I checked have a single instance of ioperm()/iopl()
>usage=2E
>
>So the real question is whether it's worth the trouble or if we are
>just
>better off to copy if there is an actual user and the sequence count of
>the
>bitmap is different than the one which was active last time=2E
>
>Thanks,
>
>	tglx

I have written suffer using this, because of far better real time performa=
nce=2E I just want to punch a hole (just like mmapping an MMIO device=2E)

I do agree that let's not optimize for the rare case=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
