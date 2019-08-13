Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB69C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1674720842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 05:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+dmDban"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfHMFGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 01:06:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37677 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfHMFGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 01:06:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id 129so3970788pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 22:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Abf3cK9D+gRrRGwQh2kwak/YzDDkHOqgDtvVTIo4q7A=;
        b=Y+dmDbanwPRKrcGCv4/WQS9jtPyx6cpYSiNcTCluUKOVyeyn7wl8RZe0u1cf6FlML6
         wfRe3v8dcFvKIShJjXRgh8cEGNhzCFLCfZTUSJEGO2Ea0/S9/l8EIDzT2hfdmu4vYl3/
         XIR90pnuI3K4kV1d5Bm11Pn57c+GfE4dVDOOxOsnLShgWMYlA1pJcJoF7sOPZtexCwYP
         ELhxZQwrFnEmjZhgXx2mjuE3HiLK9TadecMdLzAo0eHIWgo1V1G1uOa5P7ZTv3NrW55Q
         IwxyHJePJisriyJmWo1d+yNh53aHnfmOSYFZCbC26Ph2JuMFkmU8c4wQttP2Gfux7zEx
         HKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Abf3cK9D+gRrRGwQh2kwak/YzDDkHOqgDtvVTIo4q7A=;
        b=lE9ZisKt8ckvT7nQ4pi4oaW46umPL3AOUdjEQ0X1qwnLIXeMAktnmUtKHkHhCqTYXx
         du6AIGvEn+6BwKoZSZuk5tOekTe1Z5sAr2v9gure0LY5moyCgrDa1vx3L2ASsp49O0Rf
         YL0IbeuTQpcAj2T3/2KolB5T8peEQMBaNBsoAAh+h2IGaHgd7QgUou98Ajkz6V4Hth5l
         jnyMDK4f4lXH6qCDLxkmzE17rKVbOBdkAIDRzPWGC3jlkYDhJc6gFS2mJf9EizbynXLc
         eEsSASnKNHeTYDZK1R9RYRu2i8qUcFxrLDchu15VXbfNt1rQr0pV25dHdZ2/vWQsJpxz
         q0Tg==
X-Gm-Message-State: APjAAAWy2uoLmiBfpumMFzMRA6cwP/f9Nh2iMG8JoZIU3q3Q1pjbxDYO
        OIcCsET5rBtSQl5erUa8mk67CQHOvfp6UF7miEDRrw==
X-Google-Smtp-Source: APXvYqzlm/LZa7vLxmhuF4EQXYFyYKJYlrIat9BhnUUptmEmQR49KGysQZ4JhDoNNZWx7O5yEaH2e2yfA6hMO6s/qoE=
X-Received: by 2002:a63:205f:: with SMTP id r31mr30781941pgm.159.1565672775425;
 Mon, 12 Aug 2019 22:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-11-brendanhiggins@google.com> <20190813042455.4A04320644@mail.kernel.org>
In-Reply-To: <20190813042455.4A04320644@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 12 Aug 2019 22:06:04 -0700
Message-ID: <CAFd5g46LHq1sQaio2Vj5jt54YN-Y2HuCT8FbALQhJoekkYJ-uQ@mail.gmail.com>
Subject: Re: [PATCH v12 10/18] kunit: test: add tests for kunit test abort
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

On Mon, Aug 12, 2019 at 9:24 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 11:24:13)
> > +
> > +static int kunit_try_catch_test_init(struct kunit *test)
> > +{
> > +       struct kunit_try_catch_test_context *ctx;
> > +
> > +       ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
>
> Can this fail? Should return -ENOMEM in that case?

Yes, I should do that.

> > +       test->priv = ctx;
> > +
> > +       ctx->try_catch = kunit_kmalloc(test,
> > +                                      sizeof(*ctx->try_catch),
> > +                                      GFP_KERNEL);
