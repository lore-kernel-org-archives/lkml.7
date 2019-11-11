Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CB7C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D020A206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 16:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573491090;
	bh=3aqSNLMkAfhr0ckS4Z72CoVXhjDAGn4IU4b+uZjqr2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=J7OQT0TxzOL+V/v5ewMBeGETOWThuL+pvSDek4lAapnqP0jL3YmD7xi01pz8OZvfg
	 cYbsfcBwhzBBYeiSw3My2lhLxZ1UbFXkzTGH77awHrWzU16NUuIyw+zbakZix927yx
	 4cudRGFjtBHRZCNgr4mMM7De1VPvhG9TV0QNQU6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKKQv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:51:29 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:46187 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfKKQv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 11:51:28 -0500
Received: by mail-lj1-f178.google.com with SMTP id e9so14528141ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aeNceNPo4fD73RiaH/hTBoQsDr0kmiNbYJTGEnnIYNQ=;
        b=JmJIJEsYG9Wpj4YU/56e8ykDzFdN2fR4vGH46xHy3bkh2I24Hnn5R/34gNiaGVe8A0
         +rVGaLTkWv6CwWmzdAT4f5P6hMwCoAq6LfbYEKOIFQw5NJ+7EEWplIoj/gNrKAbvmwqO
         i4JZsCoqZ1wP4f7j3+yTHe9LMpjypC2/CgyEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aeNceNPo4fD73RiaH/hTBoQsDr0kmiNbYJTGEnnIYNQ=;
        b=etvBGZ/vrY4/y7WcIjy56ZcYFUOe4DKj4WyE5EPzDhdB4BG3NteUeGc0XzJu7br4rv
         pWFInugFRmQEWTMOFX5ni1Z6fOY8gzDEe6G5OQt617/HVcoBpZPFYXb5/BeLLxKczeAW
         G7suqgaX0d7Z1TZaWGEgWBDZmS63nlB5EFQrDXOxOo0MlbyVNxUnFtkVyRRnJ7f7+jLc
         /a9VSoOLmdTxVbHRf651f8yvBtELsAWs7m+8Q2+27HG5aqyHg70OLQdVclyFhdqyLzEt
         Mhgjv83NV56/GBw0dJUTkITGrQtZMaV28ZrQ288lrlN4OOU14u/arNIz73jUX52QJT6Y
         mZBg==
X-Gm-Message-State: APjAAAViF2djJvnPPKC5+dGDSC+nfvJe2xDeYuxts5a0ZpchSSqIhhLL
        iyvjCAvltH+ZvDhHlMzVhYzwmb2Ly30=
X-Google-Smtp-Source: APXvYqwNN0uSXY75JyHXwIUvgn3qFq9E6trQozbCkrN2heMebG3IuXq1MzZAGXYtMiHAGSZu8hI6fg==
X-Received: by 2002:a2e:558:: with SMTP id 85mr17098922ljf.67.1573491085037;
        Mon, 11 Nov 2019 08:51:25 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 68sm8575423ljf.26.2019.11.11.08.51.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 08:51:23 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id q2so14578930ljg.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 08:51:23 -0800 (PST)
X-Received: by 2002:a2e:8809:: with SMTP id x9mr16952774ljh.82.1573491083270;
 Mon, 11 Nov 2019 08:51:23 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 08:51:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
Message-ID: <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Marco Elver <elver@google.com>, Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 7:51 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> I dislike the explicit annotation approach, because it shifts the
> burden of proving correctness from the automatic verifier to the
> programmer.

Yes.

However, sometimes explicit annotations are very useful as
documentation and as showing of intent even if they might not change
behavior or code generation.

But they generally should never _replace_ checking - in fact, the
annotations themselves should hopefully be checked for correctness
too.

So a good annotation would implicitly document intent, but it should
also be something that we can check being true, so that we also have
the check that reality actually _matches_ the intent too. Because
misleading and wrong documentation is worse than no documentation at
all.

Side note: an example of a dangerous annotation is the one that Eric
pointed out, where a 64-bit read in percpu_counter_read_positive()
could be changed to READ_ONCE(), and we would compile it cleanly, but
on 32-bit it wouldn't actually be atomic.

We at one time tried to actually verify that READ/WRITE_ONCE() was
done only on types that could actually be accessed atomically (always
ignoring alpha because the pain is not worth it), but it showed too
many problems.

So now we silently accept things that aren't actually atomic. We do
access them "once" in the sense that we don't allow the compiler to
reload it, but it's not "once" in the LKMM sense of one single value.

That's ok for some cases. But it's actually a horrid horrid thing from
a documentation standpoint, and I hate it, and it's dangerous.

                Linus
