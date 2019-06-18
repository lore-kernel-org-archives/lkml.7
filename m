Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C2CC31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DE5205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 20:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Dq0x7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfFRU1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 16:27:22 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38823 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbfFRU1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 16:27:22 -0400
Received: by mail-yw1-f67.google.com with SMTP id k125so7290397ywe.5;
        Tue, 18 Jun 2019 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QMKaBxL4CnjzjmwadmOPe4XGvcXSwVBiLXM53oPLnQ=;
        b=T+Dq0x7EPaLEza5d0zMKW1NvBlc7WCBqZ+ukuGL2lbxDTMhAQhjyRaZMsSlHWnz0b9
         /NZLi/7k0NU6v3Ss1efP5H1LgDf5cReCDPURqtuDLd/xtTYqzCBKrOmPCwUC7Qx47+LH
         VSfo829s+FB+SvzSurYMnZK4WTt9duhifHFO+wlg02GGu+z3j6OkRVeIRaHu7/lUMVGB
         VzeYWdBIfhLkk/NzUgloOk9HcYQjLqKg3tQwarad3Tpf7tfq70D3kkGYMnaap6Ir6cZX
         uyKKRaFq+/v5+TdS9xos5awfWpyq/fmp6+4qWOjRqa6fJpcE4s/w/50za6dTISqYPoj0
         6ImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QMKaBxL4CnjzjmwadmOPe4XGvcXSwVBiLXM53oPLnQ=;
        b=RQOpqinHFODawXZo8pVEg/yk3rwQJ0vs4Gh8b+pd3BigE0P181S3i0VVDQqRvphRFD
         F0Vl43I2cdjl51l0QlX28t22zZBx3pYXkjfc8orBadJMrYVRMblRO5g71rFrv5G/eb3r
         PO8ea+yBNFWFptRbscmJjox8QYUa3t7cj7bLasOI8pmDVMs4ggj/km36M76yqiPwbbr+
         4osR0cWL4Bp5u8tcOwyY8HS1n2C4p6jlYhlklhbJpx4yqY8lTTdwlrdlM6mCp4ekF/DR
         LFyfQfMVkJjdLH5avW9HDH43k1U7BA+HhnsKXsF2Vn6jwTqrJVTmPtwzjlPndCktFbz8
         i+uA==
X-Gm-Message-State: APjAAAUqjpXfZtQbTT+nMJ9m6gMgESYiN3azYW9mWaJlNklU2kQ2rEZq
        hQ4itJncGTxRg9vBZfe7tCcwCA/5Q9l5GvK6dhU=
X-Google-Smtp-Source: APXvYqzOmIwVBwcmvQvSRdvCPmiYYWYbAEJNnMJ3QxF6seY1ZPR0HzYHP2MAVg0VNKuRWH6wVnKCGsD7iOmD9ELl3dY=
X-Received: by 2002:a81:3956:: with SMTP id g83mr65870477ywa.183.1560889641067;
 Tue, 18 Jun 2019 13:27:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000623c45058b9c2479@google.com>
In-Reply-To: <000000000000623c45058b9c2479@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Jun 2019 23:27:09 +0300
Message-ID: <CAOQ4uxhsnOXXVCuOT4p4c_koBMFfprWwdtCPGNGhzprFaJZwRA@mail.gmail.com>
Subject: Re: WARNING in fanotify_handle_event
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 8:07 PM syzbot
<syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    963172d9 Merge branch 'x86-urgent-for-linus' of git://git...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17c090eaa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
> dashboard link: https://syzkaller.appspot.com/bug?extid=c277e8e2f46414645508
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a32f46a00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a7dc9ea00000
>
> The bug was bisected to:
>
> commit 77115225acc67d9ac4b15f04dd138006b9cd1ef2
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Jan 10 17:04:37 2019 +0000
>
>      fanotify: cache fsid in fsnotify_mark_connector
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12bfcb66a00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11bfcb66a00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16bfcb66a00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com
> Fixes: 77115225acc6 ("fanotify: cache fsid in fsnotify_mark_connector")
>
> WARNING: CPU: 0 PID: 8994 at fs/notify/fanotify/fanotify.c:359
> fanotify_get_fsid fs/notify/fanotify/fanotify.c:359 [inline]

Oops, we forgot to update conn->fsid when the first mark added
for inode has no fsid (e.g. inotify) and the second mark has fid,
which is more or less the only thing the repro does.
And if we are going to update conn->fsid, we do no have the
cmpxchg to guaranty setting fsid atomically.

I am thinking a set-once flag on connector FSNOTIFY_CONN_HAS_FSID
checked before smp_rmb() in fanotify_get_fsid().
If the flag is not set then call vfs_get_fsid() instead of using fsid cache.
conn->fsid can be updated in fsnotify_add_mark_list() under conn->lock,
and flag set after smp_wmb().

Does that sound correct?

Thanks,
Amir.
