Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F364C206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfCKSI2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:08:28 -0400
Received: from unicorn.mansr.com ([81.2.72.234]:35172 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfCKSI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:08:27 -0400
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 5288814CEA; Mon, 11 Mar 2019 18:08:25 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matt Turner <mattst88@gmail.com>, Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch\/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] x86: Deprecate a.out support
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
        <20190305091904.GB8256@zn.tnic>
        <20190305122218.GD13380@bombadil.infradead.org>
        <20190305134347.4be2449c@alans-desktop>
        <20190305145717.GD8256@zn.tnic>
        <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
        <20190305173134.GE8256@zn.tnic>
        <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
        <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
        <CAEdQ38G5M3vq9pGBV1iyEViO7JhFuXk5g+VCs-vUH+Z62kNqgQ@mail.gmail.com>
        <CAHk-=wgt7M6yA5BJCJo0nF22WgPJnN8CvViL9CAJmd+S+Civ6w@mail.gmail.com>
        <yw1xa7i14btw.fsf@mansr.com>
        <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
Date:   Mon, 11 Mar 2019 18:08:25 +0000
In-Reply-To: <CAHk-=whD1SumZUBQeuMT-GcciwPxg_jW_TsPAmokYp3sGGCGhA@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 11 Mar 2019 09:45:32 -0700")
Message-ID: <yw1x5zsp473a.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Mar 11, 2019 at 9:26 AM Måns Rullgård <mans@mansr.com> wrote:
>>
>> Anyone running an Alpha machine likely also has some old OSF/1 binaries
>> they may wish to use.  It would be a shame to remove this feature, IMO.
>
> If that's the case then we'd have to keep a.out alive for alpha, since
> that's the OSF/1 binary format (at least the only one we support - I'm
> not sure if later versions of OSF/1 ended up getting ELF).

The latest version I have is 5.1, and that uses ECOFF.

> Which I guess we could do, but the question is whether people really
> do have OSF/1 binaries. It was really useful early on as a source of
> known-good binaries to test with, but I'm not convinced it's still in
> use.
>
> It's not like there were OSF/1 binaries that we didn't havce access to
> natively (well, there _were_ special ones that didn't have open source
> versions, but most of them required more system-side support than
> Linux ever implemented, afaik).

I don't have any specific examples, but I can well imagine people
keeping an Alpha machine for no other reason than the ability to run
some (old) application only available (to them) for OSF/1.  Running them
on Linux rather than Tru64 brings the advantage of being a modern system
in other regards.

For anything open source, there's little reason to keep the Alpha at
all.

-- 
Måns Rullgård
