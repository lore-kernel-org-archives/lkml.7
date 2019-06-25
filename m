Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ECDC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E6208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 14:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HmeIFN3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfFYOKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 10:10:23 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37383 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbfFYOKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 10:10:22 -0400
Received: by mail-io1-f66.google.com with SMTP id e5so502550iok.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HCTXmED67QxlWjZdbjfavIVRsAMOts0L1yStcn4Jn/8=;
        b=HmeIFN3VaT8x+NY01emcXpm8Zamxgc+BVsnQYpDctHOPKFpovFlz0g8AW1L7XxvPiX
         Cmwv2NjoowYefQp3Skip40AJpuDw+N4g3eBZxb4KFdqJuLiyOBowVDqBGB7IFO93/lE+
         4uZrOw+/7LNsvNuQxLKiLbYyYNljjQ99vG39YyJW2xw5UYFHYd8LI0ylY9UeMlIuTZFF
         nXKB2eT1TqNWLjTd+srjc27AUctMu50pgnXdGN+KrmzEvcGpUE9GUyqizB77Jf6cmC6B
         hSy0PEBeg6BR7G6pZaNNLjWe5t5Tlf2u1Xpd/L3dqo9CbQ9LkyNgTP7Gdf7weHYpfIgW
         8/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HCTXmED67QxlWjZdbjfavIVRsAMOts0L1yStcn4Jn/8=;
        b=QSrDlf21qWoLjLKKCO7GA8cbpeZEdOEcp5jIqJJf+EjuxGkgQffgQKiRlK9a11sKxP
         6TkDMTRv7WFfpSMV+G1y8/3Gd5UqBBpN0enzXduI/pnIWM1VxTMPQ20IktJl26jBUCnx
         ryrDmTpyWp2f3GOEbio5Vz3ugPLOTFN2MUG/WwMSjDe/Uefd7rcOgEG4LqzZPqcYmWOD
         vZTP301xwBvaGhCxZM06KWErLA3vMCpaLUFsXCRzhBariFrN35t6eretCzO0N+DoRjB+
         Dw3KniFiQHkHkHjmMtOe3yfCqNFZPkisYA9+JekIBbL1f3wEBPCueynhG6/G6GnpiC5D
         3aAw==
X-Gm-Message-State: APjAAAUDK20kYOsbwHFP6NlsotD/1c1ds0/fchXHKm/68QirMFw20eCP
        7ZLJ6NsJOy4LZX+S9E9k/PXSvcRge5SWMT9Y0UHiuQ==
X-Google-Smtp-Source: APXvYqxA2dqVqjyxELQTmigsiEqAOxNPjmvI6AyVFBZtMFeQTh+LxaCmV0cvtm2GMwwhyc4GM23SQGZTDOo08LtVM8Y=
X-Received: by 2002:a02:3308:: with SMTP id c8mr66668066jae.103.1561471821756;
 Tue, 25 Jun 2019 07:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005aedf1058c1bf7e8@google.com> <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
 <20190625110301.GX3419@hirez.programming.kicks-ass.net> <20190625110609.GA3463@hirez.programming.kicks-ass.net>
 <CACT4Y+ZR9T9jGqx2aEijAzA8XP3W5gtGWtgubjW-WXBMirEAqA@mail.gmail.com> <20190625140129.GB3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190625140129.GB3419@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 Jun 2019 16:10:10 +0200
Message-ID: <CACT4Y+YVxwin22VybNyk-AF9ANiYbNeRzbYAbTbOHHtF1qp-mw@mail.gmail.com>
Subject: Re: WARNING in mark_lock
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+a861f52659ae2596492b@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 4:01 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 25, 2019 at 02:07:42PM +0200, Dmitry Vyukov wrote:
> > On Tue, Jun 25, 2019 at 1:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Tue, Jun 25, 2019 at 01:03:01PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Jun 25, 2019 at 08:20:56AM +0200, Thomas Gleixner wrote:
> > > > > On Mon, 24 Jun 2019, syzbot wrote:
> > > >
> > > > > > syzbot found the following crash on:
> > > > > >
> > > > > > HEAD commit:    dc636f5d Add linux-next specific files for 20190620
> > > > > > git tree:       linux-next
> > > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000
> > >
> > > syzcaller folks; why doesn't the above link include the actual kernel
> > > boot, but only the userspace bits starting at syzcaller start?
> > >
> > > I was trying to figure out the setup, but there's not enough information
> > > here.
> >
> > Hi Peter,
> >
> > Usually there is too much after-boot output, so boot output is evicted
> > anyway even if was preserved initially. Also usually it's not
> > important (this is the first time this comes up). And also
> > structurally boot is a separate procedure in syzkaller VM abstraction,
> > a machine is booted, output is analyzed for potential crashes, then
> > the machine is considered in a known good state and then some workload
> > is started as a separate procedure and new output capturing starts
> > from this point again.
>
> Ah, for my own machines I spool all serial console output to a file,
> everything is preserved until logrotate kills it after a week or so.
>
> There is no distinction between boot and anything else, everything that
> goes to serial (and I make sure everything does) lands together.
>
> > What info are you interested in? Can if be obtained after boot?
>
> I was interested in the kernel commandline; and in particular the
> nohz_full configuration if any.

We don't give nohz_full or anything similar. The command line
arguments are available here:
https://github.com/google/syzkaller/blob/master/dashboard/config/upstream-apparmor.cmdline
and few are here:
https://github.com/google/syzkaller/blob/master/tools/create-gce-image.sh#L211
