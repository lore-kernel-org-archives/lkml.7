Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B46C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713A420644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 14:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uAmDYZgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfE2O1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 10:27:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46794 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbfE2O1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 10:27:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id m15so2638829ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 07:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=txpjRqYYOZS/ShrVU6bXWv+qUy5T0vwzzaHXMZH9BOU=;
        b=uAmDYZgjUx18rTghGSreZ2ScwAmCoyJOdnrFBi6ptsxhagi/ce47qucnOXUOM/Tyv+
         TRzShMAWLjojmNsQL/VjuaCPwtqj01laNNolm62wJ8wV8x7vCBKih4FMz28nW4mJXu67
         Vsz/C2cPu9g4hF7vy9dtNtzMK3nEXsFczuLjqVPN/uo9+oZejH/96fBwlEdgCsJO+tY4
         bzRgJqPX2b9VYVcZJoQ0P7cEzZJC3UHWKSBImlCPt+SZG1c5TE8Zh3wc8fWRKmR1hRKp
         FoB0pF4m/QVRpUKvjRDN6g3wAUT/DzgALpzbuuUn12Z6PjIRbSA8ZLdzFHuLgqR6Hn81
         tBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=txpjRqYYOZS/ShrVU6bXWv+qUy5T0vwzzaHXMZH9BOU=;
        b=m+n6TrlZN1XpxBpUtPNS38ws533gb+TAOjHMV3UQ/q2QlJ9QU+dWN9o1huyL2y6UsV
         Ijl6QrJmIPmmmMUuk52xfskIKwUiYizjwozuOlcT17+JEnFnDL/TwIlaIU3o6RZe49G1
         Uem2u/hj5Jr7tcQGK13f9hTIGyBep0oPy5zP7U4NIFo+p7cpQBIY5sCj+nuDileQRkNz
         pndqKszENLXs+dLZINLSAKd/O3pN73eE3Yo+YwI4MndY1CPpb6zWInRrCXhISFNLHVPb
         Kz0Jwv7owOgBhzgkwN2j/gI6giDQqaK633xdqdMtV6VtiL/6r8uf9vhZFhQd3OVtzrBP
         jMFQ==
X-Gm-Message-State: APjAAAVvZb5p2agHsNygt/pJQOBkFahzZybddDGdFhahGaIBWyp56uX0
        cW1gMiiA7SupwJdGn1a9JFwGrVMgzik=
X-Google-Smtp-Source: APXvYqy+KK61FLPg3ccG6ErfwW09hYPA1YPZRGlYX9JcVUajhRDTFh8WV3sCPQlsg2as8CG6+LAHPg==
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr59470737ljj.47.1559140038726;
        Wed, 29 May 2019 07:27:18 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id j10sm4069946lfc.45.2019.05.29.07.27.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 07:27:17 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 29 May 2019 16:27:15 +0200
To:     Roman Gushchin <guro@fb.com>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 2/4] mm/vmap: preload a CPU with one object for split
 purpose
Message-ID: <20190529142715.pxzrjthsthqudgh2@pc636>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-3-urezki@gmail.com>
 <20190528224217.GG27847@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528224217.GG27847@tower.DHCP.thefacebook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman!

> On Mon, May 27, 2019 at 11:38:40AM +0200, Uladzislau Rezki (Sony) wrote:
> > Refactor the NE_FIT_TYPE split case when it comes to an
> > allocation of one extra object. We need it in order to
> > build a remaining space.
> > 
> > Introduce ne_fit_preload()/ne_fit_preload_end() functions
> > for preloading one extra vmap_area object to ensure that
> > we have it available when fit type is NE_FIT_TYPE.
> > 
> > The preload is done per CPU in non-atomic context thus with
> > GFP_KERNEL allocation masks. More permissive parameters can
> > be beneficial for systems which are suffer from high memory
> > pressure or low memory condition.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 76 insertions(+), 3 deletions(-)
> 
> Hi Uladzislau!
> 
> This patch generally looks good to me (see some nits below),
> but it would be really great to add some motivation, e.g. numbers.
> 
The main goal of this patch to get rid of using GFP_NOWAIT since it is
more restricted due to allocation from atomic context. IMHO, if we can
avoid of using it that is a right way to go.

From the other hand, as i mentioned before i have not seen any issues
with that on all my test systems during big rework. But it could be
beneficial for tiny systems where we do not have any swap and are
limited in memory size.

> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index ea1b65fac599..b553047aa05b 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -364,6 +364,13 @@ static LIST_HEAD(free_vmap_area_list);
> >   */
> >  static struct rb_root free_vmap_area_root = RB_ROOT;
> >  
> > +/*
> > + * Preload a CPU with one object for "no edge" split case. The
> > + * aim is to get rid of allocations from the atomic context, thus
> > + * to use more permissive allocation masks.
> > + */
> > +static DEFINE_PER_CPU(struct vmap_area *, ne_fit_preload_node);
> > +
> >  static __always_inline unsigned long
> >  va_size(struct vmap_area *va)
> >  {
> > @@ -950,9 +957,24 @@ adjust_va_to_fit_type(struct vmap_area *va,
> >  		 *   L V  NVA  V R
> >  		 * |---|-------|---|
> >  		 */
> > -		lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> > -		if (unlikely(!lva))
> > -			return -1;
> > +		lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
> > +		if (unlikely(!lva)) {
> > +			/*
> > +			 * For percpu allocator we do not do any pre-allocation
> > +			 * and leave it as it is. The reason is it most likely
> > +			 * never ends up with NE_FIT_TYPE splitting. In case of
> > +			 * percpu allocations offsets and sizes are aligned to
> > +			 * fixed align request, i.e. RE_FIT_TYPE and FL_FIT_TYPE
> > +			 * are its main fitting cases.
> > +			 *
> > +			 * There are a few exceptions though, as an example it is
> > +			 * a first allocation (early boot up) when we have "one"
> > +			 * big free space that has to be split.
> > +			 */
> > +			lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
> > +			if (!lva)
> > +				return -1;
> > +		}
> >  
> >  		/*
> >  		 * Build the remainder.
> > @@ -1023,6 +1045,48 @@ __alloc_vmap_area(unsigned long size, unsigned long align,
> >  }
> >  
> >  /*
> > + * Preload this CPU with one extra vmap_area object to ensure
> > + * that we have it available when fit type of free area is
> > + * NE_FIT_TYPE.
> > + *
> > + * The preload is done in non-atomic context, thus it allows us
> > + * to use more permissive allocation masks to be more stable under
> > + * low memory condition and high memory pressure.
> > + *
> > + * If success it returns 1 with preemption disabled. In case
> > + * of error 0 is returned with preemption not disabled. Note it
> > + * has to be paired with ne_fit_preload_end().
> > + */
> > +static int
> 
> Cosmetic nit: you don't need a new line here.
> 
> > +ne_fit_preload(int nid)
> 
I can fix that.

> > +{
> > +	preempt_disable();
> > +
> > +	if (!__this_cpu_read(ne_fit_preload_node)) {
> > +		struct vmap_area *node;
> > +
> > +		preempt_enable();
> > +		node = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, nid);
> > +		if (node == NULL)
> > +			return 0;
> > +
> > +		preempt_disable();
> > +
> > +		if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, node))
> > +			kmem_cache_free(vmap_area_cachep, node);
> > +	}
> > +
> > +	return 1;
> > +}
> > +
> > +static void
> 
> Here too.
> 
> > +ne_fit_preload_end(int preloaded)
> > +{
> > +	if (preloaded)
> > +		preempt_enable();
> > +}
I can fix that.

> 
> I'd open code it. It's used only once, but hiding preempt_disable()
> behind a helper makes it harder to understand and easier to mess.
> 
> Then ne_fit_preload() might require disabled preemption (which it can
> temporarily re-enable), so that preempt_enable()/disable() logic
> will be in one place.
> 
I see your point. One of the aim was to make less clogged the
alloc_vmap_area() function. But we can refactor it like you say:

<snip>
 static void
@@ -1091,7 +1089,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
                                unsigned long vstart, unsigned long vend,
                                int node, gfp_t gfp_mask)
 {
-       struct vmap_area *va;
+       struct vmap_area *va, *pva;
        unsigned long addr;
        int purged = 0;
        int preloaded;
@@ -1122,16 +1120,26 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
         * Just proceed as it is. "overflow" path will refill
         * the cache we allocate from.
         */
-       ne_fit_preload(&preloaded);
+       preempt_disable();
+       if (!__this_cpu_read(ne_fit_preload_node)) {
+               preempt_enable();
+               pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
+               preempt_disable();
+
+               if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
+                       if (pva)
+                               kmem_cache_free(vmap_area_cachep, pva);
+               }
+       }
+
        spin_lock(&vmap_area_lock);
+       preempt_enable();
 
        /*
         * If an allocation fails, the "vend" address is
         * returned. Therefore trigger the overflow path.
         */
        addr = __alloc_vmap_area(size, align, vstart, vend);
-       ne_fit_preload_end(preloaded);
-
        if (unlikely(addr == vend))
                goto overflow;
<snip>

Do you mean something like that? If so, i can go with that, unless there are no
any objections from others.

Thank you for your comments, Roman!

--
Vlad Rezki
