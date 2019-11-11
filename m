Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D805DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A258D21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 21:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qy7hsN4r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbfKKVxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 16:53:21 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:41559 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfKKVxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 16:53:21 -0500
Received: by mail-il1-f179.google.com with SMTP id q15so8388260ils.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 13:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5dR2X2FPjc0R4vKaFMq42of1ocjgN73FFpV0IAy3Es=;
        b=Qy7hsN4rNqDIsADEty2zFKc9T419wkbTgjhkrGwsJBb0mS8oAXBvZmLuLbksEbS967
         AS7SumZJtySJk+Uo7BlorvhZJ/5b9I8wZEi62BArK7PTRkStJ7lOmT7lWRpD/TaXyk5T
         l6oBe+cBgOHBhzLF0fHedCG3gbw2w7v8poM7XnJ2Wn09xLoLqO1YnMHVB6a1ePNU/BV1
         lnf39TjhLmTLV75aN6SI7p8VuObJkzj5PtJamPDhv3MorHUDsDjxbKsoeHQDmWdX35/+
         dxJpPyl8uSV6uOrQzRkX654Dtdl5cZVmvYrKkMIcy8V2OMcGBQiHwjzO8KfKmXXoHsZ1
         IFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5dR2X2FPjc0R4vKaFMq42of1ocjgN73FFpV0IAy3Es=;
        b=Xfjx2YhiBp3Y1IofMzfKBO/RH7ugSPcts0S3PW0gCpQd+NgDmzZJ18iQ3LSt3dvq/E
         2Isuwb6PX1TbapoCHtoyx3uzJJ+cuEXJoc50p+bbHgAFx5Z5BHskvfrkGKSkxiqM5TxL
         6yiWEPUW+T6E9kpGTSjhbld5hentEP/zNp9tZJtfzEODmzKDoEFiOQDEqdy+jk5Bm3VQ
         cuAervj3/u+rnIFArwfcqCSrfsIi8jNM79kkvOrYgBjzGdHKEagZLDGFuzjgA2a7J7Bf
         D6MiMShIRIZ3XPPY3aged/VN/EgiH2A1FlMNf5tGeTmuwJdPwejksLie/FWrPjuPdD5h
         pvKw==
X-Gm-Message-State: APjAAAUkIgDTdy7plbNAxxC7pigGH5GE++a0AsR8/RRMRWmHyPhZ2WFO
        CWCECRlBb5U6HHMqyDpIZBnPBQTtetILOlY1Lx4KjQ==
X-Google-Smtp-Source: APXvYqyEKArgN/a9P0jAoaKNekFY1H9Ikjs3X+yMpFLujCjs7WSeV2O3zE/DTUMb+bgZ6AKrEPGh8EwSxNFXUbMagqA=
X-Received: by 2002:a92:99cb:: with SMTP id t72mr29681319ilk.218.1573509199768;
 Mon, 11 Nov 2019 13:53:19 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CANn89i+x7Yxjxr4Fdaow-51-A-oBK3MqTscbQ4VXQuk4pX9aCg@mail.gmail.com>
 <CAHk-=whRQuSrstW+cwNmUdLNwkZsKsXuie_1uTqJeKjMBWmr6Q@mail.gmail.com> <CAHk-=whWNkk7vCQr7LLshcB6B_=ikmpMXQ7RtO2FyDx-Np_UKg@mail.gmail.com>
In-Reply-To: <CAHk-=whWNkk7vCQr7LLshcB6B_=ikmpMXQ7RtO2FyDx-Np_UKg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 11 Nov 2019 13:53:07 -0800
Message-ID: <CANn89iJsh97aaAHhPTtkPjz4QFJgi9WHs3bbSTnLGrdE8qrJaA@mail.gmail.com>
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

On Mon, Nov 11, 2019 at 12:47 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Nov 11, 2019 at 12:43 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Yeah, maybe we could have some model for marking "this is statistics,
> > doesn't need to be exact".
>
> Side note: that marking MUST NOT be "READ_ONCE + WRITE_ONCE", because
> that makes gcc create horrible code, and only makes the race worse.
>
> At least with a regular add, it might stay as a single r-m-w
> instruction on architectures that have that, and makes the quality of
> the statistics slightly better (no preemption etc).
>
> So that's an excellent example of where changing code to use
> WRITE_ONCE actually makes the code objectively worse in practice -
> even if it might be the same in theory.

Yes, I believe that was the rationale of the ADD_ONCE() thing I
mentioned earlier.

I do not believe we have a solution right now ?

We have similar non atomic increments in some virtual network drivers
doing "dev->stats.tx_errors++;"  in their error path.
