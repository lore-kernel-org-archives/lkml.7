Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBC0C10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BCEA2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hSBUd/eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfCLRKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:10:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:34979 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbfCLRKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:10:50 -0400
Received: by mail-it1-f194.google.com with SMTP id 188so5766147itb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q63ookcgnvhAqs3Sfl5pVKDmKu933OB0+OqZ26Ou1RY=;
        b=hSBUd/eG9bU9hkcXf07Vnzfvi70ZPJSBcBfruaCjFYM14tdDKN1568MVLHVkp1/rzg
         +6Kvr4CytIiREYS1zYlJHoH0flAM+XoTrGW0QCnwrTFi8ah/X4azfw5jprA37easCbb6
         WWKnUm+2oRUpKiOdwawihqIoCdbHuur985R5Kkka3cKAsMMJZbuwhwEvkcBX7iQcpmff
         Ltj6D7ENtQA15Jtc0daYUa/UPPmEAq+7Q7HYNkrp8zPyXJl1seIegJbM0EEuiUPKUWsi
         h6I5mMiXJmk0x9sKsteaUVj7+VdBvxAvjIcz+jlPIwTaTcR9NVX/luULEMgqgAncsgAa
         nynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q63ookcgnvhAqs3Sfl5pVKDmKu933OB0+OqZ26Ou1RY=;
        b=QExWmNxkOivU9Z92HYmrD2by5dUx1bIvJNKeClSz7EXjHpYR5i06WgUd34KVdmqryz
         O1JMZ8ON4M/lS8shRIXFwYFoglqkxFuGfIrD9yFawmP+oA8O1khD0fHmn+J0Cg1xiDva
         wcW2USkxQLq4x2vVCnYKDLeFvdX08hpUIyjSHl6rsi1oSZ4tn26+MIE7KjOjmdsrcsK4
         zszzmwDShrDgcTc4NFHfuix6w6+XrXxUwxd2smjkKzssx67mxZs9hZ8Ud93rsE4Lp8uN
         e2LzxAhK+iDI1UkOOx1SWntKfRg5PrVchadsM5+ApiXK01sIsqChOzFyrUBh1mweBt8o
         r/Vg==
X-Gm-Message-State: APjAAAUGwfpMsrVIznwkDm5DWd3pwqTdYBZ9Jsz++oPGMFfMLlbXPrMe
        tkeAj0BQzo4U32TAafxSeO4ws8Ac7/WgfCa0MWkFeA==
X-Google-Smtp-Source: APXvYqwqCfJYHXCtfsLZSl2M8UsGhzjYvPKuIRwXqEZvL3LVq/MLO/l88WdygX5M9kEtHiE4/PMhCh92IpnBJ8mAObU=
X-Received: by 2002:a24:3b01:: with SMTP id c1mr2440750ita.144.1552410649381;
 Tue, 12 Mar 2019 10:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000010b2fc057fcdfaba@google.com> <0000000000008c75b50583ddb5f8@google.com>
 <20190312040829.GQ2217@ZenIV.linux.org.uk>
In-Reply-To: <20190312040829.GQ2217@ZenIV.linux.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 Mar 2019 18:10:37 +0100
Message-ID: <CACT4Y+atEoMK8GFHTyH-L617-Qbsds5OkqcU1ibc2NR7DUKK3Q@mail.gmail.com>
Subject: Re: INFO: rcu detected stall in sys_sendfile64 (2)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     syzbot <syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com>,
        David Airlie <airlied@linux.ie>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        DRI <dri-devel@lists.freedesktop.org>, eparis@redhat.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Jan Kara <jack@suse.cz>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@redhat.com>,
        mszeredi@redhat.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Peter Zijlstra <peterz@infradead.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 5:08 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Mon, Mar 11, 2019 at 08:59:00PM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 34e07e42c55aeaa78e93b057a6664e2ecde3fadb
> > Author: Chris Wilson <chris@chris-wilson.co.uk>
> > Date:   Thu Feb 8 10:54:48 2018 +0000
> >
> >     drm/i915: Add missing kerneldoc for 'ent' in i915_driver_init_early
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13220283200000
> > start commit:   34e07e42 drm/i915: Add missing kerneldoc for 'ent' in i915..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=10a20283200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17220283200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=abc3dc9b7a900258
> > dashboard link: https://syzkaller.appspot.com/bug?extid=1505c80c74256c6118a5
> > userspace arch: amd64
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c4dc28c00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15df4108c00000
> >
> > Reported-by: syzbot+1505c80c74256c6118a5@syzkaller.appspotmail.com
> > Fixes: 34e07e42 ("drm/i915: Add missing kerneldoc for 'ent' in
> > i915_driver_init_early")
>
> Umm...  Might be a good idea to add some plausibility filters - it is,
> in theory, possible that adding a line in a comment changes behaviour
> (without compiler bugs, even - playing with __LINE__ is all it would
> take), but the odds that it's _not_ a false positive are very low.

Thanks for pointing this out.

I've started collecting all such cases, so that we are able to draw
broader conclusions later:
https://github.com/google/syzkaller/issues/1051

added for this one:
=========
A mix of problems: unrelated bug triggered by the same repro
("WARNING: ODEBUG bug in netdev_freemem"); lots of infrastructure
failures ("failed to copy test binary to VM"); also the original
failure seems to be flaky. All this contributed to pointing to a
random commit.
Al Viro points out that the commit only touches comments, so we could
mark the end result as suspicious.
=========

The infrastructure problems is definitely something we need to fix
("failed to copy test binary to VM") (currently the machine hangs
periodically with lots of time consumed by dmcrypt, but I don't know
if it's related or not yet).

Re the comment-only changes, I would like to see more cases where it
would help before we start creating new universes for this. We could
parse sources with clang to understand that a change was comment-only,
but I guess kernel is mostly broken with clang throughout history....
