Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B971C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119A3217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzZqGiNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfDSTxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:53:21 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37942 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfDSTxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:53:21 -0400
Received: by mail-yb1-f196.google.com with SMTP id w206so2375796ybg.5;
        Fri, 19 Apr 2019 12:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qtlSwlrVY/goP+PctpH8UCAG3AsT0X+m7uAupcx87Eg=;
        b=RzZqGiNjSuI4w+vEsTQHh2moqzupHJOtrEBLhRhmSDHWmK6sjXKMY0LN+B4LZNlwj8
         CAel2+lhMk7aK7BQ7cTwzJc4MYLgXT3zSPcnHMdosTFr5LT8JeyHSmeI0lK6C0xOyl3v
         MoDA3dsmEyI72VBoL1w09I63mA1QhmB0+6dNaXLxrzDfpCN9AwgsP6w5XHfKw3fv8umI
         USo7ugMaFo85uIra6Hn0Yl+OcRESoEmW/UYZ8aUKv90v2KgBIrGZiPxPfr7SkMs5H9YB
         aMWn3Is3D7/mLKy7+lAiAEmmSFrIISKlA47le6Lw0Ez3QKzON9HiIsI6wqyml3xDvu2i
         7iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qtlSwlrVY/goP+PctpH8UCAG3AsT0X+m7uAupcx87Eg=;
        b=ZBkFzEQti7IOuIYHMvV69sBt/KMYzMD3vjBk8/0ltFiAcRSP4Fk7APoJEjgvx5X5vw
         LGTYe1gk4IzJvhoUln5q5Q8VREtbWrFLljSyPnU47UMVLa6SUh9a3WG/tRgSLThqC8Of
         ARz2Eligr8/uYQbHsou7tFLq9NwfP/hpwFQtpQ+5/1yXrgJoEcIFS74ErV6PHybtCm8U
         aA/0qxC/P5ebcUVcM9X9NFIiPeJep0kLWp6MgIEvzNlxQLB1kuPV+Zl5mmr66wiR7ji3
         bqybJT/h7q81IiQJRo4Npgj23/Fq6AbNVd4NvADN95Uppe+ngTlar47aYJmwO/qW1w5o
         bSqw==
X-Gm-Message-State: APjAAAXqJvCFpKMn8LQWdWf6Fr/lFaUUmTYYP14e/ANxHYek2cHO+Djp
        F/dOe0fVtudlnTb15ucplYPmx6MDixK1YNEP5V43TrrV
X-Google-Smtp-Source: APXvYqwo8Jhl3r+ZOD48KbfwYNT3vv6PaPtRkiJHrXAnzWZURf2iZq1Ss22N9GIQsFFkGZUef1loMLFgostZSdLBI5Y=
X-Received: by 2002:a25:952:: with SMTP id u18mr1809007ybm.397.1555662074979;
 Fri, 19 Apr 2019 01:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000064bcf057a59e3b9@google.com> <0000000000004f7f7c0584fe33c0@google.com>
In-Reply-To: <0000000000004f7f7c0584fe33c0@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Apr 2019 11:21:03 +0300
Message-ID: <CAOQ4uxjOm+VFyTbm=2k1d0774qu2tK5gzEgKNnRPjd0GvMnihA@mail.gmail.com>
Subject: Re: WARNING in ovl_instantiate
To:     syzbot <syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 2:10 PM syzbot
<syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this bug to:
>
> commit 01b39dcc95680b04c7af5de7f39f577e9c4865e3
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Fri May 11 08:15:15 2018 +0000
>
>      ovl: use inode_insert5() to hash a newly created inode
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=176da0cd200000
> start commit:   de6629eb Merge tag 'pci-v5.0-fixes-1' of git://git.kernel...
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=14eda0cd200000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10eda0cd200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=edf1c3031097c304
> dashboard link: https://syzkaller.appspot.com/bug?extid=9c69c282adc4edd2b540
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c7a94f400000
>
> Reported-by: syzbot+9c69c282adc4edd2b540@syzkaller.appspotmail.com
> Fixes: 01b39dcc9568 ("ovl: use inode_insert5() to hash a newly created
> inode")
>

Dmitry,

The root cause of this bug is that repro is mounting overlapping overlay
layers (i.e. upperdir=./file0,lowerdir=.:file0).
Miklos claimed that the fix should be to fail such mounts.
Below is a patch to test:

#syz test: https://github.com/amir73il/linux.git ovl-check-overlap

However, I see that this specific overlapping layers mount has already
mutated to several other repros out there, like the ones in this bug:

https://syzkaller.appspot.com/bug?extid=a55ccfc8a853d3cff213

I believe that disallowing overlapping layers will silence some
bugs, whose root cause may be different.

Besides doing the overlapping layers mount, this repro family also
does extensive access to overlay underlying layers concurrently
with overlay access and *that* is the root cause for most of these
"possible deadlock" bugs (some false positives and some real).

Assuming that ovl-check-overlap will get merged, you may need to
hint syzkaller that overlapping layers is no longer a valid input or
maybe it will figure it out on its own?...

Thanks,
Amir.
