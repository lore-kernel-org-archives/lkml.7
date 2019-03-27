Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E24C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A19B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 17:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pwbk2Y6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfC0RUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 13:20:15 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:33175 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727420AbfC0RUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 13:20:13 -0400
Received: by mail-it1-f193.google.com with SMTP id v8so6143252itf.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=PKPA7wqJ0qLFC7fysSoiGTeZE/Lb7x0tsSB5PVice/A=;
        b=Pwbk2Y6wQSe7vGIMXCRl1XzR5iOnmnRwgqREFmvmu/ODIPmhz34u5H1eAZGBUHH12j
         DwOXxgT8iH+G6tx5Kg+tJVoO758saq6OP1U/5za9SQfNDeMCzPCLm52CGdoo76gjt8dc
         rZPqo+E3amN0Su/2ifGktEFOKnp9fKSevIEbWLoZIWRomL+rwt5QR8nF6feF2ch53O/g
         hjCxI6dalDrD/6hO5qgr24uXQJyMPkU659Gf4kO7ynUhYUT6WElILK0qyi4pxXKAIRIF
         3tgJRNAD/4wWI+v7f7WgGlkfbiXXJ6DKOh0f/6Tr68Qxo0OMT13b4QchEoBydysu6oj6
         Ct3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=PKPA7wqJ0qLFC7fysSoiGTeZE/Lb7x0tsSB5PVice/A=;
        b=RJmxVUc9oKU6uHUIh2+FvvlRiLiI4ukMQmh/t30qaZkalsEKk+A4WTeUQeBqgpisPm
         vVfEXtksXE/Sf/g5L+ALIQexByLzICK8jEpRDq4RdjU60GUoVHVxLJgTwqq3B4ck/8Rb
         vznoSGQ22E6SbhjEteeAYjAy91SY2x3q2iXT9WaGEQqncWezXgdLdfpnqPwHj5qL9EOu
         RjOsXKdwJ14/VCGNczGUb75wdbNcIt6p6HdR2OoXlXU28GeKPjdUqW0jXVSVK7tXtO/a
         swWDl9NO5jZsBJF3w9KSPteXNdvN37r4z9Z6PE4NQLYGhgZ19bwdD4fC3PS2L1UxcJTY
         1/QQ==
X-Gm-Message-State: APjAAAU4WsPZlnTP14awn1se9nEe0wk32BAg5Gpc0Zt7EenRgAc5DozP
        vyTTkTMJQE4juetJ2+rBi/6sd7jHQGQmqV0T/BYKvA==
X-Google-Smtp-Source: APXvYqzhXdRR+f1RsAutBIlGSOD+0DT2EUD20Q0xGzOg+uaUUF7+N7pZtPN2D/VNpJfcpSCz+1P0L+e3/4YYbcgyHvg=
X-Received: by 2002:a02:84ab:: with SMTP id f40mr25663965jai.72.1553707212083;
 Wed, 27 Mar 2019 10:20:12 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 27 Mar 2019 18:20:00 +0100
Message-ID: <CACT4Y+Y3nN=nLEkHXLFcX7vxp_vs1JrD=8auJ3cX9we6TQHO+w@mail.gmail.com>
Subject: syzbot bisection analysis
To:     syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As most of you probably already noticed, syzbot started bisecting
cause commits for crashes about 2 weeks ago and sending emails like
this:
https://groups.google.com/d/msg/syzkaller-bugs/2XhfN2Kfbqs/0U3YnKsGBQAJ
The bisection results are also available on the dashboard, e.g.:
https://syzkaller.appspot.com/bug?id=02bde0600a225e8efa31bdce2e7f1b822542fef1

Bisection was probably the most popular feature request for syzbot.
Cause commits allow to add the right people to CC and also should help
to pin-point the harder bugs. If you are interested in details of the
bisection process, some are described here:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#bisection
The next step step will be fix commit bisection to help identify and
close bugs that are already fixed but syzbot is not aware yet.

As expected automatic bisection of kernel bugs is not completely
trivial and we've got lots of incorrect results. To better understand
what happens, why and how we are doing, I've analyzed the 118
bisections that we have so far for the following metrics:
 - if the bisection was correct or not
 - the crash has multiple manifestations (on the same commit or on
different commits)
 - if the fact that bug hard to reproduce contributed to incorrect bisection
 - if unrelated bugs contributed to incorrect bisection
 - if skipped commits contributed to incorrect bisection
 - if disabled configs contributed to incorrect bisection
There are also some auto-extracted metrics like the start release of
bisection, start/end crash, etc. I won't claim that the analysis is
100% correct, which would require spending a day on each case. But it
should be 95% correct or so. The results are here (there is a second
tab with raw data):
https://docs.google.com/spreadsheets/d/1WdBAN54-csaZpD3LgmTcIMR7NDFuQoOZZqPZ-CUqQgA

Total success rate is slightly above 50%. But there is strong
correlation with how far back in history we have to go: for recently
introduced bugs the rate is 70+%. And for bugs introduced since v5.0
it's 95%. So hopefully this is a good forecast for future.

The 2 major contributors to incorrect results look quite fundamental:
 - unrelated bugs contributed to 66% of incorrect results
 - hard to reproduce bugs contributed to 46% of incorrect results

I've started collecting feedback/ideas re improving bisection quality here:
https://github.com/google/syzkaller/issues/1051
But so far no magic bullet come up. So please continue treating the
results with understanding. The incorrect results were usually easy to
identify: commit to a completely unrelated subsystem, or even
non-current arch. There is always a detailed bisection log attached as
well.

If you are still here, there were some curious cases too, e.g.:
A bug bisected to a comment-only commit:
https://groups.google.com/d/msg/syzkaller-bugs/1BSkmb_fawo/vz7GhBd0CQAJ
A bug bisected to a release tag:
https://groups.google.com/d/msg/syzkaller-bugs/38HP_pUXJ3s/ehD37HSxDAAJ
And a fault-injection-provoked bug bisected to addition of the fault
injection facility by me (which is, well, kinda expected):
https://groups.google.com/d/msg/syzkaller-bugs/GYiA5CKTPXw/MA4mO01wDAAJ

Thanks
