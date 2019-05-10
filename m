Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0304CC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0EE4217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 07:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557474738;
	bh=RWCk7FWLQCkznFj94llF4rlXPE3luZml0sl2ajMBiCc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZMucHrhbS71CXARrmM2QB1jnv3zkPtMfAFXXA0JXtaQnJfR5zHxhzJHBdjLnWy8C5
	 tZxKYQyOR77BFPgkW7q6JYlv4VDD9lhEwwckwPArgqMvjS4bsBN5UtFYOTbQ5rrU2N
	 n193d4oxz6FV0MlPLmODd0FlqQFOmXWrWNGXEKXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfEJHwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 03:52:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37184 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbfEJHwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 03:52:17 -0400
Received: by mail-oi1-f196.google.com with SMTP id 143so3894864oii.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 00:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3oslHu1NscZhc+DysTmTMjmvChYt+BCh0Sxf/JECV2E=;
        b=VakV7+ROmGY/JpBtHSUpP55g9YKTlJuGD63qbt3Q77zClaBoDzTRaje+GF9uwm8sFM
         Qw12yuC8cf5pR6QoQq1sQqFu/wgPRUemPQa935e1lq9d8AcvAOuCyFsagI8e0z1Oz+TZ
         RedtiYm4zUYpMjX8wHGWJGUechkul2AgfqUM9jqXZHZgRZTlfONM6nVORcWTlAhjfIR4
         F4b2tN8A8t4uIayYCVVcECqSF/nb44GbYz0ZEhA56pnhSn+Bj6OHRiixXc5ot16HW/d7
         QGCyvzucA0LPqAI/KWixrXeo/g3FHcqq1RhpjlpBGHQXcXiTgrVC8LpQxP+z4yOdFULb
         GRgg==
X-Gm-Message-State: APjAAAVlHqUqrnKKTaq2rRPVQuTlVBLUtG/XoKPNz//FFQLO5r4liARq
        6Ip1xKD4WOXhXx8jVGNyATazYCnkPPR2/x3v/Jg=
X-Google-Smtp-Source: APXvYqx6sQbx42NfJ53mCPa9gdt6t00k9w4a++pgteLGKNbfYpTCIys1an0LGqXpUfq96FAjXEXfc5qeFvezSrCCP0c=
X-Received: by 2002:aca:f4c3:: with SMTP id s186mr4016815oih.68.1557474736378;
 Fri, 10 May 2019 00:52:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190430233803.GB10777@eros.localdomain> <CAJZ5v0g34RZmugeBm63UT3XRvUmdJtvCAjcowdwDffrRorrscQ@mail.gmail.com>
 <20190510023538.GA10356@eros.localdomain>
In-Reply-To: <20190510023538.GA10356@eros.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 10 May 2019 09:52:03 +0200
Message-ID: <CAJZ5v0jMnDnNLP8JO8-wQn+CxZtxn_4TAQn24SKABm5qGdKaWA@mail.gmail.com>
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

On Fri, May 10, 2019 at 4:36 AM Tobin C. Harding <me@tobin.cc> wrote:
>
> On Wed, May 01, 2019 at 09:54:16AM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 1, 2019 at 1:38 AM Tobin C. Harding <me@tobin.cc> wrote:
> > >
> > > Hi,
> > >
> > > Looks like I've created a bit of confusion trying to fix memleaks in
> > > calls to kobject_init_and_add().  Its spread over various patches and
> > > mailing lists so I'm starting a new thread and CC'ing anyone that
> > > commented on one of those patches.
> > >
> > > If there is a better way to go about this discussion please do tell me.
> > >
> > > The problem
> > > -----------
> > >
> > > Calls to kobject_init_and_add() are leaking memory throughout the kernel
> > > because of how the error paths are handled.
> > >
> > > The solution
> > > ------------
> > >
> > > Write the error path code correctly.
> > >
> > > Example
> > > -------
> > >
> > > We have samples/kobject/kobject-example.c but it uses
> > > kobject_create_and_add().  I thought of adding another example file here
> > > but could not think of how to do it off the top of my head without being
> > > super contrived.  Can add this to the TODO list if it will help.
> > >
> > > Here is an attempted canonical usage of kobject_init_and_add() typical
> > > of the code that currently is getting it wrong.  This is the second time
> > > I've written this and the first time it was wrong even after review (you
> > > know who you are, you are definitely buying the next round of drinks :)
> > >
> > >
> > > Assumes we have an object in memory already that has the kobject
> > > embedded in it. Variable 'kobj' below would typically be &ptr->kobj
> > >
> > >
> > >         void fn(void)
> > >         {
> > >                 int ret;
> > >
> > >                 ret = kobject_init_and_add(kobj, ktype, NULL, "foo");
> > >                 if (ret) {
> > >                         /*
> > >                          * This means kobject_init() has succeeded
> > >                          * but kobject_add() failed.
> > >                          */
> > >                         goto err_put;
> > >                 }
> > >
> > >                 ret = some_init_fn();
> > >                 if (ret) {
> > >                         /*
> > >                          * We need to wind back kobject_add() AND kobject_put().
> >
> > kobject_add() and kobject_init() I suppose?
> >
> > >                          * kobject_add() incremented the refcount in
> > >                          * kobj->parent, that needs to be decremented THEN we need
> > >                          * the call to kobject_put() to decrement the refcount of kobj.
> > >                          */
> >
> > So actually, if you look at kobject_cleanup(), it calls kobject_del()
> > if kobj->state_in_sysfs is set.
> >
> > Now, if you look at kobject_add_internal(), it sets
> > kobj->state_in_sysfs when about to return 0 (success).
> >
> > Therefore calling kobject_put() without the preceding kobject_del() is
> > not a bug technically, even though it will trigger the "auto cleanup
> > kobject_del" message with debug enabled.
> >
> > >                         goto err_del;
> > >                 }
> > >
> > >                 ret = some_other_init_fn();
> > >                 if (ret)
> > >                         goto other_err;
> > >
> > >                 kobject_uevent(kobj, KOBJ_ADD);
> > >                 return 0;
> > >
> > >         other_err:
> > >                 other_clean_up_fn();
> > >         err_del:
> > >                 kobject_del(kobj);
> > >         err_put:
> > >                 kobject_put(kobj);
> > >
> > >                 return ret;
> > >         }
> > >
> > >
> > > Have I got this correct?
> > >
> > > TODO
> > > ----
> > >
> > > - Fix all the callsites to kobject_init_and_add()
> > > - Further clarify the function docstring for kobject_init_and_add() [perhaps]
> > > - Add a section to Documentation/kobject.txt [optional]
> > > - Add a sample usage file under samples/kobject [optional]
> >
> > The plan sounds good to me, but there is one thing to note IMO:
> > kobject_cleanup() invokes the ->release() callback for the ktype, so
> > these callbacks need to be able to cope with kobjects after a failing
> > kobject_add() which may not be entirely obvious to developers
> > introducing them ATM.
>
> It has taken a while for this to soak in.  This is actually quite an
> insidious issue.  If I give an example and perhaps we can come to a
> solution.  This example is based on the code (and assumptions) in
> mm/slub.c
>
> If a developer has an object that they wish to add to sysfs they go
> ahead and embed a kobject in it.  Correctly set up a ktype including
> release function that just frees the object (using container of).  Now
> assume that the object is already set up and in use when we go to set up
> the sysfs entry.  If kobject_init_and_add() fails and we correctly call
> kobject_put() the containing object will be free'd.  Yet the calling
> code may not be done with the object, more to the point just because
> sysfs setup fails the object is now unusable.  Besides the interesting
> theoretical discussion this means we cannot just go and willy-nilly add
> calls to kobject_put() in the error path of kobject_init_and_add() if
> the original code was not written under the assumption that the release
> method could be called during the error path (I have found 2 places at
> least where behaviour of calling the release method is non-trivial to
> ascertain).

Well, generally speaking, you can add kobject_put() somewhere only if
invoking the ->release() callback for the ktype of the kobject in
question is safe at that point.

Now, it may be unsafe for two reasons: there may be active references
to the memory that would be freed by ->release() along with the
kobject (as you said above) or the code in ->release() may have
assumed some initialization to take place before it runs and so
->release() should not be invoked before completing that
initialization.

> I guess, as Greg said, its just a matter that reference counting within
> the kernel is a hard problem.  So we fix the easy ones and then look a
> bit harder at the hard ones ...
>
> Any better suggestion?

Well, I would say we fix all of them, but we are careful enough to
understand what's going on.

And the more complex cases will take more work (and time) to fix.  As
always. :-)
