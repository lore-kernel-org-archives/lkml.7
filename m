Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C667DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A3B5216B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N0w2rApM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbfGZPVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:21:12 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:44693 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfGZPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:21:10 -0400
Received: by mail-io1-f68.google.com with SMTP id s7so105411329iob.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9G1CH0Ps2FRcZ/NwMc7CwEB3cMwgOdfmNpmMO9HdoM=;
        b=N0w2rApMLkoaZxE6gBTrU8k8luxL61ZdCWczIF69GZlKQMFUb4lG2guayRg6yAIpbk
         H1X366pDlqnI3DIuEPp2eBW6njqlQnGw537yrxBAD3BJ8WtV/88SiHMNhsFBE5NfC8Mc
         6pFDGGrtahrlAC+muBEsD3Uw/mU6kjLtiI4R5g3tYOUIQwjj+xGug574LijMJ9525yyM
         PBE6JWBDuqPjDFgkXCHTfNPmGyDCt/onMSaEIBQ8DSyYxWlpz9e/7Zj/YiwrwWq4N/JH
         c1tG2fhMhAiOJtHrldKpL6DVeLTIm6XxQznNCdMNS+EWp3QiFKDkpkNeDLme62XdCPgV
         PtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9G1CH0Ps2FRcZ/NwMc7CwEB3cMwgOdfmNpmMO9HdoM=;
        b=ddYwkNme2Olsn/6/ibToIf5LFGxw+ufXwTMDSQaPw6NR6PCtPNJ2jV6nHPaq0y1GTw
         gJ3A3uOiWSUmYZgrOJ0XAi76D8GJYKWvizyhIfFPHf8lz9isOBdUQIYTHhZmmB/EAvPn
         Qct4xZ8FqKXrTH4MjEUNv83FjKDiB0khYAiXy2pavj1t5hZJn9sb996Fjrp3XKiDiD45
         NbDeCoI6fEKiYE+WdUi+Jg3GGzkK94Ak7L6ecCSNZON8hoky1Di2iXoXUbPhOgDmeGw4
         U4Hrb9yeDgJgaOXMFg9E/EB8H6+59B2NqE1po3ZAX4Yn5Dei3WYLpxiRsZGVIWshD7qT
         RoyQ==
X-Gm-Message-State: APjAAAWr0kagDp9BymO9T3zEUcYMCSoP0BTYOnygC2kEpvCqgM5pUUXQ
        Uh50DhgBNMgXKCbRhuPGqZGWnDhSGnQdkC2sgZo8/A==
X-Google-Smtp-Source: APXvYqzWkKaER3d1SoL4pM51luD5r76GIZCi5wBc/4zHT9xYg4/8N5PMzy6UISLqCi9oNf8Xd9jLBaT9T4dOYpBVyvo=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr65334094ior.231.1564154468687;
 Fri, 26 Jul 2019 08:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052ad6b058e722ba4@google.com> <20190726130013.GC2368@arrakis.emea.arm.com>
In-Reply-To: <20190726130013.GC2368@arrakis.emea.arm.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 26 Jul 2019 17:20:55 +0200
Message-ID: <CACT4Y+b5H4jvY34iT2K0m6a2HCpzgKd3dtv+YFsApp=-18B+pw@mail.gmail.com>
Subject: Re: memory leak in vq_meta_prefetch
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     syzbot <syzbot+a871c1e6ea00685e73d7@syzkaller.appspotmail.com>,
        alexandre.belloni@free-electrons.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, nicolas.ferre@atmel.com,
        Rob Herring <robh@kernel.org>, sre@kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 3:00 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Wed, Jul 24, 2019 at 12:18:07PM -0700, syzbot wrote:
> > syzbot found the following crash on:
> >
> > HEAD commit:    c6dd78fc Merge branch 'x86-urgent-for-linus' of git://git...
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15fffef4600000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8de7d700ea5ac607
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a871c1e6ea00685e73d7
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127b0334600000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12609e94600000
> >
> > The bug was bisected to:
> >
> > commit 0e5f7d0b39e1f184dc25e3adb580c79e85332167
> > Author: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Date:   Wed Mar 16 13:19:49 2016 +0000
> >
> >     ARM: dts: at91: shdwc binding: add new shutdown controller documentation
>
> That's another wrong commit identification (a documentation patch should
> not cause a memory leak).
>
> I don't really think kmemleak, with its relatively high rate of false
> positives, is suitable for automated testing like syzbot. You could

Hi Catalin,

Do you mean automated testing in general, or bisection only?
The wrong commit identification is related to bisection only, but you
generalized it to automated testing in general. So which exactly you
mean?


> reduce the false positives if you add support for scanning in
> stop_machine(). Otherwise, in order to avoid locking the kernel for long
> periods, kmemleak runs concurrently with other threads (even on the
> current CPU) and under high load, pointers are missed (e.g. they are in
> CPU registers rather than stack).
