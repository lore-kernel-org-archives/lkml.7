Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AFDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DF0D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDKi5kGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390607AbfCVMbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:31:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:39812 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390291AbfCVMQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:16:56 -0400
Received: by mail-it1-f194.google.com with SMTP id 139so2897368ita.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 05:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YW0V78Vu4h5rSxMfAZ1y6bOUKJxVXX904UGaBFUKQa8=;
        b=WDKi5kGgQoYwzYVeTQGYAfCluHUyqqkQr4L8XoBUwwRZ3Rg+07S302dhmtQ+U8cm7l
         T64sdCX78UXmCrajT2z1ppLdxsApxO4uxZBxOFTnwyWEw+tnwsKrJ2UhxFyXM4G+wPUw
         0UrCAaHqC/wLO1N8dvoxsuLcjUV3ClatF+q/UQGQFpLxhoSF1y3CPuartj6QbQ3yVGio
         eOFkathweuzmY2hzgwHobGIs1BFTiTcZaiHbO1J2wSsRaKjB5L6MwxiZ4lzY+sz/3MPW
         uwHa3CUIpQ4FmfXzen4U2NLHa/AcRR562jzCzurIy7A+KTL6C7w7HryfziZNyiMUPr5M
         mcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YW0V78Vu4h5rSxMfAZ1y6bOUKJxVXX904UGaBFUKQa8=;
        b=uYpeO4JVxC4ZwPt001lzbVbj4swsxvcsCDuHx9o9EXpbxYSiXGUSBLqaaBMihkdotz
         ZAG6VvASeF8aPmU/jPolLb+DOxac5E35Htq57ptkDUv2y0BDvX+poGu6VQRFzX/f2ddQ
         WOOfwQ7JOSdC7rET7fDpo1kWo1BMUK0bIy9xhrDk+fYeCc8daZUyPE9jO6AnC+TS6LsF
         9jvwWmsb8f/o0sKcFSBnSg+eVeXyFOW1ZdBPyvv5SOca4mKx482bCjqeYUsEItMxCOsb
         nRCQj/oypYY5UbgUribzYOjBm3w87ZkFRSkixTfamlAW02GkLUJUkKnsM/y4qDLdd5AJ
         FkWQ==
X-Gm-Message-State: APjAAAXc/OR1vkGJMFwfrT0w+16YDHpPGfckHi3ll0WT4CEQQWRXzkB7
        k9lmvyPXwyzVDOuHvv35XqorpsTYQ8wwW9o62OYiDA==
X-Google-Smtp-Source: APXvYqxW+fbLoSgmqWDCRVDgW60p0UzonxKZfDmM1G9AzaUHotxUW5g5bfKL4XCdaufNXQCj6gvKPUNBytz7C3jvfbM=
X-Received: by 2002:a02:84ab:: with SMTP id f40mr6306106jai.72.1553257015828;
 Fri, 22 Mar 2019 05:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003692760578e651dd@google.com> <0000000000007917ff0584ada6e7@google.com>
In-Reply-To: <0000000000007917ff0584ada6e7@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 22 Mar 2019 13:16:44 +0100
Message-ID: <CACT4Y+b0Onk4AB0hkvhXgZPdk+rERFsYAQra681o6QLDH_Ct-g@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in hci_sock_release
To:     syzbot <syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        "open list:KERNEL BUILD + fi..." <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Michal Marek <mmarek@suse.com>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 1:04 PM syzbot
<syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit c470abd4fde40ea6a0846a2beab642a578c0b8cd
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 19 22:34:00 2017 +0000
>
>      Linux 4.10
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1664c6df200000
> start commit:   c470abd4 Linux 4.10
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7308e68273924137
> dashboard link: https://syzkaller.appspot.com/bug?extid=b364ed862aa07c74bc62
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=152532bb400000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13f73320c00000
>
> Reported-by: syzbot+b364ed862aa07c74bc62@syzkaller.appspotmail.com
> Fixes: c470abd4fde4 ("Linux 4.10")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

The same story of HCI being broken before v4.10, so this is bisected
to the release.
