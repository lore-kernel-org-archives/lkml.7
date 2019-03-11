Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC817C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC0A205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HB25eUUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfCKQiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:38:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40370 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKQiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:38:07 -0400
Received: by mail-io1-f67.google.com with SMTP id p17so4588308iol.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ipn/5myNwouNT6UUJzGkDkf1Ss+2OoiytB9AUmnnvak=;
        b=HB25eUUK8cr86dgo/Q8YiGVFXt55l2f21f6w1tPyhp22JWMX/2gJ4OM5HJ0LWm+o4+
         tnibXvoh8bHiUSqvA1s7ClHkZUk7i9d4NCXUA3r+8zH9OGnTcQFcjhMLI6rQEzs3Rykj
         xbGgcqoLwxcipi1eqnKjt0am7JANzI1MGLDV+SQRfMnGEOcnNmWsxqkgsMMhjNEcXvcu
         9iNYj7qAp1C1pq2mpXrtg3pArqShYcUlyGcj2K812o+H2pb0/UeHzTgQUaHz/O5JL1Ut
         yZxgIcJRpRKHNpv6EsjlA4zEtHai85FSI+OkxcRwnu2XvdSgLi2IRM1ulz2bQUty3ZR8
         y+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ipn/5myNwouNT6UUJzGkDkf1Ss+2OoiytB9AUmnnvak=;
        b=Hr6aXhluzLlTPBqEjGA8+ZMvgxlUvipnxlgwFNpG+GK7ksGaozGgusNoyWdvlyddx0
         sG4TKVpNuUUKmQEwV8g9EAa+ktQgcX2AoT0dr9UyMTe9PlDg0jiOa78Wu+pLG+rEYy/+
         77sW1tthwICADdN/iZMVz3Q1aul/rYMqolpaNSN8W00XEzAlyx96ZnJWShZLat0R4Ua2
         J6TbduyiNQ4OI4hxmnpUj6N+1wkYjlq5A4kbGQvTeMGpCGcAIBuIlbLX1zIFMASSr7Le
         B1D+znq8c+yUHNVA9bduE+qhUqmp9iYcCgcYxCSzkKOKaqAoFbeCOjj4cCVZx3F2F8Dh
         2JeA==
X-Gm-Message-State: APjAAAUemUbgckeIw4DENbwp7jNA5h3KGJLNcTGw2aBwIIcXoz6++O5O
        vt0zlTP+A3PX8A1Qi1SR4uu+iCJAgINAUvBDZvl4tA==
X-Google-Smtp-Source: APXvYqzBguLd7N68Z1Z2tWiLvpFPIMTA0qvVa44s1tQzpC8iBCrcWKibUUn7nmtRgITNhPrLx/9Y3CyWlPobSAJFkd8=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr8213415ioa.282.1552322285829;
 Mon, 11 Mar 2019 09:38:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+YLZYJ21Bao5HVAvXhvb9PQ41J-4RvtkZZEMF38qtkxHg@mail.gmail.com>
 <00000000000073a5740583d42c1e@google.com>
In-Reply-To: <00000000000073a5740583d42c1e@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Mar 2019 17:37:54 +0100
Message-ID: <CACT4Y+aHBMnOHQaTphgGwW8mZbDeHCu+Ce8zXki1ntdEbTPJqQ@mail.gmail.com>
Subject: Re: Re: WARNING in ep_poll_callback
To:     syzbot <syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com>,
        Roman Penyaev <rpenyaev@suse.de>
Cc:     "'Dmitry Vyukov' via syzkaller-bugs" 
        <syzkaller-bugs@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>, dbueso@suse.de,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 5:36 PM syzbot
<syzbot+@syzkaller.appspotmail.com> wrote:
>
> > On Mon, Mar 11, 2019 at 2:53 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> >> On 2019-03-11 14:45, Dmitry Vyukov wrote:
> >> > On Mon, Mar 11, 2019 at 2:37 PM Roman Penyaev <rpenyaev@suse.de> wrote:
> >> >>
> >> >> Hi Andrew,
> >> >>
> >> >> I thought "epoll: loosen irq safety in ep_poll_callback()" patch was
> >> >> removed from your tree, at least I got a notification on 9th of
> >> >> january,
> >> >> also I do not see it in the linux-next tree.
> >> >>
> >> >> Should I ignore this syzbot message?
> >> >
> >> > If this was resolved we need to communicate it to syzbot one way or the
> >> > other.
> >> > Since it was in linux-next, it won't even be able to do fix bisection.
> >> > So the bug will be open forever otherwise.
>
> >> Bug was fixed (commit was simply dropped).  How can I tell syzbot to
> >> shut up
> >> and to resolve the issue?
>
> > Hi Roman,
>
> > The docs are at:
>
> >> See https://goo.gl/tpsmEJ for more information about syzbot.
>
> > There is no official support for bugs fixed not by commit merges.
> > Linux-next creates various interesting corner-cases for the process.
> > Let's go with this option for now:
>
> > #syz invalid
>
> I see the command but can't find the corresponding bug.
> Please resend the email to syzbot+HASH@syzkaller.appspotmail.com address
> that is the sender of the bug report (also present in the Reported-by tag).

+syzbot email

Please don't drop bug reporter email from CC.
