Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6F7C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C65A2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 22:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvefYQ4C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfGOWnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 18:43:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41195 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbfGOWne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 18:43:34 -0400
Received: by mail-pg1-f194.google.com with SMTP id q4so8397495pgj.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 15:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0dmaddygNqZgaGUDAa6cmxBvESBVDt3nRTuc2Ed70Y=;
        b=TvefYQ4CXwYECIE1DD5mMNTXSS5HYvyG/pzvPIWc/AcUeE000MlMBoQ+UnA0lQ1n5F
         J7msY35wgId7ntbvKXqQfoaqQ86v3mXkjix4KiLl4u6U93/fC5IaevmselacDdowCR/G
         iyLUy9PuUK6XnxYy7VDz4MJceIVqGDB7wOfFH9e4PAIu+KvegnYNT6RGkjvCG2CcAryr
         zNpIkVs0KHES2MAvXC6bkPoPCjnPfiickXXO58iW726KzLdfp/yLgSvrpmy/5Ix9KBQ0
         9sghkw+DYAjzdFPtaBU764DprOajqeRr5/CW8du6jhE57m3uscWi90TZpp/kvfYXdZoS
         /10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0dmaddygNqZgaGUDAa6cmxBvESBVDt3nRTuc2Ed70Y=;
        b=fcLMDgpMiVDEnkecmSZynitxPyl5Hsp5cUOBjjJpJQflzQJXu6dXtgdwV2ssjbqcYj
         aArcNc8hL6AhHEMh6LgymOg4W5E9dad3CTvkHHnmU1NStvy+f0e5mmu/ORRXpQvV9d1O
         KZvsI12+6FQCMb4V4OOt4rj5a857H5Ab0qQ10jCFpazxoSWsfEdZGmMOO0XXkouwQ/9F
         3Y1Ob1DQ9WQUR/M0UHS6q7UYseqif6Eyy5/bYM5XluN7QbW9K5S87v7tk3MPDvzdFB7O
         70Y3GbzsL27t8Zbu6F9PU20JU9M+dNUIFRhWum3+UqVAOHxSIkYl4y7uVvpbme6KDSHG
         Y8ug==
X-Gm-Message-State: APjAAAXKalFU5PpsVFZooIDweCv8bFIiDIFjc+fh9xGNLN9ge3zOh2CX
        Hk8Ht1WDGelk4HSvM+9cgrCcrppUbihZ5gN21VfJpw==
X-Google-Smtp-Source: APXvYqwafDOiX+PiabduZWro+OOpT5RPBS9Ci2pxCrNN9UWVIxex8mHl/Rh2UWEvSxgoEZAT49mdKVcWgja67R7I7ck=
X-Received: by 2002:a63:eb51:: with SMTP id b17mr28611693pgk.384.1563230612372;
 Mon, 15 Jul 2019 15:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190712081744.87097-1-brendanhiggins@google.com>
 <20190712081744.87097-4-brendanhiggins@google.com> <20190715204356.4E3F92145D@mail.kernel.org>
 <CAFd5g47481sRaez=yEJN4_ghiXZbxayk1Y04tAZpuzPLsmnhKg@mail.gmail.com>
 <20190715220407.0030420665@mail.kernel.org> <CAFd5g44bE0F=wq_fOAnxFTtoOyx1dUshhDAkKWr5hX9ipJ4Sxw@mail.gmail.com>
In-Reply-To: <CAFd5g44bE0F=wq_fOAnxFTtoOyx1dUshhDAkKWr5hX9ipJ4Sxw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 15 Jul 2019 15:43:20 -0700
Message-ID: <CAFd5g47y4vDB2P=EsGN8305LGeQPCTveNs-Jd5-=6K-XKY==CA@mail.gmail.com>
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

On Mon, Jul 15, 2019 at 3:11 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Jul 15, 2019 at 3:04 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Brendan Higgins (2019-07-15 14:11:50)
> > > On Mon, Jul 15, 2019 at 1:43 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > >
> > > > I also wonder if it would be better to just have a big slop buffer of a
> > > > 4K page or something so that we almost never have to allocate anything
> > > > with a string_stream and we can just rely on a reader consuming data
> > > > while writers are writing. That might work out better, but I don't quite
> > > > understand the use case for the string stream.
> > >
> > > That makes sense, but might that also waste memory since we will
> > > almost never need that much memory?
> >
> > Why do we care? These are unit tests.
>
> Agreed.
>
> > Having allocations in here makes
> > things more complicated, whereas it would be simpler to have a pointer
> > and a spinlock operating on a chunk of memory that gets flushed out
> > periodically.
>
> I am not so sure. I have to have the logic to allocate memory in some
> case no matter what (what if I need more memory that my preallocated
> chuck?). I think it is simpler to always request an allocation than to
> only sometimes request an allocation.

Another even simpler alternative might be to just allocate memory
using kunit_kmalloc as we need it and just let the kunit_resource code
handle cleaning it all up when the test case finishes.

What do you think?
