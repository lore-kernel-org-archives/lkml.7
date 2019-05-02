Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F87CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEA62089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 09:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556788015;
	bh=gO+U+NcJxMBF5LS75ZcZh0WcY4pECA/aNanq/JVdeQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I7G7vu+CXPpnVhTPcDfM0LKkLs6pKv/0CYPW8IAuGSytLuAIIVKD75IVlxPFdIbAe
	 8Akm5z/FqVdvV9HIWK+5U4g1T9/jSsEJy9JYfOX2x7uSdZ9CWQ8RAhPUF26KS85+l+
	 T3F33FlUxMZn/Zdh+yghnpEuaOsfAyrcn7bEsZr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfEBJGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 05:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726394AbfEBJGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 05:06:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D5DD206DF;
        Thu,  2 May 2019 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556788009;
        bh=gO+U+NcJxMBF5LS75ZcZh0WcY4pECA/aNanq/JVdeQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzTJxRuAone2L1Egf+gbfXBaeUJGx85XD/prQNibKSFa2bIRtcBcQKrUt/OLyqbdi
         5ZadnmxkccnVH03zPpKWyzQS1sJy8/E5N8oofIV63t2SnEoQfkboUVlKb7PsU0Jmr4
         Z9t1higogTBV4aaaz095FvPnJui/7+k3lBV1ah+I=
Date:   Thu, 2 May 2019 11:06:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Message-ID: <20190502090647.GB25154@kroah.com>
References: <20190430233803.GB10777@eros.localdomain>
 <20190502083412.dhqw35juhm42wgmk@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502083412.dhqw35juhm42wgmk@pathway.suse.cz>
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

Yes, that is not a good patern, some_init_fn() should happen first.

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

Yes, kobject_del() should not be used unless you really know what you
are doing.

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


need to unwind some_init_fn() here too.

> 		/* kobject_init() always succeds and take reference. */
> 		kobject_put(kobj);
> 		return ret;
> 
> 	init_err:
> 		/* kobject was not initialized, simple free is enough */
> 		kfree(a);
> 		return ret;
> 	}


Yes.

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

The second variant is much more rare (or at least it should be), but
your example is a good one.

thanks,

greg k-h
