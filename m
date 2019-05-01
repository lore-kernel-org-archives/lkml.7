Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAA6C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 309BF21734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 07:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556697271;
	bh=1aQpcuRv7eGuERoCUmndQa8VFtF8VQoHgzkh4JtPH3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=imq8Ah4nvq+3rRT2O8sMa8bUeBXeq5EDd9oxAcnBPh9xjXP+eKTncZpkjTt9NGAgK
	 a0Kkrj0wf3pourfxZxwSF+fO4efG6RWJXXXLTkmfgzkMmmAK1TJ2sStJO9q/y5w5B5
	 +9EITYOmWrRzsrF2uaECUJkXUva3vqdXEyuvorKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbfEAHya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 03:54:30 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36056 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfEAHy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 03:54:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id b18so5219830otq.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 00:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IZIZCgRlJrdoeeM5+bR4Nwd/BZVjgYJ9Aq/1WcElNo=;
        b=k/JRdASVZCYaYVofPMvkl0Sw4h4JBKuFkXgJ8FSE80nmPE+JLfz1+7wP806dr9TFUb
         6155yhM+n6EGy+4TGpmwIbnosQOt5AXkl11tAEul86ii4oqMHVwTJ6NxPWrHgmDIeQZd
         by8HSCJLEkh8/S7qnlOvf6nPweIcI3VqXk6YjqJBDUANmJG6oKRy26NgteSTnFIMvdsS
         ucKLqIeZJnhfhsSCqmU3PF9dEqW8cSACFDKCEGXEo3/B9OEUFxh2VIslJYqvnWR7miEl
         wiQv/KeIcYQRxkFW1r+LsGMA3I+ggcA984sSxHwW4U0OTorARdvJELQCbGaYpSgccAg6
         CcIg==
X-Gm-Message-State: APjAAAWVv39ZT10l14FhpD/hOuMGqVF/cE58nErsidwFcuK+XBOH+DNt
        PqT12YHZ6fD8ilcoADMiTBBvleLi2u4xoHcZws0=
X-Google-Smtp-Source: APXvYqzk76H+LXDVVKS5qcdc+PUv8u6pna/A7rMA01ocZP/3p1ee9ZNh9RyKeZV5MBJtuVO8gggUle3wKriHUUuXT2w=
X-Received: by 2002:a9d:6e17:: with SMTP id e23mr15111444otr.65.1556697268777;
 Wed, 01 May 2019 00:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190430233803.GB10777@eros.localdomain>
In-Reply-To: <20190430233803.GB10777@eros.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 May 2019 09:54:16 +0200
Message-ID: <CAJZ5v0g34RZmugeBm63UT3XRvUmdJtvCAjcowdwDffrRorrscQ@mail.gmail.com>
Subject: Re: kobject_init_and_add() confusion
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 1, 2019 at 1:38 AM Tobin C. Harding <me@tobin.cc> wrote:
>
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
>         void fn(void)
>         {
>                 int ret;
>
>                 ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
>                 if (ret) {
>                         /*
>                          * This means kobject_init() has succeeded
>                          * but kobject_add() failed.
>                          */
>                         goto err_put;
>                 }
>
>                 ret = some_init_fn();
>                 if (ret) {
>                         /*
>                          * We need to wind back kobject_add() AND kobject_put().

kobject_add() and kobject_init() I suppose?

>                          * kobject_add() incremented the refcount in
>                          * kobj->parent, that needs to be decremented THEN we need
>                          * the call to kobject_put() to decrement the refcount of kobj.
>                          */

So actually, if you look at kobject_cleanup(), it calls kobject_del()
if kobj->state_in_sysfs is set.

Now, if you look at kobject_add_internal(), it sets
kobj->state_in_sysfs when about to return 0 (success).

Therefore calling kobject_put() without the preceding kobject_del() is
not a bug technically, even though it will trigger the "auto cleanup
kobject_del" message with debug enabled.

>                         goto err_del;
>                 }
>
>                 ret = some_other_init_fn();
>                 if (ret)
>                         goto other_err;
>
>                 kobject_uevent(kobj, KOBJ_ADD);
>                 return 0;
>
>         other_err:
>                 other_clean_up_fn();
>         err_del:
>                 kobject_del(kobj);
>         err_put:
>                 kobject_put(kobj);
>
>                 return ret;
>         }
>
>
> Have I got this correct?
>
> TODO
> ----
>
> - Fix all the callsites to kobject_init_and_add()
> - Further clarify the function docstring for kobject_init_and_add() [perhaps]
> - Add a section to Documentation/kobject.txt [optional]
> - Add a sample usage file under samples/kobject [optional]

The plan sounds good to me, but there is one thing to note IMO:
kobject_cleanup() invokes the ->release() callback for the ktype, so
these callbacks need to be able to cope with kobjects after a failing
kobject_add() which may not be entirely obvious to developers
introducing them ATM.

Thanks,
Rafael
