Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9117FC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E8CD206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P/gkTfFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfDWPFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:05:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44113 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfDWPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:05:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id y12so5099120plk.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OD+RZV04VouyQVp1GzCs1QA3xxiEWeSzMkM54So/b1E=;
        b=P/gkTfFf/IvM4b2jKbyt7svwWoM8xvT8fBn07/PS/H2K5eVPxwxs0B3K491rZsdR4T
         liBRFWfFFbnkRImFaZKn0XYKl49935OnVwDspPBXJJVfPdy2VMU1gkyUFLq+H/0Es7SG
         ChbvlSo/H6mPh/ti2aXubOQOQmgWebjklgmojczusppy2BocA17DikVCWC0OKaqiAOaw
         ns7sn/qvMsRXZZLh613YJq0MDCdlxEdXhJJiuXe7/95u1FIb9O8t0QZ5t6eFLcL0sRmm
         ZOj+vRVhQmetCdE5eHiG2y+e+czKSpClT8eSHTqUFhBFWDvk3gcbZhyLpXelkI4XDzDO
         39Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OD+RZV04VouyQVp1GzCs1QA3xxiEWeSzMkM54So/b1E=;
        b=E2NZa27cd/r6TxI++YIhzz18NX4RMgC7Xf6sNpVDGKCtSsppumlR7kDdSkS3H2A6MW
         9tKkPEmBvjkNTbVq7qNpW92eO9L/+GO/Spz7HC47psDuynNfRgGg4vIYi54yoHdcGdFQ
         V1byYmClVBPq3QYCkOHWPxwMQfbrv3ARUiPlNzfpp6Rm/1XjjffMorEfNwZNCDsoU3gW
         xliPSnfBTmKCvPedaXkRl0cgGDUOhRIUJ9BIfxaLcduOUPC4IOnT6OKOX8DD3zI4vURZ
         hJXJRpVfx1CrbKhonwXi7okNeP7l4PWovxcC73HNSmKwDYezBIC1/1C7nYoiBM2g+H3n
         I6AQ==
X-Gm-Message-State: APjAAAVeWU4J0CxnycumT5xHmMdxXhTfrh9H/n8vOk/L3WOGepVPjF4Q
        EofVXcPk3hq4JKbENMMxQdCv9/MB7U8mZik9KFQnJVK347lKKQ==
X-Google-Smtp-Source: APXvYqxD0jWt64GjYbWfNRXykoTSI3tXj/XFafdavhMsZqvORYGpMFssNpaGA8SGXLZQIehqHM06Z6ZmSbBSXcjw7kM=
X-Received: by 2002:a17:902:2b89:: with SMTP id l9mr25383680plb.329.1556031941580;
 Tue, 23 Apr 2019 08:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000029431d0586d10813@google.com> <Pine.LNX.4.44L0.1904221344550.1384-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904221344550.1384-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 23 Apr 2019 17:05:30 +0200
Message-ID: <CAAeHK+zUiv+CSip7OwrQ6FKxwE_+Wh0LTmGW86ipQ5QkaAOT8w@mail.gmail.com>
Subject: Re: general protection fault in __dev_printk
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>, rafael@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 7:53 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Thu, 18 Apr 2019, syzbot wrote:
>
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    d34f9519 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10adfe6b200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=c73d1bb5aeaeae20
> > dashboard link: https://syzkaller.appspot.com/bug?extid=2eb9121678bdb36e6d57
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=145cb7e3200000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17f8bd2d200000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+2eb9121678bdb36e6d57@syzkaller.appspotmail.com
> >
> > yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> > usb 1-1: USB disconnect, device number 112
> > yurex 1-1:0.150: yurex_interrupt - unknown status received: -71
> > kasan: CONFIG_KASAN_INLINE enabled
> > kasan: GPF could be caused by NULL-ptr deref or user memory access
> > general protection fault: 0000 [#1] SMP KASAN PTI
>
> Andrey:
>
> This original bug report included a "USB disconnect" line, as shown
> above.  The newer results, for runs with my patches added, do not.  At
> least, if such a line was present, it didn't show up in the console
> output files -- the most recent one contains nothing but repeats of
> that "yurex_interrupt - unknown status received: -71" line, although
> for devices on multiple buses.
>
> Is there any way to get more information about what's happening, such
> as a complete kernel log?

It should be possible to provide the full log for the result of the
"syz test" command. I'll talk to Dmitry about this when he's back from
vacation next week.

> And perhaps to run the test with just a
> single dummy-hcd bus instead of 6?

Hm, it might be possible to implement overriding of syz-execprog flags
and provide them via "syz test". It's not implemented right now
though.

Running the reproducer manually is the most flexible way to make
changes to the way it's ran or to make changes to the environment. In
this case I haven't managed to reproduce the hang manually though :(

I see two ways to deal with this right now:

1. Submit your fix (it fixes the original issue for me) and wait until
it gets into the usb-fuzzer tree. Then maybe syzbot will report the
hang and provide a better reproducer.

2. Change the testing patch to also suppress those "yurex_interrupt -
unknown status received: -71" messages and rerun the "syz test"
command. Hopefully then syzbot will provide the full kernel log.

>
> At this point, I suspect the original general protection fault in
> the yurex driver has been fixed, but something else in dummy-hcd may be
> causing the rcu-detected stalls.
>
> Alan Stern
>
