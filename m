Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3786FCA9ED0
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0445B2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 18:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+FQf0a/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfKASDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 14:03:24 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44380 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbfKASDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 14:03:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id o11so8929994qtr.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k8D0kxdveIpuC6UigtyTU7urwvjnhy2BPAZbxffIYkA=;
        b=f+FQf0a/ifANPLSwBV+ZkSgxM5Jp/onawYBupphq/LsTjIej2U+EoZiplzDJaj+w9f
         f+HNklqSQZF2LnhTGh7KLY0AgjSJJzx2aI4Hn67VjCULaV+wlrwW2pf4YAr/1vY0DU+H
         O69QaL/E2EfY4PDEOhF0PmKMeT/GqXZeYkLWyjeGmh84W4mLY39849znwYXB3Fd4ApvX
         kV0JygyDXSgMrkVC+vPJcBomOufJZwPeHCOl80eSjh8PAx1zeAmiwhTd6SV2DOpohy6a
         V1sA4A5q91zDXDOsrN+gypNTEucv0fgbKEUPi6AZLEvMGgH6SuL6ap6GoYm9uHPF2Tcv
         ZSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k8D0kxdveIpuC6UigtyTU7urwvjnhy2BPAZbxffIYkA=;
        b=nUbhQtGKui/KmhuSmQkAH0u9Hk6I803vai8zVJiRiu8BIUFL12iWwhBmFkz9cmdMbc
         cXN5NYxIvd+g/VGP62r1urqaFNp31c8tNvlAqHORnKOQOzb60VO848HWzHCeUDkCyaR8
         nURoGbIn1box11qIXKpEkQehCQNufoAe64cWK8t6sPuLPebQQJKiifzQVrIVSlkeyVpR
         Ossh8lLbNYwAJR+mkYkgHc0YvWWntY0/6NPjs4aVUWcTTFOZ65gQOsaCA+hdIjhw2Lu8
         mB+dAzQO9x+31laHeNOK8bL8Rboi42kqOEpwxwpESXRIVHhzj28Vz0Ge+Ke9QLp+sDq+
         y7Kw==
X-Gm-Message-State: APjAAAX3gvhq/wElC3Hym+Ih51/oCmFvely9/0ZWNXlFmqPZeHLjNIHx
        1GplzX8Xp3JQ68VB6xdfNWnTyEnEjWwcTQE0npCA9A==
X-Google-Smtp-Source: APXvYqzRbyd6XaGiNNRA/t8TJsdO3rNYFVp/yOubJZnZL7YPB7EhMjaMtD1BiKpR716ZDhtNj0+0ij3ku29znK/XFIg=
X-Received: by 2002:ac8:1103:: with SMTP id c3mr676808qtj.50.1572631402359;
 Fri, 01 Nov 2019 11:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000069801e05961be5fb@google.com> <0e2bc2bf-2a7a-73c5-03e2-9d08f89f0ffa@kernel.dk>
 <CACT4Y+asiAtMVmA2QiNzTJC8OsX2NDXB7Dmj+v-Uy0tG5jpeFw@mail.gmail.com> <7fe298b7-4bc9-58e7-4173-63e3cbcbef25@kernel.dk>
In-Reply-To: <7fe298b7-4bc9-58e7-4173-63e3cbcbef25@kernel.dk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 1 Nov 2019 19:03:10 +0100
Message-ID: <CACT4Y+au222UbfG_rbV+Zx6O75C1BHfCCw4R_Mp4ki4xw=_oDA@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel paging request in io_wq_cancel_all
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, mchehab+samsung@kernel.org,
        Ingo Molnar <mingo@redhat.com>, patrick.bellasi@arm.com,
        Richard Guy Briggs <rgb@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 1, 2019 at 6:56 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 11/1/19 11:50 AM, Dmitry Vyukov wrote:
> > On Wed, Oct 30, 2019 at 3:41 PM Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >> On 10/30/19 1:44 AM, syzbot wrote:
> >>> syzbot has bisected this bug to:
> >>>
> >>> commit ef0524d3654628ead811f328af0a4a2953a8310f
> >>> Author: Jens Axboe <axboe@kernel.dk>
> >>> Date:   Thu Oct 24 13:25:42 2019 +0000
> >>>
> >>>        io_uring: replace workqueue usage with io-wq
> >>>
> >>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16acf5d0e00000
> >>> start commit:   c57cf383 Add linux-next specific files for 20191029
> >>> git tree:       linux-next
> >>> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15acf5d0e00000
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=11acf5d0e00000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=cb86688f30db053d
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=221cc24572a2fed23b6b
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=168671d4e00000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140f4898e00000
> >>>
> >>> Reported-by: syzbot+221cc24572a2fed23b6b@syzkaller.appspotmail.com
> >>> Fixes: ef0524d36546 ("io_uring: replace workqueue usage with io-wq")
> >>
> >> Good catch, it's a case of NULL vs ERR_PTR() confusion. I'll fold in
> >> the below fix.
> >
> > Hi Jens,
> >
> > Please either add the syzbot tag to commit, or close manually with
> > "#syz fix" (though requires waiting until the fixed commit is in
> > linux-next).
> > See https://goo.gl/tpsmEJ#rebuilt-treesamended-patches for details.
> > Otherwise, the bug will be considered open and will waste time of
> > humans looking at open bugs and prevent syzbot from reporting new bugs
> > in io_uring.
>
> It's queued up since two days ago:
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring&id=975c99a570967dd48e917dd7853867fee3febabd
>
> and should have the right attributions, so hopefully it'll catch up
> eventually.
>
> --
> Jens Axboe
>

Cool! Thanks!
I've seen "fold in" and historically lots of developers did not add
the tag during amending, so wanted to double check.
