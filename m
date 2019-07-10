Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E82EC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE7B208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 20:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DXE2Tyoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfGJU1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 16:27:55 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37565 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbfGJU1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 16:27:54 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so1620642pfa.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 13:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hO2jzOM05mxrz5IGdqgpee+axiQH+2OXPmqo+Ul0FcM=;
        b=DXE2TyoaAsiT9dgVdMLJlwnFOJG+VPwltPNRpKt3x1FLvKASU/iQDS/su9pWcI6ZPd
         MXkkWpKWuusX2P8emSJdJDlt30oE5SxYRezHyYxpjjVp3ZbcLi8A3iWXovzH83yYRc8k
         fjxQns6K5/tsiMazqiGGWLPX8o1RPbeCk84rZYGhBrbKZfsdxcSVvoPDO0y7puTr2iGH
         fQNI4xvqDUtOGBpEZRrc5xNRkpC2AFKD+tShr+e3Bwk8ghWvxHexXjknk4e4/Fuddr4K
         h5eIBtrjZWB7rbYTWe1Z8/fz44NvT2DlWtjdcUYum8NYmtJkqcBIajW2gxCHzFBMqhlz
         2q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hO2jzOM05mxrz5IGdqgpee+axiQH+2OXPmqo+Ul0FcM=;
        b=dEEyfGv4YcBhCQ/AVheWQjKxS0lZWuk6z5Ul5ZMLA0lcIgaXiAOSSlsBRXZnTwRpXN
         w9QygFZAyHhuWTzcCWIKBqbF8lQiYWHxE2W6qkcRrWdZYOzdZ6+qs/CVgXBxjbSTGvCr
         1pqT4n4UysIWudEon2uiQk1HW+wsWFHInISuTRDA9tj3rwc1hI7RmY1/E4E4SXBWDX/U
         983s7ZaiyY3j2ItVpUFpJtUmOiCm5p62qpx3yanyD1UK7wNYarZn4kROv1VTb2epZqjS
         oTtcIRyM+8hwf6H260lkf8d1Vb8Ii+72QSGFrid/3oVIRr3s0L4PmPlgesrZmPKpI+dm
         P0wg==
X-Gm-Message-State: APjAAAVTSvvBoUW2WKHJAkUET18Cl6+0nhsSYKnUyLbXs3VGXfZ/2S+M
        WH2ht5S4mSkkv98dx9bbKM9Nj+F2WlVibsM9/ic7kA==
X-Google-Smtp-Source: APXvYqzZdlWhCkBvFW8XUuT2KDhsG6TgutjUsDP74lsWb4XjESrHCjQll9Q/yu+3XrTs4ARL+yM6pPyLsGbtB4DuWT0=
X-Received: by 2002:a63:205f:: with SMTP id r31mr109331pgm.159.1562790473396;
 Wed, 10 Jul 2019 13:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190709063023.251446-1-brendanhiggins@google.com>
 <20190709063023.251446-17-brendanhiggins@google.com> <7cc417dd-036f-7dc1-6814-b1fdac810f03@kernel.org>
 <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
In-Reply-To: <CAFd5g4595X8cM919mohQVaShs4dKWzZ_-2RVB=6SH3RdVMwuQw@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 10 Jul 2019 13:27:42 -0700
Message-ID: <CAFd5g45zFhBN-yrJbRt6KnFkYKxVqjs9qeQULCSD6z89vvG-Tg@mail.gmail.com>
Subject: Re: [PATCH v7 16/18] MAINTAINERS: add entry for KUnit the unit
 testing framework
To:     shuah <shuah@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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

On Tue, Jul 9, 2019 at 11:01 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Jul 9, 2019 at 7:53 AM shuah <shuah@kernel.org> wrote:
> >
> > On 7/9/19 12:30 AM, Brendan Higgins wrote:
> > > Add myself as maintainer of KUnit, the Linux kernel's unit testing
> > > framework.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > ---
> > >   MAINTAINERS | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 677ef41cb012c..48d04d180a988 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -8599,6 +8599,17 @@ S:     Maintained
> > >   F:  tools/testing/selftests/
> > >   F:  Documentation/dev-tools/kselftest*
> > >
> > > +KERNEL UNIT TESTING FRAMEWORK (KUnit)
> > > +M:   Brendan Higgins <brendanhiggins@google.com>
> > > +L:   linux-kselftest@vger.kernel.org
> > > +L:   kunit-dev@googlegroups.com
> > > +W:   https://google.github.io/kunit-docs/third_party/kernel/docs/
> > > +S:   Maintained
> > > +F:   Documentation/dev-tools/kunit/
> > > +F:   include/kunit/
> > > +F:   kunit/
> > > +F:   tools/testing/kunit/
> > > +
> > >   KERNEL USERMODE HELPER
> > >   M:  Luis Chamberlain <mcgrof@kernel.org>
> > >   L:  linux-kernel@vger.kernel.org
> > >
> >
> > Thanks Brendan.
> >
> > I am good with this. I can take KUnit patches through kselftest
> > with your Ack.
>
> My acknowledgement? Sure! I thought we already agreed to that.
>
> Also, do we need an ack from Masahiro or Michal for the Kbuild patch
> [PATCH v7 06/18]? And an ack from Josh or Peter for the objtool patch
> [PATCH v7 08/18]?

By the way, I am guessing you have already seen it, but I uploaded a
new version to incorporate a suggestion made by Masahiro on patch
06/18. In addition, I have gotten acks on the two patches mentioned
above. So I think we are good to go.

Thanks!
