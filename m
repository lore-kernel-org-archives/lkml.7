Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25C1C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B021655
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 00:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDbhNhUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfD3AjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 20:39:04 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44054 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbfD3AjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 20:39:04 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so10357921otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 17:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgTZ/3K30VQ7Yy+pkC8aq78l5d1oLQkhIepKaWoCAis=;
        b=hDbhNhUUvtz91pYUFmj6nfFXK8CKr5RbKdQxwq4t9TgTcelkeWGGBkCFCVn1roCGTY
         5gCaEeHjrUe+44R/9CUFSnxJsPyMbN5Yedvj+K0BJcQoz7xv9AK4lWxoXOjtD7txq1FR
         IszJWlRcxRV66h+r/Q1aUkJur2mIkSYoeRYsk2r9OkuYs0zmliDeHL1b2PKeL/oj+E+k
         SF55kopRV66yIgAmst000r/FAqTIuVGN7MDzN/5QyzEK9PpLIe59lTC21+Nh1T4XDCBL
         7Gm2HOK/pKO+Eq6hW+L1OokwwwjUfFbbrqHdUo/bWpsB2Sj1fjd0KHaYbnHcocOicwY9
         WlHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgTZ/3K30VQ7Yy+pkC8aq78l5d1oLQkhIepKaWoCAis=;
        b=ZLgMKh0U5EVsDb4nim6/driiBCPkZBW1tFKvO/os5gza8p5/jCZDhUA6UXzlloRnO3
         7B+QqwzmdRnpts88faGWGMgHSKW8v/ZMR6YQHPy7jRT7WmqsqXXq0iMiDq1Wun+h4mjR
         IX9e4iLbbUe1MnQuzE+R2hRLPEZu3LZ6pJLFAe5FrKgKxwqO8kI4Ax7oPfLIOup6PaAH
         RrRsI49x+CW+cwOwN1PahPtCGSoS2A2XXeCJtE9e70h69H3x4CT1GRA2yjzZecNuRAi8
         rB8hVb5wwqzUhhBTyQQp0a0xzLU0IB9eiKEjIT1OZsbademjHSqo/6dqGEYS30/6zql9
         +arQ==
X-Gm-Message-State: APjAAAWVETzcrUU9C6T9h3Yqr0t5L0T6CA/VCvIHoIeUyo+a71JsKPBb
        kR/a0/i8jlmq56VAwbWbLxefmIFNlw+Wy31R5DQkpQ==
X-Google-Smtp-Source: APXvYqwWLXmgw6LO0TQOApqsoDQCT6J8Fxw3fh5GCqCZu3eyL9N9e5DL2d3J/0PsdjmDC+DNw2jfN8I4xhhddyTXqlk=
X-Received: by 2002:a9d:6748:: with SMTP id w8mr6113811otm.198.1556584743486;
 Mon, 29 Apr 2019 17:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190414201436.19502-1-christian@brauner.io> <dc05ffe3-c2ff-8b3e-d181-e0cc620bf91d@metux.net>
 <20190415195911.z7b7miwsj67ha54y@yavin> <CALCETrWxMnaPvwicqkMLswMynWvJVteazD-bFv3ZnBKWp-1joQ@mail.gmail.com>
 <20190420071406.GA22257@ip-172-31-15-78> <CAG48ez0gG4bd-t1wdR2p6-N2FjWbCqm_+ZThKfF7yKnD=KLqAQ@mail.gmail.com>
 <CAG48ez15bf1EJB0XTJsGFpvf8r5pj9+rv1axKVr13H1NW7ARZw@mail.gmail.com> <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
In-Reply-To: <CAHk-=wi_N81mKYFz33ycoWiL7_tGbZBMJOsAs16inYzSza+OEw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 29 Apr 2019 20:38:36 -0400
Message-ID: <CAG48ez1CV54c1xZ9s26ym=9avkihiNi=ppW-CWA1-qrCpYdc1A@mail.gmail.com>
Subject: Re: RFC: on adding new CLONE_* flags [WAS Re: [PATCH 0/4] clone: add CLONE_PIDFD]
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kevin Easton <kevin@guarana.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 4:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Apr 29, 2019 at 12:55 PM Jann Horn <jannh@google.com> wrote:
> >
> > ... I guess that already has a name, and it's called vfork(). (Well,
> > except that the Linux vfork() isn't a real vfork().)
>
> What?
>
> Linux vfork() is very much a real vfork(). What do you mean?

... uuuh, whoops. Turns out I don't know what I'm talking about.
Nevermind. For some reason I thought vfork() was just
CLONE_VFORK|SIGCHLD, but now I see I got that completely wrong.
