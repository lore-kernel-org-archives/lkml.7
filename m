Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1BEC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496892089E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="EzNYLkd3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IvaHd04W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEAV45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:56:57 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59501 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726137AbfEAV44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:56:56 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3CC0B514;
        Wed,  1 May 2019 17:56:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 01 May 2019 17:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=KSx46+0od7zYFYf4TPD9PRc6aSB
        MI50hqnUo753dPAU=; b=EzNYLkd3Xb9BP3/F0v5TphBf8Dr3N6A4VlM3iEPdNKp
        HrDjoG1KOSAM+mew12aPwDx3y9ya5D5+SsIQJMfKsYGsXS+FH/S8wSw59xWRMeLQ
        MHJtNDezeA3bdNiHsJFnzJIetdHOTbSeEjp7ZaSZ4ewQQIAnuZoP6aVCNvW2kTlH
        Qy+vplVDVV0EUc/2ROwhWAZwyMQjteTaQOvEibyIhH5nnfcxIGBMKWqwLQKIO7jL
        8MU1N4fHXGAB0hOR6+7t34jmwmQSaS1q3sTBOnsbeV8Fmc9Kx01XGtuysvLubxKR
        +UvQXLYZQ5c3xVcFU+ZMmnPQjyjCTQA4jpQWvn3iX6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=KSx46+
        0od7zYFYf4TPD9PRc6aSBMI50hqnUo753dPAU=; b=IvaHd04WVJMG3do4XQFHU/
        /tWqjB3Otq0Lw6Dyqa4AeKIGbc/Iq8Ce0vlZ4/RinRKdhcxfPgCh3T2U/g6Nkix9
        AHEQddkWMxCahaBGmoykmv6eGZ3hYOpGsnZ0CiWRXE55PSEo0fMEypRCyfRYlj25
        uWm5Wl8MuZTPLf6JrsUuHZg/AVLuH391As2oxWtfoefCylpQV6x6mQhYY5yeTLWX
        woS7zk8snHXpSN4/KI1IYyuq4t3ZDk6+9khv0H6ZyT4e6+u7hOZGIGZsJt5RGAtm
        AWYaBG1ooLzpK+wCT84JapKt4rEn1VbUfyri1rAduyepCBXZ8vnahBdtM5LlqBeA
        ==
X-ME-Sender: <xms:JhbKXBfOf5yxuTulHyMvb6GpLgU-zYV4o2egToaLJr3HXAHar2N1Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieejgdduieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvddtgedrvdefheenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:JhbKXGfWoCabpYBhbBZ1lWXF7mHTIWPed8remsJiykPHkT1SYZE5fA>
    <xmx:JhbKXKCYbxgOrPcGvIc734POmbx-T-6bnFCff0WSI-X9KD3GuIfLZA>
    <xmx:JhbKXEFEhSrn90JBXlVG5JJyS9qYFWQa5_NINdCqlwgR3ORbdgqxUw>
    <xmx:JhbKXCLRNsZkFj7NClHqr72HXCaDxvD7ma1GhPHh6HdIgXrdH09SNg>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5C6DE4382;
        Wed,  1 May 2019 17:56:52 -0400 (EDT)
Date:   Thu, 2 May 2019 07:56:16 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: memleak around kobject_init_and_add()
Message-ID: <20190501215616.GD18827@eros.localdomain>
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
> 
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
	kojbect_put(&foo->kobj);
> }

Does this need this extra call to kobject_put()?  Then foo_create()
leaves foo with a refcount of 1 and foo_destroy drops that refcount.

Thanks for taking the time to explain this stuff.

thanks
Tobin.


Leaving below for reference.

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
