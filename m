Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D46C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A9C20842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 08:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CPZkWOHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfHMIR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:17:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40033 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfHMIR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 04:17:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so50860217pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 01:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CvvGY69Nmyx3J8sHaJpZGgipVJI6CqLFqZK5+1dlPxc=;
        b=CPZkWOHowV+aBwrh9KxH7EXMPTuFrJOvoS7J4A7iG2d7XZw+PZZte604kQB4upqcuw
         XI3Y4LPhGHyipmQwzFk37+5/VCxe323AKZeCXKXep46wzvR7MYknNyG/+FbVtSad+szr
         AFq2r4IUblQknCCefEy6N3Sn+/ExP19jK141bUmx712IHTDtdiy0WQ8Zsuj8EnxuNkOl
         DGvMO5zQtqovgRxT29Vpmp0npGFPjCkvMrUp+g/Itgu2cFRUjl718xsitSHYLFxNTEtS
         uiUDv6gkmUu6niAH/wMNWuzALz1k2xhMYJykU91hkS+EPrbNS0sG8Q4+Ae8q+RCLUi8a
         5cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CvvGY69Nmyx3J8sHaJpZGgipVJI6CqLFqZK5+1dlPxc=;
        b=IpolGh7DqB7w/go8JDFZ3rSHdAOEft10bbv3E5Yvmnzd5WoJmMke9/+uGvkgWOEgVT
         IB2hPmIohLdfElkpsNnWhBvTWEAr1ftHuhv+cBEbcixEYwcg2YKtXCF1+dYHG4drmqvM
         qA8mZ62OTHWfdYf/C3ygF+EXpyMos1x8hDpqLdq/iWCX/NZK0qQkdZenhPzKiNNaBmo5
         yG3T+C2QG/8bAJZRpMGIt3AG0dWpTGIvpUwGOmHz8D7VWn5l1vLot0h/cMvUMT2r+Ix4
         I390vesk8KDsU94lPB3DHookxmZi4U2zRxjyw66SkvoQS4OsMt7RA3n1DyehntZ7Rytj
         3fSg==
X-Gm-Message-State: APjAAAUzRpPWZd1WXKE6VSx0vtBV6wEca8OYcHSFJExwIP2whWD6ZWHK
        PDCkw/dfHcYXbELY2fDZLQ4DTRy88RPTiyN+fdsJt2tC
X-Google-Smtp-Source: APXvYqzabaO2apnTNYnFnDL04olYDCtMnZ1clIiOV2CeIO2ivFJRxo/gI/E23vbtMIVs62KTtm1zXuEoBc5tVih7rnk=
X-Received: by 2002:a17:90a:c391:: with SMTP id h17mr1093870pjt.131.1565684276281;
 Tue, 13 Aug 2019 01:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
In-Reply-To: <cover.92d76bb4f6dcedc971d0b72a49e8e459a98bca54.1565676440.git-series.knut.omang@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 13 Aug 2019 01:17:45 -0700
Message-ID: <CAFd5g47bK2hv6dRvqE3hOyq-FrgrR8NJo__HonHFoYOOMkWh6w@mail.gmail.com>
Subject: Re: [RFC 00/19] Integration of Kernel Test Framework (KTF) into the
 kernel tree
To:     Knut Omang <knut.omang@oracle.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shreyans Devendra Doshi <0xinfosect0r@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hidenori Yamaji <hidenori.yamaji@sony.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Timothy Bird <Tim.Bird@sony.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Daniel Vetter <daniel@ffwll.ch>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:11 PM Knut Omang <knut.omang@oracle.com> wrote:
[...]
> Alan Maguire (3):
>   ktf: Implementation of ktf support for overriding function entry and return.
>   ktf: A simple debugfs interface to test results
>   ktf: Simple coverage support
>
> Knut Omang (16):
>   kbuild: Fixes to rules for host-cshlib and host-cxxshlib
>   ktf: Introduce the main part of the kernel side of ktf
>   ktf: Introduce a generic netlink protocol for test result communication
>   ktf: An implementation of a generic associative array container
>   ktf: Configurable context support for network info setup
>   ktf: resolve: A helper utility to aid in exposing private kernel symbols to KTF tests.
>   ktf: Add documentation for Kernel Test Framework (KTF)
>   ktf: Add a small test suite with a few tests to test KTF itself
>   ktf: Main part of user land library for executing tests
>   ktf: Integration logic for running ktf tests from googletest
>   ktf: Internal debugging facilities
>   ktf: Some simple examples
>   ktf: Some user applications to run tests
>   ktf: Toplevel ktf Makefile/makefile includes and scripts to run from kselftest
>   kselftests: Enable building ktf
>   Documentation/dev-tools: Add index entry for KTF documentation
>
>  Documentation/dev-tools/index.rst                   |    1 +-
>  Documentation/dev-tools/ktf/concepts.rst            |  242 +++-
>  Documentation/dev-tools/ktf/debugging.rst           |  248 +++-
>  Documentation/dev-tools/ktf/examples.rst            |   26 +-
>  Documentation/dev-tools/ktf/features.rst            |  307 ++++-
>  Documentation/dev-tools/ktf/implementation.rst      |   70 +-
>  Documentation/dev-tools/ktf/index.rst               |   14 +-
>  Documentation/dev-tools/ktf/installation.rst        |   73 +-
>  Documentation/dev-tools/ktf/introduction.rst        |  134 ++-
>  Documentation/dev-tools/ktf/progref.rst             |  144 ++-
>  scripts/Makefile.host                               |   17 +-
>  tools/testing/selftests/Makefile                    |    1 +-
>  tools/testing/selftests/ktf/Makefile                |   21 +-
>  tools/testing/selftests/ktf/examples/Makefile       |   17 +-
>  tools/testing/selftests/ktf/examples/h2.c           |   45 +-
>  tools/testing/selftests/ktf/examples/h3.c           |   84 +-
>  tools/testing/selftests/ktf/examples/h4.c           |   62 +-
>  tools/testing/selftests/ktf/examples/hello.c        |   38 +-
>  tools/testing/selftests/ktf/examples/kgdemo.c       |   61 +-
>  tools/testing/selftests/ktf/kernel/Makefile         |   15 +-
>  tools/testing/selftests/ktf/kernel/ktf.h            |  604 +++++++-
>  tools/testing/selftests/ktf/kernel/ktf_context.c    |  409 +++++-
>  tools/testing/selftests/ktf/kernel/ktf_cov.c        |  690 ++++++++-
>  tools/testing/selftests/ktf/kernel/ktf_cov.h        |   94 +-
>  tools/testing/selftests/ktf/kernel/ktf_debugfs.c    |  356 ++++-
>  tools/testing/selftests/ktf/kernel/ktf_debugfs.h    |   34 +-
>  tools/testing/selftests/ktf/kernel/ktf_map.c        |  261 +++-
>  tools/testing/selftests/ktf/kernel/ktf_map.h        |  154 ++-
>  tools/testing/selftests/ktf/kernel/ktf_netctx.c     |  132 ++-
>  tools/testing/selftests/ktf/kernel/ktf_netctx.h     |   64 +-
>  tools/testing/selftests/ktf/kernel/ktf_nl.c         |  516 ++++++-
>  tools/testing/selftests/ktf/kernel/ktf_nl.h         |   15 +-
>  tools/testing/selftests/ktf/kernel/ktf_override.c   |   45 +-
>  tools/testing/selftests/ktf/kernel/ktf_override.h   |   15 +-
>  tools/testing/selftests/ktf/kernel/ktf_test.c       |  397 +++++-
>  tools/testing/selftests/ktf/kernel/ktf_test.h       |  381 ++++-
>  tools/testing/selftests/ktf/kernel/ktf_unlproto.h   |  105 +-
>  tools/testing/selftests/ktf/lib/Makefile            |   21 +-
>  tools/testing/selftests/ktf/lib/ktf.h               |  114 +-
>  tools/testing/selftests/ktf/lib/ktf_debug.cc        |   20 +-
>  tools/testing/selftests/ktf/lib/ktf_debug.h         |   59 +-
>  tools/testing/selftests/ktf/lib/ktf_int.cc          | 1031 ++++++++++++-
>  tools/testing/selftests/ktf/lib/ktf_int.h           |   84 +-
>  tools/testing/selftests/ktf/lib/ktf_run.cc          |  177 ++-
>  tools/testing/selftests/ktf/lib/ktf_unlproto.c      |   21 +-
>  tools/testing/selftests/ktf/scripts/ktf_syms.mk     |   16 +-
>  tools/testing/selftests/ktf/scripts/resolve         |  188 ++-
>  tools/testing/selftests/ktf/scripts/runtests.mk     |    3 +-
>  tools/testing/selftests/ktf/scripts/runtests.sh     |  100 +-
>  tools/testing/selftests/ktf/scripts/top_make.mk     |   14 +-
>  tools/testing/selftests/ktf/selftest/Makefile       |   17 +-
>  tools/testing/selftests/ktf/selftest/context.c      |  149 ++-
>  tools/testing/selftests/ktf/selftest/context.h      |   15 +-
>  tools/testing/selftests/ktf/selftest/context_self.h |   34 +-
>  tools/testing/selftests/ktf/selftest/hybrid.c       |   35 +-
>  tools/testing/selftests/ktf/selftest/hybrid.h       |   24 +-
>  tools/testing/selftests/ktf/selftest/hybrid_self.h  |   27 +-
>  tools/testing/selftests/ktf/selftest/ktf_syms.txt   |   17 +-
>  tools/testing/selftests/ktf/selftest/self.c         |  661 ++++++++-
>  tools/testing/selftests/ktf/user/Makefile           |   26 +-
>  tools/testing/selftests/ktf/user/hybrid.cc          |   39 +-
>  tools/testing/selftests/ktf/user/ktfcov.cc          |   68 +-
>  tools/testing/selftests/ktf/user/ktfrun.cc          |   20 +-
>  tools/testing/selftests/ktf/user/ktftest.cc         |   46 +-
>  64 files changed, 8909 insertions(+), 9 deletions(-)

It also looks like all your test code lives outside of the kernel
source dir. I take it you intend for tests to live in
tools/testing/selftests/ktf/ ?

[...]
