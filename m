Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1BFC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DA420B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 08:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IkHW2/q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfFZIDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 04:03:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34957 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbfFZIDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 04:03:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so931164pfd.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 01:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwcdyZlVJNYhzqAX8drYdwwlincSCC0RlYdtVUa7uAU=;
        b=IkHW2/q5zYf/AiFOwOUn62sZGCukGK93pV5qaXaFIqAD6rVurvvvVguZ0CQNqSK004
         PUW6XYRD1tpIvu/H8uK2xdNaMWkc3s+ZreXHoEsItZgP1H729MJ8nowT1aehVpl1AnJq
         rAPmVbRpyeOR+0aKXV1iywesPypOO3F4fwUcKnHNHDKkSlnXU9KrB33bQAymKu7tZx6G
         yt/Ix8apmwB+zPUY0f7g7GrCvvhKCA2B8FFf68JI9BW8d/snEU6oOmLqSE4EOwMnXWLP
         uFddQ1SWm8yfpnKxzglfseoQZZbmazxOSGTrgVrxfJIOk1+YhP4zhoDMctTsB330F1Sn
         /4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwcdyZlVJNYhzqAX8drYdwwlincSCC0RlYdtVUa7uAU=;
        b=ZNIxTc9nsDJz3fjZomNhH/uSevfdUZbiWGyL8qlTaqlnncqYlACB2Vm4uPyr1fXy2r
         NbGeRPYGBUG3iCIL8+uFn/w2Rakg+hIdt/qalABX8VsKR/WC/vym5mGMG6JamOY3c4CM
         uyrjjGkpA+Hn3ironVAd/fVLipanGycoSvCMVGgwsWTIUeND8EFVX0sMC/y4DYO6D+R0
         Qq542PMdDyegzr2gqgj60hoJpI+hKD/UhVvjRP7hbLUWu4GKhpkHLHQqaQKZ1jEf3nhc
         r4+xP6Yp2vi63XSqfycXWzcb2s8iKXNfj14PNG2B5r2NhyHsPM5UG5aQmA60woxg78av
         DoEg==
X-Gm-Message-State: APjAAAWCR+dRVSxwbRq+DDQEOr7kRJqn9VWvYJeZ4+miGeF0iGNI700n
        l9ovgR2jpTL5qM8Q5pIbU8Qzky1T8aETcUGMoXBX0A==
X-Google-Smtp-Source: APXvYqzSvFzyXqC4mv+sYfABQnmt0YNMhvFTkgdzLZZeovItyFY3wThgA7+iWx0YSEf5WS6vtdXjsfVxGyJkZN8WaD8=
X-Received: by 2002:a17:90a:9382:: with SMTP id q2mr3140021pjo.131.1561536186861;
 Wed, 26 Jun 2019 01:03:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-14-brendanhiggins@google.com> <20190626000150.GT19023@42.do-not-panic.com>
In-Reply-To: <20190626000150.GT19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 26 Jun 2019 01:02:55 -0700
Message-ID: <CAFd5g44kkepB2hZcpYL-NB5ZHYE5tP7W-0yducGCX7Khd9gd9w@mail.gmail.com>
Subject: Re: [PATCH v5 13/18] kunit: tool: add Python wrappers for running
 KUnit tests
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
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
        Randy Dunlap <rdunlap@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com,
        Felix Guo <felixguoxiuping@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 5:01 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:26:08AM -0700, Brendan Higgins wrote:
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed.log
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-failure.log
> >  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
> >  create mode 100644 tools/testing/kunit/test_data/test_output_isolated_correctly.log
> >  create mode 100644 tools/testing/kunit/test_data/test_read_from_file.kconfig
>
> Why are these being added upstream? The commit log does not explain
> this.

Oh sorry, those are for testing purposes. I thought that was clear
from being in the test_data directory. I will reference it in the
commit log in the next revision.
