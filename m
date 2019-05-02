Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FCBC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E5D204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 18:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9mmkEct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEBSp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 14:45:56 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40763 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfEBSpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 14:45:55 -0400
Received: by mail-oi1-f193.google.com with SMTP id y64so2547485oia.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17OVt5sF62dgswwCTgJsxP7RAt3WsAf5VJ4Ut9AHOnQ=;
        b=P9mmkEctGFviK6NgZSHwMcUWXoaX/YoeIAK9bJMcE3Lx9wj9ioBeHG7azUaTRvfMEz
         TY2RHOx0ThWPnz2RyK/JeVea8tpHo/vQkabwSgIPQaucOPCDrRgdtpJvHIeyfXSXZIdh
         EEpMDUWFYZWhjIh9jDc8FJvMTlSL8vQ8VfgY4koM+if0RzgjLUM+G7N96Iar9oJO2RWW
         y2bZo1FvLirTsbvZcF5UvfSKsfdjWdxyGHNZOdT8DOFyQvGPVysWQaUTlUo3hkMnOD0e
         RSC2W/FJE39vCVMCViynhllAgBlnR6+D6q04cTiRfgx2IG0+4k0zkzJ9Spq984jh3G9l
         lWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17OVt5sF62dgswwCTgJsxP7RAt3WsAf5VJ4Ut9AHOnQ=;
        b=NckCsoKRVIQhHmOV35GbUcvctQKNsyxH1Gd5Gxq/gYFwYX5LBlxVSqoEaZG6u4xVN+
         UvXXJGpNHj1a9fyMgCAD+P1xCKiYtMpR7OaCJ5ay7N1aQ0W65ftBRrJEpcSiXkwiCN83
         XeLGxL4bMt5VPpJ8hzFtRHb81vkgYkRRVrhV4TswjqNz2dR1XGvlGURVziwdwJXGlhKz
         6ljres2i3e/wa1PxKu90N0uqEjy/Xr+sJQlIzbsr6E/FTBVnfYAjOO6Hv1GuQjEgaFSa
         FdL/1FN4rzVjs00r5L30cMFGlSNCmMJe4A0OUU66ol3pHtxu+DilZeH6b57CBpWZwwLt
         oA5Q==
X-Gm-Message-State: APjAAAXfbCJBGexwVTzJmwKmCuqF6VaMnEnoxgogw9hoqsNJLw5cy3Ya
        gh1BEaLwlhXtuJUqgFecgrdK9jqF2rfJczDgWm9/sA==
X-Google-Smtp-Source: APXvYqzC6lEhFzCwba9WNGtoNJlN2/sxNxsRqKIHnQJUgSQQ4oc4XCI9kW3OGRwazcEXau+lGinuQZlka+T3d8xNOxI=
X-Received: by 2002:aca:4586:: with SMTP id s128mr3264542oia.148.1556822754511;
 Thu, 02 May 2019 11:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190501230126.229218-1-brendanhiggins@google.com>
 <20190501230126.229218-17-brendanhiggins@google.com> <20190502110347.GE12416@kroah.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF9770A3A0@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF9770A3A0@USCULXMSG01.am.sony.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 2 May 2019 11:45:43 -0700
Message-ID: <CAFd5g471Wawu6g14p0AO3aY8VPBKLA0mjHSdfR1qStFGzp3iGQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] kernel/sysctl-test: Add null pointer test for sysctl.c:proc_dointvec()
To:     "Bird, Timothy" <Tim.Bird@sony.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        shuah@kernel.org, devicetree <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-um@lists.infradead.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
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
        Iurii Zaikin <yzaikin@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 2, 2019 at 11:15 AM <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Greg KH
> >
> > On Wed, May 01, 2019 at 04:01:25PM -0700, Brendan Higgins wrote:
> > > From: Iurii Zaikin <yzaikin@google.com>
> > >
> > > KUnit tests for initialized data behavior of proc_dointvec that is
> > > explicitly checked in the code. Includes basic parsing tests including
> > > int min/max overflow.
> > >
> > > Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > >  kernel/Makefile      |   2 +
> > >  kernel/sysctl-test.c | 292
> > +++++++++++++++++++++++++++++++++++++++++++
> > >  lib/Kconfig.debug    |   6 +
> > >  3 files changed, 300 insertions(+)
> > >  create mode 100644 kernel/sysctl-test.c
> > >
> > > diff --git a/kernel/Makefile b/kernel/Makefile
> > > index 6c57e78817dad..c81a8976b6a4b 100644
> > > --- a/kernel/Makefile
> > > +++ b/kernel/Makefile
> > > @@ -112,6 +112,8 @@ obj-$(CONFIG_HAS_IOMEM) += iomem.o
> > >  obj-$(CONFIG_ZONE_DEVICE) += memremap.o
> > >  obj-$(CONFIG_RSEQ) += rseq.o
> > >
> > > +obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
> >
> > You are going to have to have a "standard" naming scheme for test
> > modules, are you going to recommend "foo-test" over "test-foo"?  If so,
> > that's fine, we should just be consistant and document it somewhere.
> >
> > Personally, I'd prefer "test-foo", but that's just me, naming is hard...
>
> My preference would be "test-foo" as well.  Just my 2 cents.

I definitely agree we should be consistent. My personal bias
(unsurprisingly) is "foo-test," but this is just because that is the
convention I am used to in other projects I have worked on.

On an unbiased note, we are currently almost evenly split between the
two conventions with *slight* preference for "foo-test": I ran the two
following grep commands on v5.1-rc7:

grep -Hrn --exclude-dir="build" -e "config [a-zA-Z_0-9]\+_TEST$" | wc -l
grep -Hrn --exclude-dir="build" -e "config TEST_[a-zA-Z_0-9]\+" | wc -l

"foo-test" has 36 occurrences.
"test-foo" has 33 occurrences.

The things I am more concerned about is how this would affect file
naming. If we have a unit test for foo.c, I think foo_test.c is more
consistent with our namespacing conventions. The other thing, is if we
already have a Kconfig symbol called FOO_TEST (or TEST_FOO) what
should we name the KUnit test in this case? FOO_UNIT_TEST?
FOO_KUNIT_TEST, like I did above?

Cheers
