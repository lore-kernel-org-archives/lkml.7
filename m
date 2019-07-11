Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB2CBC742A2
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BA5208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 21:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9PwpYMa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbfGKVWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 17:22:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44899 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfGKVWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 17:22:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id t16so3318667pfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2019 14:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ll8NrHguXOqSbOpxMM5XmQWOR4BFFXXFhQrd5rYx/Xk=;
        b=C9PwpYMaU9nVnH3nEjptn59gQLUrcOKCxfNMsY8XTuu9ttCZx7aRAOEHY7h1SQW4s2
         tw4XozBpC/BRtjZAQltp+ICrnkKdPNBW9ZSZeKJczjFxavyxAimNnFXa0fqSw4s//rBe
         vjca8wK1Fs0iUswUWyHaSEcy5ZKljnQclicZ3JsLPA+Md9+CJqzqF8XncAHitOiUll/Z
         nGi/M8F4Bs3N0oJ82RN5dcn52F4Unh59YdWtHx83yUCqryESf5zS+sK+DIKNUt1RNl4B
         c5E+mqlcxYon91Rn/QKsJSNP+vTIYnRc9D+A43HI9quZrC7JXAuSiNAxuEIl3Kw6L3Zm
         xoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ll8NrHguXOqSbOpxMM5XmQWOR4BFFXXFhQrd5rYx/Xk=;
        b=cmh2fCrSHS+ZBgdfAxVu/NePZxyZvkwP/k+DtJCOEGwyxDCd4yf0QOhRDSDxNSSBuN
         5rKn6ppSwpTaaLV8BQ5XyWeheKRZ5/kBJ7PF2i8RyJHS1WGGxizvnuOQbs6z+nobLct1
         /4yNELnK2hDKUzIZqZnSOeHohlMQHSa6MuQb2xp7YVw6AcNN4sUeefoMc7stB3Awvbkt
         vXJ15GF1W/bOs5E7k0jWUWau6Rv9xogb/y+XiTF182dK5xUyDh370OCjzdyTABLyJMJ+
         N0KL0bbL3RNPrTgiYT+3SYWE96FjePIEi0fFPizFeQxs6R1MU/TMjpyhiM7BgavwtQMt
         5Cig==
X-Gm-Message-State: APjAAAWXZUsm/o3vfLZlITnyZSSOnd6X7eZqmDQxfFrm/yV1FveMAJKY
        au3wvhkYLa0GxyI/9ACjkRzruw==
X-Google-Smtp-Source: APXvYqypuSeNyb69Dk1JO7kRPzoyRnBwWoCoeZNmZn0wdvSjTCngSTAW9y6Wh2k0x/7KmWf40re8Ww==
X-Received: by 2002:a17:90a:d998:: with SMTP id d24mr7113307pjv.89.1562880139069;
        Thu, 11 Jul 2019 14:22:19 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i3sm7186454pfo.138.2019.07.11.14.22.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 11 Jul 2019 14:22:18 -0700 (PDT)
Date:   Thu, 11 Jul 2019 14:22:17 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Chris Wilson <chris@chris-wilson.co.uk>
cc:     Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] lockdep splat with kernfs lockdep annotations and slab
 mutex from drm patch??
In-Reply-To: <156282587317.12280.11217721447100506162@skylake-alporthouse-com>
Message-ID: <alpine.DEB.2.21.1907111419120.157247@chino.kir.corp.google.com>
References: <20190614093914.58f41d8f@gandalf.local.home> <156052491337.7796.17642747687124632554@skylake-alporthouse-com> <20190614153837.GE538958@devbig004.ftw2.facebook.com> <20190710225720.58246f8e@oasis.local.home>
 <156282587317.12280.11217721447100506162@skylake-alporthouse-com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jul 2019, Chris Wilson wrote:

> Quoting Steven Rostedt (2019-07-11 03:57:20)
> > On Fri, 14 Jun 2019 08:38:37 -0700
> > Tejun Heo <tj@kernel.org> wrote:
> > 
> > > Hello,
> > > 
> > > On Fri, Jun 14, 2019 at 04:08:33PM +0100, Chris Wilson wrote:
> > > > #ifdef CONFIG_MEMCG
> > > >         if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
> > > >                 struct kmem_cache *c;
> > > > 
> > > >                 mutex_lock(&slab_mutex);
> > > > 
> > > > so it happens to hit the error + FULL case with the additional slabcaches?
> > > > 
> > > > Anyway, according to lockdep, it is dangerous to use the slab_mutex inside
> > > > slab_attr_store().  
> > > 
> > > Didn't really look into the code but it looks like slab_mutex is held
> > > while trying to remove sysfs files.  sysfs file removal flushes
> > > on-going accesses, so if a file operation then tries to grab a mutex
> > > which is held during removal, it leads to a deadlock.
> > > 
> > 
> > Looks like this never got fixed and now this bug is in 5.2.
> 
> git blame gives
> 
> commit 107dab5c92d5f9c3afe962036e47c207363255c7
> Author: Glauber Costa <glommer@parallels.com>
> Date:   Tue Dec 18 14:23:05 2012 -0800
> 
>     slub: slub-specific propagation changes
> 
> for adding the mutex underneath sysfs read, and I think
> 
> commit d50d82faa0c964e31f7a946ba8aba7c715ca7ab0
> Author: Mikulas Patocka <mpatocka@redhat.com>
> Date:   Wed Jun 27 23:26:09 2018 -0700
> 
>     slub: fix failure when we delete and create a slab cache
> 
> added the sysfs removal underneath the slab_mutex.
> 
> > Just got this:
> > 
> >  ======================================================
> >  WARNING: possible circular locking dependency detected
> >  5.2.0-test #15 Not tainted
> >  ------------------------------------------------------
> >  slub_cpu_partia/899 is trying to acquire lock:
> >  000000000f6f2dd7 (slab_mutex){+.+.}, at: slab_attr_store+0x6d/0xe0
> >  
> >  but task is already holding lock:
> >  00000000b23ffe3d (kn->count#160){++++}, at: kernfs_fop_write+0x125/0x230
> >  
> >  which lock already depends on the new lock.
> >  
> >  
> >  the existing dependency chain (in reverse order) is:
> >  
> >  -> #1 (kn->count#160){++++}:
> >         __kernfs_remove+0x413/0x4a0
> >         kernfs_remove_by_name_ns+0x40/0x80
> >         sysfs_slab_add+0x1b5/0x2f0
> >         __kmem_cache_create+0x511/0x560
> >         create_cache+0xcd/0x1f0
> >         kmem_cache_create_usercopy+0x18a/0x240
> >         kmem_cache_create+0x12/0x20
> >         is_active_nid+0xdb/0x230 [snd_hda_codec_generic]
> >         snd_hda_get_path_idx+0x55/0x80 [snd_hda_codec_generic]
> >         get_nid_path+0xc/0x170 [snd_hda_codec_generic]
> >         do_one_initcall+0xa2/0x394
> >         do_init_module+0xfd/0x370
> >         load_module+0x38c6/0x3bd0
> >         __do_sys_finit_module+0x11a/0x1b0
> >         do_syscall_64+0x68/0x250
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >  

Which slab cache is getting created here?  I assume that sysfs_slab_add() 
is only trying to do kernfs_remove_by_name_ns() becasue its unmergeable 
with other slab caches.

> >  -> #0 (slab_mutex){+.+.}:
> >         lock_acquire+0xbd/0x1d0
> >         __mutex_lock+0xfc/0xb70
> >         slab_attr_store+0x6d/0xe0
> >         kernfs_fop_write+0x170/0x230
> >         vfs_write+0xe1/0x240
> >         ksys_write+0xba/0x150
> >         do_syscall_64+0x68/0x250
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> >  
> >  other info that might help us debug this:
> >  
> >   Possible unsafe locking scenario:
> >  
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(kn->count#160);
> >                                 lock(slab_mutex);
> >                                 lock(kn->count#160);
> >    lock(slab_mutex);
> >  
> >   *** DEADLOCK ***
> >  
