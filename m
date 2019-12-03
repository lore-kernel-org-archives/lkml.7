Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F9C432C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E8520675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 22:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qmmaebzo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfLCWgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 17:36:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44883 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfLCWgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 17:36:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so2288031pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 14:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r06+KrKZmbSJH6UUm02fNkOof8/gjixGbcfjblQ+qRs=;
        b=qmmaebzoB44V44DUoG8FAhCTP3bWZxhuWc/e85o0mdI6Hg+gGv8FZsbinUlNKbd+cB
         SML2TNJLyK+1Kz5vJTHNbPffrS+dZYi3mWcVJEvQXoePAoP/scqeV34UCbocwPR6YFB6
         R4C/xrXvcfFez3m0kS8tQZ97SM/tpq2yM16XDitDpBR9BwH4IuYvXRNj9zz8dtypvU4Z
         JgmqbL+mAilAq2eBnhxfjTy+simzyTz5k7LbYN9oWVWjzwPzTekeGkc9P3LScLtACFmK
         MBXNDmluF4EhFW2ZAuR87z06qoWJveYtsGKQsHRz45F5zAAjEwhvdPwulQQGoFKsAC21
         wGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r06+KrKZmbSJH6UUm02fNkOof8/gjixGbcfjblQ+qRs=;
        b=oC8SPVHo0Q5f4Wng072F+2rDxyqvbRlMvb8oojgdO1GADAsOWfbiubTdnO7fCTZSHl
         vZOaEm5u6ijuHPdx/hzmBN8gqSJQEQ8kdTB+Qkfav8Q+oeW9wg77i/zf9NyeVvKAy+UR
         4WvP/7vidF+L9twT1yzmwYiKDDU1quBMl6r38K/JZNEAS4edbR30WELjIhy8+bsPMO5i
         kPc/uZApfkW0K2s7xZARFCa+LjyapIjAOALSHN+rjEViUdziYWQsajr774Y4ITZqOpUy
         bw8dl1H6/1ohcr1izwkmQQwi9yAtt/J4ukx5gvxoftPPPcIG+vcnPapgyZUpOP8MmnY7
         GpbQ==
X-Gm-Message-State: APjAAAUCnKlJ0XpVZwGIyCzRrPOEBmexGs8ADLfzfuKLbWb1WLpgzQUv
        IzM26B1fBzxoJUtCh6l5JInvOjUX/z4M/cWD5j76LQ==
X-Google-Smtp-Source: APXvYqxWObr1MDrGkYFSZAzjU0wyoXqLlbyFY+LBrt8mBQKO1DqOKm01gXn/4tlInbMN4BHmYN9VZEP1u5qBzoGNkK8=
X-Received: by 2002:a63:480f:: with SMTP id v15mr7802935pga.201.1575412564268;
 Tue, 03 Dec 2019 14:36:04 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <20191203070025.GA4206@google.com> <CAEjAshraUy20gEEaff69=b11DhB7zbz8WHT=6wOuw6C2FyJwYA@mail.gmail.com>
 <CAEjAsho98ER1RQ6=++ECmoCJxw2mMrGqV4jAgW5wgfb8eEM9eQ@mail.gmail.com>
 <CAFd5g46qPPsKJFqs07Eiea0Nim=YDWbOUndJu=JbW--VcTb-ww@mail.gmail.com> <CAEjAshpTAj_aYBUG1PWoyPajT69hWptXOZKwydg6duTNV5=aLQ@mail.gmail.com>
In-Reply-To: <CAEjAshpTAj_aYBUG1PWoyPajT69hWptXOZKwydg6duTNV5=aLQ@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 14:35:53 -0800
Message-ID: <CAFd5g46VZ10FeKJspSQXWc+zHervGQk5brOxei+S53OO5kYfTQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Fix nits in the kunit
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 3, 2019 at 10:11 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Tue, Dec 3, 2019 at 6:45 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Tue, Dec 3, 2019 at 12:26 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > You're right, the error was due to the assumption of the existence of the
> > > build_dir.  The "kunit: Create default config in '--build_dir'" patch made the
> > > bug.  I fixed it in the second version patchset[1].
> > >
> > > [1] https://lore.kernel.org/linux-doc/1575361141-6806-1-git-send-email-sj38.park@gmail.com/
> >
> > After trying your new patches, I am still getting the
> > "FileNotFoundError" when the given build_dir has not been created.
>
> Sorry, apparently my mistake...  Sent v3 fixing it:
> https://lore.kernel.org/linux-kselftest/1575396508-21480-1-git-send-email-sj38.park@gmail.com/T/#t

Awesome, looks like that works now!

Thanks for taking care of this!

> Thanks,
> SeongJae Park
>
>
> >
> > > Thanks,
> > > SeongJae Park
> > >
> > > On Tue, Dec 3, 2019 at 8:10 AM SeongJae Park <sj38.park@gmail.com> wrote:
> > > >
> > > > On Tue, Dec 3, 2019 at 8:00 AM Brendan Higgins
> > > > <brendanhiggins@google.com> wrote:
> > > > >
> > > > > On Mon, Dec 02, 2019 at 08:25:18AM +0900, SeongJae Park wrote:
> > > > > > From: SeongJae Park <sjpark@amazon.de>
> > > > > >
> > > > > > This patchset contains trivial fixes for the kunit documentations and the
> > > > > > wrapper python scripts.
> > > > > >
> > > > > > SeongJae Park (6):
> > > > > >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> > > > > >   docs/kunit/start: Skip wrapper run command
> > > > > >   kunit: Remove duplicated defconfig creation
> > > > > >   kunit: Create default config in 'build_dir'
> > > > > >   kunit: Place 'test.log' under the 'build_dir'
> > > > > >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> > > > > >
> > > > > >  Documentation/dev-tools/kunit/start.rst | 19 +++++--------------
> > > > > >  tools/testing/kunit/kunit.py            | 10 ++++++----
> > > > > >  tools/testing/kunit/kunit_kernel.py     |  6 +++---
> > > > > >  3 files changed, 14 insertions(+), 21 deletions(-)
> > > > >
> > > > > I applied your patchset to torvalds/master, ran the command:
> > > > >
> > > > > tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig --build_dir=.kunit
> > > > >
> > > > > and got the error:
> > > > >
> > > > > Traceback (most recent call last):
> > > > >   File "tools/testing/kunit/kunit.py", line 140, in <module>
> > > > >     main(sys.argv[1:])
> > > > >   File "tools/testing/kunit/kunit.py", line 123, in main
> > > > >     create_default_kunitconfig()
> > > > >   File "tools/testing/kunit/kunit.py", line 36, in create_default_kunitconfig
> > > > >     kunit_kernel.KUNITCONFIG_PATH)
> > > > >   File "/usr/lib/python3.7/shutil.py", line 121, in copyfile
> > > > >     with open(dst, 'wb') as fdst:
> > > > > FileNotFoundError: [Errno 2] No such file or directory: '.kunit/.kunitconfig'
> > > > >
> > > > > It seems that it expects the build_dir to already exist; however, I
> > > > > don't think this is clear from the error message. Would you mind
> > > > > addressing that here?
> > > >
> > > > Thank you for sharing this.  I will take a look!
> > > >
> > > >
> > > > Thanks,
> > > > SeongJae Park
> > > > >
> > > > > Cheers!
