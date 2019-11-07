Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB84C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6302087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 10:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CFISEveA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388034AbfKGKVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 05:21:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36933 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733286AbfKGKVn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 05:21:43 -0500
Received: from [IPv6:2601:646:8600:3281:ac8f:6015:6ba:e227] ([IPv6:2601:646:8600:3281:ac8f:6015:6ba:e227])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA7AJRLO1183002
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 7 Nov 2019 02:19:34 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA7AJRLO1183002
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1573121976;
        bh=AaGRA4knSHuQOz/lRQToqAJaFbs9AnO7FrD+GG16roo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=CFISEveAyfzOZeXhayycKsSpoGnXj8I/wJ4SvbZ0CNqUpyuCC1d0TL4XrEG1Z8zR0
         /V6A8WaRxSuSD2ke/y+dYMcBfYEeuVhHbSoReVXOtLvyE/XNtsah1+TUngIEZUiRkn
         dw9TFPGQlXaq4N+F6YLK3f97553iP4Cx3re8lJOSlY7625AkR1SoKM4CRnX9Wh7VQY
         yxUWypZh5duoczKTUHTzLR6qkB48OfI0UOnfd5Ym6SIQbcmpLwbxUwCkFSgFkJzGQX
         EvNckJbGJofEPA7AGm7LphFCGoeV7Y+Shnqq9TX+oscEWtrvvmmINEGX2ZCVPWeS6p
         cix0vXDiAeFRw==
Date:   Thu, 07 Nov 2019 02:19:19 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
References: <20191106193459.581614484@linutronix.de> <20191106202806.241007755@linutronix.de> <CAHk-=wjXcS--G3Wd8ZGEOdCNRAWPaUneyN1ryShQL-_yi1kvOA@mail.gmail.com> <20191107082541.GF30739@gmail.com> <20191107091704.GA15536@1wt.eu> <alpine.DEB.2.21.1911071058260.4256@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [patch 5/9] x86/ioport: Reduce ioperm impact for sane usage further
To:     Thomas Gleixner <tglx@linutronix.de>, Willy Tarreau <w@1wt.eu>
CC:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
From:   hpa@zytor.com
Message-ID: <71DE81AC-3AD4-47B3-9CBA-A2C7841A3370@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 7, 2019 2:00:27 AM PST, Thomas Gleixner <tglx@linutronix=2Ede> =
wrote:
>On Thu, 7 Nov 2019, Willy Tarreau wrote:
>> On Thu, Nov 07, 2019 at 09:25:41AM +0100, Ingo Molnar wrote:
>> > I=2Ee=2E the model I'm suggesting is that if a task uses ioperm() or
>iopl()=20
>> > then it should have a bitmap from that point on until exit(), even
>if=20
>> > it's all zeroes or all ones=2E Most applications that are using those
>
>> > primitives really need it all the time and are using just a few
>ioports,=20
>> > so all the tracking doesn't help much anyway=2E
>>=20
>> I'd go even further, considering that any task having called ioperm()
>> or iopl() once is granted access to all 64k ports for life: if the
>task
>> was granted access to any port, it will be able to request access for
>any
>> other port anyway=2E And we cannot claim that finely filtering accesses
>> brings any particular reliability in my opinion, considering that
>it's
>> generally possible to make the system really sick by starting to play
>> with most I/O ports=2E So for me that becomes a matter of trusted vs
>not
>> trusted task=2E Then we can simply have two pages of 0xFF to describe
>> their I/O access bitmap=2E
>>=20
>> > On a related note, another simplification would be that in
>principle we=20
>> > could also use just a single bitmap and emulate iopl() as an
>ioperm(all)=20
>> > or ioperm(none) calls=2E Yeah, it's not fully ABI compatible for
>mixed=20
>> > ioperm()/iopl() uses, but is that ABI actually being relied on in=20
>> > practice?
>>=20
>> You mean you'd have a unified map for all tasks ? In this case I
>think
>> it's simpler and equivalent to simply ignore the values in the calls
>> and grant full perms to the 64k ports range after the calls were
>> validated=2E I could be totally wrong and missing something obvious
>> though=2E
>
>Changing ioperm(single port, port range) to be ioperm(all) is going to
>break a bunch of test cases which actually check whether the permission
>is
>restricted to a single I/O port or the requested port range=2E
>
>Thanks,
>
>	tglx

This seems very undesirable=2E=2E=2E as much as we might wish otherwise, t=
he port bitmap is the equivalent to the MMU, and there are definitely users=
 doing direct device I/O out there=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
