Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDD2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE6120637
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 08:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EA+/5w6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfKVIMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 03:12:17 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:33491 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKVILH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 03:11:07 -0500
Received: by mail-qv1-f65.google.com with SMTP id x14so2544803qvu.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 00:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bunR22uohvLumSntRQCcWdw1R7jgySamsOIo5iz6NMg=;
        b=EA+/5w6i1pKnrL2pn3ktDXOh6H+54aNLV2LSClr5L+8ngdUgBsF1wcv5p1Cj4u95cb
         WIxIp+e45TL/K1UuwGkhJ7ul8TDo9pfGmyYdMe6XbSTo6zT5/DS/KZpHZecgr8pYUvtW
         oemOTf+WY+3qi8tqN05M/LFN0TT9HkwMpyCtBxAK3gMqrcP/SbwT6QYrUimNd8fyCSE/
         +74qcLZpLr8DWUIQo6qATXRLOZzzRIIsvFZMrs4e+gdJMVLvGo2zm1pwulbWZnkmKkOn
         NAz4K1k3iD9e03paQCALC8tYpWLoicbIByko5b1CZ2SRhF4+9YnXjnrJzgIiWHVUOr7D
         CXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bunR22uohvLumSntRQCcWdw1R7jgySamsOIo5iz6NMg=;
        b=Ly4DyHkQsqRiPyN+zGy88WRU//RYs5bH+8ryBL6SYBmM9vngcCpygj9CzchooeaYt8
         nHHOC+fgq/4idlbgumGzU0uxuEox2ot0Yqt861/n+kMigyqgxl2aIlhNuWNiWNZIpAOF
         zbVdSh/9wB7L2gLF8mN90UWVMmosf538FV7JyBSU+o45PvUiloDWxde3m8QKfTbWmp7L
         SnUYJAQNMcHPTWu64xhFKqitR+vM3/0nwJCE7EnJmGAWOW9hpF8CpxEnFINKSIL14oLc
         0I0Ve5ZTU5u0+eB8FoECFtObsSpwq9dugFLN14a2BlbiPFR8AGVx0vHobwppuPvSaLnS
         mCBw==
X-Gm-Message-State: APjAAAXzcwmWj9i3B0RG296RNH4FInwifVgX1hbi1dVd6uLC9KCpH3jC
        mIsmh7eu3O0s8Z9eihrWAdPIEP1papzlj7TuS7/fHA==
X-Google-Smtp-Source: APXvYqygFQrkNm6Bt588zmo6tr7srw9mz4qHapNvIHUVmygRLfGyxXTse6VYxx2Cq5vwWS04IxnKEwPg4nNLc1pthaI=
X-Received: by 2002:a0c:b064:: with SMTP id l33mr12729742qvc.34.1574410265787;
 Fri, 22 Nov 2019 00:11:05 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bf6bd30575fec528@google.com> <000000000000e2ac670597ad2663@google.com>
 <CAHk-=wjg0JXgwb6rkFK0q_JvW7YdGpiPtMVWe=YhFK1y_2-F7Q@mail.gmail.com>
 <14e1a22937ce5a54d94dab04a103e159215fb654.camel@kernel.crashing.org> <CAHk-=wgR=8QX6A6iPAzsD-E38t6Uesa45yWLmeTWZTnK0GbRow@mail.gmail.com>
In-Reply-To: <CAHk-=wgR=8QX6A6iPAzsD-E38t6Uesa45yWLmeTWZTnK0GbRow@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Nov 2019 09:10:54 +0100
Message-ID: <CACT4Y+ZQ6uB2qNjjbyvqgvywZvDay8Zo9mqUw=FhGUysAf9yiA@mail.gmail.com>
Subject: Re: general protection fault in kernfs_add_one
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        syzbot <syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Tejun Heo <tj@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 5:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Nov 19, 2019 at 8:04 PM Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
> >
> > Could this be what was fixed by:
> >
> > ac43432cb1f5c2950408534987e57c2071e24d8f
> > ("driver core: Fix use-after-free and double free on glue directory")
> >
> > Which went into 5.3 afaik ?
>
> Hmm. Sounds very possible. It matches the commit syzbot bisected to,
> and looking at the reports, the I can't find anything that is 5.3 or
> later.
>
> I did find a 5.3.0-rc2+ report, but that's still consistent with that
> commit: it got merged just before 5.3-rc4.
>
> So I think you're right.
>
> I forget what the magic email rule was to report that something is
> fixed to syzbot..

Hi Linus,

This would be:

#syz fix: driver core: Fix use-after-free and double free on glue directory

FTR, the cheat sheet is referenced in every bug report:

> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#bug-status-tracking for how to communicate with syzbot.
