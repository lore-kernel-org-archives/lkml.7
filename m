Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B382082F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="hrNKnlKF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731664AbfCZRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:19:07 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34617 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZRTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:19:07 -0400
Received: by mail-lf1-f67.google.com with SMTP id y18so9371046lfe.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N8QaPWniQ5NkA2UI9jkozGX6x/IIAEbf+oBiV5XG1HI=;
        b=hrNKnlKFSnTu7DVYEWLpqUm7nP8/oEIBLZY4tz5U/Wybt4xQTm4kW2kD2rLVPNlCGP
         ajLTHXbMCTKsTim0X0nGZIMsFOd5zKm0yB6QAkXM/Q4ZgsAMLZqvpUeksDZkDEGHjbkR
         /GtbS2RaGhpuop9i9n1TWjsff0xw5V3v/TquQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N8QaPWniQ5NkA2UI9jkozGX6x/IIAEbf+oBiV5XG1HI=;
        b=slJeOdygOZvm8eNmsfGw2yNlQpW56T2guxBwwY6Rr9Fo1g+xUkh1jAEFg6hMhBo0wt
         rOy2we8GqjGh23xhwWSFpASG+TSePj/ycnOkiJHnbFzL9vjzN4EikHN7WxDjQtqPIhEo
         t+M+wDWXbC3hd3om/NMq4CneDd+xIoKB+oH5cRzo6aL6yakArtarVVqh++3T81Woy746
         BOmbCwxzqBd+tC27RVnPgJIlkKDY6J383DKObcOBRAiguGG0Hvj/JN7gbc9ojJ2TkfHY
         HE4q9QiPUIzjZ0y2Yoe6qj77q0AYVDWjMMRwXzZSl0BIrUuzlFrO6ada9CbPlkvtd3rN
         VVQw==
X-Gm-Message-State: APjAAAVbfro4N0O2+7kVYUhKA6y+s9+2eSOAGf4kVR4rVbbr94TnG5A5
        m9+4f5mX8/mTQj8zj1rfenTOGegdz5j9ujXwIj3hpw==
X-Google-Smtp-Source: APXvYqxcPw+846CmUbMD+fuDRDPi1kEM6hwfagoYvB+wvkzNiZiC429bNueyuPIt6ifaPc2j8RhvxUWnfAvi1K05mtc=
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr15908422lfm.14.1553620744924;
 Tue, 26 Mar 2019 10:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155513.26964-1-christian@brauner.io> <20190326155513.26964-3-christian@brauner.io>
 <20190326170601.GA101741@google.com> <20190326170827.p2wlwsscf5u6f3i7@brauner.io>
 <20190326171525.GA116974@google.com> <20190326171702.smehtebw4e656ehl@brauner.io>
In-Reply-To: <20190326171702.smehtebw4e656ehl@brauner.io>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 26 Mar 2019 13:18:53 -0400
Message-ID: <CAEXW_YRXDeJSJaSZBaCk=o+4Dhbq-WWzG=6OW4hDx5ynu7fgwg@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
To:     Christian Brauner <christian@brauner.io>
Cc:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 1:17 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Tue, Mar 26, 2019 at 01:15:25PM -0400, Joel Fernandes wrote:
> > On Tue, Mar 26, 2019 at 06:08:28PM +0100, Christian Brauner wrote:
> > [snip]
> > > >
> > > > > +
> > > > > +               if (!result)
> > > > > +                       result = -ENOENT;
> > > > > +
> > > > > +               put_pid(struct_pid);
> > > >
> > > > so on error you would put_pid twice which seems odd..  I would suggest, don't
> > > > release the pid ref from within pidfd_create_fd, release the ref from the
> > > > caller. Speaking of which, I added to my list to convert the pid->count to
> > > > refcount_t at some point :)
> > >
> > > as i said, pidfd_create_fd takes its own reference
> >
> > Oh. That was easy to miss. Fair enough. I take that comment back.
> >
> > Please also reply to the other comments I posted, thanks. Generally on LKML,
> > I have seen there is an expectation to reply to all reviewer's review
> > comments even if you agree with them. This helps keep the review going
> > smoothly. Just my 2 cents.
>
> I tend to do it in multiple mails depending on whether or not I need to
> think about a comment or not.

Ok, that's also fine with me. thanks,

 - Joel
