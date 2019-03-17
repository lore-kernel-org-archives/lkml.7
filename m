Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D1CC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234932087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552840528;
	bh=hY0cRlqP6mrRAqGYm7UL1g03Ausu68ntfsBU8bXi3d8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Sk4bIYtpnAQoGrdlIS6JjNsPUXKDgs2CoMMIW/ccq/ugt4DGlTwOTX6rsNdTgY0bm
	 lmvTp+zmaHzUkjpHomRwzzINxx1jAneCN+7+jB3FOXIaSY3JHhlmeS+LKkE39kXB7Q
	 dJ6EVm/DUn94JlDhmugV0DLxhE8GsBDVzPhtABz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfCQQf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:35:26 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:38185 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfCQQfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:35:23 -0400
Received: by mail-lj1-f182.google.com with SMTP id x13so11886546ljj.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Lf3U1XdQWa3yMAD7V43VAz3JgxkZo6Z32jdZoT2Yig=;
        b=DfZ3BJd6LTAmwRVqj7BLIaxh7yuigvmKiH39h80K7yrdnXV+k7698Sa4ME3L0eCUxe
         Pg8+iSVEpoOfSqLsgGEuG3suCyJ9hsGxx5uCpfV7QE1rLBpCWr8uttHWyruLpM9FCG75
         yHdGHVkMcNmqxh9A3qh1vCMUKoOt5DefIkzTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Lf3U1XdQWa3yMAD7V43VAz3JgxkZo6Z32jdZoT2Yig=;
        b=gOIsg2CeDreuaoYegx6YpHMU6Mr0xTOj8xO4Cp3Vkn7SSf65gULJAwZHejPbNQjNJx
         gGXE9ZKrS7rEqwLrtEVfLT+/8uH2woPEHg4sCMULbQ3mioGXiNF2qdwCz9L9P5h69IzC
         8PMJ7W3ZytUYmTC/VRmGTcTxDKl1hDjWvzOJvGFkWkUCyE46DaiY7WCHbOp0H+QPBjtf
         38AG0aeelpiRfn4OSJRxXB/LcBhWIuJcxh0Tzc9uGCzQOrqCTca3HNbfsF1uwsK2EoKr
         g1PD43w7qRWhBTkIeB+02qo8XWeMxc7C+m68fcXI602D3oN+pWuqBvraZ0YqGx4okzG6
         qCqg==
X-Gm-Message-State: APjAAAWpMOrztetOE4GUHvHows+9gRZt91Gban14WAcWywj0lZQ12C7D
        ZRuhRHrlA5JAyKZD2FVagwSUNb5FTUg=
X-Google-Smtp-Source: APXvYqz5nn7XTTebc6w0vpV7mJxlevuNWZKgwrvif/DsltQRF+f1pBfAfFXKgHd0O7Gb5LgwJgf9rg==
X-Received: by 2002:a2e:21d1:: with SMTP id h78mr7154643lji.49.1552840520714;
        Sun, 17 Mar 2019 09:35:20 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id y13sm380040lfl.22.2019.03.17.09.35.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 09:35:19 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id l7so2084529ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 09:35:19 -0700 (PDT)
X-Received: by 2002:a2e:87cf:: with SMTP id v15mr8069744ljj.22.1552840518847;
 Sun, 17 Mar 2019 09:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008a1bce057ede3d13@google.com> <0000000000009950e1058447ef43@google.com>
In-Reply-To: <0000000000009950e1058447ef43@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Mar 2019 09:35:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com>
Message-ID: <CAHk-=wjUrznUSUKN1AXQA9kCStQ3MHFY95ZmeTZ5zYDcvMhBiQ@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in bacpy
To:     syzbot <syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>, mmarek@suse.com,
        Netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 3:43 AM syzbot
<syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 19 22:34:00 2017 +0000

Heh. Yeah, I doubt it.

It would probably be good if syzbot did some confidence testing before
bisecting.

Don't get me wrong, "git bisect" is absolutely wonderful and has done
a ton to help us fix bugs, but bisection has one major downside: if
the bug you are bisecting isn't 100% repeatable, the bisection will go
off into the random weeds and give completely nonsensical results.
They won't even be *close*. What makes bisection so powerful is also
what makes it then completely random if there's even *one* mistaken
bisection point.

So it would probably be good to test each bisection point at least
twice, and if they don't agree, report it as being unbisectable rather
than give a random "this is what introduced the problem".

Hmm?

            Linus
