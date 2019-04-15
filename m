Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59CAC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA4220848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 17:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ApHHfgv/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfDORs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 13:48:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35712 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfDORs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 13:48:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so8938421plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 10:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Dv+R0VL/bb+jQfziwn2QW1zo1nWTJgpQUXYmCc2ap4=;
        b=ApHHfgv/brsFKSwRUyz8eNdWSjFtlZ9bNiUxkt0ycFqZT0cx7Y/xeGghp+2fEUlF04
         ouZ9QvcWV+4ovzmtFoT961GYF1yUmC4yIWZ50XHsg99XypZYRl9GqOCeUaPCrjZOOirT
         EjIQtArdWE+HNSZiGgD1Gwgg53iym4wMFtRyl/qxR3Mk/t8umK6xQT4JCvL/OAmIOrHP
         9arDv4lw325LlfASfzSw/39anUuyhn1E/k06PH2uAkzeJB2mwq+Gqpq+W8bq928RxDuf
         Igrp7nDkE8qBlrRXFkRDnw0HmDk3vfn+fPAUpPdUSmp7/MIYzImOzVdevIBYKhuw6X7U
         evCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Dv+R0VL/bb+jQfziwn2QW1zo1nWTJgpQUXYmCc2ap4=;
        b=SLn66x9wEWEFMEtHFbrJzZ1REq1QUNIlLcqGyL5f7SVsWlrsGgjhpgMYEJl94m0Eqk
         vL0rPchEkFUqhAnCvBXmxsA1EKmdVmE0l169cJ8hquXZ6kngp4dFmrBBOoqfPBfgGFaa
         m3CLCt0nH8CHBu+OCDJtP0ANl7Ff3iRmiVYcPjViXNYdnX1hyNsLc+k2SNQYIOVGI4er
         LqE6Gz8JMkmei692OoSEeukQC//5uyxw47wSNZBHuZ4fRa45VxJRXrkIdFEnyyp00fv+
         xkPYK+Tz1jw2AgYME+bqW30X2zChjaMETnhG+jkhmMM8agR9m4TkJnEkUxhh4bKQpXqw
         s42g==
X-Gm-Message-State: APjAAAUZJEioYaNQ/JJNjLeEOAERy/H9iMs2eGW1Wb4irG/COln1noZS
        1TJS1eBSsDVWZAFx0sJJzMl7SD6M8+sBfaGaFBJtyA==
X-Google-Smtp-Source: APXvYqyLCe79Crj+h8qxyZJJMXZlAmSLdWORBWOAlSt3hOuWVlrS2thdXslxIN4DWKPBsrLbk8kFOgT3pEOU6EopIOc=
X-Received: by 2002:a17:902:b48c:: with SMTP id y12mr74860592plr.280.1555350507794;
 Mon, 15 Apr 2019 10:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000006f1596058653d991@google.com> <Pine.LNX.4.44L0.1904121540001.1283-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1904121540001.1283-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 15 Apr 2019 19:48:16 +0200
Message-ID: <CAAeHK+wrF8Oh7ur+BcuyARvm2sx6KNVGFxqKHoyajApN+tOA_g@mail.gmail.com>
Subject: Re: INFO: task hung in usb_kill_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        gustavo@embeddedor.com,
        Kernel development list <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 9:46 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> Andrey:
>
> It's really hard to tell just what's going on here.
>
> On Fri, 12 Apr 2019, syzbot wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    9a33b369 usb-fuzzer: main usb gadget fuzzer driver
> > git tree:       https://github.com/google/kasan/tree/usb-fuzzer
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14c4c1af200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
> > dashboard link: https://syzkaller.appspot.com/bug?extid=d919b0f29d7b5a4994b9
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14410dbb200000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12f0acd3200000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+d919b0f29d7b5a4994b9@syzkaller.appspotmail.com
> >
> > usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> > usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> > usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> > usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> > usb-fuzzer-gadget dummy_udc.0: failed to start USB fuzzer: -22
> > INFO: task kworker/0:2:532 blocked for more than 143 seconds.
> >        Not tainted 5.1.0-rc4-319354-g9a33b36 #3
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > kworker/0:2     D26656   532      2 0x80000000
> > Workqueue: usb_hub_wq hub_event
> > Call Trace:
> >   schedule+0x8f/0x180 kernel/sched/core.c:3562
> >   usb_kill_urb drivers/usb/core/urb.c:695 [inline]
> >   usb_kill_urb+0x22a/0x2c0 drivers/usb/core/urb.c:687
> >   usb_start_wait_urb+0x257/0x4d0 drivers/usb/core/message.c:63
> >   usb_internal_control_msg drivers/usb/core/message.c:101 [inline]
> >   usb_control_msg+0x321/0x4a0 drivers/usb/core/message.c:152
>
> It looks like something is stuck waiting for usb_kill_urb() to finish.
> But what happened before that?

This crash is somewhat special. It happens quite often during USB
fuzzing, but at the same time it's a hang, which makes it a bit harder
debug. I initially thought that is somehow related to my custom USB
fuzzing kernel patches, but then I saw that someone else hit this
issue while doing USB fuzzing in a completely different way that
doesn't require kernel modifications. So it might be an actual issue
in the kernel.

The full console output is provided by the syzbot, but I guess it's
not very useful in this case. I've just made sure that this issue is
manually reproducible, so we can easily retest it with debug patches
(syzbot should be also able to do that via the syz test command). Or
is there a way to turn on some verbose mode to see some USB debug
messages?

>
> I can't tell from the reproducer source, because it uses a bunch of
> special stuff you added in your usb-fuzzer tree.
>
> Alan Stern
>

I understand, for now I guess the simpler way to debug this is to run
the reproducer. I'll write you and Greg a separate email regarding all
that special stuff that I added.

Thanks!
