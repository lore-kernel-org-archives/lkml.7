Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47659C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB01206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 13:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJDQrkSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfHMN7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 09:59:51 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:39143 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727724AbfHMN7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 09:59:50 -0400
Received: by mail-pl1-f170.google.com with SMTP id z3so2504397pln.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ftBFYEynUrG71VYjZU1HexLV5i8GQkTYaQFk1n/5Tno=;
        b=mJDQrkSUMldAyUvXs55XlGqmDLCH0aQpx7ChM9DX7T0b4BiZ6SrfNoA+Lx4nAfZ5ig
         Om614mrZQMK4EtryDxkjvS+etMcGQVgnqSJRY9Tl1JVksKV1jAZ2ruA+Q9P2KrSClOsf
         tOitY9VIpO4hVU9KLbd87AVOTw7gU76RSNTcfT+HGxFannGCeW4/7HD9oXkg9abMxPBp
         9+82LRdnnlyPHo4sGk1FiUjvxTLFRX5cI+99QAr5gMehrDjNzZCz9wrechG4MmXVGIrm
         EcbufeJ4F+WFBdiB6Sob6yXdlp4c8KnPZGeQNY3qpUHzCZcUo7NXAILbmistl2UHjXtB
         UfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ftBFYEynUrG71VYjZU1HexLV5i8GQkTYaQFk1n/5Tno=;
        b=OijQOPAiPdHpsDfTNgHGV3+yheEIsqnP5ZZ1iN/0XiV+Uxg6+0a2UHXu+1fQiFTaA+
         sSOR9IJleJpvHQomQ9dvHFUDLgdzfvgqhxwEX3yeUBNYgBmL77c8OBEFsR7czDhhzCz2
         6DWQZ2vfVLtW3t+Y7YSi/9UcEm3cKv9odBNblTs7+EjwzcdQ3W9npJnaL2Pm+5WbvnZ4
         ZaaVV9Y04NrOvt+wdZoxYkTIvG1oWYHfcn/xTfqFxcpcmBWkN4jccVho0BZAmeXJPKBA
         XmnTFxmYrXO4dIvDo3MlqEfTuPy0dGYsugPG4EV3VTU6NoqpmauGD0fRCIUD5Fk8Xs5t
         d74g==
X-Gm-Message-State: APjAAAW50Fkgrtat9Uh+xqoa5c8Fj7CwqFp2D0kH4Pzb48OOlCDVoanj
        6BjqvTZDm1RHPUDmKHQ7sn9tUBk0i8e6pFI7gjGdnruZiMKK/w==
X-Google-Smtp-Source: APXvYqxacBUqIGtFxch6ifNtADcD9dOQvnPPX60v7ti4FSuS2LNlScGOQeLdEmsyCKT842NHY+4T1jFzR0DdpSu6bV4=
X-Received: by 2002:a17:902:ab96:: with SMTP id f22mr31893761plr.147.1565704789671;
 Tue, 13 Aug 2019 06:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <Pine.LNX.4.44L0.1908011359580.1305-100000@iolanthe.rowland.org>
 <1565095011.8136.20.camel@suse.com> <CAAeHK+wyvJbi08ruuOn1qF0O1Jubz_BhZz5wXdNg4Vy5XeyQmw@mail.gmail.com>
 <1565185131.15973.1.camel@suse.com> <CAAeHK+yv-oy_GqMYch7WoVXKOkzpWUmrY9mVY0_FU_0FXjS4nA@mail.gmail.com>
 <CAAeHK+zDVmxgjkZ6dR-sk1=99-Aj=Z4wwxaRCaOXeuYYG3-bUw@mail.gmail.com>
In-Reply-To: <CAAeHK+zDVmxgjkZ6dR-sk1=99-Aj=Z4wwxaRCaOXeuYYG3-bUw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 13 Aug 2019 15:59:38 +0200
Message-ID: <CAAeHK+zsA=O0bgSHij5Opx-RhknnQEhj+2VoCCjLcVRc5Q-=Zg@mail.gmail.com>
Subject: Re: KASAN: use-after-free Read in device_release_driver_internal
To:     syzbot <syzbot+1b2449b7b5dc240d107a@syzkaller.appspotmail.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 3:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Wed, Aug 7, 2019 at 3:44 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > On Wed, Aug 7, 2019 at 3:38 PM Oliver Neukum <oneukum@suse.com> wrote:
> > >
> > > Am Dienstag, den 06.08.2019, 14:50 +0200 schrieb Andrey Konovalov:
> > > > On Tue, Aug 6, 2019 at 2:36 PM Oliver Neukum <oneukum@suse.com> wrote:
> > > > >
> > > > > Am Donnerstag, den 01.08.2019, 14:47 -0400 schrieb Alan Stern:
> > > > > >
> > > > > > I think this must be caused by an unbalanced refcount.  That is,
> > > > > > something must drop one more reference to the device than it takes.
> > > > > > That would explain why the invalid access occurs inside a single
> > > > > > bus_remove_device() call, between the klist_del() and
> > > > > > device_release_driver().
> > > > > >
> > > > > > The kernel log indicates that the device was probed by rndis_wlan,
> > > > > > rndis_host, and cdc_acm, all of which got errors because of the
> > > > > > device's bogus descriptors.  Probably one of them is messing up the
> > > > > > refcount.
> > > > >
> > > > > Hi,
> > > > >
> > > > > you made me look at cdc-acm. I suspect
> > > > >
> > > > > cae2bc768d176bfbdad7035bbcc3cdc973eb7984 ("usb: cdc-acm: Decrement tty port's refcount if probe() fail")
> > > > >
> > > > > is buggy decrementing the refcount on the interface in destroy()
> > > > > even before the refcount is increased.
> > > > >
> > > > > Unfortunately I cannot tell from the bug report how many and which
> > > > > interfaces the emulated test device has. Hence it is unclear to me,
> > > > > when exactly probe() would fail cdc-acm.
> > > > >
> > > > > If you agree. I am attaching a putative fix.
> > > >
> > > > Let's see if it fixes the issue.
> > > >
> > > > #syz fix: https://github.com/google/kasan.git 6a3599ce
> > >
> > > Hi,
> > >
> > > did this ever produce a result? I saw none.
> >
> > Hm, that's weird, maybe that's caused by putting the bot into CC. Let
> > me try that again.
> >
> > #syz fix: https://github.com/google/kasan.git 6a3599ce

Let's fix the wrong title displayed on dashboard:

#syz fix: usb: cdc-acm: make sure a refcount is taken early enough

>
> Oh, wait, it should be syz test =)
>
> #syz test: https://github.com/google/kasan.git 6a3599ce
>
> >
> > >
> > >         Regards
> > >                 Oliver
> > >
> > > --
> > > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/1565185131.15973.1.camel%40suse.com.
