Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F28BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CC620659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 19:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GBX1Myr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfKKTAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 14:00:13 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:36603 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729568AbfKKTAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 14:00:11 -0500
Received: by mail-il1-f171.google.com with SMTP id s75so13056765ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 11:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WGvx3izZbFGPfmHpTzf+7OBf9luhXuuKiVs0MgvxepI=;
        b=GBX1Myr4/EEVjz5Vb/HzUXNoAYfrM++Xv2+dIwNg/RscbmfvDOiDwQ02WAb6KP3jV7
         d61Z50AxiPwxcAEN96zBwrLDvW+3aQ/stoEL94alWqSIFWzMHtL66h/QIgToqPdRrYVp
         dLe67Yop326tdkSjKj7mDMEn5wS9UdFPThUQB6slmBb2YnI9spILMCByCuzBbILE6/B2
         XlGr2Gup2l4mHBQ+RDaY/uquwBsMqbW5p2c5AF4mlU3tfxF7OiGdGXT5fRGWoDQ/+zzg
         zMBQu042zzmwZaT3sNHfbyiXX7KbvdL/37mmy3WZs07q7kInzBRWtoxl+/uHXVtIRBWN
         Dsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WGvx3izZbFGPfmHpTzf+7OBf9luhXuuKiVs0MgvxepI=;
        b=aPj8v4W4g/MjWby1hw/bhim/1d7NRdFuwtCXaRqzMUztdSVzbuagDZktEUpqVeqqnn
         bKlYeu5t0RQT/xWrGoYdkudy20Z/6zVWMK3ziSNLIE01+dTfhAIj2e43wT9bisq+8doP
         T1u1OJOIQXGQm6Cl3H/K+G6rgTrWzhvycmQ4uhIox2+9KSRow4FF4pUN/+Asf3umAhV+
         EYcibN10BEWU6m0zx223Ci3ESVJxUzmS82t+0EMR1YlSpeUnsyCKnmgMUhEdNxmuHQ4I
         lEHFUi2Fajl71sVcVkPbWudbvepES2Orq1XYB5NHKb2pVhQHvMBhuHBnAxetdIToDtza
         I2zA==
X-Gm-Message-State: APjAAAWDX2iecr1sntDPwzE6ZmCmjfA4YMz4qpty/t5bsFy2JelOFz0B
        Xt9qF3gVXN9sRCf35kkOJPO1FCgy3Xu/2wMCGuh3VA==
X-Google-Smtp-Source: APXvYqwShvBdde63wM6WkVvjPNnkh7th4SxNy1hc6lp/UK1knU2zEsBaSIqGds382nbOWj7UXEGvX8LgAf8Pv1S9W/g=
X-Received: by 2002:a92:109c:: with SMTP id 28mr31505069ilq.142.1573498809674;
 Mon, 11 Nov 2019 11:00:09 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com> <CAHk-=wgWf7Ma+iWuJTTr9HW1-yP26vEswC1Gids-A=eOP7LaOQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgWf7Ma+iWuJTTr9HW1-yP26vEswC1Gids-A=eOP7LaOQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 11 Nov 2019 10:59:58 -0800
Message-ID: <CANn89iK1+m2CuOD9CYCQanKLWx4JsXw22YCbkSEcYYKw211Ztg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Mon, Nov 11, 2019 at 10:50 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> Yeah, if it hasn't shown any real bugs so far, that just strengthens
> the "it needs much fewer false positives to be useful".
>

It definitely has shown real bugs, some of them being still addressed
(not yet fixed)
