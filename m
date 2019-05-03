Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D56AC004C9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDA382075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfECH4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:55794 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725777AbfECH4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:56:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E9BFAAEE3;
        Fri,  3 May 2019 07:56:28 +0000 (UTC)
Date:   Fri, 3 May 2019 09:56:28 +0200
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
Message-ID: <20190503075628.kw6h2coyoft2w6o5@pathway.suse.cz>
References: <20190430233803.GB10777@eros.localdomain>
 <20190502083412.dhqw35juhm42wgmk@pathway.suse.cz>
 <20190503011626.GA7416@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503011626.GA7416@eros.localdomain>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2019-05-03 11:16:26, Tobin C. Harding wrote:
> On Thu, May 02, 2019 at 10:34:12AM +0200, Petr Mladek wrote:
> > On Wed 2019-05-01 09:38:03, Tobin C. Harding wrote:
> > I guess that we need two examples. I currently understand
> > it the following way:
> > 
> > 1. sysfs interface and the structure can be freed anytime:
> > 
> >    	struct A
> > 	{
> > 		struct kobject kobj;
> > 		...
> > 	};
> > 
> > 	void fn(void)
> > 	{
> > 		struct A *a;
> > 		int ret;
> > 
> > 		a = kzalloc(sizeof(*a), GFP_KERNEL);
> > 		if (!a)
> > 			return;
> > 
> > 		/*
> > 		 * Initialize structure before we make it accessible via
> > 		 * sysfs.
> > 		 */
> > 		ret = some_init_fn();
> > 		if (ret) {
> > 			goto init_err;
> > 		}
> > 
> > 		ret = kobject_init_and_add(&a->kobj, ktype, NULL, "foo");
> > 		if (ret)
> > 			goto kobj_err;
> > 
> > 		return 0;
> > 
> > 	kobj_err:
> > 		/* kobject_init() always succeds and take reference. */
> > 		kobject_put(kobj);
> > 		return ret;
> > 
> > 	init_err:
> > 		/* kobject was not initialized, simple free is enough */
> > 		kfree(a);
> > 		return ret;
> > 	}
> > 
> > 
> > 2. Structure must be registered into the subsystem before
> >    it can be made visible via sysfs:
> > 
> >    	struct A
> > 	{
> > 		struct kobject kobj;
> > 		...
> > 	};
> > 
> > 	void fn(void)
> > 	{
> > 		struct A *a;
> > 		int ret;
> > 
> > 		a = kzalloc(sizeof(*a), GFP_KERNEL);
> > 		if (!a)
> > 			return;
> > 
> > 		ret = some_init_fn();
> > 		if (ret) {
> > 			goto init_err;
> > 		}
> > 
> > 		/*
> > 		 * Structure is in a reasonable state and can be freed
> > 		 * via the kobject release callback.
> > 		 */
> > 		kobject_init(&a->kobj);
> > 
> > 		/*
> > 		 * Register the structure so that it can cooperate
> > 		 * with the rest of the system.
> > 		 */
> > 		ret = register_fn(a);
> > `		if (ret)
> > 			goto register_err;
> > 
> > 
> > 		/* Make it visible via sysfs */
> > 		ret = kobject_add(&a->kobj, ktype, NULL, "foo");
> > 		if (ret) {
> > 			goto kobj_add_err;
> > 		}
> > 
> > 		/* Manipulate the structure somehow */
> > 		ret = action_fn(a);
> > 		if (ret)
> > 			goto action_err;
> > 
> > 		mutex_unlock(&my_mutex);
> > 		return 0;
> > 
> > 	action_err:
> > 		/*
> > 		 * Destroy sysfs interface but the structure
> > 		 * is still needed.
> > 		 */
> > 		kobject_del(&a->kboject);
> > 	kobject_add_err:
> > 		/* Make it invisible to the system. */
> > 		unregister_fn(a);
> > 	register_err:
> > 		/* Release the structure unsing the kobject callback */
> > 		kobject_put(&a->kobj);
> > 		return;
> > 
> > 	init_err:
> > 		/*
> > 		 * Custom init failed. Kobject release callback would do
> > 		 * a double free or so. Simple free is enough.
> > 		 */
> > 		 kfree(a);
> > 	}
> > 
> > I would really prefer if we clearly understand where each variant makes
> > sense before we start modifying the code and documentation.
> 
> Hi Petr,
> 
> Shall we work these two examples into samples/kobject/.  I'm AFK now for
> the rest of the week but I can do it on Monday if you don't mind me
> doing it?

Sounds good to me. The current samples/kobject/kobject-example shows
the most simple case when the kobject is standalone. While the
above samples shows how to have it bundled in a bigger structure.

Thanks,
Petr
