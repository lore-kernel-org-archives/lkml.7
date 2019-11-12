Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189BBC17440
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E531021925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573579437;
	bh=1gHo5E+uKZ9x+eI9Wq/7mpHpWnOyRT8MgE4vYVLyeaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zgU/o/9R1jUkZB73A5ApdDT3CkouonOZZDhqCoSc6Vw/EViUO2ChPIbxURxTwOo2t
	 aKOWLw2E/BF+GL7hiZrjLSSe/4xj9G83yi4uCceTe7BrQ1d6wJ5u5qyRThts56K2pN
	 15X1H9ECTEdyjnb3RwRqtXOTJh4T9KkCw2uFPOgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfKLRX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:23:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37992 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLRXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:23:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id v8so18725293ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XShByMLu//cYaYZBKvqGtxFWH4UjDRbybOVR95jGz/I=;
        b=MNvkK6gaA2ornBJfgB8lmMgtKjS5hIKoXiHCGGLj7vU0zf0dCWiBna4ovnMMdHCGhH
         HsHFPAgdTnHSJhls7WKv0HtJ6tf4Mdstu5O/Ru9eMp90WQkrRwW9bX+/zXWgLjTgzkr9
         iQksID0zMw01OIpz2Z4X0yD1w6oNJb3f8ASss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XShByMLu//cYaYZBKvqGtxFWH4UjDRbybOVR95jGz/I=;
        b=md4x/OcU8H9fflUT6SbBhu2Xh9Ce5sULoOahzCRIfUsd95DEXt31PfQBjC5Qs/iBJJ
         Th4vzuVzVIL7FrK7eP2k8j9Gu9oP1Xo6FnW3Vqbd5trARjJOdUUOxXYEArUed45Ssu3h
         Qcnj79HD7vTzPxNwRFzAWOc+9DIhJcE3F6ZZ9Q8UcrnE4VtnuEL8Y3+P3lKNxHxNlc4S
         88kKJOgYay1G9ykcCGBMji2N42a3qS2Casp5w5IIff5kW5OcfigI0ttd57G4ijDoSzHE
         7FEW0F3BnA58mjLFHtL/w4nVd7qJ43XVyr9frjhm6QgvMhl68iQCzZ/mMYuLugRmg+bC
         RE3w==
X-Gm-Message-State: APjAAAV4/Rs8nZ9VGX7k4lCUerZ2nndcfiOuivvTf6Emcgu9B5stJQgl
        /Rc+gxa4v/UXRt8pLGb9BCFRd912LgE=
X-Google-Smtp-Source: APXvYqwhllCMZ68a1BoQoswGIu3gQ8W8yuaEwrfASeOFTJMZbddMP/ZOMmZr3JDmxuHC8Ad508R6Cw==
X-Received: by 2002:a2e:9b89:: with SMTP id z9mr21487668lji.185.1573579432613;
        Tue, 12 Nov 2019 09:23:52 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id m20sm2700607lfj.35.2019.11.12.09.23.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2019 09:23:51 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id j14so4912394lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 09:23:51 -0800 (PST)
X-Received: by 2002:a19:4949:: with SMTP id l9mr6614232lfj.52.1573579430925;
 Tue, 12 Nov 2019 09:23:50 -0800 (PST)
MIME-Version: 1.0
References: <CANpmjNMvTbMJa+NmfD286vGVNQrxAnsujQZqaodw0VVUYdNjPw@mail.gmail.com>
 <Pine.LNX.4.44L0.1911111030410.12295-100000@netrider.rowland.org>
 <CAHk-=wjp6yR-gBNYXPzrHQHq+wX_t6WfwrF_S3EEUq9ccz3vng@mail.gmail.com>
 <CANn89i+OBZOq-q4GWAxKVRau6nHYMo3v4y-c1vUb_O8nvra1RQ@mail.gmail.com>
 <CAHk-=wg6Zaf09i0XNgCmOzKKWnoAPMfA7WX9OY1Ow1YtF0ZP3A@mail.gmail.com>
 <CANn89i+hRhweL2N=r1chMpWKU2ue8fiQO=dLxGs9sgLFbgHEWQ@mail.gmail.com>
 <CANn89iJiuOkKc2AVmccM8z9e_d4zbV61K-3z49ao1UwRDdFiHw@mail.gmail.com>
 <CAHk-=wgkwBjQWyDQi8mu06DXr_v_4zui+33fk3eK89rPof5b+A@mail.gmail.com>
 <CAHk-=whFejio0dC3T3a-5wuy9aum45unqacxkFpt5yo+-J502w@mail.gmail.com> <20191112165033.GA7905@deco.navytux.spb.ru>
In-Reply-To: <20191112165033.GA7905@deco.navytux.spb.ru>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Nov 2019 09:23:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
Message-ID: <CAHk-=witx+fY-no_UTNhsxXvZnOaFLM80Q8so6Mvm6hUTjZdGg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Alan Stern <stern@rowland.harvard.edu>,
        Marco Elver <elver@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        syzbot <syzbot+3ef049d50587836c0606@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 8:50 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> The same logic applies if it is not 2 processes, but 2 threads:
> thread T2 adjusts file position racily to thread T1 while T1 is doing
> read syscall with the end result that T1 read could access file range
> that it should not be allowed to access.

Well, I think we actually always copy the file position before we pass
it down. So everybody always _uses_ their own private pointer, and the
race is only in the "read original value" vs "write new value back".

You had a patch that passed the address of file->f_pos down in your
original series iirc, but I NAK'ed that one. Exactly because it made
me nervous.

> By the way on "1" topic I suspect there is a race of how
> `N(file-users) > 1` check is done: file_count(file) is
> atomic_long_read(&file->f_count), but let's think on how that atomic
> read is positioned wrt another process creation: I did not studied in
> detail, so I might be wrong here, but offhand it looks like there is no
> synchronization.

Well, that's one reason to add the test for threads - it also gets rid
of that race. Because without threads, there's nothing else that could
access - or fork - a "N(file-users) == 1" file but us.

> So talking about the kernel I would also review the possibility of
> file_count wrt clone race once again.

See above. That goes away with the test for FDPUT_FPUT.

> About "2": I generally agree with the direction, but I think the kernel
> is not yet ready for this switch. Let me quote myself:

Hmm. I thought we already then applied all the patches that marked
things that didn't use f_pos as FMODE_STREAM. Including pipes and
sockets etc.

But if we didn't - and no, I didn't double-check now either - then
obviously that part of the patch can't be applied now.

             Linus
