Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E318C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58C32084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lP/14vur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfCZI1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:27:17 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42055 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbfCZI1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:27:17 -0400
Received: by mail-io1-f67.google.com with SMTP id c4so9987993ioh.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBP5A9a4aVJEwwaWqzyX57leFxlQKLpSpWq8pLzSaM0=;
        b=lP/14vurRBJbIOkUxlDxpE0ZVG6FIXfwA3GdGtzJuvQnZQDYAatN5L3NsrNm5Nc4L0
         8q6M5dt7iA7eSimdXtUD260Bh+KwWCFm0IMKT+OTR0zit6DrhhAyDuWZ77dJvcAN4Atc
         +tbfEQSIp09HchqlLINhuXZP9NxHOuU4UpyjGJN10G6b24/cZ+9wbWdK1B/lqoos6V1I
         T4WNevYvsN0iQwv7uzxur6CmRNXceWIiU4tBfsaVbGsx+yUZYqbwK7Y/i6qaL+SgncS7
         vSgjuPwCDpD8Mmo5NAvg2rnDZhWdZDFy6Q68oCvZF9P7AHPAo18p06tZ+qU00CUlSO6c
         yoVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBP5A9a4aVJEwwaWqzyX57leFxlQKLpSpWq8pLzSaM0=;
        b=LM9S7j3MJ6qTyAOIUjkqX9gDp0KliE+tITe+KQfeEoLP8OBcwmB9siQktOisPMyC3f
         j4rPMGeYle0h0Z57HfMZJaJ4Lj1ICTsa6szLEvTFhW2nES1/Xtejo7cOOWvAanWgpFpz
         pgXxZsP1qfrBb2GeEa+TIK9eBWhZvPFmnHV1AS/hQW5A0YO6UJ8pVN2Nd7nqGLOsQjWc
         kNqIQ+lLuvFYLza4Hy2HZQed3fEQ/iYITjx5bbe1oI7x8eqvsqR//yNaW3Og3gIDw6GX
         f66AHi7LNClTxLNeffQJLw+uLZ6QSj0bZwbB/188oIXR8On9tjM0HAN7YfKUkEENpU4c
         nS+g==
X-Gm-Message-State: APjAAAXX7CZaSqO9k+pVZKiUlzNJgQ5iYcGhAJDY20+gjazPMNjrTCZX
        q/yFtsNPZJRzhndbZpHeyW6zHc5p2qxbUv26l5IR3w==
X-Google-Smtp-Source: APXvYqzpdYf0hEQt48fQy1vAugepa/Pknp1XSaJClvDNPZ1eWeeECVYDNcvGv7XBmP3Aotz6CHeq8ZPXAY7jVQkOui8=
X-Received: by 2002:a6b:c3cc:: with SMTP id t195mr20048116iof.11.1553588835844;
 Tue, 26 Mar 2019 01:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f302fc057ea3b499@google.com> <000000000000557b4c0584cdabed@google.com>
 <20190325121635.GA10590@splinter>
In-Reply-To: <20190325121635.GA10590@splinter>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 26 Mar 2019 09:27:04 +0100
Message-ID: <CACT4Y+ai7ap_dKLetuZzfRC4VheZPWo=S=MB6J9a7_DHhTo0hw@mail.gmail.com>
Subject: Re: WARNING in bpf_prog_kallsyms_add
To:     Ido Schimmel <idosch@mellanox.com>
Cc:     syzbot <syzbot+987e48d84abddbe2506d@syzkaller.appspotmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 1:16 PM Ido Schimmel <idosch@mellanox.com> wrote:
>
> + Dmitry
>
> On Sat, Mar 23, 2019 at 07:16:01PM -0700, syzbot wrote:
> > syzbot has bisected this bug to:
> >
> > commit 7607dd35fc34893214284cca740d015154d20452
> > Author: Ido Schimmel <idosch@mellanox.com>
> > Date:   Mon Jul 17 12:15:30 2017 +0000
> >
> >     mlxsw: spectrum: Trap IPv4 packets with Router Alert option
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14e0ac07200000
> > start commit:   645ff1e8 Merge branch 'for-linus' of git://git.kernel.org/..
> > git tree:       upstream
> > final crash:    https://syzkaller.appspot.com/x/report.txt?x=16e0ac07200000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12e0ac07200000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=20271e14bc1c87f0
> > dashboard link: https://syzkaller.appspot.com/bug?extid=987e48d84abddbe2506d
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c69d20c00000
> >
> > Reported-by: syzbot+987e48d84abddbe2506d@syzkaller.appspotmail.com
> > Fixes: 7607dd35fc34 ("mlxsw: spectrum: Trap IPv4 packets with Router Alert
> > option")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>
> Dmitry,
>
> The bisection is probably wrong. Above mentioned commit is specific to
> mlxsw which is not even present in the provided kernel config.
>
> I see that this also appears in the web interface [1] which might be
> misleading to some people. Might be worthwhile to add a command for
> syzbot that tells it that bisection is wrong?
>
> [1] https://syzkaller.appspot.com/bug?id=b658eb696c8279d9951a4ceea79efba8a1d12467

Hi Ido,

Do you mean for the purposes of showing the results as "wrong" on the dashboard?

Generally the idea is that people can leave any free form comments on
the email thread associated with the bug (there is always a link from
the dashboard back to the email thread).  It's not possible to capture
all possible situations in a set of fixed tags. All information on the
dashboard may be incorrect in interesting ways. For example, consider
bisection diverged at the very last steps, so one may check the
bisection log and easily identify the commit that is most likely the
root cause, but the official result is off-by-one. Or may the free
stack in a use-after-free report is incorrect and then somebody may
suggest the right stack.

But having said that there is a proposal for custom tags for bugs
(e.g. for priority, subsystem, etc):
https://github.com/google/syzkaller/issues/608
And "bisection is wrong" may be a reasonable tag. I just don't want to
jump to a first ad-hoc implementation right now. I want to at least
try to thought out some consistent, extensible and useful design for
tagging.
I will add a note about bisection there.
Another concern is that I suspect very few people will actually use
it. Most people seem to tend to just drop a comment like "this is
fixed" or "syzbot sucks" without actually caring about any formal bug
state tracking...
But even if nobody will use it for majority of bugs, somebody (me)
still needs to design, implement, write tests, carefully deploy and
maintain this thing...

But thanks for the proposal!
