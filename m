Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AEEC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1872A20659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573505242;
	bh=3zQMEK7OYr48r4YyOSUY29EhrSqUnXImkEn3hXa4OeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xhTOZovWFXD5ejXAMtRYb6N1nNUHPnHuncZUOpjeHKrYW8V2nbOBDXNhKhKjNvshW
	 nHvXHbnrMQjpMdt1zwLfQmnchn+7o+zEic4gKgwgBOcFK1cvoYYpqe9ImFHI0ziVrp
	 z+SlF8PLA5J7QQjFfuASoqnkBnhpcOIG0MfraB2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfKKUrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:47:21 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45305 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:47:19 -0500
Received: by mail-lj1-f193.google.com with SMTP id n21so15275955ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OaEDXSnozFKU9AfcCmi3n5mppwBp0l4bFT/aQieMhC0=;
        b=Zs8Zzq88VsL2T86KxW7IgVWl6ZhIIzNKAf9FuqchaKJtKHaYsoAYP+TPoclakBI6l3
         ljes5eRvglTxez5EmHsBrnpio1cu+VIFH8/TCGhqHn3GzE608nn3f94tnbKbNvbVffrZ
         6m3v2QDJ6S7Hl1KbBOeyM4E0K5JCKzaUiZKxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OaEDXSnozFKU9AfcCmi3n5mppwBp0l4bFT/aQieMhC0=;
        b=he3hLOk+aP+ohJZaoTDT5Bw2sxIobjlbZnz1d7gppdFWta2scjV2+VnOp5x1kwO361
         BoYCnAClVL2TriWcLLwaMj8HXcF5YO4O7JFMXtgWGmMONna9SBZAnZ0ZmD3hAY5vBdpE
         qmhC+TRjM2/+G7Gpx2LaWvoIuO6uZao7Gm6GUEyUdSvVzWX9jQImj9gvSfWwHzvt3guF
         1meoypsRSMSY2yu0+xCsAPJhNTcgk5au8p1NKR5boy0xSnc7fR++lP0tS5vzOVuuzjgj
         /dvNn0H735XRiM5Zx+TG01Rs+4LtYDHapXQ9n098KsRy9i86KGJ6yv6RXEG40JXlCxhQ
         aaag==
X-Gm-Message-State: APjAAAU+mPgY8fADSFVyL3GG1Mu6jDnwOvfzA79cyaZ7lTRpANJCpqmG
        RDZ0aSK3ymCwvwgTWlMc9AFTb5inmSo=
X-Google-Smtp-Source: APXvYqxPMU1H+06lAzEc2assGSH0uW78hGxUMg52WKZD0OkztfxIuVtB7YoVfbkJ47oQvIM4ALtCeQ==
X-Received: by 2002:a05:651c:238:: with SMTP id z24mr10301264ljn.36.1573505237219;
        Mon, 11 Nov 2019 12:47:17 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id 15sm7088090ljq.62.2019.11.11.12.47.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:47:14 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id d5so5782305ljl.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:47:14 -0800 (PST)
X-Received: by 2002:a2e:982:: with SMTP id 124mr9131365ljj.48.1573505233789;
 Mon, 11 Nov 2019 12:47:13 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CANn89i+x7Yxjxr4Fdaow-51-A-oBK3MqTscbQ4VXQuk4pX9aCg@mail.gmail.com> <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com>
In-Reply-To: <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 12:46:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whWNkk7vCQr7LLshcB6B_=ikmpMXQ7RtO2FyDx-Np_UKg@mail.gmail.com>
Message-ID: <CAHk-=whWNkk7vCQr7LLshcB6B_=ikmpMXQ7RtO2FyDx-Np_UKg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Eric Dumazet <edumazet@google.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
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

On Mon, Nov 11, 2019 at 12:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, maybe we could have some model for marking "this is statistics,
> doesn't need to be exact".

Side note: that marking MUST NOT be "READ_ONCE + WRITE_ONCE", because
that makes gcc create horrible code, and only makes the race worse.

At least with a regular add, it might stay as a single r-m-w
instruction on architectures that have that, and makes the quality of
the statistics slightly better (no preemption etc).

So that's an excellent example of where changing code to use
WRITE_ONCE actually makes the code objectively worse in practice -
even if it might be the same in theory.

                Linus
