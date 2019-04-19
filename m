Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F42C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA3C204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GhPbXeAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfDSSjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:39:53 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36192 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfDSSjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:39:52 -0400
Received: by mail-yb1-f194.google.com with SMTP id e76so2322949ybc.3;
        Fri, 19 Apr 2019 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heT2Fiu4i5olnWvQfzuhWUCvK7pfdqNTELrz3cur6Vk=;
        b=GhPbXeAOwhAEB/9KGJplG/h/JbxDFzQMgy5qndFrfiqD+pHxO/JnQ3XM1vq/7arYlF
         K3zDNPRdMsZcjIeRKzThdC8pP/Un+kLGZtDp6846K6WQlzY20t56aQbr8rzKiX4r88AR
         MOIsFFv2ES35R9W+McWYMtc4tG4hasIOb8SfBYpBThxFnMPXeay6aMbHMPnrlmPH/3mS
         ZI25cZRKvXOKi2xxwx4RCIZsCqe5CPsdV1I/wWGuXn2tVaYIVW5tOqyUks5pabvQXHbg
         2u4cnUED4o4hft6IG7M84EAtsbr9g+aBjknp+o4HRez5UCOKgttDAdQXBBEm1InKmpPA
         v5ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heT2Fiu4i5olnWvQfzuhWUCvK7pfdqNTELrz3cur6Vk=;
        b=jJWA/SuH+loGJZe55vVkcEznSpDhgUwUgS9LWUdR5pOjI+7jCCzBYJvnXSmBDpvB09
         dQCbZyzv01RpynXe9K2T3Flu2tE73Jk4nA3Qd79GQioNryd/calvbW1cAcuhrSzBYU1H
         F96Vi/0b2FkXveUIelqty6AUiTrhDnXA93IIaff1SK4xckLQ7Als+RgFya4qGTw+CeRg
         VImfuakGCXyE9TOMMCO7g+4eYjP0/xA048EcTHG8d8aURHG7pcwejBKbYqcdTggwFCVp
         StQvVgXDakLcg/5OjEShkNEk/t7Knl3pm7o5+QVHUXAHaClQ/jB7cFKHX/djeyKR15w2
         LHzg==
X-Gm-Message-State: APjAAAWymx+nkJkTDgq3Uwb1/ZKzkz5yUq/5oP+jEfbjM7Bs56eC7mXA
        5X8dhV18m98wZYhmWJorMjtEhVOjshB0YmKGmnRbTmb8
X-Google-Smtp-Source: APXvYqwQE6u5kucbo7rlQ7VC5EseV1ZNo3zjvTRTbsUCG9hUYJhFPlqXQglxP0ZCiC+icSDE46/NOCWt6ywkavIE8Ac=
X-Received: by 2002:a5b:64a:: with SMTP id o10mr1673373ybq.32.1555660386981;
 Fri, 19 Apr 2019 00:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007dedf00576dd53eb@google.com> <000000000000c51f7505850b5f3e@google.com>
 <CAOQ4uxgUNDTWvFzFJR_OENBZ_hYtwLGHem_yUd406hr7f5QX+g@mail.gmail.com> <CACT4Y+bXB06ZAdvwsdgsNvscOUBemH7C_G-ojKirGVeGefCWpQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bXB06ZAdvwsdgsNvscOUBemH7C_G-ojKirGVeGefCWpQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Apr 2019 10:52:55 +0300
Message-ID: <CAOQ4uxhm_gShPC_gbRePGoq5xTU3m_cvJ5fosxpyX=aXA5AmCw@mail.gmail.com>
Subject: Re: possible deadlock in acct_pin_kill
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:23 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Mar 27, 2019 at 8:16 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > On Wed, Mar 27, 2019 at 5:53 AM syzbot
> > <syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com> wrote:
> > >
> > > syzbot has bisected this bug to:
> > >
> > > commit e950564b97fd0f541b02eb207685d0746f5ecf29
> > > Author: Miklos Szeredi <mszeredi@redhat.com>
> > > Date:   Tue Jul 24 13:01:55 2018 +0000
> > >
> > >      vfs: don't evict uninitialized inode
> > >
> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12123143200000
> > > start commit:   da5322e6 Merge tag 'selinux-pr-20181115' of git://git.kern..
> > > git tree:       upstream
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=11123143200000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=16123143200000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d86f24333880b605
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=2a73a6ea9507b7112141
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12298533400000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ff545d400000
> > >
> > > Reported-by: syzbot+2a73a6ea9507b7112141@syzkaller.appspotmail.com
> > > Fixes: e950564b97fd ("vfs: don't evict uninitialized inode")
> > >
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> > The repro seems fine for catching the subject bug, but I can't get it
> > to reproduce on my system. I have written a simpler reliable repro.
> > Its in the commit message of the patch to test below:
> >
> > #syz test: https://github.com/amir73il/linux.git acct_pin_kill_deadlock
> >
> > I have been pinging Al about the fix above for a while, but no response:
> >
> > https://marc.info/?l=linux-fsdevel&m=155119096826039&w=2
>
> I would ping it as well, but I can't find it in my inbox. Is it on LKML?
>

No. it's scope is linux-fsdevel.

Anyway, this fix by Al is in linux-next now:

#syz fix: acct_on(): don't mess with freeze protection

Thanks,
Amir.
