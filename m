Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D04C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A9CC208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfGKGSA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:18:00 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:53143 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725963AbfGKGSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:18:00 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17214061-1500050 
        for multiple; Thu, 11 Jul 2019 07:17:55 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190710225720.58246f8e@oasis.local.home>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190614093914.58f41d8f@gandalf.local.home>
 <156052491337.7796.17642747687124632554@skylake-alporthouse-com>
 <20190614153837.GE538958@devbig004.ftw2.facebook.com>
 <20190710225720.58246f8e@oasis.local.home>
Message-ID: <156282587317.12280.11217721447100506162@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [BUG] lockdep splat with kernfs lockdep annotations and slab mutex from
 drm patch??
Date:   Thu, 11 Jul 2019 07:17:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt (2019-07-11 03:57:20)
> On Fri, 14 Jun 2019 08:38:37 -0700
> Tejun Heo <tj@kernel.org> wrote:
> 
> > Hello,
> > 
> > On Fri, Jun 14, 2019 at 04:08:33PM +0100, Chris Wilson wrote:
> > > #ifdef CONFIG_MEMCG
> > >         if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
> > >                 struct kmem_cache *c;
> > > 
> > >                 mutex_lock(&slab_mutex);
> > > 
> > > so it happens to hit the error + FULL case with the additional slabcaches?
> > > 
> > > Anyway, according to lockdep, it is dangerous to use the slab_mutex inside
> > > slab_attr_store().  
> > 
> > Didn't really look into the code but it looks like slab_mutex is held
> > while trying to remove sysfs files.  sysfs file removal flushes
> > on-going accesses, so if a file operation then tries to grab a mutex
> > which is held during removal, it leads to a deadlock.
> > 
> 
> Looks like this never got fixed and now this bug is in 5.2.

git blame gives

commit 107dab5c92d5f9c3afe962036e47c207363255c7
Author: Glauber Costa <glommer@parallels.com>
Date:   Tue Dec 18 14:23:05 2012 -0800

    slub: slub-specific propagation changes

for adding the mutex underneath sysfs read, and I think

commit d50d82faa0c964e31f7a946ba8aba7c715ca7ab0
Author: Mikulas Patocka <mpatocka@redhat.com>
Date:   Wed Jun 27 23:26:09 2018 -0700

    slub: fix failure when we delete and create a slab cache

added the sysfs removal underneath the slab_mutex.

> Just got this:
> 
>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.2.0-test #15 Not tainted
>  ------------------------------------------------------
>  slub_cpu_partia/899 is trying to acquire lock:
>  000000000f6f2dd7 (slab_mutex){+.+.}, at: slab_attr_store+0x6d/0xe0
>  
>  but task is already holding lock:
>  00000000b23ffe3d (kn->count#160){++++}, at: kernfs_fop_write+0x125/0x230
>  
>  which lock already depends on the new lock.
>  
>  
>  the existing dependency chain (in reverse order) is:
>  
>  -> #1 (kn->count#160){++++}:
>         __kernfs_remove+0x413/0x4a0
>         kernfs_remove_by_name_ns+0x40/0x80
>         sysfs_slab_add+0x1b5/0x2f0
>         __kmem_cache_create+0x511/0x560
>         create_cache+0xcd/0x1f0
>         kmem_cache_create_usercopy+0x18a/0x240
>         kmem_cache_create+0x12/0x20
>         is_active_nid+0xdb/0x230 [snd_hda_codec_generic]
>         snd_hda_get_path_idx+0x55/0x80 [snd_hda_codec_generic]
>         get_nid_path+0xc/0x170 [snd_hda_codec_generic]
>         do_one_initcall+0xa2/0x394
>         do_init_module+0xfd/0x370
>         load_module+0x38c6/0x3bd0
>         __do_sys_finit_module+0x11a/0x1b0
>         do_syscall_64+0x68/0x250
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>  
>  -> #0 (slab_mutex){+.+.}:
>         lock_acquire+0xbd/0x1d0
>         __mutex_lock+0xfc/0xb70
>         slab_attr_store+0x6d/0xe0
>         kernfs_fop_write+0x170/0x230
>         vfs_write+0xe1/0x240
>         ksys_write+0xba/0x150
>         do_syscall_64+0x68/0x250
>         entry_SYSCALL_64_after_hwframe+0x49/0xbe
>  
>  other info that might help us debug this:
>  
>   Possible unsafe locking scenario:
>  
>         CPU0                    CPU1
>         ----                    ----
>    lock(kn->count#160);
>                                 lock(slab_mutex);
>                                 lock(kn->count#160);
>    lock(slab_mutex);
>  
>   *** DEADLOCK ***
>  
> 
> 
> Attached is a config and the full dmesg.
> 
> -- Steve
> 
