Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B887CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F4F2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 01:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="jnMn+EFK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EqADz1+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbfECBRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 21:17:13 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33773 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726267AbfECBRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 21:17:12 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C2FD22960;
        Thu,  2 May 2019 21:17:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2019 21:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=8+hast7KJ4VcauzFWvFQpJHR2lC
        4MnLGF7sZAjIBWrc=; b=jnMn+EFKg/lAlzn4Bm1Q4M5mG4UNrdH7Dz7X6etTs/h
        keC/I4P1dow5pm1SCmoLO0FV23gW2UpbgKleYw7Aa4uh3OLYTXw8bk3Z9AGIpiCL
        a4EtWcOLBiW/GimQKcm0tAvj9CMXoF/L+PM2tn/UX6EVxVmhmw/7x95CeQjTf9in
        cZOtlrWObHymACry0JuSfwRNH/8pb5+hEv4Y1+b1nDJ7Cm0h2R95XPpfcJit+mVQ
        dDVX0KuQ3Mv7F2q3iYNiyOfCT0mR7ktnsOg7ThXliXOC4PLRY5RQRarxgHztwhq8
        5en8nU/XsPSsuz20JrFIe9LjE997FFuswY9Vy/u8VIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=8+hast
        7KJ4VcauzFWvFQpJHR2lC4MnLGF7sZAjIBWrc=; b=EqADz1+hKPU2BiGPApDZfH
        3r2aRlmws4Q0zd6U2BP2E133O+0ZIK4BemHBnhfNsnciVEvXb4NGXWbPI1MLoLlZ
        O89noHkb49+UKEkYRkjQyt8v36/aoLZPXjFtpNq0I7j3r0fuTbMhnW8OcsEa3nEr
        VGhRCqvgje3fw2WsftldTaplORmszAdmkQDf7YC4lPFAWnH0ApGVMXJYsQXdP57U
        7tOBb8OgZTIERa+aogag1NIM4DyMs7Wkg7KPM+Ktcqt8P/iRqnP+Ya8VDloOg6wh
        QyHVR6PfF2sVKnOxd0EWik5flqiWGbWkh7iX620jb8JYUoAWwVJasq3LN1Bvg1YA
        ==
X-ME-Sender: <xms:k5bLXEh8LLxgHCgXxQjSn_xyIaAPKJEZ1LeHp7mHMHazmsFXXvHnFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrjedtgdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvuddrgeegrddvtdegrddvfeehnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:k5bLXItqnCWU83CfaN_1kUrYARFO_ozLT-JHuAwXyWPKAwmjEFYcPg>
    <xmx:k5bLXGyYvunMN3QsmF5ZxvI-HTZvI1uPfd0TZXpoJtXixxyTErE2LQ>
    <xmx:k5bLXGM10rwi-LlU3jjoh-j6ZoWFrqG3lGjXR8i8z2rpqnhrjlSEYg>
    <xmx:lZbLXMN5m1W-ZUB9XM9hpSUj-A81tIQoxlpv3wbVlU-eFAhBSsxEWQ>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1248FE4805;
        Thu,  2 May 2019 21:17:06 -0400 (EDT)
Date:   Fri, 3 May 2019 11:16:26 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Message-ID: <20190503011626.GA7416@eros.localdomain>
References: <20190430233803.GB10777@eros.localdomain>
 <20190502083412.dhqw35juhm42wgmk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502083412.dhqw35juhm42wgmk@pathway.suse.cz>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 10:34:12AM +0200, Petr Mladek wrote:
> On Wed 2019-05-01 09:38:03, Tobin C. Harding wrote:
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
> > 	void fn(void)
> > 	{
> > 	        int ret;
> > 
> > 	        ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
> > 	        if (ret) {
> > 			/*
> > 			 * This means kobject_init() has succeeded
> > 			 * but kobject_add() failed.
> > 			 */
> > 			goto err_put;
> > 		}
> 
> It is strange to make the structure visible in sysfs before
> we initialize it.
> 
> > 	        ret = some_init_fn();
> > 	        if (ret) {
> > 			/*
> > 			 * We need to wind back kobject_add() AND kobject_put().
> > 			 * kobject_add() incremented the refcount in
> > 			 * kobj->parent, that needs to be decremented THEN we need
> > 			 * the call to kobject_put() to decrement the
> >			 * refcount of kobj.
>  			 */
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
> 
> IMHO, separate kobject_del() makes only sense when the sysfs
> interface must be destroyed before some other actions.
> 
> I guess that we need two examples. I currently understand
> it the following way:
> 
> 1. sysfs interface and the structure can be freed anytime:
> 
>    	struct A
> 	{
> 		struct kobject kobj;
> 		...
> 	};
> 
> 	void fn(void)
> 	{
> 		struct A *a;
> 		int ret;
> 
> 		a = kzalloc(sizeof(*a), GFP_KERNEL);
> 		if (!a)
> 			return;
> 
> 		/*
> 		 * Initialize structure before we make it accessible via
> 		 * sysfs.
> 		 */
> 		ret = some_init_fn();
> 		if (ret) {
> 			goto init_err;
> 		}
> 
> 		ret = kobject_init_and_add(&a->kobj, ktype, NULL, "foo");
> 		if (ret)
> 			goto kobj_err;
> 
> 		return 0;
> 
> 	kobj_err:
> 		/* kobject_init() always succeds and take reference. */
> 		kobject_put(kobj);
> 		return ret;
> 
> 	init_err:
> 		/* kobject was not initialized, simple free is enough */
> 		kfree(a);
> 		return ret;
> 	}
> 
> 
> 2. Structure must be registered into the subsystem before
>    it can be made visible via sysfs:
> 
>    	struct A
> 	{
> 		struct kobject kobj;
> 		...
> 	};
> 
> 	void fn(void)
> 	{
> 		struct A *a;
> 		int ret;
> 
> 		a = kzalloc(sizeof(*a), GFP_KERNEL);
> 		if (!a)
> 			return;
> 
> 		ret = some_init_fn();
> 		if (ret) {
> 			goto init_err;
> 		}
> 
> 		/*
> 		 * Structure is in a reasonable state and can be freed
> 		 * via the kobject release callback.
> 		 */
> 		kobject_init(&a->kobj);
> 
> 		/*
> 		 * Register the structure so that it can cooperate
> 		 * with the rest of the system.
> 		 */
> 		ret = register_fn(a);
> `		if (ret)
> 			goto register_err;
> 
> 
> 		/* Make it visible via sysfs */
> 		ret = kobject_add(&a->kobj, ktype, NULL, "foo");
> 		if (ret) {
> 			goto kobj_add_err;
> 		}
> 
> 		/* Manipulate the structure somehow */
> 		ret = action_fn(a);
> 		if (ret)
> 			goto action_err;
> 
> 		mutex_unlock(&my_mutex);
> 		return 0;
> 
> 	action_err:
> 		/*
> 		 * Destroy sysfs interface but the structure
> 		 * is still needed.
> 		 */
> 		kobject_del(&a->kboject);
> 	kobject_add_err:
> 		/* Make it invisible to the system. */
> 		unregister_fn(a);
> 	register_err:
> 		/* Release the structure unsing the kobject callback */
> 		kobject_put(&a->kobj);
> 		return;
> 
> 	init_err:
> 		/*
> 		 * Custom init failed. Kobject release callback would do
> 		 * a double free or so. Simple free is enough.
> 		 */
> 		 kfree(a);
> 	}
> 
> I would really prefer if we clearly understand where each variant makes
> sense before we start modifying the code and documentation.

Hi Petr,

Shall we work these two examples into samples/kobject/.  I'm AFK now for
the rest of the week but I can do it on Monday if you don't mind me
doing it?

Cheers,
Tobin.
