Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE0DC17445
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C35D206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 18:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573495518;
	bh=D4j7yAa9xAY9us41sVbrmAc7dvEFhURazhNLhVZqnww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G8DNUcOUGhzbcuEJzz8N3C20u2Ub49L4Ci0GcgyFE+Ha4MpkTnIEhvWrNe7vOIgKm
	 uzpaEoODoX+Rr61iKp9zRcSSy2TbTMHIsZxqNXYJyApdlYWtU8gOxQOsCCS9tNtXso
	 XYR+wbp7XrhQ6QgA35n8f5o2AeJkvdp4y7rZZUcM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbfKKSFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 13:05:17 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35621 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKSFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 13:05:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id r7so14826288ljg.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvHuArWQZSt4FAfTL9KeJpBsocvaDQs9zK3jRy53Tcc=;
        b=ag0ij2l3tpP9oh4bJbAnRGep+63OugvYZJhjMCwlauwgfrGQ7pqUmJvv8qj0uakSts
         ZDSkRSJFWChbxsuYWUpcogXRNaLW+mnwqdTCozn5LsyQqxp2G8J+ESzbHFLEaLpk8fc1
         Wny6vPFLNuEJ1jLedmt1cN279S4odF0GC9reA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvHuArWQZSt4FAfTL9KeJpBsocvaDQs9zK3jRy53Tcc=;
        b=eYxB1ChF2BlqMjk/96kxg/FKtAfCYj43KWMnPddUa5kie5C8eqyJX95HJGyQioUMDQ
         a41sAIOzEUJX6K1pio1JOoMnCbqBBmxOML1nnNHPnJfobISMDxJIMX1izsIsi0oYyfi0
         62e/D1/ANm7//1XPag4xgMFWD83bkt03JGtqh4Xv0dMclI4pNuh6yDiu7T65au2I5N0p
         09j57xzCH7vCLmunQE3SUc+MQN1PVLtSJNfeFYkUbue5jTzgZ4Uf3fDyIaKiXlzDHFjj
         QB1AX04vNjzSZ+8GVwUCHIx07Sv0xloq4QVLC0tfRbatYFRzhN2TroM0Kca4PPlbFU2q
         e8SA==
X-Gm-Message-State: APjAAAVZWHf9cxpGCUt6ZYaSdZVH05nVNjk5jgwhl9qpcXCz6vRX2GjG
        vbN0Z4iFeIY2VefKVGXicwG0PwEOXKE=
X-Google-Smtp-Source: APXvYqw29lH3zxk41alcWpSnLyRUPps85P0iCS5mmPFXPpPn4DR8BDcYHGnHm0JHEDSUtlnmAaLVFA==
X-Received: by 2002:a2e:b4f0:: with SMTP id s16mr8187414ljm.123.1573495514543;
        Mon, 11 Nov 2019 10:05:14 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c12sm8732853ljk.77.2019.11.11.10.05.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 10:05:11 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id b20so10594467lfp.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 10:05:11 -0800 (PST)
X-Received: by 2002:ac2:498a:: with SMTP id f10mr4549583lfl.170.1573495511138;
 Mon, 11 Nov 2019 10:05:11 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com> <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
In-Reply-To: <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 10:04:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
Message-ID: <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
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

On Mon, Nov 11, 2019 at 9:52 AM Eric Dumazet <edumazet@google.com> wrote:
>
> Now I wonder what to do with the ~400 KCSAN reports sitting in
> pre-moderation queue.

So regular KASAN reports are fairly easy to deal with: they report
actual bugs. They may be hard to hit, but generally there's no
question about something like a use-after-free or whatever.

The problem with KCSAN is that it's not clear how many of the reports
have been actual real honest-to-goodness bugs that could cause
problems, and how many of them are "this isn't actually a bug, but an
annotation will shut up KCSAN".

My gut feeling would be that it would be best to ignore the ones that
are "an annotation will shut up KCSAN", and look at the ones that are
real bugs.

Is there a pattern to those real bugs? Is there perhaps a way to make
KCSAN notice _that_ pattern in particular, and suppress the ones that
are "we can shut these up with annotations that don't really change
the code"?

I think it would be much better for the kernel - and much better for
KCSAN - if the problem reports KCSAN reports are real problems that
can actually be triggered as problems, and that it behaves much more
like KASAN in that respect.

Yes, yes, then once the *real* problems have been handled, maybe we
can expand the search to be "stylistic issues" and "in theory, this
could cause problems with a compiler that did X" issues.

But I think the "just annotate" thing makes people more likely to
dismiss KCSAN issues, and I don't think it's healthy.

                Linus
