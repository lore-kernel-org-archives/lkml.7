Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A82CC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA487206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 00:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nNN/MavS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfCGAhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 19:37:00 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:37446 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfCGAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 19:37:00 -0500
Received: by mail-vs1-f67.google.com with SMTP id y19so3433673vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 16:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OIIL3avLv0JJGnmF3/9V3Uwq0jp+vCztotzjLKOlseY=;
        b=nNN/MavSBstEWMjJtBj+urYjYPVzNMcLp+GzbwXr/R9FOLMakEXdIIgT5E3foa5s3A
         WZ+2jYdp++JvXcbryxL6G+3k3QMa8x3t1G8LrsmlbneHggxzqCuiWCGrJ+Lyilu0WtAN
         UPrQ0zcnn6JUqXJuHwB7QFn4kTpByxx1jrhxU3O+UDzN03jz0bgdMjI/Wt63h5vwAXmp
         7IzlzTGKDPq7HYOB6jWx/KSAPdcc+gXWhtu/vNLD0qqJ1fLvDmwYEiF/nz5nNCgU5dlA
         Qe9Pl1Y3FhPBVsMR9eQ3vYLduITH5EAqKMx41C5FniJRsDXfLF1GzZ+YrLk2AM7Mx1j/
         5SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OIIL3avLv0JJGnmF3/9V3Uwq0jp+vCztotzjLKOlseY=;
        b=afujQaWCXhSBnKv9QP5gpn2k3+7lSpoE/9F/aNTGrwlMjfJDzBn/m0FMf7riGYDa0M
         cwgNJPGl3oAoLVNcK+xpHKSiXVnHvjTkV9fEEZrNCTA7jx3mh6N2ndxtIiHwe63uEYek
         b2kHv7Sk6cx9dGqG2/9OdlimUkEKZX+4t3ffJ3EePTLqFUB74APADAt3hsRva+PK3xns
         9lLycE38phsW6OIQMtcdBjhKAd7gwTT9oYqqWBC5Y5ba9U6mKOLTPsme5w1OMemzH31S
         vUK98rcmbKPsn8ehCQJjm3ojdEaUUJZTFkHJKIRFihV1RpyXgU22ZeKT8pZXP+Bk931T
         wvZw==
X-Gm-Message-State: APjAAAVRG3gHgZZ4d7XdhcNJstMMoWKW02poej/kMeELH6o1pjvjJbVp
        FTvJr/7tQ8a5NKxHicHgVtmahBttr5kwhs+jjIvyFQ==
X-Google-Smtp-Source: APXvYqzSV6GoNgm7u4vTZrTxWsEVpNN4HdHeDFqG/MFU3UdfeYewD6twZAQZv3ri1e3+0MGUpjnQ1GzBw67z0Sa4KOw=
X-Received: by 2002:a67:8448:: with SMTP id g69mr5396057vsd.77.1551919018224;
 Wed, 06 Mar 2019 16:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
 <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
 <20190119232503.GA149403@google.com> <78AACAF1-8EBF-4DF3-BE94-5B14E78BA791@zytor.com>
 <20190120155838.GA23827@google.com> <20190306230944.GB7915@amd>
 <CAKOZuetOePf89cXRkvmWeGnvG7zYN=SW1yyrZibuyOqZQFTGkg@mail.gmail.com> <2205470b-1efc-b357-8b2e-67392cf8bb2e@zytor.com>
In-Reply-To: <2205470b-1efc-b357-8b2e-67392cf8bb2e@zytor.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 6 Mar 2019 16:36:46 -0800
Message-ID: <CAKOZuet5+sbmtft-2s-bm07owTBP8+0yzP83_76tQM0xmfAamQ@mail.gmail.com>
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atish patra <atishp04@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 4:33 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 3/6/19 3:37 PM, Daniel Colascione wrote:
> >
> > I just don't get the opposition to Joel's work. The rest of the thread
> > already goes into detail about the problems with pure-filesystem
> > solutions, and you and others are just totally ignoring those
> > well-thought-out rationales for the module approach and doing
> > inflooping on "lol just use a tarball". That's not productive.
> >
>
> You might think they are well thought out, but at least from what I can
> tell they seem completely spurious.

That sentence is a general-purpose objection to literally anything.
Anything so general is useless. If you want to claim that the
rationale behind the work is inadequate, you have to explain why the
use cases that it enables are either illegitimate or amenable to other
solutions, not just call them spurious.
