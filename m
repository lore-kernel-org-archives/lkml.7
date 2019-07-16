Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CFEC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6E220665
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j9eLSBzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbfGPS4H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:56:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40579 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388494AbfGPS4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:56:07 -0400
Received: by mail-pg1-f196.google.com with SMTP id w10so9882579pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZybekRt/woJPUqImfzbAl3ncwjUgoXdjZVOXaEHk8I8=;
        b=j9eLSBzu7vGeOp+9v4PjjMY8Y60gIHirQjt/95JgwPIeMch+f2SZ4m2BcsmqzLNPnA
         y6mKbUvfRgB58Dd24aP06L/LHkjitHNk2jtHnbwOvIcJMeUwKyAY7Zj3rZzVz85nZG+R
         H6nYqq0HtuMcKgj4ph8KvSOJ57XFS8xQJyN4O9EfZBueGH2zgw2CSiJKxHwffHaRiCZU
         F2ZM5rxXlitmIEXm2ndwKKQaLdsI3EeFpaR3+KwtG2rjkMO/QifOGpG1dhcUu5Cz8T3g
         tXwTsXzmF1fc22PaEHeit7cbJ2ZXrz0nkagsUOfmTF+46/GQqdl6HnMMZCq90oDQiUGy
         RAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZybekRt/woJPUqImfzbAl3ncwjUgoXdjZVOXaEHk8I8=;
        b=XRW99dkCO7ZZgKtC5d0C6fH3PWb938soJSr/uPAFuV2rTTkRMdEuaEifBRVF/PJPoZ
         mHBJbTmZtoakdUYg+Vp3UptcSaC/JQw0/CIy++mBRbueCkNsAaNkEYu+zGzWeKGchfn0
         z4G+R5S61rc9z9IuB6xY0Hak8S8rWHFfYeETEr9n/Om5TlrALShAmK6BU8yHdRQ9FwNp
         Oy/plGHWV7LUCXZQRXJxX5E/kTvQcXEvf0NTLjkdtTD7Bygyiu5FVZC62fHxeutTtid4
         Sr3sTaYZ2ErffXhjBO+EcJak5WMpNf7hSE207Dm32GY0jE5ZIXeOE7giCQ5fA4JAycgT
         etqg==
X-Gm-Message-State: APjAAAXb9F6hPmwoPMlcmMWfHvd26Z1ynMCX4jtXgUl4P/0ANBgBjrD4
        L7TjoGA14bsNJQe+fkBjqTbSs3Hk+nKL3hWPP8qLUQ==
X-Google-Smtp-Source: APXvYqwkl9ifterOK2ove6KXh9jZEcTxm4XlxkMBt5KD+9P3zl/wFtgkQs2T9gGivENnFOevPZS3P3oa9+3ivqemHYQ=
X-Received: by 2002:a63:205f:: with SMTP id r31mr35946123pgm.159.1563303365863;
 Tue, 16 Jul 2019 11:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-4-brendanhiggins@google.com> <20190715204356.4E3F92145D@mail.kernel.org>
 <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com>
 <20190715220407.0030420665@mail.kernel.org> <CAFd5g44bE0F=wq_fOAnxFTtoOyx1dUshhDAkKWr5hX9ipJ4Sxw@mail.gmail.com>
 <CAFd5g47y4vDB2P=EsGN8305LGeQPCTveNs-Jd5-=6K-XKY==CA@mail.gmail.com> <20190716153400.5CB182054F@mail.kernel.org>
In-Reply-To: <20190716153400.5CB182054F@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 16 Jul 2019 11:55:54 -0700
Message-ID: <CAFd5g47Nawp7V8=hetgBQWzWqmEyAz1GtWWwMrb9k=CCR33inQ@mail.gmail.com>
Subject: Re: [PATCH v9 03/18] kunit: test: add string_stream a std::stream
 like string builder
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

On Tue, Jul 16, 2019 at 8:34 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-07-15 15:43:20)
> > On Mon, Jul 15, 2019 at 3:11 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Mon, Jul 15, 2019 at 3:04 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > Quoting Brendan Higgins (2019-07-15 14:11:50)
> > > > > On Mon, Jul 15, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > > >
> > > > > > I also wonder if it would be better to just have a big slop buffer of a
> > > > > > 4K page or something so that we almost never have to allocate anything
> > > > > > with a string_stream and we can just rely on a reader consuming data
> > > > > > while writers are writing. That might work out better, but I don't quite
> > > > > > understand the use case for the string stream.
> > > > >
> > > > > That makes sense, but might that also waste memory since we will
> > > > > almost never need that much memory?
> > > >
> > > > Why do we care? These are unit tests.
> > >
> > > Agreed.
> > >
> > > > Having allocations in here makes
> > > > things more complicated, whereas it would be simpler to have a pointer
> > > > and a spinlock operating on a chunk of memory that gets flushed out
> > > > periodically.
> > >
> > > I am not so sure. I have to have the logic to allocate memory in some
> > > case no matter what (what if I need more memory that my preallocated
> > > chuck?). I think it is simpler to always request an allocation than to
> > > only sometimes request an allocation.
> >
> > Another even simpler alternative might be to just allocate memory
> > using kunit_kmalloc as we need it and just let the kunit_resource code
> > handle cleaning it all up when the test case finishes.
>
> Sure, sounds like a nice way to avoid duplicating similar logic to
> maintain a list of things to free later.

I think I will go that route for now.

> >
> > What do you think?
>
> If you go the allocation route then you'll need to have the flags to
> know what context you're in to allocate appropriately. Does that mean
> all the string operations will now take GFP flags?

We could set the GFP flags in the constructor, store them in a field,
and then just reuse them.

Thanks!
