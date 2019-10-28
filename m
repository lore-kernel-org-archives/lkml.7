Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3605CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7352054F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 07:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="A72Ecndl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733001AbfJ1HjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:39:11 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42554 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfJ1HjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 03:39:11 -0400
Received: by mail-pg1-f196.google.com with SMTP id f14so6320273pgi.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=W6KtXbeNB73L7K8HlIwOcgcuJ+P24gHi6K3WdunG+G4=;
        b=A72Ecndl1uDlUulcxZtsu13muErR/lU5GxMGHazyGJDJCYl+cgN1yTFGpnQzGc3R0F
         B/FLvXZQWadeofbZ8s52iQfdFNSfE6qYpH0D+mLFs2pTSZDRhHIlqrbiU8ILpQI83jCI
         KeS+8zZ1ooWV3mRoXdkA1MYHF9YYpcj6CaWCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=W6KtXbeNB73L7K8HlIwOcgcuJ+P24gHi6K3WdunG+G4=;
        b=IF6VhMD7r4PKkvURRBBXIuoBn3JHFHgDs2U5LQ6u/OHlj+CdOxNyqamcCrxjxqVvRJ
         80cQ1Ju65nk9DqMhO78rrOcsTzN5c7VX1XQdEslg6o7sT8qnomfM5XEaatt1SwzocU3U
         lpstCdnBggiVJIyYzzzyxytSW31B3hoxv98YXCDnJKpRzYl0XWYxGVg3VeDYwdBzDQh6
         w5wv20/srTzH2fsalwDK5ODDmGn3HDzqMXoJhDsDMuvy9mPoIqxq1C5P3F2Lx5bUqd49
         5cQDL+eSS9OpR1Av8ov2mGYUk/bzl4E/7xKcLS9uyaeyHyA4SKNgrGcnfZBDkBiCIsoY
         efIg==
X-Gm-Message-State: APjAAAWMEvC0LfU4ZhAsrc+rg+XJ4wlNbbhblwBgsZALq0iCirfFUTkp
        EXsGsXUzjuWWZOKQjJvr9dZZzQ==
X-Google-Smtp-Source: APXvYqyJgdsMELh5YzfO9lfXAMmWDjSS5OoSyz3S8TTPvQ3C5awf1OmXS2S6lTk7CB3OzUGg7Lpvjw==
X-Received: by 2002:a62:e312:: with SMTP id g18mr535124pfh.250.1572248349944;
        Mon, 28 Oct 2019 00:39:09 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id 184sm10426925pfu.58.2019.10.28.00.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 00:39:09 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org, x86@kernel.org,
        glider@google.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        dvyukov@google.com, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, gor@linux.ibm.com
Subject: Re: [PATCH v8 1/5] kasan: support backing vmalloc space with real shadow memory
In-Reply-To: <95c87ba1-9c15-43fb-dba7-f3ecd01be8e0@virtuozzo.com>
References: <20191001065834.8880-1-dja@axtens.net> <20191001065834.8880-2-dja@axtens.net> <352cb4fa-2e57-7e3b-23af-898e113bbe22@virtuozzo.com> <87ftjvtoo7.fsf@dja-thinkpad.axtens.net> <8f573b40-3a5a-ed36-dffb-4a54faf3c4e1@virtuozzo.com> <20191016132233.GA46264@lakrids.cambridge.arm.com> <95c87ba1-9c15-43fb-dba7-f3ecd01be8e0@virtuozzo.com>
Date:   Mon, 28 Oct 2019 18:39:04 +1100
Message-ID: <87blu18gkn.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Or let me put it this way. Let's assume that CPU0 accesses shadow and CPU1 did the memset() and installed pte.
> CPU0 may not observe memset() only if it dereferences completely random vmalloc addresses
> or it performs out-of-bounds access which crosses KASAN_SHADOW_SCALE*PAGE_SIZE boundary, i.e. access to shadow crosses page boundary.
> In both cases it will be hard to avoid crashes. OOB crossing the page boundary in vmalloc pretty much guarantees crash because of guard page,
> and derefencing random address isn't going to last for long.
>
> If CPU0 obtained pointer via vmalloc() call and it's doing out-of-bounds (within boundaries of the page) or use-after-free,
> than the spin_[un]lock(&init_mm.page_table_lock) should allow CPU0 to see the memset done by CPU1 without any additional barrier.


I have puzzled through the barrier stuff. Here's what I
have. Apologies for the length, and for any mistakes - I'm pretty new
to deep kernel memory model stuff!

One thing that I don't think we've considered so far is _un_poisioning:


|	ret = apply_to_page_range(&init_mm, shadow_start,
|				  shadow_end - shadow_start,
|				  kasan_populate_vmalloc_pte, NULL);
|	if (ret)
|		return ret;
|
|	kasan_unpoison_shadow(area->addr, requested_size);

That unpoisioning is going to write to the shadow via its virtual
address, loading translations into the TLB. So we cannot assume that
another CPU is doing the page table walk and loading the TLB entry for
the first time. We need to make sure that correctness does not depend
on that.

We have 2x2 cases to consider:

{Access via fixed address, access via unknown address}
x
{Access within object - unpoisioned, access just beyond object but
within shadow - poisoned}

I think we can first drop all consideration of access via fixed
addresses. Such accesses will have to be synchronised via some
external mechanism, such as a flag, with appropriate
locking/barriers. Those barriers will order the rest of the memory
accesses within vmalloc(), and I considered speculative faults in my
other email.

That leaves just memory accesses via an unknown address. I'm imagining
the following two cases:

[Access of Unpoisoned Shadow - valid access]

CPU#0                                   CPU#1
-----                                   -----
WRITE_ONCE(p, vmalloc(100))             while (!(x = READ_ONCE(p))) ;
                                        x[99] = 1;

[Access of Poisoned Shadow - invalid read past the end]

CPU#0                                   CPU#1
-----                                   -----
WRITE_ONCE(p, vmalloc(100))             while (!(x = READ_ONCE(p))) ;
                                        x[100] = 1;


---------- Access to the unpoisioned region of shadow ----------

Expanding the CPU#0 side, let `a` be area->addr:

// kasan_populate_vmalloc_pte
...
STORE page+PAGE_SIZE-1, poison
// Mark's proposed smp_wmb() goes here
ACQUIRE page_table_lock
STORE ptep, pte
RELEASE page_table_lock
// return to kasan_populate_vmalloc
// call kasan_unpoison_shadow(a, 100)
STORE shadow(a), unpoison
...
STORE shadow(a+99), unpoison
// rest of vmalloc()
STORE p, a


CPU#1 looks like (removing the loop bit):

x = LOAD p
<data dependency>
shadow_x = LOAD *shadow(x+99)
// if shadow_x poisoned, report
STORE (x+99), 1

Putting the last few operations side-by-side:

CPU#0                                    CPU#1
 STORE shadow(a+99), unpoision           x = LOAD p
                                         <data dependency>
 STORE p, a                              shadow_x = LOAD shadow(x+99)


While there is a data dependency between x and shadow_x, there's no
barrier in kasan_populate_vmalloc() that forces the _un_poisoning to
be correctly ordered.

My worry would be that CPU#0 might commit the store to p before it
commits the store to the shadow. Then, even with the data dependency,
CPU#1 could observe store to shadow(a+99) after it executed the load
of shadow(x+99). This would lead CPU#1 to observe a false-positive
poison.

We need a write barrier, and Mark's proposed smp_wmb() is too early to
help here.

Now, there is an smp_wmb() in clear_vm_uninitialized_flag(), which is
called by __vmalloc_node_range between kasan_populate_vmalloc and the
end of the function. That makes things look like this:

  CPU#0                                   CPU#1
STORE shadow(a+99), unpoision           x = LOAD p
smp_wmb()                               <data dependency>
STORE p, a                              shadow_x = LOAD shadow(x+99)

memory-barriers.txt says that a data dependency and a write barrier
are sufficient to order this correctly.

Outside of __vmalloc_node_range(), the other times we call
kasan_populate_vmalloc() are:

 - get_vm_area() and friends. get_vm_area does not mapping any pages
   into the area returned. So the caller will have to do that, which
   will require taking the page table lock. A release should pair with
   a data dependency, making the unpoisoning visible.

 - The per_cpu allocator: again the caller has to map pages into the
   area returned - pcpu_map_pages calls map_kernel_range_noflush.

So, where the address is not known in advance, the unpoisioning does
need a barrier. However, we do hit one anyway before we return. We
should document that we're relying on the barrier in
clear_vm_uninitialized_flag() or barriers from other callers.

---------- Access to the poisioned region of shadow ----------

Now, what about the case that we do an overread that's still in the
shadow page?

CPU#0                                    CPU#1
 STORE page+100, poison
 ...
 # Mark's proposed smp_wmb()
 ACQUIRE page_table_lock
 STORE ptep, pte
 RELEASE page_table_lock
 ...
 STORE shadow(a+99), unpoision           x = LOAD p
 smp_wmb()                               <data dependency>
 STORE p, a                              shadow_x = LOAD shadow(x+100)


Here, because of both the release and the smp_wmb(), the store of the
poison will be safe. Because we're not expecting anything funky with
fixed addresses or other CPUs doing page-table walks, I still think we
don't need an extra barrier where Mark has proposed.

-------------------- Conclusion --------------------

I will send a v10 that:

 - drops the smp_wmb() for poisoning
 
 - adds a comment that explains that we're dependent on later barriers
   for _un_poisioning

I'd really like to get this into the coming merge window, if at all
possible.

Regards,
Daniel
