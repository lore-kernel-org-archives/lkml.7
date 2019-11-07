Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44292C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0E2214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="UiUMtlqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387917AbfKGKwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:52:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57227 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727528AbfKGKwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:52:18 -0500
Received: from [IPv6:2601:646:8600:3281:ac8f:6015:6ba:e227] ([IPv6:2601:646:8600:3281:ac8f:6015:6ba:e227])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA7AoRDw1190819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Nov 2019 02:50:28 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA7AoRDw1190819
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1573123828;
        bh=xjHsNjx3y7WGORGoGD9WB7uagne++HGfQiBOzl7OELY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=UiUMtlqRiId81RDJjjcPVf4gTOcGEIzJ+mXMcajzvrJE4FGs5ueGbvy2Ts0ZXZQzC
         /bKEPhhg4TrchWdA0/K0fSoxoPCM8dkAlDFBSfKXdYB4QYb0rc9p2wGNOpgE8b+8e5
         ZkwMuF1JK5s2yKxFv9BhhQlqX7PdJFtgaGK02DKW7Dg8F8bYmLD5IlxyfVNGXbNpvi
         SbFE96WpBjGVSkCGvf6EdkL6HYwTGuC58bKawBtVpJeqVHL/DXY7v9OpY5/JcMc2zu
         1EYT7N6BPMdwN9CNrbc9NHCU9U4GCwct6upi9PMGgLNaREcYjqcuoA0X8LI5IC9xF6
         3cEd4me0NO4qQ==
Date:   Thu, 07 Nov 2019 02:50:20 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20191107102756.GD15536@1wt.eu>
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de> <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com> <20191107082541.GF30739@gmail.com> <20191107091704.GA15536@1wt.eu> <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de> <71DE81AC-3AD4-47B3-9CBA-A2C7841A3370@zytor.com> <20191107102756.GD15536@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     Willy Tarreau <w@1wt.eu>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
From:   hpa@zytor.com
Message-ID: <5AAEF116-EC9D-4C58-878F-9D27189E123A@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 7, 2019 2:27:56 AM PST, Willy Tarreau <w@1wt=2Eeu> wrote:
>On Thu, Nov 07, 2019 at 02:19:19AM -0800, hpa@zytor=2Ecom wrote:
>> >Changing ioperm(single port, port range) to be ioperm(all) is going
>to
>> >break a bunch of test cases which actually check whether the
>permission
>> >is restricted to a single I/O port or the requested port range=2E
>> >
>> >Thanks,
>> >
>> >	tglx
>>=20
>> This seems very undesirable=2E=2E=2E as much as we might wish otherwise=
,
>the port
>> bitmap is the equivalent to the MMU, and there are definitely users
>doing
>> direct device I/O out there=2E
>
>Doing these, sure, but doing these while ranges are really checked ?
>I mean, the MMU grants you access to the pages you were assigned=2E Here
>with the I/O bitmap you just have to ask for access to port X and you
>get it=2E I could understand the benefit if we had EBUSY in return but
>that's not the case, you can actually request access to a port range
>another device driver or process is currently using, and mess up with
>what it does even by accident=2E I remember streaming 1-bit music in
>userland from the LED of my floppy drive in the late-90s, it used to
>cause some trouble to the floppy driver when using mtools in parallel
>:-)
>
>Willy

You get access to the ports you are assigned, just like pages you are assi=
gned=2E=2E=2E the rest is kernel policy, or, for that matter, privileged us=
erspace (get permissions to the necessary ports, then drop privilege=2E=2E=
=2E the usual stuff=2E)

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
