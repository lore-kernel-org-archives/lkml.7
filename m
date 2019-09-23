Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A153C4CED0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E38A20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T1+NUcrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440316AbfIWSGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:06:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46021 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390851AbfIWSGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:06:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so6823116pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 11:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nhneKc2j612Q2N+13gaGbKUVRsMhSSxGH7dWRfDGMkM=;
        b=T1+NUcrIy3lmkEWKUYoZizpT4pz7k1bgugAw5x236rFYSY4jiXwwGSkW/t3eTOgxZZ
         BdFUIyPtNrmuOnFW8pMCBh0TOJ0ymwQs3hrr2tpjSwDy/Jn7hGK64HYhWlOR+Pme/Rjs
         q1skpdHUJIQUzoH1STCk8Qg+RNLa+nlemSvf5GuWwDF1JHGzH7MzOgvgGfuUDt1Yjlx+
         jLfCXyd8JabRhAP+sdDZJeube1e/2Pp2+w4UQdEthm0TnALHcGP03fa6VfY8gUFfbf65
         93WWIiL7H75Fl011ZWNdHPF+hL1hlBHne2JyK6E63p3OCh/BSVxvl8asUe8na9vlCXYJ
         Puqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nhneKc2j612Q2N+13gaGbKUVRsMhSSxGH7dWRfDGMkM=;
        b=CghBe7MVc1lurHLJkzDdQgzmU6ERFK/MlciYY0/pVay2b0G+Bl80d2vJ/wR6dULjcp
         0A8Ngwb4cRZ+FF1EHM/FvP83i8uJyhCpkLxQiukAPm230vtynMr1VkEMFhuhyph0tjVy
         oZ+8SjKUpSgaJdSzWfV2HrHgT0INhzr/lrflEV6d224fo96yCbyvgtLr95+mT52YpBV3
         wIoIT5gRUnzOOWJt9mDfL1V+oFnV2Q0qFCb6/zuByzr42usgEsoPBlNJSrbderR6OYTV
         9IYHo7Nwx0Z8tQ792k+arr1uvAzZgWaJjGy4JSepljWG/JXUzmuZeVaczfdMpv+AjS7h
         2reA==
X-Gm-Message-State: APjAAAWwlvEjUtiXnoMBuy+yzFT0y0ZcG9+b3KrE31slM0XLijWuokr5
        vR6+OYbUR9XqXO92OIKeURb6lgrjKB9qLjJmwUdVcg==
X-Google-Smtp-Source: APXvYqwfsjyOL3n2LFVEPJm/qlWBl4UOe3/cXY8+uFis2YYWhVkjpN1GVmQ/ETS5lMq5TdaURd2f4h4p74UheIpwH8I=
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr1025347plj.325.1569261990405;
 Mon, 23 Sep 2019 11:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190923090249.127984-1-brendanhiggins@google.com>
 <20190923090249.127984-16-brendanhiggins@google.com> <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
In-Reply-To: <d87eba35-ae09-0c53-bbbe-51ee9dc9531f@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 23 Sep 2019 11:06:19 -0700
Message-ID: <CAFd5g45y-NWzbn8E8hUg=n4U5E+N6_4D8eCXhQ74Y0N4zqVW=w@mail.gmail.com>
Subject: Re: [PATCH v18 15/19] Documentation: kunit: add documentation for KUnit
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah <shuah@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
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
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Felix Guo <felixguoxiuping@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 8:48 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 9/23/19 2:02 AM, Brendan Higgins wrote:
> > Add documentation for KUnit, the Linux kernel unit testing framework.
> > - Add intro and usage guide for KUnit
> > - Add API reference
> >
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  Documentation/dev-tools/index.rst           |   1 +
> >  Documentation/dev-tools/kunit/api/index.rst |  16 +
> >  Documentation/dev-tools/kunit/api/test.rst  |  11 +
> >  Documentation/dev-tools/kunit/faq.rst       |  62 +++
> >  Documentation/dev-tools/kunit/index.rst     |  79 +++
> >  Documentation/dev-tools/kunit/start.rst     | 180 ++++++
> >  Documentation/dev-tools/kunit/usage.rst     | 576 ++++++++++++++++++++
> >  7 files changed, 925 insertions(+)
> >  create mode 100644 Documentation/dev-tools/kunit/api/index.rst
> >  create mode 100644 Documentation/dev-tools/kunit/api/test.rst
> >  create mode 100644 Documentation/dev-tools/kunit/faq.rst
> >  create mode 100644 Documentation/dev-tools/kunit/index.rst
> >  create mode 100644 Documentation/dev-tools/kunit/start.rst
> >  create mode 100644 Documentation/dev-tools/kunit/usage.rst
>
>
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > new file mode 100644
> > index 000000000000..6dc229e46bb3
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -0,0 +1,180 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +===============
> > +Getting Started
> > +===============
> > +
> > +Installing dependencies
> > +=======================
> > +KUnit has the same dependencies as the Linux kernel. As long as you can build
> > +the kernel, you can run KUnit.
> > +
> > +KUnit Wrapper
> > +=============
> > +Included with KUnit is a simple Python wrapper that helps format the output to
> > +easily use and read KUnit output. It handles building and running the kernel, as
> > +well as formatting the output.
> > +
> > +The wrapper can be run with:
> > +
> > +.. code-block:: bash
> > +
> > +   ./tools/testing/kunit/kunit.py run
> > +
> > +Creating a kunitconfig
> > +======================
> > +The Python script is a thin wrapper around Kbuild as such, it needs to be
>
>                                        around Kbuild. As such,

Thanks for pointing this out.

>
> > +configured with a ``kunitconfig`` file. This file essentially contains the
> > +regular Kernel config, with the specific test targets as well.
> > +
> > +.. code-block:: bash
> > +
> > +     git clone -b master https://kunit.googlesource.com/kunitconfig $PATH_TO_KUNITCONFIG_REPO
> > +     cd $PATH_TO_LINUX_REPO
> > +     ln -s $PATH_TO_KUNIT_CONFIG_REPO/kunitconfig kunitconfig
> > +
> > +You may want to add kunitconfig to your local gitignore.
> > +
> > +Verifying KUnit Works
> > +---------------------
> > +
> > +To make sure that everything is set up correctly, simply invoke the Python
> > +wrapper from your kernel repo:
> > +
> > +.. code-block:: bash
> > +
> > +     ./tools/testing/kunit/kunit.py
> > +
> > +.. note::
> > +   You may want to run ``make mrproper`` first.
>
> I normally use O=builddir when building kernels.
> Does this support using O=builddir ?

Yep, it supports specifying a separate build directory.

> > +
> > +If everything worked correctly, you should see the following:
> > +
> > +.. code-block:: bash
> > +
> > +     Generating .config ...
> > +     Building KUnit Kernel ...
> > +     Starting KUnit Kernel ...
> > +
> > +followed by a list of tests that are run. All of them should be passing.
> > +
> > +.. note::
> > +   Because it is building a lot of sources for the first time, the ``Building
> > +   kunit kernel`` step may take a while.
> > +
> > +Writing your first test
> > +=======================
>
> [snip]
>
> > diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> > new file mode 100644
> > index 000000000000..c6e69634e274
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/usage.rst
>
> TBD...

What did you mean by this comment?

Cheers
