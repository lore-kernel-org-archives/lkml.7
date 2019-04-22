Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14F6C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92C01214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555950834;
	bh=kfIcnxKvqoQ8S/q2CBsY7jfi/O92sQ/nQh33ZlA5XR8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k5JzbPXC9mJBMzy3PFD1fejT1WASHWpKrJyKWms4i4nAdEjSO2Kw8SknMsEnssL0p
	 jOLImnbx0XgkZxaT8ClGJh9zc9VQpS2G/MDZ6xZuf3BRlUZPksBkuIXoOUq7Eu7+Nd
	 yH+B6lyU22xAMUWtmANCuXhl470rovS5+ksEH2i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfDVQdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:33:53 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:33730 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfDVQdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:33:52 -0400
Received: by mail-lf1-f45.google.com with SMTP id j11so9416205lfm.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 09:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fehd6cWonKO2WJxaw8cPP4qBfU61mSuWXXGtQiq40Us=;
        b=VlWHTpciCrw/OJCBlw1zce2W9q5v+eNGC+pBmsyhOxfbTzMjB8phJ5lZX8PGq9UwPX
         HVxH3usdHGv7SQS9UbMGk3kuK7G5yAdfYFbSb38lV+7rJwcw/6wggDMrLeUmvMZMj1CT
         DR+2GIz8Qg8/SKDedS38j34hOh+rvpgRbMtLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fehd6cWonKO2WJxaw8cPP4qBfU61mSuWXXGtQiq40Us=;
        b=OYV8aM7+Oml0KUnB0Gk2Dl/CSpY+AJH09nI8Tzh75A/zK0QM0JdKf+hPET7gZwuUBS
         CFo9uNtZ3SPSzsD1D6ifSJxugj/bT+g/wkzAClkwg/mb8l4I/fBL+z64j+Ml26RMIFtx
         H3eBKkJ8ETbicPfgfhoVBjbKqn9/5FgcPoBAUB6pBAFezuLrtsob3NznKXZM5wGM0mUD
         jqHKsGIeHscpzEkT/w0BlbSzlNNieE+OLQhM6bJxHZ3AytF27K55Ovvv7UV9mRIfvx//
         VIWjtxgr8WSUfJ66/7t612SsREiYrsfR9HbCeGGbgLBNyNzO+SqIcA6biJK4shiXPH/t
         BAzA==
X-Gm-Message-State: APjAAAXiSML0HN98sDsmKzat7AAhPZyk9hVpNcKIZZXf15YWQB75EelJ
        xJhAgWJS8FIr6NffxO6z/zjLjMqOKSg=
X-Google-Smtp-Source: APXvYqzWp8oVlMoEjDObXfd1oC2VjS+iYt+3eSNCLr5uNpHbahWVw7CUz9SXqPXjtM6zBwB6VdoMwA==
X-Received: by 2002:ac2:5a11:: with SMTP id q17mr10821994lfn.145.1555950830183;
        Mon, 22 Apr 2019 09:33:50 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m14sm45430ljj.75.2019.04.22.09.33.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:33:49 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id o19so9422366lfl.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 09:33:49 -0700 (PDT)
X-Received: by 2002:ac2:547a:: with SMTP id e26mr10716923lfn.148.1555950494590;
 Mon, 22 Apr 2019 09:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000043fe9c058720a5d3@google.com> <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
In-Reply-To: <ad884b18-0e03-d6be-02b0-4e5273f068ce@kernel.dk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Apr 2019 09:27:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
Message-ID: <CAHk-=wgG=RqK8T5kWiZfH7da6rBuqp3kAesP=ETgceb6RzvZng@mail.gmail.com>
Subject: Re: WARNING in percpu_ref_kill_and_confirm
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+10d25e23199614b7721f@syzkaller.appspotmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Crossed emails ]

On Mon, Apr 22, 2019 at 9:23 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> I think the below should fix this. Very early versions of io_uring didn't
> have this issue, since we did the percpu ref tryget for io_uring_register().

Ok, so I like your patch better than mine, but note how syzbot
bisected this to the initial merge of the io_uring code.

I agree that code shouldn't have had this particular issue, but it
looks like it does.

Is there some way to race with io_ring_ctx_wait_and_kill(), which
_also_ does that ref_kill() thing? I'm not seeing how that could
happen, but maybe if the file ref counts get screwed up you have
->release() called early..

                  Linus
