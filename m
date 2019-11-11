Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6BCC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9B2222C1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573498874;
	bh=6Y9SkLWC5ucVzdD21aXq6P4PZcHCyuYthaOO95QTRSM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wcUcawM5WoCV3eJfEcMgebtxXJrzZBDBHrpjVoCUxur2Q8FW5HNAfQvUX2nhJ6Sxb
	 6gGMPoY6uBVs9uslQJ2GlAgqD6U8n/N6P33GRQ/h+yLXkXpGR6HsMs9p5p+NfM1hb+
	 zo9snVqW3rJeIr/vWUwV+8AIvkW4qrf5B/AoLuw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfKKTBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:01:13 -0500
Received: from mail-lf1-f49.google.com ([209.85.167.49]:39176 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbfKKTBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:01:10 -0500
Received: by mail-lf1-f49.google.com with SMTP id j14so2123877lfk.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 11:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7X+i/K/e1sfyo/sSNSz4o3Zk6I09VNaSQEUuToduhok=;
        b=IfGf7e0vnSjr5D5/DFnDtseZozwEmG+KD34J8cRx2xf34AIG9uoiU23s5fCGgXqEK5
         pSM5R4LyfWGXW4tT+suDhlW+bfiQEQkNQpZTYlGHKMQ/MYDHAI4BuxjcbA3OnkuY9PoG
         2YgxBEu1RUtZ1BQ8hGZGSjXauXMoa4FK+6ZBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7X+i/K/e1sfyo/sSNSz4o3Zk6I09VNaSQEUuToduhok=;
        b=Xlash8t0tAlW7htMkLHvGuV8Hx4GUhMP/l5M7dhu5G0B6LKZPGWzYTg/s33Ups/oGW
         4sKKo/nD8Q1n547Xnh3xBnlAazOBKsmJIuXbcXqTE9GpfPdrCZlCx5arR1jZNrEES/Lv
         NFTxy3gHY1cSRAcjrsdEvsncGTfIrW7PFhEyzNWlTCcn8BFa6kCo6g8tI+A/qka9n1DC
         r3n5gdTGXrl+AN2Bs8uiyPyMtqtwzTAi0+BUdTp9Wt5WhGfQFSy2olDwlv3LeiSCj84W
         uA9amZsBIcSPUn1NUm1Cr4/hkGLX1V7MmUfe4OsBKIzoLm3oiStp6pSXulrKm6TMXSgw
         u29w==
X-Gm-Message-State: APjAAAXyjUlTU3qfrlqABupC7mXEFqZz9Gd3eYCx17iPRi6Uhs/j0fcu
        w12gcGWJhvtDTtsWKG3beWkaNF9QLNg=
X-Google-Smtp-Source: APXvYqy+8VnCA4UWuBAiHaZ4qgzIN5JAD6WFQassCDFe3HCdc3YdlT/K5VJAWmlmriRawyAFVLA7KA==
X-Received: by 2002:a05:6512:25d:: with SMTP id b29mr5805888lfo.171.1573498866586;
        Mon, 11 Nov 2019 11:01:06 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id d5sm1539822lfl.2.2019.11.11.11.01.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 11:01:05 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id e9so14945090ljp.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 11:01:04 -0800 (PST)
X-Received: by 2002:a2e:982:: with SMTP id 124mr8876387ljj.48.1573498864524;
 Mon, 11 Nov 2019 11:01:04 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com> <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
In-Reply-To: <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 11:00:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
Message-ID: <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
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

On Mon, Nov 11, 2019 at 10:44 AM Eric Dumazet <edumazet@google.com> wrote:
>
> An interesting case is the race in ksys_write()

Not really.

> if (ppos) {
>      pos = *ppos; // data-race

That code uses "fdget_pos().

Which does mutual exclusion _if_ the file is something we care about
pos for, and if it has more than one process using it.

Basically the rule there is that we don't care about the data race in
certain circumstances. We don't care about non-regular files, for
example, because those are what POSIX gives guarantees for.

(We have since moved towards FMODE_STREAM handling instead of the
older FMODE_ATOMIC_POS which does this better, and it's possible we
should get rid of the FMODE_ATOMIC_POS behavior in favor of
FMODE_STREAM entirely)

Again, that's pretty hard to tell something like KCSAN.

Of course, it's then questionable whether our rules for not caring are
necessarily the _right_ rules for not caring. For example, if you have
threads, the "more than one process opening it" doesn't trigger. It's
literally just atomicity across processes that we guarantee. That's
certainly a bit questionable. But that's a higher-level decision.

               Linus
