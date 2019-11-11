Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84036C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57EF920659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573505050;
	bh=4lIQrmRhHr3b3c2e8onwB0BZvgQoV+M/N2xV16p4TXc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qw+9W3XNx84W2M05lXTt95CF9BS7B8GiNbWl0Fkx9fRLj2/1GgjUmUGtTejh1hR3u
	 stdvJXko7WLKat6XvVDBXh2zA2VamngsZHo5gU+rnUMCzRzkYEUluBeNaol56NdQaV
	 vcHB0I7k3QmIRRbpXPfeDcOykxKkeddDiRvZnhdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfKKUoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:44:09 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:37426 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKUoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:44:08 -0500
Received: by mail-lj1-f171.google.com with SMTP id d5so5774418ljl.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRpKFfWznVhj0rOmApAqWtyU5VUj2Sa8IVNQNnpT9os=;
        b=HWedAvPLYel4dWRGlAl6RaJ3Yu3or3ICRF5dcXJUzKCmWReTCRRVOKzRS6Z3LxfDIr
         l0e8MYVVHvCHAhgsOsOTZcnm+wKkf9HPI9/P3cBWrjFgw3bENmYWUazQx+bSFZG4Gm6Z
         d/PZrJ7ylSByQPRbgQv5LTVX8eUcGbMpV4Ke4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRpKFfWznVhj0rOmApAqWtyU5VUj2Sa8IVNQNnpT9os=;
        b=bBVd4H8nahyFq6YZ0UCdCgCAyf/GtFwmkIpg3at7ZM/0T/3ov1BJ+UuJzvw0wI4NkX
         OzvKLNtOa7i9tYhsDb5UK+k7j2lP8e32VzLOqq9GKMQ29HPS5mXy3aDxMa8+92QFvt1b
         vm+mI3mJF89aIGMN+bB9VXY4yAG50EcdiT1hL/Zre1Crv6Nu9YSagqqqpq+Ao5XdZmY4
         1TEw4rKNPMPst/1whmQvfVD1GV+0fmzweZ4KIbj2B5tNpuOziUIv5dSEeZ5CxSNdSSAF
         746aqX6zEghr8KrMSXTal/k6ffNSaB86tTZChzfoGhn95Eubxu2x26NAe40oAXWQMmmk
         vReg==
X-Gm-Message-State: APjAAAXnXfy4kyA5QfbTs9QPV+9t3ZIc9mJthRC6mV7tLqLNdrAP3G/h
        KedY2opfXXyVvZFJsnqgEywCLRV4pqA=
X-Google-Smtp-Source: APXvYqzxlDeDs+E+qL2LSxdowQq2JDc8ZPNPSrYR1XbnJmiOWoWJZdyj4Dn1PTH3wEno1aLMR3O9fQ==
X-Received: by 2002:a05:651c:284:: with SMTP id b4mr6321ljo.253.1573505045388;
        Mon, 11 Nov 2019 12:44:05 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id g5sm8145928ljn.101.2019.11.11.12.44.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2019 12:44:02 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id t5so15310268ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:44:02 -0800 (PST)
X-Received: by 2002:a2e:8919:: with SMTP id d25mr17557153lji.97.1573505041971;
 Mon, 11 Nov 2019 12:44:01 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com> <CANn89i+x7Yxjxr4Fdaow-51-A-oBK3MqTscbQ4VXQuk4pX9aCg@mail.gmail.com>
In-Reply-To: <CANn89i+x7Yxjxr4Fdaow-51-A-oBK3MqTscbQ4VXQuk4pX9aCg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Nov 2019 12:43:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com>
Message-ID: <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com>
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

On Mon, Nov 11, 2019 at 11:13 AM Eric Dumazet <edumazet@google.com> wrote:
>
> What about this other one, it looks like multiple threads can
> manipulate tsk->min_flt++; at the same time  in faultin_page()

Yeah, maybe we could have some model for marking "this is statistics,
doesn't need to be exact".

> Should we not care, or should we mirror min_flt with a second
> atomic_long_t, or simply convert min_flt to atomic_long_t ?

Definitely not make it atomic. Those are expensive, and there's no point.

                    Linus
