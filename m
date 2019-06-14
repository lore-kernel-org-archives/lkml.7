Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94009C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B0A20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 15:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbfFNPIt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 11:08:49 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:58369 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725789AbfFNPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 11:08:49 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16904012-1500050 
        for multiple; Fri, 14 Jun 2019 16:08:35 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190614093914.58f41d8f@gandalf.local.home>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20190614093914.58f41d8f@gandalf.local.home>
Message-ID: <156052491337.7796.17642747687124632554@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [BUG] lockdep splat with kernfs lockdep annotations and slab mutex from
 drm patch??
Date:   Fri, 14 Jun 2019 16:08:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt (2019-06-14 14:39:14)
> I'm trying to debug some code where I need KASAN and lockdep enabled
> but I can't get past this splat unrelated to my code. I bisected it
> down to this commit:
> 
>  32eb6bcfdda9da ("drm/i915: Make request allocation caches global")
> 
> To make sure it wasn't a bad bisect, I removed the patch and the splat
> goes away. I add the patch back, and the splat returns. I did this
> several times, so I have a large confidence that this is the cause of
> the splat, or at least it is the commit that triggers whatever is going
> on.
> 
> Perhaps all the cache updates caused the slab_mutex to be called
> inverse of the kernfs locking?
> 
> Attached is my config.
> 
> Also might be helpful, the splat happens:
> 
>   kernfs_fop_write()
>     ops->write == sysfs_kf_write
>        sysfs_kf_write()
>          ops->store = slab_attr_store

More interestingly,

static ssize_t slab_attr_store(struct kobject *kobj,
                                struct attribute *attr,
                                const char *buf, size_t len)
{
        struct slab_attribute *attribute;
        struct kmem_cache *s;
        int err;

        attribute = to_slab_attr(attr);
        s = to_slab(kobj);

        if (!attribute->store)
                return -EIO;

        err = attribute->store(s, buf, len);
#ifdef CONFIG_MEMCG
        if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
                struct kmem_cache *c;

                mutex_lock(&slab_mutex);

so it happens to hit the error + FULL case with the additional slabcaches?

Anyway, according to lockdep, it is dangerous to use the slab_mutex inside
slab_attr_store().
-Chris
