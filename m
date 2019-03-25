Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C62C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76B902075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eTiSqGe7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfCYWMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:12:19 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33716 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730745AbfCYWMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:12:18 -0400
Received: by mail-ot1-f66.google.com with SMTP id j10so3134932otq.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/9DdkqyJUdYHxW/iZvrRk/lgc4wfAXWDYK7qOhybAoM=;
        b=eTiSqGe7TbvdWusyTEXsyiaKCfR9/R+FDSjCNBWGz1+636l9v1679hiQUwZWFSiEXA
         uSeHr91Dy9MDtARILGNjkKOvxsZi6u+2ss+BnqXsMQ0S6VdYbGHR0t7yVa6t8kuZLg+B
         4xLeg3fJWv+aBq+k1Th/Gk9HIvsxRe6nteRdCZyOe0n6gRW86oSAT4UlCfzzU1qyxVXs
         j2tkA3Qp8KPaTElkMiLEuqGR/zWPFzhmBldSCygAH14yhSaAxIIvMuxr0ejJSwUKvX6X
         uHLue7wXb/3/0wUKSdVzyXsgN00AfTxh976LU2tS20kxE30AfRewyLj72/zgEJBnpRp5
         GdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/9DdkqyJUdYHxW/iZvrRk/lgc4wfAXWDYK7qOhybAoM=;
        b=Kcrl4e0eZTfC+EU9tmwGFBdJlxWNTbf6LkdAr4PLYreKJAxb4/iF2mG91pnz6cvnI/
         iDN9FMnUsiWVGjbSCkz7ocXtxkh8Z+KgmvfFFkRuvjy+1yIoigiexT0vNt6LIFudF57i
         CdFeObFsAt3jKlVfTCHGSqVY0wxf0KLCFO2BIQ3iRVOENpv8Y8WkwlBfqKeD4cWQSXyU
         o7hB1W3JsrWMAqfGxX8IoRpWTjSB/Y0f3U+eCI12fTjGmExYJ7Ixn3GVSE0V6n4s4HJR
         va6zdjLJvsrYxfPUEmK11o/sFOm1nvc/5weyn8EYBRI1/oYClpHVEXwDcNogchVcn/Cu
         1DKA==
X-Gm-Message-State: APjAAAX4SJW/3fNq38RmckKd1VOK1BreI3ZOLnrt6r2osFO4niernf77
        n0EQ3c0INwJPMkV9iguqyV1oqApnByua5XhfLu/EHg==
X-Google-Smtp-Source: APXvYqwlWvbUAAmQ+rySDi0LPbyfblMg+mXUL18n5h/g0DU3mkUw4KZpSqBR1rXGuRujUCeOZA8i08/mRllOThBeMwU=
X-Received: by 2002:a9d:d66:: with SMTP id 93mr19460567oti.25.1553551936866;
 Mon, 25 Mar 2019 15:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com> <CAFd5g47G=mTdk+=wpO+rkyO0+mAbEfPAg=Pr7_507Uek4sdWeA@mail.gmail.com>
 <3bdbe44c-5bd8-db37-89f9-a518cd5a21a8@deltatee.com> <CAFd5g45u6oX=nK9anAEdfsV+8SET8Zo_Dpy0WfzCna19r_jSyw@mail.gmail.com>
 <aea24c8e-5ce8-5f33-c81b-d2eeef588ec8@gmail.com>
In-Reply-To: <aea24c8e-5ce8-5f33-c81b-d2eeef588ec8@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 25 Mar 2019 15:12:05 -0700
Message-ID: <CAFd5g46ky5617JB=h-gcgdYMZzKtn9zv=qzvbyyHZpQW0m_84Q@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com,
        Frank Rowand-real <frowand@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 6:12 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 3/21/19 4:33 PM, Brendan Higgins wrote:
> > On Thu, Mar 21, 2019 at 3:27 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>
> >>
> >> On 2019-03-21 4:07 p.m., Brendan Higgins wrote:
> >>> A couple of points, as for needing CONFIG_PCI; my plan to deal with
> >>> that type of thing has been that we would add support for a KUnit/UML
> >>> version that is just for KUnit. It would mock out the necessary bits
> >>> to provide a fake hardware implementation for anything that might
> >>> depend on it. I wrote a prototype for mocking/faking MMIO that I
> >>> presented to the list here[1]; it is not part of the current patchset
> >>> because we decided it would be best to focus on getting an MVP in, but
> >>> I plan on bringing it back up at some point. Anyway, what do you
> >>> generally think of this approach?
> >>
> >> Yes, I was wondering if that might be possible. I think that's a great
> >> approach but it will unfortunately take a lot of work before larger
> >> swaths of the kernel are testable in Kunit with UML. Having more common
> >> mocked infrastructure will be great by-product of it though.
> >
> > Yeah, it's unfortunate that the best way to do something often takes
> > so much longer.
> >
> >>
> >>> Awesome, I looked at the code you posted and it doesn't look like you
> >>> have had too many troubles. One thing that stood out to me, why did
> >>> you need to put it in the kunit/ dir?
> >>
> >> Yeah, writing the code was super easy. Only after, did I realized I
> >> couldn't get it to easily build.
> >
> > Yeah, we really need to fix that; unfortunately, broadly addressing
> > that problem is really hard and will most likely take a long time.
> >
> >>
> >> Putting it in the kunit directory was necessary because nothing in the
> >> NTB tree builds unless CONFIG_NTB is set (see drivers/Makefile) and
> >> CONFIG_NTB depends on CONFIG_PCI. I didn't experiment to see how hard it
> >> would be to set CONFIG_NTB without CONFIG_PCI; I assumed it would be tricky.
> >>
> >>> I am looking forward to see what you think!
> >>
> >> Generally, I'm impressed and want to see this work in upstream as soon
> >> as possible so I can start to make use of it!
> >
> > Great to hear! I was trying to get the next revision out this week,
> > but addressing some of the comments is taking a little longer than
> > expected. I should have something together fairly soon though
> > (hopefully next week). Good news is that next revision will be
> > non-RFC; most of the feedback has settled down and I think we are
> > ready to start figuring out how to merge it. Fingers crossed :-)
> >
> > Cheers
>
> I'll be out of the office next week and will not be able to review.
> Please hold off on any devicetree related files until after I review.

Will do.
