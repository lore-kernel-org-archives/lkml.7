Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EDCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA1206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NRR0RRm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfCKNqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:46:00 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35533 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKNp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:45:59 -0400
Received: by mail-it1-f194.google.com with SMTP id 188so7328224itb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dGbWLAbGdP2dt1Ji3sFEPy8nE5bOi94Sx8Q7SdZwl/c=;
        b=NRR0RRm+ucm6/fH9ki6PCN5ENjumfQYH8+I0VgBNcGtemaAAXStSSGbUujjdHOoryL
         bkUammXLthZRhu/QTwxQS4EErohWxAmbLw5TB6SFdH63/n4V+ic73Tl7hV1qTCeJlRsu
         TehzqO3KGyVnJ9MOX+NGHCmDN7g4RujGyUGxFbokgrt/xyUV0pciyEwkaPO5cg6OuSBo
         gLdoY00fmc49rMIpfVfOHTmJWWXILKMbuX6saNYFfBufX+4wtp3T2shg1dESRUN8QQvA
         Nb2EeZ6RP05SXGbI7UEvLnBj4EQoH41smObU/cRSwOzeL7LRPZ6cHkI6LggF8bsCJsAW
         E97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dGbWLAbGdP2dt1Ji3sFEPy8nE5bOi94Sx8Q7SdZwl/c=;
        b=LVMONuIfPP5B6UiTtC+nnzNhWShFmIri0mnwYfHI2bn/U7F1r2TexirP7v07jo/V6m
         tUepIz5cVZ01AaMx3Zd55bxrVGmlXDZDc0IJlHoU8LUJwM66YLCbzZXaVOhSp7OBx5m5
         3kt2Vts2puV6TJGPgb+CJu7N7++y3ikevGk4yWhaQGVXNljutgg49/nkzeyxT6qj35CD
         2SGgt4Y+INQwGk/SsqYuW+Et4uOSReM6u/ZnGYsh5Zs5aEZNJp0XZEp4OYAJfoxpp3An
         Ym0/bMjBa/T6BbA6ABjSCw6ycSevjWY0O5sbRinUtai25Fx7agU6A3/JmdaMONBJrUxq
         Qqcw==
X-Gm-Message-State: APjAAAVpEIjzEhUszNSx9LB+TsE4fCHvKfYTh+8Hr1VtwEDibJ6SgV6w
        4DpRaun/A+Q31pp3Bz5JD2KBfj5jbHl4fi/k31akVQ==
X-Google-Smtp-Source: APXvYqxkfVD+fyyD9HI6O9hePZoEpcmVhlshwb5kiC2YUCuwoZaevjuenVggrhxR0GdtbN91uUlFb8sLSFMKmZy+NmI=
X-Received: by 2002:a02:5986:: with SMTP id v6mr1657341jad.35.1552311957696;
 Mon, 11 Mar 2019 06:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008f34570583d15823@google.com> <0ded99b8d69a74c260f3f44f5ae1ab59@suse.de>
In-Reply-To: <0ded99b8d69a74c260f3f44f5ae1ab59@suse.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 Mar 2019 14:45:46 +0100
Message-ID: <CACT4Y+ZXBhNamhTYVW_9y_yUWRE+=rO8vdBF=m40kjqJQGY-gQ@mail.gmail.com>
Subject: Re: WARNING in ep_poll_callback
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, dbueso@suse.de,
        Jason Baron <jbaron@akamai.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 2:37 PM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> Hi Andrew,
>
> I thought "epoll: loosen irq safety in ep_poll_callback()" patch was
> removed from your tree, at least I got a notification on 9th of january,
> also I do not see it in the linux-next tree.
>
> Should I ignore this syzbot message?

If this was resolved we need to communicate it to syzbot one way or the other.
Since it was in linux-next, it won't even be able to do fix bisection.
So the bug will be open forever otherwise.

> --
> Roman
>
> On 2019-03-11 14:14, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit f92cacf118171208f62519d92502a8dd0341286d
> > Author: Roman Penyaev <rpenyaev@suse.de>
> > Date:   Tue Jan 8 01:15:44 2019 +0000
> >
> >     epoll: loosen irq safety in ep_poll_callback()
> >
> > bisection log:
> > https://syzkaller.appspot.com/x/bisect.txt?x=107ae15f200000
> > start commit:   f92cacf1 epoll: loosen irq safety in ep_poll_callback()
> > git tree:       linux-next
> > final crash:
> > https://syzkaller.appspot.com/x/report.txt?x=127ae15f200000
> > console output:
> > https://syzkaller.appspot.com/x/log.txt?x=147ae15f200000
> > kernel config:
> > https://syzkaller.appspot.com/x/.config?x=1521b074ff5a5bdf
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=aea82bf9ee6ffd9a79d9
> > userspace arch: amd64
> > syz repro:
> > https://syzkaller.appspot.com/x/repro.syz?x=1776034b400000
> > C reproducer:
> > https://syzkaller.appspot.com/x/repro.c?x=14c2e580c00000
> >
> > Reported-by: syzbot+aea82bf9ee6ffd9a79d9@syzkaller.appspotmail.com
> > Fixes: f92cacf1 ("epoll: loosen irq safety in ep_poll_callback()")
>
>
>
