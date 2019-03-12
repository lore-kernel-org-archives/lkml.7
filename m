Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4ADC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D820206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXfF694R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfCLRrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:47:10 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37512 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfCLRrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:47:09 -0400
Received: by mail-io1-f66.google.com with SMTP id x7so2888724ioh.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WS/zoe9Fq2qDK9lRGH6W30+/oPnf/aVCcbDJGZCBBdU=;
        b=XXfF694RgGbcN683Zkyd3LiWrPi6C7L7emapJR2qyNEO4NAsgHJsu0w9613q72tCcO
         K6OESGGQr0YVti0KgrkZD5Pyqb4Zbkeg6CC681Y8YQdvR2RrVeoTuQRuZ7Gc/O8G2zl2
         mu4Ya8HnO/t958ewUUicnfSqwtCk1zRSwK2dVqbvjGnxGSUW8KaeEuqau7vClbLYssK+
         2vSE8nTPU6tahuBgwUSoOaIl9emJ5Y5Ll581P/1Uy11SX9fN6ltQtkmHiSuth8EQdT/r
         twcAuHg2un5X2WeL+GDmi173hUR9EGDLWB/ahONdje3HuTFXRn6CDOJ8RpkjQzt8ac7u
         L2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WS/zoe9Fq2qDK9lRGH6W30+/oPnf/aVCcbDJGZCBBdU=;
        b=aa5C3OTTM1wnZaudMYgTEZzdD8eDqqla6vWiPz7e8090W6JQPLwfq+h9XnNg5R1o7t
         O6GPfO521F/K3hnSshC7hoprG12Qo5oa7yjtNNcreVyAkgC6TlHRXEz0GBhWMrU3/NeT
         PjdO9n8ANc1yMmfXN7sgakpUuRCaZMH9H1M/OLeUneCnT5gVlBnbv7RHUlK3ikysHro7
         kNYTVhnJIbvdoITb1xXq3Mqs65skg3KMjGlXdeszZlbQlHMnm23v9Dyhm3csHsF7k25Q
         CJ9Q3C60RgwFu79NymosmXBzgVW1QfBKl81mJaNB1i/iNFAjgIGjsmmbpsKT1kjnYEp+
         b6eA==
X-Gm-Message-State: APjAAAWy3X/uv7pIrfBiFbXQGMX16JSRoPOOkKjIm3YFeFJdW5PF3CHM
        dQp8nWAng4PBd/Jq6UWVsJAiv+wpgTxI4ALZIurXVg==
X-Google-Smtp-Source: APXvYqxaLllcVzvKFvg2PP6hT8HjPB97yTjqwMTQObFrdWFnjGfR2/zVHqwzeEljjeGqh9vJkgAi3zMcxOGfdB+CcQM=
X-Received: by 2002:a6b:3709:: with SMTP id e9mr11117866ioa.282.1552412827423;
 Tue, 12 Mar 2019 10:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000032b7f0583d16e0e@google.com> <b17bcabf-5f2c-083a-91a9-6d99f5111a3f@broadcom.com>
 <CACT4Y+aT_oeWK5UWy9N76noDEfPTC8q2d8vd+KugE2UXgxpJcQ@mail.gmail.com> <a68b264c-d573-87ef-13fb-883c6b0a710c@gmail.com>
In-Reply-To: <a68b264c-d573-87ef-13fb-883c6b0a710c@gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Mar 2019 18:46:56 +0100
Message-ID: <CACT4Y+aYo14D+o=mUmefw2PzPc3QpF7F4cQq9jK6tXmz5zxg6g@mail.gmail.com>
Subject: Re: general protection fault in skb_put
To:     James Smart <jsmart2021@gmail.com>
Cc:     James Smart <james.smart@broadcom.com>,
        syzbot <syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Johan Hedberg <johan.hedberg@gmail.com>, keith.busch@intel.com,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvme@lists.infradead.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 7:10 PM James Smart <jsmart2021@gmail.com> wrote:
>
> On 3/11/2019 9:40 AM, Dmitry Vyukov wrote:
> > On Mon, Mar 11, 2019 at 5:20 PM 'James Smart' via syzkaller-bugs
> > <syzkaller-bugs@googlegroups.com> wrote:
> >>
> >> On 3/11/2019 6:20 AM, syzbot wrote:
> >>> syzbot has bisected this bug to:
> >>>
> >>> commit 97faec531460c949d7120672b8c77e2f41f8d6d7
> >>> Author: James Smart <jsmart2021@gmail.com>
> >>> Date:   Thu Sep 13 23:17:38 2018 +0000
> >>>
> >>>      nvme_fc: add 'nvme_discovery' sysfs attribute to fc transport device
> >>>
> >>> bisection log:
> >>> https://syzkaller.appspot.com/x/bisect.txt?x=121f55db200000
> >>> start commit:   97faec53 nvme_fc: add 'nvme_discovery' sysfs attribute
> >>> to ..
> >>> git tree:       linux-next
> >>> final crash: https://syzkaller.appspot.com/x/report.txt?x=111f55db200000
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=161f55db200000
> >>> kernel config: https://syzkaller.appspot.com/x/.config?x=59aefae07c771af6
> >>> dashboard link:
> >>> https://syzkaller.appspot.com/bug?extid=65788f9af9d54844389e
> >>> userspace arch: amd64
> >>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=178e0798c00000
> >>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=11b4f0b0c00000
> >>>
> >>> Reported-by: syzbot+65788f9af9d54844389e@syzkaller.appspotmail.com
> >>> Fixes: 97faec53 ("nvme_fc: add 'nvme_discovery' sysfs attribute to fc
> >>> transport device")
> >>
> >> can someone contact me as to what this thing is doing and how to
> >> interpret all the logs.  nvme_fc isn't remotely in any of the logs and
> >> doesn't use skb's unless the underlying udev_uevents are using them.
> >
> > Hi James,
> >
> > What exactly is unclear/needs interpretation? syzbot did what is
> > commonly known as kernel/git bisection process. This is a new feature
> > so there can be some rough edges. Hopefully we can improve the
> > representation together.
> >
> > Thanks
> >
> Everything is unclear. You're telling me that an error occurred and that
> you reduced it to the git submit where the error starts appearing.
>
> Usually there would be something in the base crash, which I'm looking at
> in https://syzkaller.appspot.com/x/report.txt?x=111f55db200000 which
> would point back at something in the patch or related to it. There are
> no relationships.  I can't quite figure out what the base test actually
> did that generated the failure to see if there's any possible relationship.
>
> Everything in the base crash stacktrace points to an issue in the
> bluetooth uart driver doing all the logging - not the patch called out.

Everything up to this point is perfectly correct. So lots of things
seem to be clear to you ;)
The base test case is provided in under the "syz/C repro" links in the
original report and in the bisection results report.

> So this looks like a failure of your infrastructure.

I agree that the result seems to be unrelated to the original crash.
What is the root cause is a good question. You can see the exact
history of how bisection progressed any why it ended up at the commit
it ended up over the "bisection log" link.
Kernel is unfortunately (or fortunately) is not a single-threaded
deterministic user-space parser library without global state where
everything can be bisected precisely. There is a very long tail of
other problems as well. E.g. the same reproducer triggering multiple
bugs at once, of different bugs at different commit ranges. At the
same time lots of people asked for bisection of bugs. So this is where
we are.
I've started collecting all cases with incorrect bisection results, so
that we can draw broader conclusions later and bucket common root
causes:
https://github.com/google/syzkaller/issues/1051
Added this case too.
