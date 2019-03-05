Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E289C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF7BA2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 16:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jvBnX9zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfCEQal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 11:30:41 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42289 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbfCEQal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 11:30:41 -0500
Received: by mail-ot1-f67.google.com with SMTP id i5so7928692oto.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2019 08:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEQk04XL5PKf0YI4oJPFIaQIVja34n2keKTOPYEH3So=;
        b=jvBnX9zvFRV4mMzcId2VgMamgPmCBS6nelLomGQEsMvUxLzQqKT9DGzz7pF0kwGMX6
         iMxSZQVaQVn3TcsJonfMTvdhQu32v1B4qtzFXOqH6wLni94asXO48604fONvEWWr19fK
         tv1c90jtiYzIauyUN6d7wvw07Bdl9N0P9Z66PY1QJPg8fm01YRMyl5SCfng9bxCS/c8M
         sXvDHakEhHRKJ2xuE7MCW9CHtfn9RS4z5y/fUwftZ4cbI64um6NnmPZdWbVUx+AlmgMH
         mqGyL3oMdfYEuJUu1bGvTdVc59wmPZNBuOIoSznsufHaoWv6CJVcPwE7E2eYpCjqka9u
         rBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEQk04XL5PKf0YI4oJPFIaQIVja34n2keKTOPYEH3So=;
        b=KcQBumSK55QuesPUtq9X+UirSN2VhDQn0xe/i97W8XzvZlISrfAQkEEerAU97RZnzS
         nVKfocI7nCp/m5k7R9FA9WwO/DhPRcZVnmmcipqtAgIjoM1MGaBY6jetGUuTaGOUZkRI
         9j+n6qUKmaCmwH2Zay0UvD6JmpkxD9Xwb5sl1/OGKDjSoN/5byrWXLT7dkkMHZo+WroT
         WdXZEj3TdGGVWT5VCJoCl/KnrcvSKOiVPPVIdJvw3UYYroUqyECGK2uCnNk97+QkhGh1
         Rola+Yt67vv/T3f6iKYQAoby8JSSTymfVbwGUA2pySbNVVrMYg2LhDigaKHR2T8bP+KN
         vtuw==
X-Gm-Message-State: APjAAAX7oOlYcR/56isY0jf1sKibHo1eYLQSy+ZXn+NBrg/l/0lwbt/o
        ECB4ZYc/KuXHVrY/ssUF/5ABlYtOvpb39SOps230CyzEq3E=
X-Google-Smtp-Source: APXvYqxzzk5tODtH0Qyb046uvT0nyP6wyWEAMGyfoyBG8YxIZSalA5Bj4fkjrltAp27DOHke6TAZPsdkR6aPMtiqJ8E=
X-Received: by 2002:a9d:6c84:: with SMTP id c4mr1496349otr.242.1551803439888;
 Tue, 05 Mar 2019 08:30:39 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic> <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
In-Reply-To: <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 Mar 2019 17:30:13 +0100
Message-ID: <CAG48ez0=AWipDy+aDBtxwEs6h8AmiBnfoU7GMi=_yW3sS14MNQ@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 5:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 5, 2019 at 6:59 AM Borislav Petkov <bp@alien8.de> wrote:
> > We can at least deprecate it on x86...
>
> I'd prefer to try to deprecate a.out core dumping first.. That's the
> part that is actually broken, no?
>
> In fact, I'd be happy to deprecate a.out entirely, but if somebody
> _does_ complain, I'd like to be able to bring it back without the core
> dumping.
>
> Because I think the likeliihood that anybody cares about a.out core
> dumps is basically zero. While the likelihood that we have some odd
> old binary that is still a.out is slightly above zero.
>
> So I'd be much happier with this if it was a two-stage thing where we
> just delete a.out core dumping entirely first, and then deprecate even
> running a.out binaries separately.
>
> Because I think all the known *bugs* we had were with the core dumping
> code, weren't they?
>
> Removing it looks trivial. Untested patch attached.

We might want to also delete the then-unused aout_dump_thread()
implementations from the various arch trees. We probably want to
delete arch/*/include/asm/a.out-core.h, since that seems to be the
only thing these headers do, and the only thing that uses them is
fs/binfmt_aout.c?
