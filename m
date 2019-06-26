Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC1BC4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E522120B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 07:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyqM1jV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfFZHxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 03:53:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33462 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfFZHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 03:53:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so993612plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JHqsYYLzLAosbxbz1ZkSkQroLN+I/zt1AzacawmONrY=;
        b=WyqM1jV2u/kxM67gNNChMCD/srWLt8UFxif+PHuGpzbgE3LpTJrt7rEbevH6EDg7EA
         xF8tH7Jbh3PLlZYXRvyhQyTIN9G45hD9SE3+nPI4rxVnH9lZ6Wb6PT2UPR9Z7e8qw5Vo
         j4hYPGbTDYxJLGb6+arVCfAloAtiPanpPW4Xadwr7qterJdRgNGgoWGT+JtgLvBc9l+M
         DYSnM5SC1DrNcCapOU3OT8L/UFesJC+ezl51GMqT04qGxB9qB/8ifxdT+misqvwEisfJ
         +/kivnaJfyaOnnN1uM1pke3PaHrKRWJDezKNt97NibKS5p1mAANOOVhiidQQgXRP+WeK
         EcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JHqsYYLzLAosbxbz1ZkSkQroLN+I/zt1AzacawmONrY=;
        b=HL1uaiz2SYPPa26dogKXajbkDvUxo7J9fu5IwD8UpXSdGRcZBxvuBfRe5fPAZTovvw
         2JmPpmkA+juhffTpsPDqHzPBQLyicAG9zu9qhqvW8UR37vHbd6aug7BkBpkel0H2alBJ
         g77ZBYquh1og7dAJbtrEHKC19Oi/O5MAt43+qoixCI92wtiFHSkILhi7MLeSV5tmTySw
         6Szcc8ZnCP1mICUEvHTlIuNBNFoI0Tc8He37UlyHOKj6J2SNn3oOjGoG6WZ+Q5L8EGpv
         SahqNl5BEhf7Er6RIrLwx2KdXm4xlgXgHkSERR6amfpQ/Ia+M6oUqCfczhd4QAnNaOM5
         Rbbw==
X-Gm-Message-State: APjAAAXyPIiTcWgQzshvNge6UhC9v+IrBTrQCDwDMAB8xBjPp8r0hz7W
        T+XQU+6YbQb2a8eC2Sx4wPbkqVUjN1ONNhub6IQYqg==
X-Google-Smtp-Source: APXvYqx0OC49B+0u9fYvW2+xXIuYcGfgocchgfhlK03aaHz2u6I5PoagyCc52QVITc8deDrbZKlEXXtykOtZNEDzro4=
X-Received: by 2002:a17:902:1004:: with SMTP id b4mr3862082pla.325.1561535609164;
 Wed, 26 Jun 2019 00:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190617082613.109131-1-brendanhiggins@google.com>
 <20190617082613.109131-8-brendanhiggins@google.com> <20190625232249.GS19023@42.do-not-panic.com>
In-Reply-To: <20190625232249.GS19023@42.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 26 Jun 2019 00:53:18 -0700
Message-ID: <CAFd5g46mnd=a0OqFCx0hOHX+DxW+5yA2LXH5Q0gEg8yUZK=4FA@mail.gmail.com>
Subject: Re: [PATCH v5 07/18] kunit: test: add initial tests
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
        Steven Rostedt <rostedt@goodmis.org>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 4:22 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Mon, Jun 17, 2019 at 01:26:02AM -0700, Brendan Higgins wrote:
> > diff --git a/kunit/example-test.c b/kunit/example-test.c
> > new file mode 100644
> > index 0000000000000..f44b8ece488bb
> > --- /dev/null
> > +++ b/kunit/example-test.c
>
> <-- snip -->
>
> > +/*
> > + * This defines a suite or grouping of tests.
> > + *
> > + * Test cases are defined as belonging to the suite by adding them to
> > + * `kunit_cases`.
> > + *
> > + * Often it is desirable to run some function which will set up things which
> > + * will be used by every test; this is accomplished with an `init` function
> > + * which runs before each test case is invoked. Similarly, an `exit` function
> > + * may be specified which runs after every test case and can be used to for
> > + * cleanup. For clarity, running tests in a test module would behave as follows:
> > + *
>
> To be clear this is not the kernel module init, but rather the kunit
> module init. I think using kmodule would make this clearer to a reader.

Seems reasonable. Will fix in next revision.

> > + * module.init(test);
> > + * module.test_case[0](test);
> > + * module.exit(test);
> > + * module.init(test);
> > + * module.test_case[1](test);
> > + * module.exit(test);
> > + * ...;
> > + */
>
>   Luis
