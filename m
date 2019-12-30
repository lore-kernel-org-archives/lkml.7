Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A296C2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBBC20722
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 18:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dIsjKUO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfL3S3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:29:16 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36821 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbfL3S3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 13:29:16 -0500
Received: by mail-oi1-f195.google.com with SMTP id c16so11333516oic.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KiuU6QfyPfgeZowlNQTGQlJqj0W3IrWFK8NOM0+/Dbc=;
        b=dIsjKUO8jwOYmjmzfRVZxYUSytqiMQYo3gJZWVHQtJFhn6N3ZSUv1kat9sE2i+i8mi
         8KIKOpD5jtW5Cq99fKKyoELxhD7gEnG7pAyYoQJRieZuxjhOtyPFB3f6DyLb6fwn8qWk
         0BOUKi1bu/3B0pT4CBLt1wVoq1E5G8I39Edio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KiuU6QfyPfgeZowlNQTGQlJqj0W3IrWFK8NOM0+/Dbc=;
        b=TvdMO1JrkDkfNMaTJ49w/3v43OW+bMRKgerzgQg810Vpi+N7f82x2o8WglIgVD+b1r
         T4f/+WpF674Mf4rwgRY8or3ZLkVZNatIipyh+MmFq8g2q3UPvd1OkGov7BWSLcvJKv2c
         igqMWD6Nr8ReaVasdXxvsn/SSZzoIWs0cVGmqditjfL0WO2M1hsHDUsPugBRJi3lgGBy
         ko7ekR8zK9rjCIRERLvcaqGc8/IlCl+HlB0QYPBbKyTsirJoqtmOhn9sItcEsbwNerb8
         t7vVdBRirbjvNTkfblXPUeRjmkDbWWH90V9LO8/1Q2W8lWu0GJEND9bPZK3YpZ3SX5Z4
         OWEA==
X-Gm-Message-State: APjAAAX4IztMjkrpgd+S6fsdHn+I9KbY7Rw0piICHVu9LJwosO3vDE2S
        T7YUOPMza9Rd1auOzNDJrMJs8Q==
X-Google-Smtp-Source: APXvYqz+h2+kkSRzzgvvCkbDGl3d8KnJ2jY/361guwVk3w9/RgiruB2G7mNEi3JrCu+UdHAk+m5cxw==
X-Received: by 2002:aca:ba46:: with SMTP id k67mr209161oif.38.1577730555748;
        Mon, 30 Dec 2019 10:29:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s24sm7749395oic.31.2019.12.30.10.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:29:14 -0800 (PST)
Date:   Mon, 30 Dec 2019 10:29:13 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v3 3/3] selftests/seccomp: Test kernel catches garbage on
 SECCOMP_IOCTL_NOTIF_RECV
Message-ID: <201912301023.CEBE3A5@keescook>
References: <20191229062451.9467-1-sargun@sargun.me>
 <20191229062451.9467-3-sargun@sargun.me>
 <20191229171441.fxif7q32mv2hl3y4@wittgenstein>
 <CAMp4zn_4dN+5U2RxkpYp+m4=X9w2Wef1TuLZ2hRW+g+nK1cXGA@mail.gmail.com>
 <20191229194318.ogsqw5pbjppbtsf7@wittgenstein>
 <CAMp4zn_39bsyZo6BeZ6b+c_EeAHdWmqcJus6qD2xYp84cEcZaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMp4zn_39bsyZo6BeZ6b+c_EeAHdWmqcJus6qD2xYp84cEcZaA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2019 at 03:42:17PM -0800, Sargun Dhillon wrote:
> On Sun, Dec 29, 2019 at 11:43 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> >
> > On Sun, Dec 29, 2019 at 11:06:25AM -0800, Sargun Dhillon wrote:
> > > On Sun, Dec 29, 2019 at 12:14 PM Christian Brauner
> > > <christian.brauner@ubuntu.com> wrote:
> > > > Does that even work if no dup() syscall has been made and trapped?
> > > Yes, the first check that occurs is the check which checks if
> > > seccom_notif has been
> > > zeroed out. This happens before any of the other work.
> >
> > Ah, then sure I don't mind doing it this way. Though plumbing it
> > directly into TEST(user_notification_basic) like I did below seems
> > cleaner to me.
> >
> > >
> > > > This looks like it would give you ENOENT...
> > > This ioctl is a blocking ioctl. It'll block until there is a wakeup.
> > > In this case, the wakeup
> > > will never come, but that doesn't mean we get an ENOENT.
> >
> > Yeah, but that wold mean the test will hang weirdly if it bypasses the
> > check. Sure it'll timeout but meh. I think I would prefer to have this
> > done as part of the basic test where we know that there is an event but
> > _shrug_.

I'd like to design the tests to not _depend_ on the timeout to catch bad
behaviors. The timeout is there for us to not break a test runner when
we forget weird corner cases.

> My one worry about this is that the behaviour should be if the input
> (seccomp_notif) is invalid, it should immediately bail out, whether
> or not there is an event waiting. If we add it to basic_test, then
> it would hide the erroneous behaviour if bailout isn't immediate.

I'm not following this paragraph. The ioctl's zero check is immediate,
so this test should fail the EXPECT (but continue to the next "correct"
ioctl) -- it's not an ASSERT (which would stop the test). I think
Christian's test might be a cleaner approach, unless I'm still missing
something here?

-- 
Kees Cook
