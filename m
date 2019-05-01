Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA1C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7234920866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="rP0H0ZpX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hZ660TKs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEAVuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:50:05 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:48907 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726116AbfEAVuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:50:04 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9DB62573;
        Wed,  1 May 2019 17:44:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 May 2019 17:44:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=ggWj5DjDJpxIqBqNYfbm9smFUYn
        /s2NYjsoBI7Eb148=; b=rP0H0ZpXeAvnj+1Sd+SDFFwycEL+HdqyxFxfk5aFcjt
        RKxPasu+tK7saOVj2gU6xsUxRbfecYFFq9dyfBxxbwO6+oOoBvcGv7RLqN/tsiGG
        cGjWOHqqMZb1gqWeoSt3suq9SgoYEpuAf52LKyxCbUynIu+lJiTT4pB9phz50ECj
        OfDoSC/Ioxx2yd2ty1sXzwPDHlNRDxkU4R85ZjjJ7J0xq4clwq3XXNCvKQQcCaLC
        FMJVe5KSEiaKLJeguFymMVhFVIKOCmL+m5q2TpucPaHKB80DmAKMtqNMih946dXf
        ek84AlOuDtQpeuiqZi21nHvsrEosbmmKSJFr6x8j55g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ggWj5D
        jDJpxIqBqNYfbm9smFUYn/s2NYjsoBI7Eb148=; b=hZ660TKs8z5yiQMtbNqn1H
        N43yl/VrmLY3yYCYsU1HiXUUnmdLIfWMb7hpuUmIBeFsNW+1ofn/0e5zU5kzq556
        f83EJYLdVlM6Fm/hPCnm/Vb46zq8h/ryXThW6jQWa1o/A7iUEXbUpxhpBU121dI8
        yp0UxLHBoZO8R1vr5DKMtB8LADmpzl5OQVfW+mnXNvcmOdif4XQUIeV1KtF8C3TN
        vzw+F0ZTEyCjSBQlSp8fBJKYo9r4RydY7BcD3C233CErq4064ouvcKK5tW0dk2is
        Di24/NpNc+j0zcvsK7kFH7T5axUJNlZADDiAE/BNPi8E54h+kTOP1R8rIURqQQgw
        ==
X-ME-Sender: <xms:WRPKXP-KlDXFbHslR5EzmQJ9nQa7KcK8XGECFvZFtWqc69YsZMj5bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieejgdduieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvddtgedrvdefheenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:WRPKXBSo5z2x8AaugsC3tWq8KBRfXEVaLtNCFh14dCDpctZBMa2QvQ>
    <xmx:WRPKXGkQZttyGywWfRtgdWy2738RfZq1I20M5xJ5cGkff9gKJGsZKw>
    <xmx:WRPKXMWQhSuw-rqBw28gMY9slrSEmlFSW3rytCDAhDaNvN-GGnhJWQ>
    <xmx:WhPKXFeKwa0vtzsplO2_ZshVu9zY45CaYU3h_zXxzTEY2W5U-nAQOg>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1DCB0103D0;
        Wed,  1 May 2019 17:44:55 -0400 (EDT)
Date:   Thu, 2 May 2019 07:44:23 +1000
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
Message-ID: <20190501214423.GC18827@eros.localdomain>
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

You are correct, my mistake.

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

Thanks for this explanation.  Points noted.

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

During docs fixes I'll try to work this in.

Thanks,
Tobin.
