Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EB1C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C22C20672
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 20:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ivm+77kB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKUUN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:13:27 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35142 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfKUUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 15:13:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id i19so4273627qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7kYoMVgzXrrlMqhKt4mkkLjEcR7Iirse1ze91WZ2es=;
        b=Ivm+77kBP6dszmfwrcPYZpVNUzPEQ41aylYiP4xCZ5ljESqvBEFVvKTD2AEwmdOsL4
         14ZKZEuU2lOHuPag2Cv7szEQeCTGabe+e3UHltjZORlPWrWo1hgPvhm2w3kHeP6nb+gi
         o1TXg3NKP1VYP+fadqTqmMG9+StLeCRDU2dwzw91Rngm8de9h5b01xCy8fDo3OzvdGKc
         7sHbPWh3oF83aJ8I6i1tNam8zl1lgPg1cwehgcJ5YHq3oa13BgDC4vjo5ndPqn8nrlOU
         8scXT9s6A7/UyWL+yqZhVg+Lgl/0/1oPsHxN3/uHlqPYwTVN9cZ3becP/n2dC7RRMmDY
         zfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7kYoMVgzXrrlMqhKt4mkkLjEcR7Iirse1ze91WZ2es=;
        b=p5ijoHiCrHsrBCMhdysm1r5GzCOaw5RkF/octygg3h4WL8G4UTynlL5uqEHeoeo8Fn
         m5gWSBFcM2CU1/DpTdMdERtn4MfCRQke5rvF2NorVgGv+1qd+cmnyRRIkkoOwqTdrRKl
         sxeXbX2GMwUH/qYNjm2cpFyUOiJBLXFUGZAOQ7aDahMWTyG4n0g++L7QdN8bc94izQzU
         Ak7GNxM4V6pRdloufxPO87GRzV7vw0PbNsssmb0rK6LYJhQYveEPOr9bb9mwp5KPyc8x
         dCSQW5F+FsqN27s3FKX1A2JVqbLs5K2+CDZ/2HDMiyQRClKyf/KNk/3ikJ1HwskM8KdC
         N0Hw==
X-Gm-Message-State: APjAAAWMA3nRsyu1LgQU3q+F5523DDx5egtLTlTkQ20HS1nabP3bcnGu
        uz1TwvYDYtpFevgKMPLCEJg2L8SMPfiRou+thCurGw==
X-Google-Smtp-Source: APXvYqwLvEyx2OYuY5lEgxSfNmvYOcfePTvN/jgculMxRa6kgYzB7S5fAyaH0IZgpTPo0C5Pc2siam/z5wfKTiRPtpY=
X-Received: by 2002:a05:620a:14b9:: with SMTP id x25mr1608539qkj.8.1574367204856;
 Thu, 21 Nov 2019 12:13:24 -0800 (PST)
MIME-Version: 1.0
References: <0000000000006e31980579315914@google.com> <000000000000a6993c0597cc8375@google.com>
 <CALCETrVfWHPHiOmyJ9iDJDiCD3idPA4BdeM=4FUEO-uuxM07_g@mail.gmail.com>
In-Reply-To: <CALCETrVfWHPHiOmyJ9iDJDiCD3idPA4BdeM=4FUEO-uuxM07_g@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 21 Nov 2019 21:13:12 +0100
Message-ID: <CACT4Y+YVfyb6VSiFALAJT-O0GAxsVRY0XafAyx1NM+bkGw9vCQ@mail.gmail.com>
Subject: Re: INFO: task hung in __do_page_fault (2)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     syzbot <syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 7:01 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Wed, Nov 20, 2019 at 11:52 AM syzbot
> <syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 0161028b7c8aebef64194d3d73e43bc3b53b5c66
> > Author: Andy Lutomirski <luto@kernel.org>
> > Date:   Mon May 9 22:48:51 2016 +0000
> >
> >      perf/core: Change the default paranoia level to 2
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15910e86e00000
> > start commit:   18d0eae3 Merge tag 'char-misc-4.20-rc1' of git://git.kerne..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=17910e86e00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=13910e86e00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=342f43de913c81b9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=6b074f741adbd93d2df5
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12482713400000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=158fd4a3400000
> >
> > Reported-by: syzbot+6b074f741adbd93d2df5@syzkaller.appspotmail.com
> > Fixes: 0161028b7c8a ("perf/core: Change the default paranoia level to 2")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> Hi syzbot-
>
> I'm not quite sure how to tell you this in syzbotese, but I'm pretty
> sure you've bisected this wrong.  The blamed patch makes no sense.


Hi Andy,

Three is no way to tell syzbot about this, it does not have any way to
use this information.
You can tell this to other recipients, though, and for the record on
the bug report email thread. For this you can use any free form.

But what makes you think this is wrong?
From everything I see this looks like amazingly precise bisection.
The reproducer contains perf_event_open which seems to cause the hang
(there is a number of reports where perf_event_open hangs kernel dead
IIRC) _and_ it contains setresuid. Which makes good match for
"perf/core: Change the default paranoia level to 2" (for unpriv
users).
The bisection log also looks perfectly correct to me: no unrelated
kernel bugs were hit along the way; the crash was always reproduced
100% reliably in all 10 runs; nothing else suspicious.
I can totally imagine that your patch unmasked some latent bug, but
it's not 100% obvious to me and in either case syzbot did the job as
well as a robot could possibly do.
