Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C19EC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04B5220840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MLD0OBKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfHMJE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:04:58 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44934 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfHMJE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:04:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so48991119plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 02:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QiUXy9T56EDLZHgM/ghmiZZKu3jldBkP3AywgOf7WrE=;
        b=MLD0OBKrmLSIMOt648B9mPAmsjWuHn6T9ywV6kHk53m2QAcx/5//33wzzGap97ISgd
         1n1dPQTH2aqoshjF311lPPF9RyircKfegESJ2xxxn2TBZss5XJTQKDNllI8Lep9L/7SF
         MM7idIRhDooM4kA4MSv9ueRH5hrjDJGGg0AgX0HqE87hvGQZOuRQRmqZQqIXAW5zi2XY
         qx3rKtyNkDR1tJcjwneeXBeG+UkkSb8i3ocoTOXfuDYPqL5L4LUf+dq11gIkuMFV1by4
         yd/+IqmaOAJsJPYvSatGT0S67lif/DCk+kAwLjTl1ZQp1oSabKWPVnDpLlDJM1jY/AYp
         VtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QiUXy9T56EDLZHgM/ghmiZZKu3jldBkP3AywgOf7WrE=;
        b=Rf1VEWUPgp+zGm6GDxa0ViKnRdHsgrq+l/N+pwsJgQ6FutlpFb5efgAiq9vgeJZu0Y
         Or7SHSfTbq86aMa1GXY4mO0Ewgnl9U2M4urM5SzSIgooBNz7PDLTcfLECecYCTHHbXP2
         DdhfGAP9f9ttf9oMqf8o0MiBBtuWBRJSjkfL4x8pCZpH2xGbOlU/SGwiB4MtHTF3Z+sA
         CfXwTCCENfHakdgXU36jR869UuZqOgtheZdVWHbdpg8JE+YARyvSfy/Mb5UoYSwJMqnI
         rVYrzvpIcCQ0H+wtgOnnzjDvAglEeiJiwYKwIF0XX2SEMCQlyRVnPKKASIZlB98tjwIG
         mTlA==
X-Gm-Message-State: APjAAAXIFNokg1sSuf87k2rJHGbqD6iFCjikuwiKeCafbFQ5zd3jeFKB
        R200DZ97JTXj4DzRPR9Gn+rMAiP5TDE7haJcmdoKyA==
X-Google-Smtp-Source: APXvYqwG2gN8zpP7bhFAP1u+fXAsfwR8jNJUVHpIzT9G6iZ0jAKs6Cy6kBh6Os478yKmPUZiHWGohGqW0T9u2YI3MZY=
X-Received: by 2002:a17:902:1024:: with SMTP id b33mr27760446pla.325.1565687095973;
 Tue, 13 Aug 2019 02:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190812182421.141150-1-brendanhiggins@google.com>
 <20190812182421.141150-4-brendanhiggins@google.com> <20190812225520.5A67C206A2@mail.kernel.org>
 <20190812233336.GA224410@google.com> <20190812235940.100842063F@mail.kernel.org>
 <CAFd5g44xciLPBhH_J3zUcY3TedWTijdnWgF055qffF+dAguhPQ@mail.gmail.com>
 <20190813045623.F3D9520842@mail.kernel.org> <CAFd5g46PJNTOUAA4GOOrW==74Zy7u1sRESTanL_BXBn6QykscA@mail.gmail.com>
 <20190813053023.CC86120651@mail.kernel.org>
In-Reply-To: <20190813053023.CC86120651@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 13 Aug 2019 02:04:44 -0700
Message-ID: <CAFd5g47v7410QRAizPV8zaHrKrc95-Sk-GNzRRVngN741OKnvg@mail.gmail.com>
Subject: Re: [PATCH v12 03/18] kunit: test: add string_stream a std::stream
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

On Mon, Aug 12, 2019 at 10:30 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2019-08-12 22:02:59)
> > On Mon, Aug 12, 2019 at 9:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > >
> > > Quoting Brendan Higgins (2019-08-12 17:41:05)
> > > > On Mon, Aug 12, 2019 at 4:59 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > >
> > > > > > kunit_resource_destroy (respective equivalents to devm_kfree, and
> > > > > > devres_destroy) and use kunit_kfree here?
> > > > > >
> > > > >
> > > > > Yes, or drop the API entirely? Does anything need this functionality?
> > > >
> > > > Drop the kunit_resource API? I would strongly prefer not to.
> > >
> > > No. I mean this API, string_stream_clear(). Does anything use it?
> >
> > Oh, right. No.
> >
> > However, now that I added the kunit_resource_destroy, I thought it
> > might be good to free the string_stream after I use it in each call to
> > kunit_assert->format(...) in which case I will be using this logic.
> >
> > So I think the right thing to do is to expose string_stream_destroy so
> > kunit_do_assert can clean up when it's done, and then demote
> > string_stream_clear to static. Sound good?
>
> Ok, sure. I don't really see how clearing it explicitly when the
> assertion prints vs. never allocating it to begin with is really any
> different. Maybe I've missed something though.

It's for the case that we *do* print something out. Once we are doing
printing, we don't want the fragments anymore.
