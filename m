Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4D8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2885221874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kHhiIVgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfCUWHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:07:36 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34639 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfCUWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:07:35 -0400
Received: by mail-ot1-f68.google.com with SMTP id k21so232330otf.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MG4OOITAuafjjbHeaQsw2tggrEugvckAn561IKrqTAg=;
        b=kHhiIVgHl9lNiIz6NgMpRys0b/F8Mfamg7iuMbFpAoJ6/p8lFpYKIFcWzObohNqCx0
         IOid4mJ4NRxj9Su3l2fwtTIqXJC8KZIAPZ3BJfUST2kAjJz5lmbVXCn6fZD/nr5Myzi/
         hrAgAHcErZXwi1z6fCFIrxtvZhCnMXuRv4fim1dPRGy2BGqoWFAgKUP7YNcqrsaXSaTy
         LOlmt8aufRcgf6TuC8WPpP1dtESrim/53giYs08E7CBWxuJff3b22+CAkHCwWDqvzJYY
         gg6dc+YLRtrtJ2o/ZWBTcPnUCpF6v8x8BXZldh/wgF9aKURcUa79Gm7MasdZRo/TdH9E
         codw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MG4OOITAuafjjbHeaQsw2tggrEugvckAn561IKrqTAg=;
        b=VbF7ehBv7IGe7tMwGiwM0aJe+pp56z2MNgMSb4ylhlgmEBVOb6xqpAezZgTHBsUZNY
         T+SWPWKKjw74DiH/Ww0srnntWu2mGuTKUpn/D99c1U4uB5Zgc+QJKAcpPkHGhTgFvRsC
         l4L79ufz1ItKLqZLO/w8ZPaPN34zIjly0ULbdH968UYEGQ1kJXYel0mYVuYkp3U8Ep1V
         Mw+8wpUEUBHdNvDrowX7WCLedkM7dza4bwqpeiID6ZpsAkqxst4zLcnlAL7pTtxTo1Qq
         fkUY9cLLq5r8yKvPbKIQJw6MMN7KlcBGz9rdjG8vvLTSKcpjuDh10eYAioX+299dRRcR
         vd4Q==
X-Gm-Message-State: APjAAAXhgwfc8Rh91YUdAfuuUgyPE2EY1B/ZYRPiWepnvpl28C9Xx+Pa
        tgnxJX5EDAXpADTw8By7ZXkz9FbBMWD4EFQZYHWwGA==
X-Google-Smtp-Source: APXvYqy96ducqSQ4hRIkd6VtzDxV5pw7QscB3bX1ScOsSEKRg/ecdbSGNgonl0rrMFPKcrpefMNN/DNgiZlKoPVDgDw=
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr4218491oth.83.1553206054380;
 Thu, 21 Mar 2019 15:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com> <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
In-Reply-To: <6d9b3b21-1179-3a45-7545-30aa15306cb4@deltatee.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Mar 2019 15:07:22 -0700
Message-ID: <CAFd5g47G=mTdk+=wpO+rkyO0+mAbEfPAg=Pr7_507Uek4sdWeA@mail.gmail.com>
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

On Wed, Mar 20, 2019 at 6:08 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hi,
>
> On 2019-02-14 2:37 p.m., Brendan Higgins wrote:
> > This patch set proposes KUnit, a lightweight unit testing and mocking
> > framework for the Linux kernel.
>
> I haven't followed the entire conversation but I saw the KUnit write-up
> on LWN and ended up, as an exercise, giving it a try.

Awesome! Thanks for taking the time to try it out and to give me feedback!

>
> I really like the idea of having a fast unit testing infrastructure in
> the kernel. Occasionally, I write userspace tests for tricky functions
> that I essentially write by copying the code over to a throw away C file
> and exercise them as I need. I think it would be great to be able to
> keep these tests around in a way that they can be run by anyone who
> wants to touch the code.
>
> I was just dealing with some functions that required some mocked up
> tests so I thought I'd give KUnit a try. I found writing the code very
> easy and the infrastructure I was testing was quite simple to mock out
> the hardware.
>
> However, I got a bit hung up by one issue: I was writing unit tests for
> code in the NTB tree which itself depends on CONFIG_PCI which cannot be
> enabled in UML (for what should be obvious reasons). I managed to work
> around this because, as luck would have it, all the functions I cared
> about testing were actually static inline functions in headers. So I
> placed my test code in the kunit folder (so it would compile) and hacked
> around a couple a of functions I didn't care about that would not be
> compiled.

A couple of points, as for needing CONFIG_PCI; my plan to deal with
that type of thing has been that we would add support for a KUnit/UML
version that is just for KUnit. It would mock out the necessary bits
to provide a fake hardware implementation for anything that might
depend on it. I wrote a prototype for mocking/faking MMIO that I
presented to the list here[1]; it is not part of the current patchset
because we decided it would be best to focus on getting an MVP in, but
I plan on bringing it back up at some point. Anyway, what do you
generally think of this approach?

>
> In the end I got it to work acceptably, but I get the impression that

Awesome, I looked at the code you posted and it doesn't look like you
have had too many troubles. One thing that stood out to me, why did
you need to put it in the kunit/ dir?

> KUnit will not be usable for wide swaths of kernel code that can't be
> compiled in UML. Has there been any discussion or ideas on how to work

For the most part, I was planning on relying on mocking or faking the
hardware out as you have done. I have found this worked pretty well in
other instances. I know there are some edge cases for which even this
won't work like code in arch/; for that you *can* compile KUnit for
non-UML, but that is not really unit testing any more, but I included
it that as more of a last ditch effort, debugging aid, or to allow a
user to write integration tests (also very much because other people
asked me to do it ;-) ). So the main plan here is mocking and faking.

There has been some additional discussion here[2] (see the replies);
this thread is more about the future of trying to pull out kernel
dependencies which I discussed further with Luis (off list) here[3]
(in reality the discussion has been spread across a number of
different threads, but I think those are places you could at least get
context to jump in and talk about mocking and faking hardware and
Linux kernel resources).

In short, I think the idea is we are using UML as scaffolding and we
will gradually try to make it more independent by either reducing
dependencies on kernel resources (by providing high quality fakes) or
by somehow providing a better view of the dependencies so that you can
specify more directly what piece of code you need for your test. This
part is obviously very long term, but I think that's what we need to
do if we want to do really high quality unit testing, regardless of
whether we use KUnit or not. In anycase, right now, we are just
working on the basic tools to write *a* unit test for the kernel.

> around this so it can be more generally useful? Or will this feature be
> restricted roughly to non-drivers and functions in headers that don't
> have #ifdefs around them?

I hope not.

The #ifdef thing is something that I don't have a good answer for at
this time. Luis and I talked about it, but haven't come up with any
good ideas, sorry.

As for drivers, I found that testing drivers is quite doable. You can
see an example of a test I wrote for a i2c bus driver here[4]. I know
the i2c subsystem is pretty simple, but the general principle should
apply elsewhere.

>
> If you're interested in seeing the unit tests I ended up writing you can
> find the commits here[1].
>
> Thanks,
>
> Logan
>
> [1] https://github.com/sbates130272/linux-p2pmem/ ntb_kunit

I am looking forward to see what you think!

Cheers

[1] https://lkml.org/lkml/2018/10/17/122
[2] https://lkml.org/lkml/2018/11/29/93
[3] https://groups.google.com/forum/#!topic/kunit-dev/EQ1x0SzrUus
[4] https://kunit.googlesource.com/linux/+/e10484ad2f9fc7926412ec84739fe105981b4771/drivers/i2c/busses/i2c-aspeed-test.c
