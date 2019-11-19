Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D3EC432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6C12240C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 19:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574190035;
	bh=ltCIeeLhFvjSQbPxJsGP/R7v7l1/28FeA97JF6ezxYc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KVlUwBZZDgy+KsRwmi4FnYd0Cv3Xdz8YKVUq5Np69yVKYk9EtfEh1NRRNQh2ifmF8
	 0hMtARl4+O9cCjmJCGrG3ulAR1f6P67uwYMGvYnOUwF+npGJkvBdXO9QHL06P31LHb
	 un1+93cNlZEKLkR1RYbpO5hYox+KPZSl/DGUbsYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfKSTAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 14:00:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44622 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfKSTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 14:00:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id g3so24556703ljl.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OF+Hm1yLKQyYYXudgW+BkQo1KPOL73kywpvDxtIxLj8=;
        b=Plbrv5tHUJb0P7rN2sE4VFihDEzSU96EeXoYyr/JkcAFj5zbFTFPhTUimdmhvMUEBq
         OhzKynh0wiTSOkT8dYI+kHFBpPzasJHzONIdCFCsg4B8Kq8egOfpuzjrpluxYP04gFgQ
         GFCXfwdqUmjfCMFCAqdG4nhlfxcx16r/1PQec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OF+Hm1yLKQyYYXudgW+BkQo1KPOL73kywpvDxtIxLj8=;
        b=G5je5NctfDShZlfqaoIGvReyv7dEbfhF3Wgzg/Nr162cLISEJPRq45LoKCq95s4R+J
         m7e0zdrP8JokWfXHSraTIKtv/kaBQguujctLUir6LOj1Zb5G7sUTUI86q0T5sDZ4TR8W
         Kud7gAXp2XDTzMSVDHav1SGcnls9senGN9TmfUIM2Aj/BWh6UCaT0nxxCMLZ0N4btJw2
         lMypKq+iH26CJf673//uz112MRqPDm4WR20LLisItjZGp3mBAi778d+XStlpWLvOPD7V
         QV98zt2HWX29OWyHObxNUFjS95ntbpGV9Ta+N15v18JaT4qiQ/vi+Q/P7cnGTblpEV3L
         w5EQ==
X-Gm-Message-State: APjAAAW97Saw8In/y5PP673ApRrJmiO9i2mgN5gMhGhG+9j2XmrkZujn
        oejQYleQMx68rKQ+NQfgctJxOZmBSJ8=
X-Google-Smtp-Source: APXvYqwj1X412ay62Ri/SQz98QLhaCmLMKM6Zu7jqus58EoRwi/DHPts+Cx+zgKbVxYLumPHUYBWeA==
X-Received: by 2002:a2e:8855:: with SMTP id z21mr5503601ljj.212.1574190029209;
        Tue, 19 Nov 2019 11:00:29 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id s27sm2408403lfc.31.2019.11.19.11.00.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:00:27 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id r7so24598213ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 11:00:27 -0800 (PST)
X-Received: by 2002:a2e:982:: with SMTP id 124mr5474404ljj.48.1574190026950;
 Tue, 19 Nov 2019 11:00:26 -0800 (PST)
MIME-Version: 1.0
References: <000000000000bf6bd30575fec528@google.com> <000000000000e2ac670597ad2663@google.com>
In-Reply-To: <000000000000e2ac670597ad2663@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Nov 2019 11:00:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjg0JXgwb6rkFK0q_JvW7YdGpiPtMVWe=YhFK1y_2-F7Q@mail.gmail.com>
Message-ID: <CAHk-=wjg0JXgwb6rkFK0q_JvW7YdGpiPtMVWe=YhFK1y_2-F7Q@mail.gmail.com>
Subject: Re: general protection fault in kernfs_add_one
To:     syzbot <syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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

So looking at the decode, as usual the noise generated by KASAN isn't
being very helpful, but it does look like at least one of the reports
(I picked 5.2 because I don't care about 4.19 etc) is because
'kernfs_root(kn) is NULL in kernfs_add_one().

Looking at the reports, every single one seems to have a call chain
that comes from vhci_write() -> vhci_get_user() ->
vhci_create_device() -> __vhci_create_device() -> hci_register_dev()
-> device_add() -> kobject_add().

(In this case, "every single one" is by looking at the last 10 reports
sorted by date, it wasn't exhaustive).

The way it got into 'write()' can be a bit varied (splice, write, whatever).

That makes me think it's bluetooth that is the problem, but it might
be an effect of how syzbot groups the reports too, of course.

Might the device have been added at the same time that the last
previous device was removed, so that the parent was deleted as the new
device was aded? I dunno. The repro seem to be a repeated "open
/dev/vhci, write two random bytes to it"

Or might it be some "it happens after you've added enough devices that
something overflows" issue?

Adding bluetooth people to the cc.

                  Linus

On Mon, Nov 18, 2019 at 10:27 PM syzbot
<syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 726e41097920a73e4c7c33385dcc0debb1281e18
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Tue Jul 10 00:29:10 2018 +0000
>
>      drivers: core: Remove glue dirs from sysfs earlier
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168e1012e00000
> start commit:   5e335542 Merge branch 'for-linus' of git://git.kernel.org/..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=158e1012e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=118e1012e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9917ff4b798e1a1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=db1637662f412ac0d556
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10a66c11400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1346c771400000
>
> Reported-by: syzbot+db1637662f412ac0d556@syzkaller.appspotmail.com
> Fixes: 726e41097920 ("drivers: core: Remove glue dirs from sysfs earlier")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
