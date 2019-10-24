Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0621ECA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB39A2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BcaBLSXm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409495AbfJXOtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:49:47 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46536 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409485AbfJXOtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:49:47 -0400
Received: by mail-qt1-f194.google.com with SMTP id u22so38198869qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pd8O3Eb7qSMRp9Kj05XZyId359rCorPJtmLFzVCz1tU=;
        b=BcaBLSXmWaHk5110Xo0O38xPCC95AqKidjb+KH5ChdckilUoZbt1WyEwYm1yUOa4RM
         RfiRdAcCfWShMq1AjdO4X2NNxO19cCSlBCF7CR4/hwIxt4Qc9ZpW6S48IFadbBdf17cX
         JALXMDwZp1n9/94SF0EcqIO9snuYmxP7M7P7Uz6YvVLb9xy5N6KEnmIYf6UEPboXYSS4
         atki90J22tNTjqSCVObVMuAnhhzK1cJm0cqovSZ96lgg/WHDuWXptOynmVwTtSpq1U9m
         ZexHeZgG4YVPSYrJr3pZGyq4CSR3sZlmC9nig7ZRz43wPKhTVKpcWL8SFOKxwtxlIzAv
         Hxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pd8O3Eb7qSMRp9Kj05XZyId359rCorPJtmLFzVCz1tU=;
        b=SYG/zsb0t86UcK2YEuDdkjOBhJVYI4MSW4GX4sWAgEIidv2mirCPLoccgkRKdvgJqP
         SXJG1GH+8yr1r7P4+4yXx8T/vlKsN2NOPDmeUpeRTUomdPjcreg/M24BiAdWT9Njunsw
         +idst09kN18o+Cz10Z7v2eVVUHtRvsf7O4cPlByWzzVf5Y99wcnkJUbSI6GWJOmiqyYH
         CxLTljzenqodZzgaIERHsj1wSZb4HSCZRJT02bk7J45kx5/00m+D9v0fOaYA5YHnhAhu
         4whEZz+KW3smvg5S7QRKODRYKKlOrGpgWrfqN86S/BkgPGZcqYBiQM+o9beO/1x0IKVf
         Vkvw==
X-Gm-Message-State: APjAAAVl0pQiM6kWbWpAKFah88qPaxCzZeV6GCK/z01TzH5V9EzS//wG
        psKZT67cUHB1RijtxxHEHWKgltqvZ+UouD4csYsG2A==
X-Google-Smtp-Source: APXvYqxizfGeXucr8Xm3hiQaEdwpD1zIkSfhY2uthQgN/hAxrw59HH8nPL+eRe3wXdx0aAtlxBla3csbcsZB0vAO3is=
X-Received: by 2002:a0c:fec3:: with SMTP id z3mr15231985qvs.122.1571928585784;
 Thu, 24 Oct 2019 07:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20191009114809.8643-1-christian.brauner@ubuntu.com>
 <20191021113327.22365-1-christian.brauner@ubuntu.com> <20191023121603.GA16344@andrea.guest.corp.microsoft.com>
 <CACT4Y+Y86HFnQGHyxv+f32tKDJXnRxmL7jQ3tGxVcksvtK3L7Q@mail.gmail.com>
 <20191024113155.GA7406@andrea.guest.corp.microsoft.com> <CACT4Y+Z2-mm6Qk0cecJdiA5B_VsQ1v8k2z+RWrDQv6dTNFXFog@mail.gmail.com>
 <20191024130502.GA11335@andrea.guest.corp.microsoft.com> <CACT4Y+ahUr11pQQ7=dw80Abj5owUPnPdufbMYvsKLM6iDg5QQg@mail.gmail.com>
 <20191024134319.GA12693@andrea.guest.corp.microsoft.com> <CACT4Y+ZXQyqgBvwgb6cy7NP5FTBbktq5j4ZyySp7jrbcJwFUTA@mail.gmail.com>
 <20191024144049.GA13747@andrea.guest.corp.microsoft.com>
In-Reply-To: <20191024144049.GA13747@andrea.guest.corp.microsoft.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 24 Oct 2019 16:49:33 +0200
Message-ID: <CACT4Y+aCSZmrmGv+=LPfzt0VBD5XqjsvSQ+6LHyr8VQW5tN6xg@mail.gmail.com>
Subject: Re: [PATCH v6] taskstats: fix data-race
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bsingharora@gmail.com,
        Marco Elver <elver@google.com>,
        stable <stable@vger.kernel.org>,
        syzbot <syzbot+c5d03165a1bd1dead0c1@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 4:40 PM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> On Thu, Oct 24, 2019 at 03:58:40PM +0200, Dmitry Vyukov wrote:
> > On Thu, Oct 24, 2019 at 3:43 PM Andrea Parri <parri.andrea@gmail.com> wrote:
> > >
> > > > But why? I think kernel contains lots of such cases and it seems to be
> > > > officially documented by the LKMM:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/memory-model/Documentation/explanation.txt
> > > > address dependencies and ppo
> > >
> > > Well, that same documentation also alerts about some of the pitfalls
> > > developers can incur while relying on dependencies.  I'm sure you're
> > > more than aware of some of the debate surrounding these issues.
> >
> > I thought that LKMM is finally supposed to stop all these
> > centi-threads around subtle details of ordering. And not we finally
> > have it. And it says that using address-dependencies is legal. And you
> > are one of the authors. And now you are arguing here that we better
> > not use it :) Can we have some black/white yes/no for code correctness
> > reflected in LKMM please :) If we are banning address dependencies,
> > don't we need to fix all of rcu uses?
>
> Current limitations of the LKMM are listed in tools/memory-model/README
> (and I myself discussed a number of them at LPC recently); the relevant
> point here seems to be:
>
> 1.      Compiler optimizations are not accurately modeled.  Of course,
>         the use of READ_ONCE() and WRITE_ONCE() limits the compiler's
>         ability to optimize, but under some circumstances it is possible
>         for the compiler to undermine the memory model.  [...]
>
>         Note that this limitation in turn limits LKMM's ability to
>         accurately model address, control, and data dependencies.
>
> A less elegant, but hopefully more effective, way to phrase such point
> is maybe "feel free to rely on dependencies, but then do not blame the
> LKMM authors please".  ;-)

We are not going to blame LKMM authors :)

Acquire will introduce actual hardware barrier on arm/power/etc. Maybe
it does not matter here. But I feel if we start replacing all
load-depends/rcu with acquire, it will be noticeable overhead. So what
do we do in the context of the whole kernel?
