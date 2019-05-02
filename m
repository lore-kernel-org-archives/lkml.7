Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE16EC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879AC20873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfEBIeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:34:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:60130 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725905AbfEBIeO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:34:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 56E9EABE7;
        Thu,  2 May 2019 08:34:13 +0000 (UTC)
Date:   Thu, 2 May 2019 10:34:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Message-ID: <20190502083412.dhqw35juhm42wgmk@pathway.suse.cz>
References: <20190430233803.GB10777@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430233803.GB10777@eros.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2019-05-01 09:38:03, Tobin C. Harding wrote:
> Hi,
> 
> Looks like I've created a bit of confusion trying to fix memleaks in
> calls to kobject_init_and_add().  Its spread over various patches and
> mailing lists so I'm starting a new thread and CC'ing anyone that
> commented on one of those patches.
> 
> If there is a better way to go about this discussion please do tell me.
> 
> The problem
> -----------
> 
> Calls to kobject_init_and_add() are leaking memory throughout the kernel
> because of how the error paths are handled.
> 
> The solution
> ------------
> 
> Write the error path code correctly.
> 
> Example
> -------
> 
> We have samples/kobject/kobject-example.c but it uses
> kobject_create_and_add().  I thought of adding another example file here
> but could not think of how to do it off the top of my head without being
> super contrived.  Can add this to the TODO list if it will help.
> 
> Here is an attempted canonical usage of kobject_init_and_add() typical
> of the code that currently is getting it wrong.  This is the second time
> I've written this and the first time it was wrong even after review (you
> know who you are, you are definitely buying the next round of drinks :)
> 
> 
> Assumes we have an object in memory already that has the kobject
> embedded in it. Variable 'kobj' below would typically be &ptr->kobj
> 
> 
> 	void fn(void)
> 	{
> 	        int ret;
> 
> 	        ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
> 	        if (ret) {
> 			/*
> 			 * This means kobject_init() has succeeded
> 			 * but kobject_add() failed.
> 			 */
> 			goto err_put;
> 		}

It is strange to make the structure visible in sysfs before
we initialize it.

> 	        ret = some_init_fn();
> 	        if (ret) {
> 			/*
> 			 * We need to wind back kobject_add() AND kobject_put().
> 			 * kobject_add() incremented the refcount in
> 			 * kobj->parent, that needs to be decremented THEN we need
> 			 * the call to kobject_put() to decrement the
>			 * refcount of kobj.
 			 */
> 			goto err_del;
> 		}
> 
> 	        ret = some_other_init_fn();
> 	        if (ret)
> 	                goto other_err;
> 
> 	        kobject_uevent(kobj, KOBJ_ADD);
> 	        return 0;
> 
> 	other_err:
> 	        other_clean_up_fn();
> 	err_del:
> 	        kobject_del(kobj);
> 	err_put:
> 		kobject_put(kobj);

IMHO, separate kobject_del() makes only sense when the sysfs
interface must be destroyed before some other actions.

I guess that we need two examples. I currently understand
it the following way:

1. sysfs interface and the structure can be freed anytime:

   	struct A
	{
		struct kobject kobj;
		...
	};

	void fn(void)
	{
		struct A *a;
		int ret;

		a = kzalloc(sizeof(*a), GFP_KERNEL);
		if (!a)
			return;

		/*
		 * Initialize structure before we make it accessible via
		 * sysfs.
		 */
		ret = some_init_fn();
		if (ret) {
			goto init_err;
		}

		ret = kobject_init_and_add(&a->kobj, ktype, NULL, "foo");
		if (ret)
			goto kobj_err;

		return 0;

	kobj_err:
		/* kobject_init() always succeds and take reference. */
		kobject_put(kobj);
		return ret;

	init_err:
		/* kobject was not initialized, simple free is enough */
		kfree(a);
		return ret;
	}


2. Structure must be registered into the subsystem before
   it can be made visible via sysfs:

   	struct A
	{
		struct kobject kobj;
		...
	};

	void fn(void)
	{
		struct A *a;
		int ret;

		a = kzalloc(sizeof(*a), GFP_KERNEL);
		if (!a)
			return;

		ret = some_init_fn();
		if (ret) {
			goto init_err;
		}

		/*
		 * Structure is in a reasonable state and can be freed
		 * via the kobject release callback.
		 */
		kobject_init(&a->kobj);

		/*
		 * Register the structure so that it can cooperate
		 * with the rest of the system.
		 */
		ret = register_fn(a);
`		if (ret)
			goto register_err;


		/* Make it visible via sysfs */
		ret = kobject_add(&a->kobj, ktype, NULL, "foo");
		if (ret) {
			goto kobj_add_err;
		}

		/* Manipulate the structure somehow */
		ret = action_fn(a);
		if (ret)
			goto action_err;

		mutex_unlock(&my_mutex);
		return 0;

	action_err:
		/*
		 * Destroy sysfs interface but the structure
		 * is still needed.
		 */
		kobject_del(&a->kboject);
	kobject_add_err:
		/* Make it invisible to the system. */
		unregister_fn(a);
	register_err:
		/* Release the structure unsing the kobject callback */
		kobject_put(&a->kobj);
		return;

	init_err:
		/*
		 * Custom init failed. Kobject release callback would do
		 * a double free or so. Simple free is enough.
		 */
		 kfree(a);
	}

I would really prefer if we clearly understand where each variant makes
sense before we start modifying the code and documentation.

Best Regards,
Petr
