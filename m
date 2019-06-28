Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DAA6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8802063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5kLlPi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfF1IJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:09:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32921 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfF1IJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:09:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id m4so2252774pgk.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yibP/Iv6ps2Lbs4MfioQUnaQ1X0MZgCBiZaerRAAUs0=;
        b=e5kLlPi61UOlg3aWbm3hyHJ6zEvPrbJg4WaMTgr5J7N6beCFHbvMVMWvXm34zFIMK6
         sy+TCthgNvl6QKdGAvF199JWgLSzY0riL7Qema9Z8eQSMrEVD7QmDgObmKA9VnGm6jQk
         Qk9Vw4tG1NS/Rsaor+MwqJJtzbW9NLCCg64qdKIwo/lqdLjqjD0HoEJZR2UkGwIQNQU7
         B8LVi8olEdiEG1gQQPAGB3QH7tntl/R65/A9R5rItsLpolqg+IRJEp1Du/WH5LqoOfL3
         I3l8I0kuDspWHSG/V5vI+q5UJh9nND3VlxUlk753w0GhWsuvm1nMSIm2VqKl1wq8mbGo
         9uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yibP/Iv6ps2Lbs4MfioQUnaQ1X0MZgCBiZaerRAAUs0=;
        b=k1xPfUIvIDha27hIh88QC5jhQ8eA7QxQR8qzFb3WM1BWcWnJ99/cp5BX9wv2fc9eQF
         fvgoGnboyuSr0ZFL7kIJPXY370TR3Z8AjrCf3s3xTphuV9tUXV1fbFhzkl12EuDFRBBO
         LV/nwPMFciLkTcIKuMDLvj2g+uPrUYfAfbtwqvBKlnjFxVeL5vm7vbdWoh8uh6e5pnAn
         tJTnwCiprArbb+0Aw/s+jkJASj5MCDHAu+RAGVShZqGWKi4xukFQtG67OfUZvxJzoujH
         l67Kvjurlhdbt67TDD1hOStED5HdW+z4pT5v0rUPGUtFRCf/NcDU72omYbbHb2Z5cDEl
         ouXA==
X-Gm-Message-State: APjAAAVu//zzdcBdTOiQl0a4D7UBDeqem+sb/M8XMoTiwwnHP7ize2Dt
        UyROi8V3ILmxlVXuCs3xvuNZTKiq3v15Cg315/VV4Q==
X-Google-Smtp-Source: APXvYqwa5Gi43WdeQYYulM3cScojWTt0/MI+kDN9NbNdt1CeW4jxKTFR3Algm98Jmh+XvwAADJqdAi9a1c1dDVA05Ew=
X-Received: by 2002:a17:90a:be0d:: with SMTP id a13mr11033056pjs.84.1561709395368;
 Fri, 28 Jun 2019 01:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-2-brendanhiggins@google.com> <20190620001526.93426218BE@mail.kernel.org>
 <CAFd5g46Jhxsz6_VXHEVYvTeDRwwzgKpr=aUWLL5b3S4kUukb8g@mail.gmail.com>
 <20190626034100.B238520883@mail.kernel.org> <CAFd5g46zHAupdUh3wDuqPJti2M+_=oje_5weFe7AVLQfkDDM6A@mail.gmail.com>
 <20190627181636.5EA752064A@mail.kernel.org>
In-Reply-To: <20190627181636.5EA752064A@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 28 Jun 2019 01:09:44 -0700
Message-ID: <CAFd5g44V3ZLNazUOgOo2sFR3zzbNnTkH4e9uxGX4iHi7G73Mzw@mail.gmail.com>
Subject: Re: [PATCH v5 01/18] kunit: test: add KUnit test runner core
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, shuah <shuah@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>, Jeff Dike <jdike@addtoit.com>,
        Joel Stanley <joel@jms.id.au>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 11:16 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-06-26 16:00:40)
> > On Tue, Jun 25, 2019 at 8:41 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > > scenario like below, but where it is a problem. There could be three
> > > CPUs, or even one CPU and three threads if you want to describe the
> > > extra thread scenario.
> > >
> > > Here's my scenario where it isn't needed:
> > >
> > >     CPU0                                      CPU1
> > >     ----                                      ----
> > >     kunit_run_test(&test)
> > >                                               test_case_func()
> > >                                                 ....
> > >                                               [mock hardirq]
> > >                                                 kunit_set_success(&test)
> > >                                               [hardirq ends]
> > >                                                 ...
> > >                                                 complete(&test_done)
> > >       wait_for_completion(&test_done)
> > >       kunit_get_success(&test)
> > >
> > > We don't need to care about having locking here because success or
> > > failure only happens in one place and it's synchronized with the
> > > completion.
> >
> > Here is the scenario I am concerned about:
> >
> > CPU0                      CPU1                       CPU2
> > ----                      ----                       ----
> > kunit_run_test(&test)
> >                           test_case_func()
> >                             ....
> >                             schedule_work(foo_func)
> >                           [mock hardirq]             foo_func()
> >                             ...                        ...
> >                             kunit_set_success(false)   kunit_set_success(false)
> >                           [hardirq ends]               ...
> >                             ...
> >                             complete(&test_done)
> >   wait_for_completion(...)
> >   kunit_get_success(&test)
> >
> > In my scenario, since both CPU1 and CPU2 update the success status of
> > the test simultaneously, even though they are setting it to the same
> > value. If my understanding is correct, this could result in a
> > write-tear on some architectures in some circumstances. I suppose we
> > could just make it an atomic boolean, but I figured locking is also
> > fine, and generally preferred.
>
> This is what we have WRITE_ONCE() and READ_ONCE() for. Maybe you could
> just use that in the getter and setters and remove the lock if it isn't
> used for anything else.
>
> It may also be a good idea to have a kunit_fail_test() API that fails
> the test passed in with a WRITE_ONCE(false). Otherwise, the test is
> assumed successful and it isn't even possible for a test to change the
> state from failure to success due to a logical error because the API
> isn't available. Then we don't really need to have a generic
> kunit_set_success() function at all. We could have a kunit_test_failed()
> function too that replaces the kunit_get_success() function. That would
> read better in an if condition.

You know what, I think you are right.

Sorry, for not realizing this earlier, I think you mentioned something
along these lines a long time ago.

Thanks for your patience!

> >
> > Also, to be clear, I am onboard with dropping then IRQ stuff for now.
> > I am fine moving to a mutex for the time being.
> >
>
> Ok.

Thanks!
