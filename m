Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EE8C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD992072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMdNoJtw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfLQKsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:48:22 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40150 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfLQKsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:48:22 -0500
Received: by mail-qt1-f195.google.com with SMTP id e6so1256633qtq.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 02:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QHKgYKLOTds7ZzufnZzWPK35ejHIGRPsvP3ywQExKrE=;
        b=UMdNoJtw4DMwxm+nbiqf5cqfjEvOgZ/Y5jbVqmKSmnjZrpCB6/rM6s8Qc9BGUlczyk
         yaEXujUqY5asZYdUJTPbeYENyUDBNxVWCSSf7qhPmn9McAO9+4tnrKw+CVyN9r1dBnx1
         t13/0qlwOkq7cHGl27LYJ0ScBiKHsPxRMMVrDAE9hm5krpF01YjsC1W7p6n9JmXiXovg
         suWwuWPrLMAcv1ZQ59yrNFvcRHTDSkdgnjHHmdP2fQTJcUZNAHqJj98ZPrr7QFx44mWo
         pxoftpcDnIs1sLlZX1e1zN2oUJZL8231HgZtEU/ViL2PGybjhrjqyCYS/CvWXWpdFH1d
         FHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QHKgYKLOTds7ZzufnZzWPK35ejHIGRPsvP3ywQExKrE=;
        b=FKg2Nqg+BmVl5MjZhxgBfg6CEOBvKiIgWZESg2/NGiV6j3MpMo4e8wibA2cBaJBUbK
         PxtUFor5rathHFV2apYHqJdNd4bj+TW2dhB+xrnBDROsZ2KTvUiAu4fvsjWBlR3vY5xb
         kY2REnHflF0Y8p34e+Hh/4vSlfBfL282NMA7tJU1IjettfOmg4tjgTTpyFZWEhuN0Dlp
         zIqFT5RHTVXtM+IyeoR6zKjtIo+05FYpae5zvOut9cIwzAzyybSoSI7kEVbc50ZRRFzU
         PPx/PMDGDm7U0OjXjX9SIQhiNBlvxCx9QfurAEHIbhW7qF6CcX1jifVvL+/a7mvrnh8T
         o20A==
X-Gm-Message-State: APjAAAXzgDdE4dOnsKXILZvDdUeU+0H6goeCWU4bmZ0DatVXrsI2kCI6
        s/WR1XXeofhR5hvq4HjyJZkvCFQ/2OAIK31Pw8l+iQ==
X-Google-Smtp-Source: APXvYqyHVCaQT1CUC/NXQeXukLqetC2RAudOObXK18S/RhalOQnJwJU+9kHj3Ybzg6gBzDd9Soe8XPo3yJ0f4GPdagA=
X-Received: by 2002:ac8:30f7:: with SMTP id w52mr3870882qta.380.1576579700163;
 Tue, 17 Dec 2019 02:48:20 -0800 (PST)
MIME-Version: 1.0
References: <00000000000053539a0599173973@google.com> <20191212105701.GB1476206@kroah.com>
 <CACT4Y+ZeR=z-3CSXFazmngUhs9DqfxgZLKBNhzvfg49Nrw=EzA@mail.gmail.com>
 <20191213093357.GB2135612@kroah.com> <CACT4Y+beoeY9XwbQX7nDY_5EPMQwK+j3JZ9E-k6vhiZudEA1LA@mail.gmail.com>
 <20191213101021.GA2141429@kroah.com> <CACT4Y+ZW8oLfupDbQuk-Q-J=WtsXPEXTsqeZAPGhXXPu4gGrmg@mail.gmail.com>
 <20191213112648.GA2257852@kroah.com>
In-Reply-To: <20191213112648.GA2257852@kroah.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 17 Dec 2019 11:48:08 +0100
Message-ID: <CACT4Y+aC+Phfj91wdWJPH+zKcHLXPXQE9Ycn--qKboFHPnMW+g@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in mem_serial_out
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+f4f1e871965064ae689e@syzkaller.appspotmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asierra@xes-inc.com, ext-kimmo.rautkoski@vaisala.com,
        Jiri Slaby <jslaby@suse.com>,
        kai heng feng <kai.heng.feng@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        mika.westerberg@linux.intel.com, o.barta89@gmail.com,
        paulburton@kernel.org, sr@denx.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        yegorslists@googlemail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 10:48 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Dec 13, 2019 at 11:39:54AM +0100, Dmitry Vyukov wrote:
> > On Fri, Dec 13, 2019 at 11:10 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > You set up a dubious memory base for your uart and then get upset when
> > > > > > > you write to that location.
> > > > > > >
> > > > > > > I don't know what to really do about this, this is a root-only operation
> > > > > > > and you are expected to know what you are doing when you attempt this.
> > > > > >
> > > > > > Hi Greg,
> > > > > >
> > > > > > Thanks for looking into this!
> > > > > > Should we restrict the fuzzer from accessing /dev/ttyS* entirely?
> > > > >
> > > > > No, not at all.
> > > > >
> > > > > > Or only restrict TIOCSSERIAL on them? Something else?
> > > > >
> > > > > Try running not as root.  if you have CAP_SYS_ADMIN you can do a lot of
> > > > > pretty bad things with tty ports, as you see here.  There's a reason the
> > > > > LOCKDOWN_TIOCSSERIAL "security lockdown" check was added :)
> > > > >
> > > > > The TIOCSSERIAL ioctl is a nice one for a lot of things that are able to
> > > > > be done as a normal user (baud rate changes, etc.), but there are also
> > > > > things like setting io port memory locations that can cause random
> > > > > hardware accesses and kernel crashes, as you instantly found out here :)
> > > > >
> > > > > So restrict the fuzzer to only run as a "normal" user of the serial
> > > > > port, and if you find problems there, I'll be glad to look at them.
> > > >
> > > > Easier said than done. "normal user of the serial port" is not really
> > > > a thing in Linux, right? You either have CAP_SYS_ADMIN or not, that's
> > > > not per-device...
> > >
> > > Not true, there's lots of users of serial port devices that do not have
> > > CAP_SYS_ADMIN set.  That's why we have groups :)
> > >
> > > You can change the baud rate of your usb-serial device without root
> > > permissions, right?  That's a "normal" user right there.
> >
> > Yes, but this requires dropping CAP_SYS_ADMIN. And one can't drop
> > CAP_SYS_ADMIN only for ttyS. If it would be a separate capability, we
> > could drop just that, but not CAP_SYS_ADMIN.
>
> Ok, I think we are talking past each other here.  I am saying that it is
> fine to talk to a serial port without CAP_SYS_ADMIN.  That should be
> "safe" and not cause bad things to happen.
>
> But if you do have CAP_SYS_ADMIN, you can do a lot more "bad" things
> with a serial port (like setting memory addresses).
>
> Your tool always has this capability, which is fine, but does not mean
> that serial port accesses by everyone has to have that capability, which
> is what I thought you were saying.

I mean that I don't see a realistic way to apply your "Try running not
as root" suggestion.
We can drop root, but that will dramatic effect on lots of other
things that has nothing to do with serial console.



> > > > As far as I remember +Tetsuo proposed a config along the lines of
> > > > "restrict only things that legitimately cause damage under a fuzzer
> > > > workload", e.g. freezing filesystems, disabling console output, etc.
> > > > This may be another candidate. But I can't find where that proposal is
> > > > now.
> > > >
> > > > A simpler option that I see is as follows. syzkaller has several
> > > > sandboxing modes, one of them is "namespace" which uses a user ns, in
> > > > that more fuzzer is still uid=0 in the init namespace, so has access
> > > > to all /dev nodes, but it does not have CAP_SYS_ADMIN in the init
> > > > namespace. We could enable /dev/ttyS* only on instance that use
> > > > sandbox=namesace, and disable on the rest. Does it make sense?
> > >
> > > Maybe, I don't know.  Why do you have to run the fuzzer with uid=0 in
> > > the first place?
> >
> > There is a number of reasons.
> > 1. Lots of kernel functionalities are protected by CAP_SYS_ADMIN for
> > unclear reasons. Changing global resources would be reasonable to
> > protect by root (e.g. changing hostname or eth0). But say if I am
> > mounting local image file in my local directory, or applying bpf
> > filter to my socket that should be nobody's business because it does
> > not affect anybody else. But these things require CAP_SYS_ADMIN in
> > Linux. As a result users use sudo left and right, which leads to a
> > mismatch between what users expect and what kernel provides. If you
> > mount a USB stick or image downloaded from internet, there is no way
> > you can verify each and every byte of it manually (and it's not work
> > for humans, it's work for machines), so you just sudo mount it
> > assuming kernel will handle any bad data. But kernel assumes it's
> > protected by root, so no particular guarantees, all responsibility is
> > on you. The only way to shake out bugs in mount/bpf/etc is to test
> > them, but it requires CAP_SYS_ADMIN.
>
> Ok, that's fine, but don't test serial ports with that setting and
> expect to have a "safe" system :)
>
> > 2. Kernel should not crash on invalid inputs in most cases even if
> > they are provided by root. Root can make mistakes, programs that root
> > uses can contain bugs. Useful diagnostics are always better than
> > silently corrupting memory.
>
> Fine, but we have legacy apis that we have to support, like setting
> memory locations of ports, and those we protect with that capability.
> We can't change this, sorry, and so if you try to fuzz it, maybe just do
> not change those "known to be able to do bad things" settings.

Precisely controlling what's being done is only possible in unit
testing setting. It's not that simple in a fuzzer setting. Precisely
restricting behavior of random programs is both (1) extremely complex,
(2) will over-restrict, read, make fuzzer less efficient, (3) still
most likely will be unreliable with lots of corner cases.
So I am looking for a more practical solution.


> > 3. On Android/with lockdown/security modules root is not necessary
> > completely trusted entity. Using a memory corruption root can e.g.
> > unlock lockdown.
>
> Fine, but again, we can't remove these old apis.
>
> > 4. Last but not least, using root functionalities may be required to
> > find critical non-root provoked bugs. Consider you (root) setup
> > bpf/mount something/setup a socket in a particular, but totally normal
> > way, but then a memory corruption is caused by a malicious packet
> > arriving on network (but it requires that root-only setup done on the
> > host). But giving the fuzzer root we can find such bugs.
> >
> > We get this far with uid=0. Things were worse initially, then we did
> > lots of sandbox tuning (e.g. we still do new net ns now even if under
> > root), some syscall refinements (e.g. no FIFREEZE), disabled
> > /dev/mem/kmem/ports. There are no major problems now, except for very
> > rare and isolated cases like this one. I would very much not like to
> > abandon uid=0 wholesale at this point.
>
> Ok, then don't abandon it, just be more judicious when fuzzing the
> serial layer with what you do, and do not, change.
>
> thanks,
>
> greg k-h
