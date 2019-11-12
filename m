Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1036EC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FE02196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfU5LFrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfKLXR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:17:58 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:35621 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfKLXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:17:58 -0500
Received: by mail-il1-f196.google.com with SMTP id z12so17250241ilp.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 15:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2wmRZDK37oUqP6+uI5Wq9SWuQ2Hmj0XKslCBjAECKVc=;
        b=pfU5LFrMse1pSEkfylHbI3ThR2Y+Cw7OHPuSu2xiSoUYEvgyeHgdPu8QvG6CkhvCoe
         WJYwzI1mqsA88zP/CjDJaF5Oz69q6+PW1qcnYJeuXy1pMh7Ba4hEZxRqZ+Q0u6o/dWM/
         sVhx8vWPyecAQJtPiHMSx17SBrSEkZR+JDy3lcS/miLEsPYK9TNgNf8HPBTsr9f3Oh0r
         /LBvR7yiViw18qkXpc4NKNV2xoNgEMV7UtGA0PvfFyCtlbsuCrP3VYbIQ/XHEnPScUkB
         9GbS5RJ0I5dG+TQeq409bAOKeH6NU5DeP7mupTUsfMdSQGpJlr8ppG2clQtN7+vkfXSO
         v7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2wmRZDK37oUqP6+uI5Wq9SWuQ2Hmj0XKslCBjAECKVc=;
        b=X9RZULHlNkRqAfTHJbuZ/QKSDJF/8B8g0JAkU0kKquVv/suiaDc1P1Vde8R/pw/MPV
         OOu+dfHqWtINNSxb5FcVhhlTTpbC9dbFnMJzhhemNDTscqt0Eey2YqMapYoAXpDZZbXO
         z95ObCa1jjz0jyxTQ/bksjIWBJpnw7LbbJkWZ6eHq8Ns2PiHtiG+MIZO/eZ9sHBItFAy
         oztpKyuxoJBi7VboO52XLDyiZQRX5XcRA1J9wW+vaZT3hJw104MEKrBC3wT4jLylE0VI
         NWMpBVQTiGaZp0F6n513yNPDR8lOZVeY4+D5qxhK4f9rV2KJ/exS/odlQA27DnwbHXgs
         LkjQ==
X-Gm-Message-State: APjAAAWWiL6ohCxFMhPKpWSV24eP6Al05+VGCw9EfhQeGIjcAg3PyQUd
        GbnZ8AHiaXau13/QHuBWJ/tmvNn2IW+E5ic/Do1kkA==
X-Google-Smtp-Source: APXvYqwgnU/a21nfBNFsr9Op7EWEfA1m/SMTKYo3W1G2U2UNy2dJ91UWK8OVcS5yBL8G3n/K45v4vX9Pr75HtsohL8U=
X-Received: by 2002:a92:7e0d:: with SMTP id z13mr505883ilc.168.1573600677105;
 Tue, 12 Nov 2019 15:17:57 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgnjMEvqHnu_iJcbr_kdFyBQLhYojwv5T7p9F+CHxA9pg@mail.gmail.com>
 <Pine.LNX.4.44L0.1911121639540.1567-100000@iolanthe.rowland.org>
 <CANn89iKjWH86kChzPiVtCgVpt3GookwGk2x1YCTMeBSPpKU+Ww@mail.gmail.com> <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191112224441.2kxmt727qy4l4ncb@ast-mbp.dhcp.thefacebook.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 12 Nov 2019 15:17:44 -0800
Message-ID: <CANn89iKLy-5rnGmVt-nzf6as4MvXgZzSH+BSReXZKpSTjhoWAw@mail.gmail.com>
Subject: Re: KCSAN: data-race in __alloc_file / __alloc_file
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Tue, Nov 12, 2019 at 2:44 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Nov 12, 2019 at 02:07:03PM -0800, Eric Dumazet wrote:
> >
> > I would prefer some kind of explicit marking, instead of a comment.
> >
> > Even if we prefer having a sane compiler, having these clearly
> > annotated can help
> > code readability quite a lot.
>
> Annotating every line where tsk->min_flt is used with a comment
> or explicit macro seems like a lot of churn.
> How about adding an attribute to a field ?
> Or an attribute to a type?
>
> clang attributes can be easily exteneded. We add bpf specific attributes
> that are known to clang only when 'clang -target bpf' is used.
> There could be x86 or generic attributes.
> Then one can do:
> typedef unsigned long __attribute__((ignore_data_race)) racy_u64;
> struct task_struct {
>    racy_u64 min_flt;
> };
>
> Hopefully less churn and clear signal to clang.

Hmm we have the ' volatile'  attribute on jiffies, and it causes
confusion already :p

arch/x86/kernel/apic/apic.c:904:        jif_start = READ_ONCE(jiffies);
arch/x86/kernel/apic/apic.c:927:
unsigned long jif_now = READ_ONCE(jiffies);
kernel/sched/wait_bit.c:218:    unsigned long now = READ_ONCE(jiffies);
kernel/sched/wait_bit.c:232:    unsigned long now = READ_ONCE(jiffies);
kernel/time/timer.c:891:        jnow = READ_ONCE(jiffies);
kernel/time/timer.c:1681:       unsigned long now = READ_ONCE(jiffies);
net/rxrpc/conn_client.c:1111:           now = READ_ONCE(jiffies);
