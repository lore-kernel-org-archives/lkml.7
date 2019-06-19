Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0461BC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32032147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiaGMjNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730947AbfFSGkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:40:17 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34567 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfFSGkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:40:16 -0400
Received: by mail-yb1-f195.google.com with SMTP id x32so2885646ybh.1;
        Tue, 18 Jun 2019 23:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUQB8b/ALcnBOEXgIR9mL83C8fnNPPgpdoM8ggiCu6o=;
        b=UiaGMjNTRZklEIOHaKABCJZaYsCo2aau7Kd/LOksavDTm9WMyYfdNonQ0OuTvUkyVu
         Zf/dmD6NUiMFJ1h5akTSE3OjBQocNr+nuCt5x5vgF7eDU1gt/F8xT8UKCTFBEcHdIyvb
         GNnu5iL1KLg84OCWLN4t6TMu1XjzZN6d2//WYiG+pC+8SlVe2ga7H2xHOXw2PaxaeTgH
         n3jqi+WonV3sxY6Gh2WHZ0S/vWjtI89IzbflPProwPdwulvYD/J3OPS1e82XPlBj2wFE
         g9bjVQGtmAEwvSXYvkV/ULfpXrSOa6BOQ2zMNESIqxfrmaLcGwlUQy5PaNJXrMd0EYXJ
         wFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUQB8b/ALcnBOEXgIR9mL83C8fnNPPgpdoM8ggiCu6o=;
        b=WPsTL71Fy1c0PvFNMAMn0MiqSV77Fb5xVhKF6cKa7zqyX4bIHSHN7MyBuw1PByeQ64
         Iy1KKqv1LlIHHR7CROlE2ZiaCyFeuL99JJQyUShtVgxqb1789+hoEiwDuuyrMcG2MscC
         bbXokZdHGVSDW1I8eBqQf0aC3fAbcAvsKdsyWPzgjPTy5/EJ48RgrQW6r/gT2cQfQKNw
         cti+ROYamqzZOG8PF6A3/+NVPu90VFEBHhxebJLvUH0773mmxa4qv3+1Sn5DFCkmyuiF
         IfXIyx+o8oOY7CSD8NyxftW9uMPvREW6+bpqY6Xppx0YyenGjhEDBQ10WkpnSwhUONMi
         enuA==
X-Gm-Message-State: APjAAAXGN8UAgF2b0+uaVxe4KKpnB069vlPBnuMzH1AmEt6XdpCEcnQb
        wrmAhgM/j4C90nH6t3GUI3UlHzq6v46pESOyI84=
X-Google-Smtp-Source: APXvYqwXp4890is+TONe5fQdzQFKrWFMeQ51oVqSH9DSJdiLLDDBr0ylytN+Guu85z2Kf+87w/ZP9nujvn10DJQDb4Q=
X-Received: by 2002:a25:a081:: with SMTP id y1mr36233727ybh.428.1560926416060;
 Tue, 18 Jun 2019 23:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000623c45058b9c2479@google.com> <CAOQ4uxhsnOXXVCuOT4p4c_koBMFfprWwdtCPGNGhzprFaJZwRA@mail.gmail.com>
In-Reply-To: <CAOQ4uxhsnOXXVCuOT4p4c_koBMFfprWwdtCPGNGhzprFaJZwRA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Jun 2019 09:40:04 +0300
Message-ID: <CAOQ4uxh9ZWghUNS3i_waNq5huitwwypEwY9xEWddFo1JHYu88g@mail.gmail.com>
Subject: Re: WARNING in fanotify_handle_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 11:27 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Jun 18, 2019 at 8:07 PM syzbot
> <syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    963172d9 Merge branch 'x86-urgent-for-linus' of git://git...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17c090eaa00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c277e8e2f46414645508
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a32f46a00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a7dc9ea00000
> >
> > The bug was bisected to:
> >
> > commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
> > Author: Amir Goldstein <amir73il@gmail.com>
> > Date:   Thu Jan 10 17:04:37 2019 +0000
> >
> >      fanotify: cache fsid in fsnotify_mark_connector
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bfcb66a00000
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=11bfcb66a00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=16bfcb66a00000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com
> > Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
> >
> > WARNING: CPU: 0 PID: 8994 at fs/notify/fanotify/fanotify.c:359
> > fanotify_get_fsid fs/notify/fanotify/fanotify.c:359 [inline]
>
> Oops, we forgot to update conn->fsid when the first mark added
> for inode has no fsid (e.g. inotify) and the second mark has fid,
> which is more or less the only thing the repro does.
> And if we are going to update conn->fsid, we do no have the
> cmpxchg to guaranty setting fsid atomically.
>
> I am thinking a set-once flag on connector FSNOTIFY_CONN_HAS_FSID
> checked before smp_rmb() in fanotify_get_fsid().
> If the flag is not set then call vfs_get_fsid() instead of using fsid cache.

Actually, we don't need to call vfs_get_fsid() in race we just drop the event.

> conn->fsid can be updated in fsnotify_add_mark_list() under conn->lock,
> and flag set after smp_wmb().
>
> Does that sound correct?
>

Something like this:

#syz test: https://github.com/amir73il/linux.git fsnotify-fix-fsid-cache

It passed my modified ltp test:
https://github.com/amir73il/ltp/commits/fanotify_dirent

Thanks,
Amir.
