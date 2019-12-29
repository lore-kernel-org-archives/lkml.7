Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7E8C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 23:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A54A207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 23:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="i9I+1XWG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfL2Xm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 18:42:56 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44527 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbfL2Xmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 18:42:55 -0500
Received: by mail-ed1-f67.google.com with SMTP id bx28so31263089edb.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Dec 2019 15:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rabM4rIBG0N1M+zRAZDgiIgam+NL7i76tMVOocyysIA=;
        b=i9I+1XWGtwozpDStyAtdXl2Y7rNL91aJQKe89LIOv8m95Q5kRD2kQDspkJNDITpuFe
         1MD5U4rwgnUrTU402OYsrVzhxr2gC7yPjPdPIGegjEkjGDLpOGHoTbC8ZMK7Z3A5UGfm
         WOB9uXPQTYVgwqZyyzKnm4s4aK8yaIxLIjSoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rabM4rIBG0N1M+zRAZDgiIgam+NL7i76tMVOocyysIA=;
        b=H/jcXz8o4db4EloNtI9yf/rza3j0f5DPPXWg2EjFAOg1MAzyaiefsVBglfKxLrqegG
         ww4EE9PFXRxxggQULawMufnZEg0RjANV6tkeTcx7i8JabnO1t5yNgHjV2AMYZ0hejIoM
         5N7Bpl0FItJ4D7sSnxazWVwXVQrcVKcHlSkMnDdlpOcuOhWecUXc2Cg1kbSBxIx7ZnnA
         YpFUkWZoltkDieVZPwIOMWrgwJsgGZbbgawZlJJ8god1xXE4u2ujmrQqHFp4kLQt/YuK
         GzAhfM08LAEqZGlNoFnAJsdZ3ZgONct1jL49AzeGNkoRVZQCKhZBQPsKnA7p5xeeYC1O
         Gdzw==
X-Gm-Message-State: APjAAAVsrgb5Ho6VnQWW3PvsUfGrsOrPIkDjPzX5OjBA0jw8ZjjLF2SL
        vrBCPKJgsZk5BhY1ST5ybV2fJppaUaDQFFX4rZKJJA==
X-Google-Smtp-Source: APXvYqzK+Cf1LC8KJmdZ4Ymm0sJLKxzndri+nzBDJERNOOKphUkeQ16eB6yOCOEWGAmLIZHYZJc1evanGKmlwVjXu1Q=
X-Received: by 2002:a17:907:398:: with SMTP id ss24mr65192875ejb.317.1577662973730;
 Sun, 29 Dec 2019 15:42:53 -0800 (PST)
MIME-Version: 1.0
References: <20191229062451.9467-1-sargun@sargun.me> <20191229062451.9467-3-sargun@sargun.me>
 <20191229171441.fxif7q32mv2hl3y4@wittgenstein> <CAMp4zn_4dN+5U2RxkpYp+m4=X9w2Wef1TuLZ2hRW+g+nK1cXGA@mail.gmail.com>
 <20191229194318.ogsqw5pbjppbtsf7@wittgenstein>
In-Reply-To: <20191229194318.ogsqw5pbjppbtsf7@wittgenstein>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Sun, 29 Dec 2019 15:42:17 -0800
Message-ID: <CAMp4zn_39bsyZo6BeZ6b+c_EeAHdWmqcJus6qD2xYp84cEcZaA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] selftests/seccomp: Test kernel catches garbage on SECCOMP_IOCTL_NOTIF_RECV
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 11:43 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sun, Dec 29, 2019 at 11:06:25AM -0800, Sargun Dhillon wrote:
> > On Sun, Dec 29, 2019 at 12:14 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > Does that even work if no dup() syscall has been made and trapped?
> > Yes, the first check that occurs is the check which checks if
> > seccom_notif has been
> > zeroed out. This happens before any of the other work.
>
> Ah, then sure I don't mind doing it this way. Though plumbing it
> directly into TEST(user_notification_basic) like I did below seems
> cleaner to me.
>
> >
> > > This looks like it would give you ENOENT...
> > This ioctl is a blocking ioctl. It'll block until there is a wakeup.
> > In this case, the wakeup
> > will never come, but that doesn't mean we get an ENOENT.
>
> Yeah, but that wold mean the test will hang weirdly if it bypasses the
> check. Sure it'll timeout but meh. I think I would prefer to have this
> done as part of the basic test where we know that there is an event but
> _shrug_.
>
> Christian

My one worry about this is that the behaviour should be if the input
(seccomp_notif) is invalid, it should immediately bail out, whether
or not there is an event waiting. If we add it to basic_test, then
it would hide the erroneous behaviour if bailout isn't immediate.

I'm not sure if that's a worry or not.
