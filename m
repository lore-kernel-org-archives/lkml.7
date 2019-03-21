Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD95C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894C821900
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="evtnxhtr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCUXeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:34:00 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35894 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCUXeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:34:00 -0400
Received: by mail-oi1-f196.google.com with SMTP id t206so392956oib.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFgfChHR3rCbGCzUFjYG6e3UOwQNYwymTbMi5H8aX2k=;
        b=evtnxhtrWshSFQGY4sIPRVf5qPwktIkkciD5ssoe/FqubujjuCqumzjVIi6dKDmF7O
         0IZWCtTYtJgyVqguB1LQ65NvAc5qIQKJEHKG1nM616lGxvJtcUAruVhZwAV3/wJXolYG
         Pm71iLs6plM7/D3QJctZlMS4kto33h0rC4dr1j6Ze1uSne7u40WsoazwlDooe8SLZl66
         /zzvFjYKhTZu0Ki9G4uf+9XlZYtaNgiY19KYgo42TrigYeJLNSmKTWn3a3cziJqEq3Rb
         WgYuwZcyEH4dhokEtDFBckQ0LVR4NBhnrIFAW3jMml3pCy1JhplPzVg6txqe9Wq1Z4wx
         JzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFgfChHR3rCbGCzUFjYG6e3UOwQNYwymTbMi5H8aX2k=;
        b=oaED2Kehe9W0fbO07nI/xdl5Bj6A991SSHLxO5qJcAT9IQonfGYwZehZSpzYZfZSe/
         JFXbomz3lqsG4qLOSTIp7saBahPGNwhKFkadum+MR25ZvgrxCRepL5Tnmi7fDC3aWJJ4
         vMeVBt5aTWF3jYuUNDK8ENziBZEnP8fKXd0KZoevBMVwThgFLMkKf+5TSWwXYj+d2R/j
         HG8IX3mEE76A6cjjGamn/SHw7CP5pd+1gkgs6g7aHif4QdEDn51wm5RWoCtg8aibfZ4s
         IvjmoLe837SsgQXjuQyEpeElcAx462CB1GiPrpJ9ummsGOoqf8sTMamytB0IUuYFmdFD
         ZHhw==
X-Gm-Message-State: APjAAAWBNiQuJ7eodn3glZkdoJB/ikdcH+Vz8zemz6T3DnXrUng1wAMw
        ijV6SEiHzAidRXfOhOwEjzi7ZzPBglGUO/FNaossNQ==
X-Google-Smtp-Source: APXvYqx5mI5rMlq9Mb/gX2zikpNZRTwjDZ045ldH25NCv2n95vCZ5JqdYq8Fx5cgVNizrn2jVlZk9orTz8EbWHy+Ro8=
X-Received: by 2002:aca:4a90:: with SMTP id x138mr1371154oia.137.1553211238537;
 Thu, 21 Mar 2019 16:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com> <CAFd5g47G=mTdk+=wpO+rkyO0+mAbEfPAg=Pr7_507Uek4sdWeA@mail.gmail.com>
 <3bdbe44c-5bd8-db37-89f9-a518cd5a21a8@deltatee.com>
In-Reply-To: <3bdbe44c-5bd8-db37-89f9-a518cd5a21a8@deltatee.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Mar 2019 16:33:46 -0700
Message-ID: <CAFd5g45u6oX=nK9anAEdfsV+8SET8Zo_Dpy0WfzCna19r_jSyw@mail.gmail.com>
Subject: Re: [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit
 testing framework
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Kees Cook <keescook@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>, shuah@kernel.org,
        Rob Herring <robh@kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>,
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
        Dan Carpenter <dan.carpenter@oracle.com>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 3:27 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-03-21 4:07 p.m., Brendan Higgins wrote:
> > A couple of points, as for needing CONFIG_PCI; my plan to deal with
> > that type of thing has been that we would add support for a KUnit/UML
> > version that is just for KUnit. It would mock out the necessary bits
> > to provide a fake hardware implementation for anything that might
> > depend on it. I wrote a prototype for mocking/faking MMIO that I
> > presented to the list here[1]; it is not part of the current patchset
> > because we decided it would be best to focus on getting an MVP in, but
> > I plan on bringing it back up at some point. Anyway, what do you
> > generally think of this approach?
>
> Yes, I was wondering if that might be possible. I think that's a great
> approach but it will unfortunately take a lot of work before larger
> swaths of the kernel are testable in Kunit with UML. Having more common
> mocked infrastructure will be great by-product of it though.

Yeah, it's unfortunate that the best way to do something often takes
so much longer.

>
> > Awesome, I looked at the code you posted and it doesn't look like you
> > have had too many troubles. One thing that stood out to me, why did
> > you need to put it in the kunit/ dir?
>
> Yeah, writing the code was super easy. Only after, did I realized I
> couldn't get it to easily build.

Yeah, we really need to fix that; unfortunately, broadly addressing
that problem is really hard and will most likely take a long time.

>
> Putting it in the kunit directory was necessary because nothing in the
> NTB tree builds unless CONFIG_NTB is set (see drivers/Makefile) and
> CONFIG_NTB depends on CONFIG_PCI. I didn't experiment to see how hard it
> would be to set CONFIG_NTB without CONFIG_PCI; I assumed it would be tricky.
>
> > I am looking forward to see what you think!
>
> Generally, I'm impressed and want to see this work in upstream as soon
> as possible so I can start to make use of it!

Great to hear! I was trying to get the next revision out this week,
but addressing some of the comments is taking a little longer than
expected. I should have something together fairly soon though
(hopefully next week). Good news is that next revision will be
non-RFC; most of the feedback has settled down and I think we are
ready to start figuring out how to merge it. Fingers crossed :-)

Cheers
