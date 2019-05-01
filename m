Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D682C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34772085A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="gYZXIv6o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GoDhtNrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEAV7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:59:38 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35335 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726144AbfEAV7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:59:37 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 274C4550;
        Wed,  1 May 2019 17:59:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 01 May 2019 17:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=8NfadrpETJHHKG3TtI8ia2fqFej
        EwOO6jW14ZC31NK0=; b=gYZXIv6oUzHB9lApr+QfbajwhZzBV+ENum6D87kyTpt
        4DI5XGbtFm/pyLX/tv0s492kZDUNXvbPcUs+gzsE0qJeUhHAjWRBsdR+zz7fWniW
        PhJweVJqLaF+8ymGfsN/38Hzio68crmRMY3kdAmo/Kbj2ZEvMSjJld4MACzdvINE
        omCzTrFYpttGSk2ZvJJvNZX7ApMjsDFOEAmOyKyNNDOFsRPZI5mjWkqIacO9jJob
        0RTjGWuCzwJIXxS3BCXAG4n4XtXtOofbGPF5BSTD0dyqw1MT1cqDx3KXRC0/dlDB
        5K44EyWYy9Gztq09wAvWw53/TXGR/SuhKhp+i9Jtenw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8Nfadr
        pETJHHKG3TtI8ia2fqFejEwOO6jW14ZC31NK0=; b=GoDhtNrraQZvmNxuFZhN/t
        boP3i8GRSMzazUH7dnetVaSdpCx8fj72xgE96yLLXgF0S/ed8VNPnN9GXZmjMkoO
        nBSYq871ESynWblov5X2Izv4nxw+ZeadlTEFdc52V5iPV3EzQfyPOs1TTRomPvLf
        1DG5pltJrzx966nRM9Kx89JYrUqTBaWgmCHhH1yySrLEgQU/NOjTgEAXi76NeH/j
        K4qSlI/lyiKpymjmXC9uodIkLMpn/y98NAOCvVb5jz0C9hgdPVVj6J11KmQwg9Ww
        w2lntuTE9MPgn6BXs8B1mloC+V4/lImPVkx266Zh9IQlSIUK9tCmFHszHEOJDylg
        ==
X-ME-Sender: <xms:xhbKXDSH0FXEcWiJYWL9vcyIatYdsiYsoONTOO4YJgS7GOUGFFqBuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieejgdduieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvddtgedrvdefheenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedu
X-ME-Proxy: <xmx:xhbKXKtqIhypirQBv5jt3DHwdpH2XsDOOdFq5lGHeep9Xf-BMaq30g>
    <xmx:xhbKXF-sjusSJgrzUMjF3jto_OkKWh8V-Xx1V7ST5h5Z-ftNnvJFaQ>
    <xmx:xhbKXDzJGl0YLuYeQOqeFo77S1qggtJ5KRaN0WCkISbZET0tWFpaIQ>
    <xmx:xxbKXKuXpmFsEYSN_NMSvgrecQL4Z68eyEo4MWwlFpzc6XIxjfkoSw>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1C612103C8;
        Wed,  1 May 2019 17:59:32 -0400 (EDT)
Date:   Thu, 2 May 2019 07:58:58 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Message-ID: <20190501215858.GE18827@eros.localdomain>
References: <20190430233803.GB10777@eros.localdomain>
 <20190501111022.GA15959@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501111022.GA15959@kroah.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 01:10:22PM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 01, 2019 at 09:38:03AM +1000, Tobin C. Harding wrote:
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
> 
> s/are leaking/have the potential to leak/
> 
> Note, no one ever hits these error paths, so it isn't a big issue, and
> is why no one has seen this except for the use of syzbot at times.

One day I'll find an important issue to fix in the kernel.  At the
moment sweeping these up is good practice/learning.  If you have any
_real_ issues that need someone to turn the crank on feel free to dump
them on me :)

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
> 
> You could take the example I wrote in that old email and use it, or your
> version below as well.

Responded just now to that email.

> 
> > Here is an attempted canonical usage of kobject_init_and_add() typical
> > of the code that currently is getting it wrong.  This is the second time
> > I've written this and the first time it was wrong even after review (you
> > know who you are, you are definitely buying the next round of drinks :)
> > 
> > Assumes we have an object in memory already that has the kobject
> > embedded in it. Variable 'kobj' below would typically be &ptr->kobj
> > 
> > 
> > 	void fn(void)
> > 	{
> > 	        int ret;
> > 
> > 	        ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
> > 	        if (ret) {
> > 			/*
> > 			 * This means kobject_init() has succeeded
> 
> kobject_init() can not fail except in fun ways that dumps the stack and
> then keeps on going due to the failure being on the caller, not the
> kobject code itself.

Cheers, writing good documentation is HARD.

> > 			 * but kobject_add() failed.
> > 			 */
> > 			goto err_put;
> > 		}
> > 
> > 	        ret = some_init_fn();
> > 	        if (ret) {
> > 			/*
> > 			 * We need to wind back kobject_add() AND kobject_put().
> > 			 * kobject_add() incremented the refcount in
> > 			 * kobj->parent, that needs to be decremented THEN we need
> > 			 * the call to kobject_put() to decrement the refcount of kobj.
> > 			 */
> > 			goto err_del;
> > 		}
> > 
> > 	        ret = some_other_init_fn();
> > 	        if (ret)
> > 	                goto other_err;
> > 
> > 	        kobject_uevent(kobj, KOBJ_ADD);
> > 	        return 0;
> > 
> > 	other_err:
> > 	        other_clean_up_fn();
> > 	err_del:
> > 	        kobject_del(kobj);
> > 	err_put:
> > 		kobject_put(kobj);
> > 
> > 	        return ret;
> > 	}
> > 
> > 
> > Have I got this correct?
> 
> From what I can tell, yes.

:)

> > TODO
> > ----
> > 
> > - Fix all the callsites to kobject_init_and_add()
> > - Further clarify the function docstring for kobject_init_and_add() [perhaps]
> 
> More documentation, sure!
> 
> > - Add a section to Documentation/kobject.txt [optional]
> 
> That file should probably be reviewed and converted to .rst, I haven't
> looked at it in years.

On my TODO list once I get kobject usage clear in my head.

> > - Add a sample usage file under samples/kobject [optional]
> 
> Would be a good idea, so we can point people at it.

I'll combine your other email example with the extra init/error stuff
from this one and BOOM!

Thanks Greg.

	Tobin
