Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B33C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02A220675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 08:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="WAaGpz9O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gm9r/FbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfEBIT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 04:19:57 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:38111 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725905AbfEBIT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 04:19:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C43F824313;
        Thu,  2 May 2019 04:19:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 02 May 2019 04:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=mkM5aQJWqSkC3eU/JlI26Sj/q1O
        0J2IG2bfNM7kDS3o=; b=WAaGpz9OGoYL4AsUVHtlWNmeCH1m2+ne+vWP7R0cXq4
        d+tK8WGAdnrIP8Y52yGIJ3XowaYfOFlJnPqCW1quJOAQqld1kTO37nDxjPbFqoNR
        fhKaiIZ7hbxdEqJ+yGo2SBTNY/x9pmU0OLOqTFJ8KfmlrNIC28iMJxLibFJN6a+Z
        R+x4otZkAaIcuYWGPJEaSsGaQuPL+YzFNC+0x+wgZbyDJoR4K/CTuZb+UYj++sfJ
        pZCJ4onlRERkti1SHnze1CSwog+9ytQM6ma42hpV8gwvuLx3A7t+HBhR6TxtMlis
        u3t3KFJeNkI3Cb0vVGq0fulARmg8s4qyhFJTJKXC61Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mkM5aQ
        JWqSkC3eU/JlI26Sj/q1O0J2IG2bfNM7kDS3o=; b=gm9r/FbUf1RqQWRhayxwvL
        RpnVJ6V1EqtjAUGtQzpGV6CkjNh+V0FRecwgA5RcJhAZxJvxZAFxxssgxK5OIgpX
        ftzUBZPz/b+mLG118FVe3FIeYOpC+EGA3T/vPQ1CVgHoLsDhSA8d04bv3onk7Y8N
        dsUTiNa/tEtA3FDH3Aac2Z7eN0aVIpC5ocJrgcwPzJ0djjyMvZbEEAkzVpBIMstn
        UAJ8F1erRhPP28jS+MOg1PjUzk618NsMO2NI4VxfznzUEmg6dMBEKhSwcO/1PKr4
        tFbRH1DaIraaqaTl8bkt3tgBywVZQbZx/Aogw3a2DmX43PNCh5jDmNNetYlT1NGw
        ==
X-ME-Sender: <xms:KqjKXBCfpd2YM7oZJd7aMu21moOxZIz0xDkSsFkaJ2UMHaSNGTN9ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieelgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttdertdfo
    redvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesthhosg
    hinhdrtggtqeenucfkphepuddvuddrgeegrddvtdegrddvfeehnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmvgesthhosghinhdrtggtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:K6jKXPr5NB1oFFNEIxxAfpZEPllE6S3r8gxK5RDI27B_YJcT4pDvNg>
    <xmx:K6jKXKZpc0HSZE6ZHEuGOySNK7TokJTQ4dvm9cm4MrpV801le8wqAw>
    <xmx:K6jKXABfDHy45ZcW9tklhsT2w6TIS_Qc-rzJQ-7SoHV9DUxZDS6bGQ>
    <xmx:K6jKXIcUAY3es7cXRI8he4PIO_YRSNHjgrXzk8aBwlrSmFPt6D3LxA>
Received: from localhost (ppp121-44-204-235.bras1.syd2.internode.on.net [121.44.204.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 30C34E4173;
        Thu,  2 May 2019 04:19:53 -0400 (EDT)
Date:   Thu, 2 May 2019 18:19:18 +1000
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, cl@linux.com,
        tycho@tycho.ws, willy@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: memleak around kobject_init_and_add()
Message-ID: <20190502081918.GA18363@eros.localdomain>
References: <20190427081330.GA26788@eros.localdomain>
 <20190427192809.GA8454@kroah.com>
 <20190501215616.GD18827@eros.localdomain>
 <20190502071742.GC16247@kroah.com>
 <20190502072808.GA14064@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502072808.GA14064@kroah.com>
X-Mailer: Mutt 1.11.4 (2019-03-13)
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 09:28:08AM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 02, 2019 at 09:17:42AM +0200, Greg Kroah-Hartman wrote:
> > On Thu, May 02, 2019 at 07:56:16AM +1000, Tobin C. Harding wrote:
> > > On Sat, Apr 27, 2019 at 09:28:09PM +0200, Greg Kroah-Hartman wrote:
> > > > On Sat, Apr 27, 2019 at 06:13:30PM +1000, Tobin C. Harding wrote:
> > > > > (Note at bottom on reasons for 'To' list 'Cc' list)
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > kobject_init_and_add() seems to be routinely misused.  A failed call to this
> > > > > function requires a call to kobject_put() otherwise we leak memory.
> > > > > 
> > > > > Examples memleaks can be seen in:
> > > > > 
> > > > > 	mm/slub.c
> > > > > 	fs/btrfs/sysfs.c
> > > > > 	fs/xfs/xfs_sysfs.h: xfs_sysfs_init()
> > > > > 
> > > > >  Question: Do we fix the misuse or fix the API?
> > > > 
> > > > Fix the misuse.
> > > > 
> > > > > $ git grep kobject_init_and_add | wc -l
> > > > > 117
> > > > > 
> > > > > Either way, we will have to go through all 117 call sites and check them.
> > > > 
> > > > Yes.  Same for other functions like device_add(), that is the "pattern"
> > > > those users must follow.
> > > > 
> > > > > I
> > > > > don't mind fixing them all but I don't want to do it twice because I chose the
> > > > > wrong option.  Reaching out to those more experienced for a suggestion please.
> > > > > 
> > > > > Fix the API
> > > > > -----------
> > > > > 
> > > > > Typically init functions do not require cleanup if they fail, this argument
> > > > > leads to this patch
> > > > > 
> > > > > diff --git a/lib/kobject.c b/lib/kobject.c
> > > > > index aa89edcd2b63..62328054bbd0 100644
> > > > > --- a/lib/kobject.c
> > > > > +++ b/lib/kobject.c
> > > > > @@ -453,6 +453,9 @@ int kobject_init_and_add(struct kobject *kobj, struct kobj_type *ktype,
> > > > >  	retval = kobject_add_varg(kobj, parent, fmt, args);
> > > > >  	va_end(args);
> > > > >  
> > > > > +	if (retval)
> > > > > +		kobject_put(kobj);
> > > > > +
> > > > >  	return retval;
> > > > >  }
> > > > >  EXPORT_SYMBOL_GPL(kobject_init_and_add);
> > > > 
> > > > I would _love_ to do this, but realize what a kobject really is.
> > > > 
> > > > It's just a "base object" that is embedded inside of some other object.
> > > > The kobject core has no idea what is going on outside of itself.  If the
> > > > kobject_init_and_add() function fails, it can NOT drop the last
> > > > reference on itself, as that would cause the memory owned by the _WHOLE_
> > > > structure the kobject is embedded in, to be freed.
> > > > 
> > > > And the kobject core can not "know" that something else needed to be
> > > > done _before_ that memory could be freed.  What if the larger structure
> > > > needs to have some other destructor called on it first?  What if
> > > > some other api initialization needs to be torn down.
> > > > 
> > > > As an example, consider this code:
> > > > 
> > > > struct foo {
> > > > 	struct kobject kobj;
> > > > 	struct baz *baz;
> > > > };
> > > > 
> > > > void foo_release(struct kobject *kobj)
> > > > {
> > > > 	struct foo *foo = container_of(kobj, struct foo, kobj);
> > > > 	kfree(foo);
> > > > }
> > > > 
> > > > struct kobj_type foo_ktype = {
> > > > 	.release = foo_release,
> > > > };
> > > > 
> > > > struct foo *foo_create(struct foo *parent, char *name)
> > > > {
> > > > 	struct *foo;
> > > > 
> > > > 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
> > > > 	if (!foo)
> > > > 		return NULL;
> > > > 
> > > > 	foo->baz = baz_create(name);
> > > > 	if (!foo->baz)
> > > > 		return NULL;
> > > > 
> > > > 	ret = kobject_init_and_add(&foo->kobj, foo_ktype, &parent->kobj, "foo-%s", name);
> > > > 	if (ret) {
> > > > 		baz_destroy(foo->baz);
> > > > 		kobject_put(&foo->kobj);
> > > > 		return NULL;
> > > > 	}
> > > > 
> > > > 	return foo;
> > > > }
> > > > 
> > > > void foo_destroy(struct foo *foo)
> > > > {
> > > > 	baz_destroy(foo->baz);
> > > > 	kobject_del(&foo->kobj);
> > > 	kojbect_put(&foo->kobj);
> > > > }
> > > 
> > > Does this need this extra call to kobject_put()?  Then foo_create()
> > > leaves foo with a refcount of 1 and foo_destroy drops that refcount.
> > 
> > Oops, no, I messed this up, it should _only_ be a call to
> > kobject_put(), kobject_del() is not needed here.
> > 
> > kobject_del() is for people who "really want to control the lifetime" of
> > a kobject.  All it does is remove the kobject from sysfs, and drop the
> > parent reference of the kobject, allowing the kobject to be "free" on
> > it's own.  Later a kobject_put() call must be called on it to really
> > clean it up.
> > 
> > If you just call kobject_put(), and this is the last reference,
> > kobject_del() will be correctly called for you by the kobject code, as
> > it "knows" this is time to clean up the sysfs entities.
> > 
> > A "normal" user should never have to call kobject_del().
> 
> Which means your other patch about the kerneldoc for that function is
> also not correct, I'll go fix that up now...

lols all around with this one :)  Who knew reference counting could get
so knotty

Cheers,
Tobin.
