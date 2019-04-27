Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EFEC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CD920881
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 19:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556393294;
	bh=N+wgyotBEWSPLh1zGvcUYGkmSs8huZNVyfYucpvbhJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V685EmbeFkvF3KVu719Alabj9hLdE9AvpyAxZ6v6jPp33+ig7eVb5jfAH+8i8GhLx
	 gxIH0xYTVVVKBTHC3Y/0vVkB+W+W7bQJnl/a/aqiaJUhKJ+jT0Z+nfrtRzCwoFRUlM
	 xFMkfCpKd6uL1eozcQ7XxkzdB+MxL7HHmpQArdcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfD0T2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 15:28:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfD0T2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 15:28:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9A92077B;
        Sat, 27 Apr 2019 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556393291;
        bh=N+wgyotBEWSPLh1zGvcUYGkmSs8huZNVyfYucpvbhJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTaZSuG/1GtM2+ZWDIoYFCA1BIRk9PchMjHiFIT+W/zKf2/Kg1n/bDqzXRVqX/w/w
         iCz+zCAEJ+LkTJNarfZXwFJ0wQ1WRUV3FisXSnCe4pT1tqMoetqCpPHtsUwxLnbovV
         1RWlBAG5w3Mi/rAvzGHONeJdetxB3GXTvgY5dn1Q=
Date:   Sat, 27 Apr 2019 21:28:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: memleak around kobject_init_and_add()
Message-ID: <20190427192809.GA8454@kroah.com>
References: <20190427081330.GA26788@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427081330.GA26788@eros.localdomain>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 06:13:30PM +1000, Tobin C. Harding wrote:
> (Note at bottom on reasons for 'To' list 'Cc' list)
> 
> Hi,
> 
> kobject_init_and_add() seems to be routinely misused.  A failed call to this
> function requires a call to kobject_put() otherwise we leak memory.
> 
> Examples memleaks can be seen in:
> 
> 	mm/slub.c
> 	fs/btrfs/sysfs.c
> 	fs/xfs/xfs_sysfs.h: xfs_sysfs_init()
> 
>  Question: Do we fix the misuse or fix the API?

Fix the misuse.

> $ git grep kobject_init_and_add | wc -l
> 117
> 
> Either way, we will have to go through all 117 call sites and check them.

Yes.  Same for other functions like device_add(), that is the "pattern"
those users must follow.

> I
> don't mind fixing them all but I don't want to do it twice because I chose the
> wrong option.  Reaching out to those more experienced for a suggestion please.
> 
> Fix the API
> -----------
> 
> Typically init functions do not require cleanup if they fail, this argument
> leads to this patch
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index aa89edcd2b63..62328054bbd0 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -453,6 +453,9 @@ int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
>  	retval = kobject_add_varg(kobj, parent, fmt, args);
>  	va_end(args);
>  
> +	if (retval)
> +		kobject_put(kobj);
> +
>  	return retval;
>  }
>  EXPORT_SYMBOL_GPL(kobject_init_and_add);

I would _love_ to do this, but realize what a kobject really is.

It's just a "base object" that is embedded inside of some other object.
The kobject core has no idea what is going on outside of itself.  If the
kobject_init_and_add() function fails, it can NOT drop the last
reference on itself, as that would cause the memory owned by the _WHOLE_
structure the kobject is embedded in, to be freed.

And the kobject core can not "know" that something else needed to be
done _before_ that memory could be freed.  What if the larger structure
needs to have some other destructor called on it first?  What if
some other api initialization needs to be torn down.

As an example, consider this code:

struct foo {
	struct kobject kobj;
	struct baz *baz;
};

void foo_release(struct kobject *kobj)
{
	struct foo *foo = container_of(kobj, struct foo, kobj);
	kfree(foo);
}

struct kobj_type foo_ktype = {
	.release = foo_release,
};

struct foo *foo_create(struct foo *parent, char *name)
{
	struct *foo;

	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
	if (!foo)
		return NULL;

	foo->baz = baz_create(name);
	if (!foo->baz)
		return NULL;

	ret = kobject_init_and_add(&foo->kobj, foo_ktype, &parent->kobj, "foo-%s", name);
	if (ret) {
		baz_destroy(foo->baz);
		kobject_put(&foo->kobj);
		return NULL;
	}

	return foo;
}

void foo_destroy(struct foo *foo)
{
	baz_destroy(foo->baz);
	kobject_del(&foo->kobj);
}

Now if kobject_init_and_add() had failed, and called kobject_put() right
away, that would have freed the larger "struct foo", but not cleaned up
the reference to the baz pointer.

Yes, you can move all of the other destruction logic into the release
function, to then get rid of baz, but that really doesn't work in the
real world as there are times you want to drop that when you "know" you
can drop it, not when the last reference goes away as those are
different lifecycles.

Same thing goes for 'struct device'.  It too is a kobject, so think
about if the driver core's call to initialize the kobject failed, would
it be ok at that exact moment in time to free everything?

Look at the "joy" that is device_add().  If kobject_add() fails, we have
to clean up the glue directory that we had created, _before_ we can then
call put_device().  Then stack another layer on top of that, look at
usb_new_device().  If the call to device_add() fails, it needs to do
some housekeeping before it can drop the last reference to the device to
free the memory up.

> Fix all the call sites
> ----------------------
> 
> Go through all 117 call sites and add kobj_put() in the error path.

Yes.

> This example from mm/slub.c
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d30ede89f4a6..84a9d6c06c27 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5756,8 +5756,10 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  
>  	s->kobj.kset = kset;
>  	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
> -	if (err)
> +	if (err) {
> +		kobject_put(&s->kobj);
>  		goto out;
> +	}

Yup, it sucks, but unless you can think of a better way to do all of
this, that's the requirement here.  Again, same thing for a call to
device_add().  Another subsystem got burned by this just the other day
and we added yet-another-line in the documentation trying to call it out
explicitly.

Kernel programming is hard, sorry, let's go shopping...

> This is a Saturday afternoon 'drinking some wine, hacking on the kernel'
> email.  Sending it to the lib/kobject.c maintainers for obvious
> reasons.  CC'd a few extra people who I thought might be interested to
> take the weight of Greg and Rafael :)

Pass me that wine, I think I need it after writing this email :)

thanks,

greg k-h
