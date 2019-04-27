Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD114C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 681A1206E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 23:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="fM3Tx9f1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J7iUHoiJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfD0XeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 19:34:20 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44295 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfD0XeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 19:34:19 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CB7852151C;
        Sat, 27 Apr 2019 19:34:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 27 Apr 2019 19:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qWM12uXninszgF84nCc464a48gG
        NExnPwHQbGNuCPkw=; b=fM3Tx9f1HTN+gBlhT6w4EW+mWr4x7C8biLxvjvaTm/3
        g0dxereB2uonmwEKHxbXR/uLXjkpPX3e3yNHD8s+7wAWNwRaaUBTk+5yrOkZkRHE
        qoQuoVziWZQoHi/yFTKsWGrXEPVtOXIQJC5L/LoQmq7/YpJx7hR6yBFoT/YsKCti
        54zuj+wpXbVctjPtgDTgQRLCwmReiUvHuaJoLyTUVT2JzArZh82s7TMz6BU/k3kp
        y+GQsEGOE5MraY8095pG9l7bLl19Ao2W9FojGH14/FlXJ6dgjKPZ4wiik0A+VG1x
        w9vnK6Nlv5Y3xgIcDnskW51voYJntqdqIViUQaMi9HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qWM12u
        XninszgF84nCc464a48gGNExnPwHQbGNuCPkw=; b=J7iUHoiJoVIdMn3stg3MY7
        Rm5bQbWMIYbpXFZbszpzLb9NUKT5tSLX9sKh9Wte6LNSFOTAG7xg/Lbu6rNPt1KX
        BzK6BiTgXjLyDocZzPbRiU83U4iuO0ZNPjhe88fdDHLHkUuDWXK+Kjpzbffk6vlp
        WcNM7NGiYsKmOMIGIXkLAxS0qlc/eBhEG7q/Cg3NZ03b+1oMlsr66LBCiTuGFAXC
        GlrOYQPH5aUgreENDB3h0jMLyOxTuI0H/hCEiSrSBSpiYKMOAocHyTELphpPf+dv
        nul6n7x1QT5/2/BXhEkfVg59mEcmr6WKuf4VWseDAUCbhlKFYb0U+FuzlVUpG3jg
        ==
X-ME-Sender: <xms:-ubEXIIA7AeTzseX5fbEATg2a1pk26wS735siJZ8UAfV1ZMXqlZZnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrheelgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddukedrvdduuddrvddttddrudeileenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:-ubEXIm5aq2PKcsoYDak0OY9lBkB0V9xRPdqKTGWB7Ru1DVD94PQBg>
    <xmx:-ubEXJYRdVrN07KYnZvAztjYDsvA6CcjqKGxZrFtnRAeMfV4kx__Kw>
    <xmx:-ubEXM8nuXPdl-Mu3WUaKJL4plr8fo1xisfh7kEvjBmK8HdL3zapWQ>
    <xmx:-ubEXOm2h1RI9bmR7cST4Uu-TlWqMB3h-bUQzXYd5KgbOyT_zWzjZg>
Received: from localhost (ppp118-211-200-169.bras1.syd2.internode.on.net [118.211.200.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id B25CD103D3;
        Sat, 27 Apr 2019 19:34:16 -0400 (EDT)
Date:   Sun, 28 Apr 2019 09:33:40 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: memleak around kobject_init_and_add()
Message-ID: <20190427233340.GB31148@eros.localdomain>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190427192809.GA8454@kroah.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 27, 2019 at 09:28:09PM +0200, Greg Kroah-Hartman wrote:
> On Sat, Apr 27, 2019 at 06:13:30PM +1000, Tobin C. Harding wrote:
> > (Note at bottom on reasons for 'To' list 'Cc' list)
> > 
> > Hi,
> > 
> > kobject_init_and_add() seems to be routinely misused.  A failed call to this
> > function requires a call to kobject_put() otherwise we leak memory.
> > 
> > Examples memleaks can be seen in:
> > 
> > 	mm/slub.c
> > 	fs/btrfs/sysfs.c
> > 	fs/xfs/xfs_sysfs.h: xfs_sysfs_init()
> > 
> >  Question: Do we fix the misuse or fix the API?
> 
> Fix the misuse.

Cool, I got it!

> > $ git grep kobject_init_and_add | wc -l
> > 117
> > 
> > Either way, we will have to go through all 117 call sites and check them.
> 
> Yes.  Same for other functions like device_add(), that is the "pattern"
> those users must follow.
> 
> > I
> > don't mind fixing them all but I don't want to do it twice because I chose the
> > wrong option.  Reaching out to those more experienced for a suggestion please.
> > 
> > Fix the API
> > -----------
> > 
> > Typically init functions do not require cleanup if they fail, this argument
> > leads to this patch
> > 
> > diff --git a/lib/kobject.c b/lib/kobject.c
> > index aa89edcd2b63..62328054bbd0 100644
> > --- a/lib/kobject.c
> > +++ b/lib/kobject.c
> > @@ -453,6 +453,9 @@ int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
> >  	retval = kobject_add_varg(kobj, parent, fmt, args);
> >  	va_end(args);
> >  
> > +	if (retval)
> > +		kobject_put(kobj);
> > +
> >  	return retval;
> >  }
> >  EXPORT_SYMBOL_GPL(kobject_init_and_add);
> 
> I would _love_ to do this, but realize what a kobject really is.
> 
> It's just a "base object" that is embedded inside of some other object.
> The kobject core has no idea what is going on outside of itself.  If the
> kobject_init_and_add() function fails, it can NOT drop the last
> reference on itself, as that would cause the memory owned by the _WHOLE_
> structure the kobject is embedded in, to be freed.
> 
> And the kobject core can not "know" that something else needed to be
> done _before_ that memory could be freed.  What if the larger structure
> needs to have some other destructor called on it first?  What if
> some other api initialization needs to be torn down.
> 
> As an example, consider this code:
> 
> struct foo {
> 	struct kobject kobj;
> 	struct baz *baz;
> };
> 
> void foo_release(struct kobject *kobj)
> {
> 	struct foo *foo = container_of(kobj, struct foo, kobj);
> 	kfree(foo);
> }
> 
> struct kobj_type foo_ktype = {
> 	.release = foo_release,
> };
> 
> struct foo *foo_create(struct foo *parent, char *name)
> {
> 	struct *foo;
> 
> 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> 	if (!foo)
> 		return NULL;
> 
> 	foo->baz = baz_create(name);
> 	if (!foo->baz)
> 		return NULL;
> 
> 	ret = kobject_init_and_add(&foo->kobj, foo_ktype, &parent->kobj, "foo-%s", name);
> 	if (ret) {
> 		baz_destroy(foo->baz);
> 		kobject_put(&foo->kobj);
> 		return NULL;
> 	}
> 
> 	return foo;
> }
> 
> void foo_destroy(struct foo *foo)
> {
> 	baz_destroy(foo->baz);
> 	kobject_del(&foo->kobj);
> }
> 
> Now if kobject_init_and_add() had failed, and called kobject_put() right
> away, that would have freed the larger "struct foo", but not cleaned up
> the reference to the baz pointer.
> 
> Yes, you can move all of the other destruction logic into the release
> function, to then get rid of baz, but that really doesn't work in the
> real world as there are times you want to drop that when you "know" you
> can drop it, not when the last reference goes away as those are
> different lifecycles.
> 
> Same thing goes for 'struct device'.  It too is a kobject, so think
> about if the driver core's call to initialize the kobject failed, would
> it be ok at that exact moment in time to free everything?
> 
> Look at the "joy" that is device_add().  If kobject_add() fails, we have
> to clean up the glue directory that we had created, _before_ we can then
> call put_device().  Then stack another layer on top of that, look at
> usb_new_device().  If the call to device_add() fails, it needs to do
> some housekeeping before it can drop the last reference to the device to
> free the memory up.

Thanks for the detailed response, unusual objects call for unusual
coding practices eh ;)

> > Fix all the call sites
> > ----------------------
> > 
> > Go through all 117 call sites and add kobj_put() in the error path.
> 
> Yes.
> 
> > This example from mm/slub.c
> > 
> > diff --git a/mm/slub.c b/mm/slub.c
> > index d30ede89f4a6..84a9d6c06c27 100644
> > --- a/mm/slub.c
> > +++ b/mm/slub.c
> > @@ -5756,8 +5756,10 @@ static int sysfs_slab_add(struct kmem_cache *s)
> >  
> >  	s->kobj.kset = kset;
> >  	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
> > -	if (err)
> > +	if (err) {
> > +		kobject_put(&s->kobj);
> >  		goto out;
> > +	}
> 
> Yup, it sucks, but unless you can think of a better way to do all of
> this, that's the requirement here.  Again, same thing for a call to
> device_add().  Another subsystem got burned by this just the other day
> and we added yet-another-line in the documentation trying to call it out
> explicitly.
> 
> Kernel programming is hard, sorry, let's go shopping...

lols, and good documentation is at times even harder than kernel
programming.

Thanks, patches to follow.


	Tobin.
