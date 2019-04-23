Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F9C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1274420685
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nytGHXiL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDWSFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:05:35 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40808 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbfDWSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:05:35 -0400
Received: by mail-yb1-f193.google.com with SMTP id q17so5555966ybg.7;
        Tue, 23 Apr 2019 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CscWNWRRKoHtjzZS+e6JYs58o9d6cw3EQoavwBOmRxs=;
        b=nytGHXiLrRCAP+ZBwOwG0LEsYPlcp2fqqZI6zZ2jl0Rzr+XrIwFu74IVNopetoFv74
         hyKFwZtagfg6KRpi2eAu2t3e0vTyO0ZmHiQ4i8OkSZpPQ7WDkqrzZDRlw4uHcujTI0el
         uyzhUytPVbIdNHE+Bbyl8b4ay16luiZhar8DSg42LuR2YyDIOhfhCookcaKO0fTLw7+j
         JeqRsbDH79S4IU4ucXPFVwJudoJ9SkPnIDvn78RmHPLeqL7un3k4fys0J6q2sFq6wy64
         Esz5p6Mrwx3WQzFR1EQlFHb+48if+Ycd9a05QXApfN/9opIyXhZVFd95Duncv/I/756M
         t0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CscWNWRRKoHtjzZS+e6JYs58o9d6cw3EQoavwBOmRxs=;
        b=sDUzFrinZTlrZVv7U9aIpDyW6S1pdzPyBFowkQ9BCEvcZ/HyXGkT1iS0jyMobwDI/3
         9EYqTdCAOqqs9JtSlNj6ctpUgISCgDMMz0rxgj/Ya+M443yA4t6nZAfhl9kKL8ZcbpPZ
         ImGNAPQcI/PMS6AnBhgMrqbtuAFjfvRIh7bUCHA6utXhNJ6UxFcvvkLZQU9D71j0hF2I
         EJholXhH3WfNRr69asMU/ytDazQh7Xy16o7L2IBK0CRR8hCaejfdQwuErfAEdy3LUN+Q
         FIFGx2HDzX/EbDoAhR58BbIDRPILs/rS4nzLhSHd5JQWV62C2hAWHNykiagu7WiqEoOo
         Sfsw==
X-Gm-Message-State: APjAAAUmT7W96o9UkVJIcr5lMqEVlQlqIbiPtW3E6e6DPcQxgnKBQpML
        3rx4PiH1OT4AJnz0OsWm4zzYQy3n2WVDsdSXgvk=
X-Google-Smtp-Source: APXvYqzYh2mJf4+HuTtO2MqmzHcy/0ShBqJ0Jn7uZuGjsXja2N72Dt48qxGWADjsPy5y2fdNOELODhb8akMr1i+6tec=
X-Received: by 2002:a25:952:: with SMTP id u18mr23356636ybm.397.1556042734141;
 Tue, 23 Apr 2019 11:05:34 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000091becf0586d104c6@google.com> <000000000000d97b380586d1205f@google.com>
 <CAOQ4uxgbAQEok9AqnnVwqBrF=q0UBP6yQuvdG-WDVpHNk8Xi7A@mail.gmail.com> <20190423162755.GF9910@quack2.suse.cz>
In-Reply-To: <20190423162755.GF9910@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 23 Apr 2019 21:05:22 +0300
Message-ID: <CAOQ4uxj83NA0QYP_kqgyRWxicUuQHoPK+vcTLEN-+rL+Vwa2HQ@mail.gmail.com>
Subject: Re: general protection fault in fanotify_handle_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 7:27 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 19-04-19 12:33:02, Amir Goldstein wrote:
> > On Thu, Apr 18, 2019 at 8:14 PM syzbot
> > <syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this bug to:
> > >
> > > commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
> > > Author: Amir Goldstein <amir73il@gmail.com>
> > > Date:   Thu Jan 10 17:04:37 2019 +0000
> > >
> > >      fanotify: cache fsid in fsnotify_mark_connector
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1627632d200000
> > > start commit:   3f018f4a Add linux-next specific files for 20190418
> > > git tree:       linux-next
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=1527632d200000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1127632d200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=faa7bdc352fc157e
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=15927486a4f1bfcbaf91
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155543d3200000
> > >
> > > Reported-by: syzbot+15927486a4f1bfcbaf91@syzkaller.appspotmail.com
> > > Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
> > >
>

[...]

>
> I'd prefer if we could make only fully initialized marks visible on
> connector's list. Just to make things simple in the fast path of handling
> events. So I'd just set mark->connector before adding mark to connector's
> list and having smp_wmb() there to force ordering in
> fsnotify_add_mark_list(). And we should use READ_ONCE() as a counter-part
> to this in fanotify_get_fsid(). It is somewhat unfortunate that there are
> three different ways how fsnotify_add_mark_list() can add mark to a list so
> we may need to either repeat this in three different places or just use
> some macro magic like:
>
> #define fanotify_attach_obj_list(where, mark, conn, head) \
>         do { \
>                 mark->connector = conn; \
>                 smp_wmb(); \
>                 hlist_add_##where##_rcu(&mark->obj_list, head); \
>         } while (0)
>
> And I would not really worry about fsnotify_put_mark() - if it ever sees
> mark->connector set, mark really is on the connector's list and
> fsnotify_put_mark() does the right thing (i.e. locks connector->lock if
> needed).
>

Sounds good to me.

I was worried about fsnotify_put_mark() NOT seeing mark->connector set
even though it is on the list (add mark; get lockless ref; remove
mark; put lockless ref).
Its subtle, not sure if possible.

I am assuming you will be sending the above patch to syzbot for testing.
If you want me do help with anything please let me know.

Thanks,
Amir.
