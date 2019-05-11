Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29188C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E50B7217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 06:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="BVXw6bzp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rDyd390K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfEKGdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 02:33:00 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55481 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbfEKGdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 02:33:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 022E821E44;
        Sat, 11 May 2019 02:32:59 -0400 (EDT)
Received: from imap37 ([10.202.2.87])
  by compute5.internal (MEProxy); Sat, 11 May 2019 02:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=urVdJJyBFXeY2/ER+RB7IsvUiLq/kfA
        pyA+UFACJ3qQ=; b=BVXw6bzp908KUqhjY+XV7cr7cONQU9BDoqIAawsxRGXFhAy
        ajielz/saTIYTHRjMMzS/yoY3O9aT/svpND+YNewT2ty6ENF6OoYOovUQlvb1OnP
        JBgDT4D2BfT5cNMzI6fwlYax2LWZuzxW6paRgpEgfc70YeDoyOJbxw7QCISoHDYD
        2SrH/isHrwE38HArpKrjUsD8Vt4wTwu4ZAFwqqGUcRaqyLLcFaDq10pjzAV6la+X
        4J8qAW2AqXnLs+mPFyPLZSFQqRtJwwNxDJHaNC+sNKQw3qsTy1l1AnEdcUfaQ4yo
        pGR5w2NL8krMwTOE9hdeuj8qZs1JgO+X7hWb6nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=urVdJJ
        yBFXeY2/ER+RB7IsvUiLq/kfApyA+UFACJ3qQ=; b=rDyd390KW5fIk+qSnIygNh
        Gj9p/62GIv/M+jHVVJlrw4hpGIeR8eN1X1RkZ81Anh0pxs7ZOyc3mxbHecZFpT5r
        ZkOv/UIVzG4B20aXRN1ne+wPyWjrJzMRfLo9desvZ/lwdJxdhr9yNzr/I3JVtMgn
        Na8zY2QIGfVHVypafhAJ6a1iQ3kOFZpwnz8JCRHPRfJZuYuSBxWQszKPstjDQN26
        otKrmINI+/60tg6YFH8oEoZrDYfUXs1QDCxH33bZnTkwX4BbdqQrV8HcOvVsNGXR
        KyPWtv/cKroDp1bAU9uoiQyv4a89j+D/KBeXrUz/gbUrNLs7+2A0q0sfCl1IGUng
        ==
X-ME-Sender: <xms:mmzWXClljGp0htJ7-FtypiL6LRyVvmmUdppPeBptTbZ8pF75Bp-qNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkeelgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdludehmdenucfjughrpefofgggkfgjfhffhffvufgtsehttdertder
    redtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsihhnrdgttgen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:mmzWXAtk17q8FFEkwLwHfjzUzfElrsjK7WcC67T-Fu0Du8DxsBEgFg>
    <xmx:mmzWXNn7TOC6j4t6px9tVKb-s7gWK4M3-cXT6RjLjyN1rVJOdjJwZw>
    <xmx:mmzWXDs763L2cBkm6sA8TVh-cJZDFeQ7C20mxo_KXELwca0tBtTwng>
    <xmx:mmzWXMUzKv74WMJs8U8qTxUjrXDr3_dWIDHjWThFRJD2UeUISPvfCA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 22D9EDEC25; Sat, 11 May 2019 02:32:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-449-gfb3fc5a-fmstable-20190430v1
Mime-Version: 1.0
Message-Id: <1aa4ce74-b0a5-474b-95ad-7402a4a2710a@www.fastmail.com>
In-Reply-To: <20190510094025.wiw37baomizk6bip@pathway.suse.cz>
References: <20190430233803.GB10777@eros.localdomain>
 <CAJZ5v0g34RZmugeBm63UT3XRvUmdJtvCAjcowdwDffrRorrscQ@mail.gmail.com>
 <20190510023538.GA10356@eros.localdomain>
 <20190510094025.wiw37baomizk6bip@pathway.suse.cz>
Date:   Sat, 11 May 2019 02:32:19 -0400
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Petr Mladek" <pmladek@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Tyrel Datwyler" <tyreld@linux.vnet.ibm.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Miroslav Benes" <mbenes@suse.cz>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, May 10, 2019, at 19:40, Petr Mladek wrote:
> On Fri 2019-05-10 12:35:38, Tobin C. Harding wrote:
> > On Wed, May 01, 2019 at 09:54:16AM +0200, Rafael J. Wysocki wrote:
> > > On Wed, May 1, 2019 at 1:38 AM Tobin C. Harding <me@tobin.cc> wrote:
> > > > TODO
> > > > ----
> > > >
> > > > - Fix all the callsites to kobject_init_and_add()
> > > > - Further clarify the function docstring for kobject_init_and_add() [perhaps]
> > > > - Add a section to Documentation/kobject.txt [optional]
> > > > - Add a sample usage file under samples/kobject [optional]
> > > 
> > > The plan sounds good to me, but there is one thing to note IMO:
> > > kobject_cleanup() invokes the ->release() callback for the ktype, so
> > > these callbacks need to be able to cope with kobjects after a failing
> > > kobject_add() which may not be entirely obvious to developers
> > > introducing them ATM.
> > 
> > It has taken a while for this to soak in.  This is actually quite an
> > insidious issue.  If I give an example and perhaps we can come to a
> > solution.  This example is based on the code (and assumptions) in
> > mm/slub.c
> > 
> > If a developer has an object that they wish to add to sysfs they go
> > ahead and embed a kobject in it.  Correctly set up a ktype including
> > release function that just frees the object (using container of).  Now
> > assume that the object is already set up and in use when we go to set up
> > the sysfs entry.
> 
> It would say that this is a bad design. I see the creation of the sysfs
> entry as part of the initialization. The object should not be made
> usable before it is fully initialized.

It may be a case of my lack of understanding of object lifecycles here and not bad design, if as you say creation of sysfs is always part of initialisation then the problem I describe above should not exist (and it may well not, assumptions behind code are hard to grok).
 
> > If kobject_init_and_add() fails and we correctly call
> > kobject_put() the containing object will be free'd.  Yet the calling
> > code may not be done with the object, more to the point just because
> > sysfs setup fails the object is now unusable.  Besides the interesting
> > theoretical discussion this means we cannot just go and willy-nilly add
> > calls to kobject_put() in the error path of kobject_init_and_add() if
> > the original code was not written under the assumption that the release
> > method could be called during the error path (I have found 2 places at
> > least where behaviour of calling the release method is non-trivial to
> > ascertain).
> 
> kobject usage is complicated and it is easy to make it wrong. I think
> that this is motivation to improve the documentation and adding
> good examples.

Cool, I did work on adding your example from last week into samples/kobject but I wasn't able to come up with anything that I was totally happy with.  Hard to use API needs minimal concise correct examples right, I'm going to keep at that as I learn more from seeing/patching current kobject code.

> > I guess, as Greg said, its just a matter that reference counting within
> > the kernel is a hard problem.  So we fix the easy ones and then look a
> > bit harder at the hard ones ...
> 
> The people working on the affected subsystem should be able to help.
> They might have misunderstood kobjects. But they should be more
> familiar with the other dependencies.

Sure thing.

> Thanks for working on it.

Things that bend ones brain are the funnest to work on ;)

Cheers,
Tobin.
