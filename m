Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74336C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E2F2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 21:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556573978;
	bh=Zj9xxx011OGk5FghX+GJ9PqQQX2m4l3ezBnglnFdH/U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ANZcz4LQunKOVZ9DVKh3lDHDBPMvm3lgqmSEuQIkvwe5OxdJ3DYBk3LN66xFYx/mT
	 d8W56pzOiXPgolKBiFhCzLttbpFwqJe5MBgHToNSzILCAS3fpqEWZHALhb/ex2/dIW
	 yVzmPXyQ8SIWjYXA7xm7W3k52gEEa8Mcp/BNgYLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbfD2Vjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 17:39:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38750 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729252AbfD2Vjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 17:39:36 -0400
Received: by mail-lj1-f193.google.com with SMTP id e18so4898146lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 14:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xn/5jS+m49YEHy9VewaGSeXNPslEqie8PTvJU6EXUNw=;
        b=hxFbqa4ewa41rSYJkjywqzmK/JSCoGBv9pbM0qVpY7Jcn8QmH+hVBPBdi7+D/zJmdk
         nmh191WRMCDQnlnOa+BZyyPstDYFCZkzpGRd0yKcaYhaQ9NmaL1Wd+MyXvvygdZSo+wh
         4K4v5k4yhv7oc8csttKN+MRZCq2FU2n6mdTIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xn/5jS+m49YEHy9VewaGSeXNPslEqie8PTvJU6EXUNw=;
        b=QpxnMYP4XDxxWgV0++z8R0nn9BpBQCGsR7g3FD6fhEqn42ckiuhRgW7EHE99dv6/et
         9QjENIIJsv08Yv9a5PKe67pFFGafbDsZvWAT28dBGnvC+lnYaNOKje4VhkQQR8EmLTzr
         +OtCvmkmJhqdf2ah/XuAviiLdfPrBlQwi9EKgnb51ciqy3DHY4C4U82lCvnOU9gLJVhH
         qCcMltpXAH/LRSvKPq/qz+clGWvCtJhFuA9N7/uYxZmv49U/C51BWrlwD8azNP9eh1nO
         QlQFNLqJ7GiTdJi6P6/BK3tEmptufppDN4XdB7CtC+Qr2SwvGTq8c/P/Sxp6MmHjvAlk
         +xDA==
X-Gm-Message-State: APjAAAUDKtGA77/VvWBz1mirguH6T5GJjd2gYc8fPapg5un9bmEu0ljT
        xykN6JF/1jgpkQB7VcHzRjkB3EggK1c=
X-Google-Smtp-Source: APXvYqz2+nE8gyiN2dh2WsShdX1xdJUq4UA5whZeCTwkCobtza0qV2ZA88FNovQw+jDjO8dtFf36JA==
X-Received: by 2002:a2e:7605:: with SMTP id r5mr12689234ljc.161.1556573974394;
        Mon, 29 Apr 2019 14:39:34 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id i64sm8165140lfe.18.2019.04.29.14.39.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:39:34 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id w23so9043877lfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 14:39:34 -0700 (PDT)
X-Received: by 2002:ac2:43cf:: with SMTP id u15mr3927622lfl.67.1556573506825;
 Mon, 29 Apr 2019 14:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com>
 <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com> <87zho8bl8x.fsf@oldenburg2.str.redhat.com>
In-Reply-To: <87zho8bl8x.fsf@oldenburg2.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 29 Apr 2019 14:31:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPv4QJBC0qX8xxnT5P2C7S5uDG0HKdvdSpcoXaHG91tQ@mail.gmail.com>
Message-ID: <CAHk-=wiPv4QJBC0qX8xxnT5P2C7S5uDG0HKdvdSpcoXaHG91tQ@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Jann Horn <jannh@google.com>, Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 1:38 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> In Linux-as-the-ABI (as opposed to Linux-as-the-implementation), vfork
> is sometimes implemented as fork, so applications cannot rely on the
> vfork behavior regarding the stopped parent and the shared address
> space.

What broken library does that?

Sure, we didn't have a proper vfork() long long long ago. But that
predates both git and BK, so it's some time in the 90's. We've had a
proper vfork() *forever*.

> In fact, it would be nice to have a flag we can check in the posix_spawn
> implementation, so that we can support vfork-as-fork without any run
> time cost to native Linux.

No. Just make a bug-report to whatever broken library you use. What's
the point of having a library that can't even get vfork() right? Why
would you want to have a flag to say "vfork is broken"?

                 Linus
