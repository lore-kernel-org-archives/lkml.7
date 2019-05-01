Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E763C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77A421743
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556709027;
	bh=RiyWMednSoirkDMsCPXi4Knnz0zqm8dM0sStuxwCq2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FLTh3b3DX00IiPLblGnIPzXsMXJLSdqXFELe+8N3NO6GGgwmxL5uQf0dIEc3+5SyW
	 /BUtRSbrTD2qd9Wc04SajvKJxRTq0I8Gkb0g3cGV+tnEyx8r+KWwU246S6ehHBcAr3
	 Fhw0XBuRK7Zm+TOVmcONiWxka6BovvA30HEXqEjg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfEALK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 07:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:42540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfEALK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 07:10:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1650321670;
        Wed,  1 May 2019 11:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556709025;
        bh=RiyWMednSoirkDMsCPXi4Knnz0zqm8dM0sStuxwCq2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnle+CACXHAFvDb/WM/1E/ZcBNOsOp0NWUUhZgXSb/3+3fxqs68eYLWUo1M3Hqdiw
         ThphdE3pbM4ye2Z7oOT2zkqn5lxhQMbnmJnOdBf1hIoqHrQHfL9pINSyTT778u+F6W
         g337f28a2qQKngNzYkFfJ0iEi9hRwvN7+PBmIgvs=
Date:   Wed, 1 May 2019 13:10:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kobject_init_and_add() confusion
Message-ID: <20190501111022.GA15959@kroah.com>
References: <20190430233803.GB10777@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430233803.GB10777@eros.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 09:38:03AM +1000, Tobin C. Harding wrote:
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

s/are leaking/have the potential to leak/

Note, no one ever hits these error paths, so it isn't a big issue, and
is why no one has seen this except for the use of syzbot at times.

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

You could take the example I wrote in that old email and use it, or your
version below as well.

> Here is an attempted canonical usage of kobject_init_and_add() typical
> of the code that currently is getting it wrong.  This is the second time
> I've written this and the first time it was wrong even after review (you
> know who you are, you are definitely buying the next round of drinks :)
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

kobject_init() can not fail except in fun ways that dumps the stack and
then keeps on going due to the failure being on the caller, not the
kobject code itself.

> 			 * but kobject_add() failed.
> 			 */
> 			goto err_put;
> 		}
> 
> 	        ret = some_init_fn();
> 	        if (ret) {
> 			/*
> 			 * We need to wind back kobject_add() AND kobject_put().
> 			 * kobject_add() incremented the refcount in
> 			 * kobj->parent, that needs to be decremented THEN we need
> 			 * the call to kobject_put() to decrement the refcount of kobj.
> 			 */
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
> 
> 	        return ret;
> 	}
> 
> 
> Have I got this correct?

From what I can tell, yes.

> TODO
> ----
> 
> - Fix all the callsites to kobject_init_and_add()
> - Further clarify the function docstring for kobject_init_and_add() [perhaps]

More documentation, sure!

> - Add a section to Documentation/kobject.txt [optional]

That file should probably be reviewed and converted to .rst, I haven't
looked at it in years.

> - Add a sample usage file under samples/kobject [optional]

Would be a good idea, so we can point people at it.

thanks,

greg k-h
