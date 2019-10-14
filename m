Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF992C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7FE20650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 20:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387575AbfJNUk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 16:40:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730188AbfJNUk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 16:40:57 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D812812A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 20:40:56 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id 101so8173326oth.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 13:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SvMDPZOcKULNOK9bYvjjcU3cyL7Xy65q4lsrYxQ1w4=;
        b=AN0UW97vWapkpEk2Hk1bzlMpbRc0fzW98F8dukZywk6kFH3CE/kaEf0jntBxI+MZFA
         TKXbys+5vKYK+WIprTFKj4xy7hCWhYkDgzqivwRpaoqwhbhdmXmzfYJBc+vIkMmQIhQE
         BQw/xJE9EfDP/uacO93NGULLITjO8C+3Gf4VAKqUuDaJH6bD5f9PUBPjnStDE1uJIlTk
         +gkLuH431PRcGKE03zSpH87WDCBoKEz3zak0nJQwt48PUtC8MzoUQE6TnZodNTGSY1gg
         4gCh+6Z/fDuMA+z5cRA6oaBhmZG3UAvr+zf6dNN5S0bsFT1TkrOzwi6IZPJDsYNxHUTm
         Sr1A==
X-Gm-Message-State: APjAAAXzFpFJHO5NMB4HYSAj+kbcD27aDWGwVjxM/y6S9PMxZmOpEk7p
        0iuy+JVEwU/ZLQnpCYJ3eXIdbKk24ZKee294nPLgtGYiC5AoYa8UnlTzNHzmJua3XHaXXtn5O/E
        3W7Uyo8oGRFAl4P9pqBe/dbojmJDMjlHsWPNj4W9q
X-Received: by 2002:a05:6830:1544:: with SMTP id l4mr11555570otp.297.1571085656360;
        Mon, 14 Oct 2019 13:40:56 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwS11yxA6JO2sXstwZ6AIazd1XnFwJycqEmuSjW8pnyFgmwB4IaS3Xbgj0YhLyyim/T+w7nl1W3FcG41CJtWfs=
X-Received: by 2002:a05:6830:1544:: with SMTP id l4mr11555559otp.297.1571085656130;
 Mon, 14 Oct 2019 13:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ac6a360592eb26c1@google.com> <d9a957b3-9f0a-20b5-588a-64ca4722d433@rasmusvillemoes.dk>
 <20190919211013.GN5340@magnolia>
In-Reply-To: <20190919211013.GN5340@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 14 Oct 2019 22:40:44 +0200
Message-ID: <CAHc6FU7drv7r7yu4BzTGKycnKi_wUDGsvND6XyhDLq7B=HCM8g@mail.gmail.com>
Subject: Re: INFO: task hung in pipe_write (2)
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        syzbot <syzbot+3c01db6025f26530cf8d@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Darrick,

On Thu, Sep 19, 2019 at 11:10 PM Darrick J. Wong
<darrick.wong@oracle.com> wrote:
> On Thu, Sep 19, 2019 at 10:55:44PM +0200, Rasmus Villemoes wrote:
> > On 19/09/2019 19.19, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    288b9117 Add linux-next specific files for 20190918
> > > git tree:       linux-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e86645600000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f6126e51304ef1c3
> > > dashboard link:
> > > https://syzkaller.appspot.com/bug?extid=3c01db6025f26530cf8d
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11855769600000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143580a1600000
> > >
> > > The bug was bisected to:
> > >
> > > commit cfb864757d8690631aadf1c4b80022c18ae865b3
> > > Author: Darrick J. Wong <darrick.wong@oracle.com>
> > > Date:   Tue Sep 17 16:05:22 2019 +0000
> > >
> > >     splice: only read in as much information as there is pipe buffer space
> >
> > The middle hunk (the one before splice_pipe_to_pipe()) accesses
> > opipe->{buffers, nrbufs}, but opipe is not locked at that point. So
> > maybe we end up passing len==0, which seems (once there's room in opipe)
> > it would put a zero-length pipe_buffer in opipe - and that probably
> > violates an invariant somewhere.
> >
> > But does the splice_pipe_to_pipe() case even need that extra logic?
> > Doesn't it handle short writes correctly already?
>
> Yep.  I missed the part where splice_pipe_to_pipe is already perfectly
> capable of detecting insufficient space in opipe and kicking opipe's
> readers to clear out the buffer.  So that hunk isn't needed, and now I'm
> wondering how in the other clause we return 0 from wait_for_space yet
> still don't have buffer space...
>
> Oh well, back to the drawing board.  Good catch, though now it's become
> painfully clear that xfstests lacks rigorous testing of splice()...

have you had any luck figuring out how to fix this? We're still
suffering from the regression I've reported a while ago (*).

If not, I wonder if reverting commit 8f67b5adc030 would make sense for now.

* https://lore.kernel.org/linux-fsdevel/CAHpGcM+WQYFHOOC8SzKq+=DuHVZ4fw4RHLTMUDN-o6GX3YtGvQ@mail.gmail.com/T/#u

Thanks,
Andreas
