Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F325C04AB1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5B5217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 02:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="LyeO9kBX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="5NKlvlAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfEJCgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 22:36:15 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:45393 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726806AbfEJCgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 22:36:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C10021ED6;
        Thu,  9 May 2019 22:36:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 09 May 2019 22:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=oq0fGdbH5xzNc9jhnh1krS5EBRx
        WNU/NUMrL0ejnGQ4=; b=LyeO9kBXfKWlmWNoBQv/HNF1JjCi18fLjEnpfyDvJs6
        /ICE59LQQnKoVkFHkWI0EpBxlibxrDjtvT2qqZYeQrRIOVBeDn7Dm3IolKUy7fKx
        KCAcpfueNQQb0kDQ7zyVH10q7pAtyXz87ol7bHMY0r7PVeFNHwBdWESfRwVOcbpE
        XcK87RJb4p6MMVgUS8l2DBguTN4QdjxH1Bqhuq94PHvZFqv45oAgjMrRX33bK7/P
        waI6pqXj+xBi1iEdgOkbIhhpAXeWV86tvRN8473Pjtv4+oaMAnTJ5gQnjUjf3mo7
        5PS7cnfO/HTCxhNiTu/eJd8+o8KIx5O7AthHC0ARGEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oq0fGd
        bH5xzNc9jhnh1krS5EBRxWNU/NUMrL0ejnGQ4=; b=5NKlvlAE4PXYeoGja1WKki
        TH7yJ/iCwT8wJRa5FvXSU3xCMqr70A3kRDj/KtFhUjrZ+nVcJPeZF9kwq8bOSMf/
        iLZKq+K1o7hMirnLfDnd0jFuApuzWhB9Irfi/da6uNF0++4MiZPO+9W+nV/Lq+7N
        NH3gGVEsbrV3OgbSn6zNe0NHfALUN4TYLRz3JUEnPpuWiuH9jcX93J8tAjeRw4Do
        X8NNDY1dc2jK38ONHzSuue2CICy+EXzk1nmI9DUf3uu4uZXuBTU1BIRUSE711Urh
        aOgxnykqcNnjiRyLBILoHlnmWzq0PLKrcSk3goGFq3uaiHVKFpzZHStdBVa0+U8A
        ==
X-ME-Sender: <xms:nOPUXGAYZON7CTGXwKb6mibw9UONZheM2mt5rkmTibroNZ4cUlH6Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrkeeigdduieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvdegrddujedurddvuddrhedvnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:nOPUXAuXTaw_WMAE5S4HJVGFTMNnjXWFi7TyP9HJKJPo_afCRaK8vQ>
    <xmx:nOPUXLZ6uwL8EHuMq0EJTruEdEmqfAuRf5LHcZx_btgy1j427I49jQ>
    <xmx:nOPUXDVBoXd4g71skM172KFCbEywdJB3r-sgw4OjYQR3yCPXUpZgjQ>
    <xmx:nePUXIr_hebcxkXH0tZfImiiKQDP0VnuJ3sjEcUg8sOPeYI4GW2A4w>
Received: from localhost (124-171-21-52.dyn.iinet.net.au [124.171.21.52])
        by mail.messagingengine.com (Postfix) with ESMTPA id CBD0C103D1;
        Thu,  9 May 2019 22:36:11 -0400 (EDT)
Date:   Fri, 10 May 2019 12:35:38 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Message-ID: <20190510023538.GA10356@eros.localdomain>
References: <20190430233803.GB10777@eros.localdomain>
 <CAJZ5v0g34RZmugeBm63UT3XRvUmdJtvCAjcowdwDffrRorrscQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g34RZmugeBm63UT3XRvUmdJtvCAjcowdwDffrRorrscQ@mail.gmail.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 09:54:16AM +0200, Rafael J. Wysocki wrote:
> On Wed, May 1, 2019 at 1:38 AM Tobin C. Harding <me@tobin.cc> wrote:
> >
> > Hi,
> >
> > Looks like I've created a bit of confusion trying to fix memleaks in
> > calls to kobject_init_and_add().  Its spread over various patches and
> > mailing lists so I'm starting a new thread and CC'ing anyone that
> > commented on one of those patches.
> >
> > If there is a better way to go about this discussion please do tell me.
> >
> > The problem
> > -----------
> >
> > Calls to kobject_init_and_add() are leaking memory throughout the kernel
> > because of how the error paths are handled.
> >
> > The solution
> > ------------
> >
> > Write the error path code correctly.
> >
> > Example
> > -------
> >
> > We have samples/kobject/kobject-example.c but it uses
> > kobject_create_and_add().  I thought of adding another example file here
> > but could not think of how to do it off the top of my head without being
> > super contrived.  Can add this to the TODO list if it will help.
> >
> > Here is an attempted canonical usage of kobject_init_and_add() typical
> > of the code that currently is getting it wrong.  This is the second time
> > I've written this and the first time it was wrong even after review (you
> > know who you are, you are definitely buying the next round of drinks :)
> >
> >
> > Assumes we have an object in memory already that has the kobject
> > embedded in it. Variable 'kobj' below would typically be &ptr->kobj
> >
> >
> >         void fn(void)
> >         {
> >                 int ret;
> >
> >                 ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
> >                 if (ret) {
> >                         /*
> >                          * This means kobject_init() has succeeded
> >                          * but kobject_add() failed.
> >                          */
> >                         goto err_put;
> >                 }
> >
> >                 ret = some_init_fn();
> >                 if (ret) {
> >                         /*
> >                          * We need to wind back kobject_add() AND kobject_put().
> 
> kobject_add() and kobject_init() I suppose?
> 
> >                          * kobject_add() incremented the refcount in
> >                          * kobj->parent, that needs to be decremented THEN we need
> >                          * the call to kobject_put() to decrement the refcount of kobj.
> >                          */
> 
> So actually, if you look at kobject_cleanup(), it calls kobject_del()
> if kobj->state_in_sysfs is set.
> 
> Now, if you look at kobject_add_internal(), it sets
> kobj->state_in_sysfs when about to return 0 (success).
> 
> Therefore calling kobject_put() without the preceding kobject_del() is
> not a bug technically, even though it will trigger the "auto cleanup
> kobject_del" message with debug enabled.
> 
> >                         goto err_del;
> >                 }
> >
> >                 ret = some_other_init_fn();
> >                 if (ret)
> >                         goto other_err;
> >
> >                 kobject_uevent(kobj, KOBJ_ADD);
> >                 return 0;
> >
> >         other_err:
> >                 other_clean_up_fn();
> >         err_del:
> >                 kobject_del(kobj);
> >         err_put:
> >                 kobject_put(kobj);
> >
> >                 return ret;
> >         }
> >
> >
> > Have I got this correct?
> >
> > TODO
> > ----
> >
> > - Fix all the callsites to kobject_init_and_add()
> > - Further clarify the function docstring for kobject_init_and_add() [perhaps]
> > - Add a section to Documentation/kobject.txt [optional]
> > - Add a sample usage file under samples/kobject [optional]
> 
> The plan sounds good to me, but there is one thing to note IMO:
> kobject_cleanup() invokes the ->release() callback for the ktype, so
> these callbacks need to be able to cope with kobjects after a failing
> kobject_add() which may not be entirely obvious to developers
> introducing them ATM.

It has taken a while for this to soak in.  This is actually quite an
insidious issue.  If I give an example and perhaps we can come to a
solution.  This example is based on the code (and assumptions) in
mm/slub.c

If a developer has an object that they wish to add to sysfs they go
ahead and embed a kobject in it.  Correctly set up a ktype including
release function that just frees the object (using container of).  Now
assume that the object is already set up and in use when we go to set up
the sysfs entry.  If kobject_init_and_add() fails and we correctly call
kobject_put() the containing object will be free'd.  Yet the calling
code may not be done with the object, more to the point just because
sysfs setup fails the object is now unusable.  Besides the interesting
theoretical discussion this means we cannot just go and willy-nilly add
calls to kobject_put() in the error path of kobject_init_and_add() if
the original code was not written under the assumption that the release
method could be called during the error path (I have found 2 places at
least where behaviour of calling the release method is non-trivial to
ascertain).

I guess, as Greg said, its just a matter that reference counting within
the kernel is a hard problem.  So we fix the easy ones and then look a
bit harder at the hard ones ...

Any better suggestion?

thanks,
Tobin.


