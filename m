Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC63C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685A520873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556781467;
	bh=dfn9OaVUJo+VbMBbmLA8YPlvG1zSHk10FsjYF9mIYEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jU/bH/kgh2pL8RseeFkPOnMa9r46V69HG+ktGI+z0iLwTj3jR6v0r2TJff3RXCFMT
	 5kmNPXiltXq/nIxMO75Cib2FVRD9HIYWh02Q9X8dtm4JaBF/q5wFpfC6k0qbeJhXRm
	 97l+mONKGmIlRL/xd7zZmu8R6ySpkIVIOheLHdyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfEBHRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBHRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:17:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0562085A;
        Thu,  2 May 2019 07:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556781464;
        bh=dfn9OaVUJo+VbMBbmLA8YPlvG1zSHk10FsjYF9mIYEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xizAyWkQDBiAnaXG/YnxyKY2HB71RqH6UXO+y26BltasfF2m9Q1SguOcApaHahHFV
         QdCkrRUN8lJNbcZ3/CXQYVg1K64uP8ldFc+9vkkvwQoODvVfUw/2I4w5w7akHQHrIt
         bG9EO80W/wgeZGJrgR8tWa6p2ZqT5d447FqP5tbc=
Date:   Thu, 2 May 2019 09:17:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: memleak around kobject_init_and_add()
Message-ID: <20190502071742.GC16247@kroah.com>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com>
 <20190501215616.GD18827@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190501215616.GD18827@eros.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 07:56:16AM +1000, Tobin C. Harding wrote:
> On Sat, Apr 27, 2019 at 09:28:09PM +0200, Greg Kroah-Hartman wrote:
> > On Sat, Apr 27, 2019 at 06:13:30PM +1000, Tobin C. Harding wrote:
> > > (Note at bottom on reasons for 'To' list 'Cc' list)
> > > 
> > > Hi,
> > > 
> > > kobject_init_and_add() seems to be routinely misused.  A failed call to this
> > > function requires a call to kobject_put() otherwise we leak memory.
> > > 
> > > Examples memleaks can be seen in:
> > > 
> > > 	mm/slub.c
> > > 	fs/btrfs/sysfs.c
> > > 	fs/xfs/xfs_sysfs.h: xfs_sysfs_init()
> > > 
> > >  Question: Do we fix the misuse or fix the API?
> > 
> > Fix the misuse.
> > 
> > > $ git grep kobject_init_and_add | wc -l
> > > 117
> > > 
> > > Either way, we will have to go through all 117 call sites and check them.
> > 
> > Yes.  Same for other functions like device_add(), that is the "pattern"
> > those users must follow.
> > 
> > > I
> > > don't mind fixing them all but I don't want to do it twice because I chose the
> > > wrong option.  Reaching out to those more experienced for a suggestion please.
> > > 
> > > Fix the API
> > > -----------
> > > 
> > > Typically init functions do not require cleanup if they fail, this argument
> > > leads to this patch
> > > 
> > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > index aa89edcd2b63..62328054bbd0 100644
> > > --- a/lib/kobject.c
> > > +++ b/lib/kobject.c
> > > @@ -453,6 +453,9 @@ int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
> > >  	retval = kobject_add_varg(kobj, parent, fmt, args);
> > >  	va_end(args);
> > >  
> > > +	if (retval)
> > > +		kobject_put(kobj);
> > > +
> > >  	return retval;
> > >  }
> > >  EXPORT_SYMBOL_GPL(kobject_init_and_add);
> > 
> > I would _love_ to do this, but realize what a kobject really is.
> > 
> > It's just a "base object" that is embedded inside of some other object.
> > The kobject core has no idea what is going on outside of itself.  If the
> > kobject_init_and_add() function fails, it can NOT drop the last
> > reference on itself, as that would cause the memory owned by the _WHOLE_
> > structure the kobject is embedded in, to be freed.
> > 
> > And the kobject core can not "know" that something else needed to be
> > done _before_ that memory could be freed.  What if the larger structure
> > needs to have some other destructor called on it first?  What if
> > some other api initialization needs to be torn down.
> > 
> > As an example, consider this code:
> > 
> > struct foo {
> > 	struct kobject kobj;
> > 	struct baz *baz;
> > };
> > 
> > void foo_release(struct kobject *kobj)
> > {
> > 	struct foo *foo = container_of(kobj, struct foo, kobj);
> > 	kfree(foo);
> > }
> > 
> > struct kobj_type foo_ktype = {
> > 	.release = foo_release,
> > };
> > 
> > struct foo *foo_create(struct foo *parent, char *name)
> > {
> > 	struct *foo;
> > 
> > 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > 	if (!foo)
> > 		return NULL;
> > 
> > 	foo->baz = baz_create(name);
> > 	if (!foo->baz)
> > 		return NULL;
> > 
> > 	ret = kobject_init_and_add(&foo->kobj, foo_ktype, &parent->kobj, "foo-%s", name);
> > 	if (ret) {
> > 		baz_destroy(foo->baz);
> > 		kobject_put(&foo->kobj);
> > 		return NULL;
> > 	}
> > 
> > 	return foo;
> > }
> > 
> > void foo_destroy(struct foo *foo)
> > {
> > 	baz_destroy(foo->baz);
> > 	kobject_del(&foo->kobj);
> 	kojbect_put(&foo->kobj);
> > }
> 
> Does this need this extra call to kobject_put()?  Then foo_create()
> leaves foo with a refcount of 1 and foo_destroy drops that refcount.

Oops, no, I messed this up, it should _only_ be a call to
kobject_put(), kobject_del() is not needed here.

kobject_del() is for people who "really want to control the lifetime" of
a kobject.  All it does is remove the kobject from sysfs, and drop the
parent reference of the kobject, allowing the kobject to be "free" on
it's own.  Later a kobject_put() call must be called on it to really
clean it up.

If you just call kobject_put(), and this is the last reference,
kobject_del() will be correctly called for you by the kobject code, as
it "knows" this is time to clean up the sysfs entities.

A "normal" user should never have to call kobject_del().

thanks,

greg k-h
