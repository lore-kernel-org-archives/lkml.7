Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E561C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A02214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 12:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cj50z+yv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfFYMH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 08:07:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46994 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfFYMH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 08:07:56 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so226050iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bfKN4YpaL6w4Kk3YgIsYRQp7M31VhMs8bgkDZeV/Vp4=;
        b=cj50z+yvosF1BT1nYJbNU7aZhdDkf6cMobWD94Z+vcW94tJ1GuN8FHvkJ7rfsbEn8c
         AnUb1S9bADCl3M7JYP6YM0agZiMZ4baKMeVmQqBMTgj1I83QRe0xtW0XY7OUjrUeb8tk
         ou7LXyL7XM8gpP5a3J2fg3uidwsbOTQyOqXAo2FuWU4bAE1JJkAD/wynpDisQSAtGbHj
         ctt+diADsmsdz/HBMFxn8cJuL8hn6NFRMawBLbvzxjvM6yxWJuDPQFJYVr7vZ26GwPkS
         8NiHqVGBGRs+FaXsuXqZi7clKJHuysHsbQ6uthkTQWJJX2UjpfecbGwbxnynWrH49oLO
         ntww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bfKN4YpaL6w4Kk3YgIsYRQp7M31VhMs8bgkDZeV/Vp4=;
        b=a7okKWRyJ0H3OlrIOUvqEQ3ccB4aX783ueqUnWTaQOMPX9M5ZKo0ZoqeDtKgZIVUyF
         EIHZ1UE0TsaXzM7YgPaNw0YPkPwgt+UHbQCfFHlJpiipeHoh+j4KNSCItDH+6b7YYW/C
         vK9nQ16RAWyMdrxUTWVIb0qa/6OOsEYYCxDC3BWsSI6j2/gss7baK3pwF9ifWC8v+kuX
         0JQuZsm20EXd/4KLFC+3HuccqT15QWlKeHzw1z8rO1bAC6GKoKuTha2upiKHiFGaUcXc
         3iZZVMsc5Z9QF7j8BChs0DZY4SqbalKU//6TSNPhkp194RL1aw72DctXdJ9R9m+APPXN
         6/cg==
X-Gm-Message-State: APjAAAXwlj4Vp0wmV/vuknf7Q9RCOMNTm3k7aNED5NHwVJ7Q21TG4HSF
        1KxuwRbrK3Qg0+/fpYiTXjVbr0m8O9pcezFKKDC1vw==
X-Google-Smtp-Source: APXvYqzgOIFJj7sflWL6DOoRD6b4lz0xYBdry2ZMhuFVZtSLc77sm8zbI1qKkj2QKW47q5erWOWx9Hr6kk2ObsWG3G8=
X-Received: by 2002:a02:c7c9:: with SMTP id s9mr131173089jao.82.1561464475045;
 Tue, 25 Jun 2019 05:07:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000005aedf1058c1bf7e8@google.com> <alpine.DEB.2.21.1906250820060.32342@nanos.tec.linutronix.de>
 <20190625110301.GX3419@hirez.programming.kicks-ass.net> <20190625110609.GA3463@hirez.programming.kicks-ass.net>
In-Reply-To: <20190625110609.GA3463@hirez.programming.kicks-ass.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 25 Jun 2019 14:07:42 +0200
Message-ID: <CACT4Y+ZR9T9jGqx2aEijAzA8XP3W5gtGWtgubjW-WXBMirEAqA@mail.gmail.com>
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

On Tue, Jun 25, 2019 at 1:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jun 25, 2019 at 01:03:01PM +0200, Peter Zijlstra wrote:
> > On Tue, Jun 25, 2019 at 08:20:56AM +0200, Thomas Gleixner wrote:
> > > On Mon, 24 Jun 2019, syzbot wrote:
> >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    dc636f5d Add linux-next specific files for 20190620
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=162b68b1a00000
>
> syzcaller folks; why doesn't the above link include the actual kernel
> boot, but only the userspace bits starting at syzcaller start?
>
> I was trying to figure out the setup, but there's not enough information
> here.

Hi Peter,

Usually there is too much after-boot output, so boot output is evicted
anyway even if was preserved initially. Also usually it's not
important (this is the first time this comes up). And also
structurally boot is a separate procedure in syzkaller VM abstraction,
a machine is booted, output is analyzed for potential crashes, then
the machine is considered in a known good state and then some workload
is started as a separate procedure and new output capturing starts
from this point again.

What info are you interested in? Can if be obtained after boot?
Perhaps I can give it to you now. And there is also this long standing request:
https://github.com/google/syzkaller/issues/466
to collect some kind of "machine info" along with crashes. Perhaps we
need to add the info you are looking for to that list.
