Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CFAC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB2AA2070B
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRmn0YNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfFIMK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:10:57 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37663 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfFIMK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:10:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id 131so5466208ljf.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MGnWlXcEZlsDllQ1p+dLiYMxOQG545jMz4NgSBC9Y94=;
        b=nRmn0YNw8W+QR/WXpFQLQvxWieu7tL/WNi0q3+UMLXv1nXW9gwzTkCv8SY1aRpJeat
         ilJLCQYmFDEiyA3lldq0wUtt9f85fPZGz+jdQ/hHsk01cnqc6AUXcRN1GNDaWLJV14jX
         ngoF5Y2eJ4ywcfSSrZxnYcfyh8zCFxI53rHruVBiZnb1KSQtkRgLJIGZ6DOctY72Hm8S
         5TbducFcWoCXLn2GTEd21oqtCp0N4r2+WEB+zmjhox+Yi53x81DvSYRbVf4NWSZqbe/P
         0aiDUGPE3KavdxykFJkQrksAtAEmmw5rxLRm30FYIRBidXHsQ1OR0t18qhaGuetsxAZY
         TQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MGnWlXcEZlsDllQ1p+dLiYMxOQG545jMz4NgSBC9Y94=;
        b=drz2dYTJX/XoMr0xFxwQ2T21XmTnPlf6wqbQFpl7svaIhyrhq6brw1gjxnGMU7imgc
         HLThBODfAzH/Ibll7sGn4J90ge4BpeXVbQ1FHLz8SyrVb/y+oZjP9I2AtKiGMibw0SHk
         Rfrbh9HyXnufalQNhOZoJfETsKyScZobjqwsN7Cjykkum2GcyI6Lmrbf1kN5yGfqN8DI
         UqrwPFk2AbhgbfiyE9gKfsTmLhGPXodK0UHf4ywZX2hmeOVi+5qgnYuG7CLZABfhgZKc
         RYnsM51Nf3HHE21PBAW/Lo08wQoTqnABGD1ujizRS4xcGthMjAVIOE/BaEFwiQfeyzK7
         iykw==
X-Gm-Message-State: APjAAAVYRn4vJIozbzsB9JEOG+XTAytCppg4pGfOChda/J68PkX03eSn
        0k/Wg+p0sFs/qlUS08+e9T4=
X-Google-Smtp-Source: APXvYqyrmwbev/kM38jFwPiKr2yUx7kn6QEzpscG18zuD1wOeoyI47i1pIxOyWt6Uu8NLD0OnZFBrg==
X-Received: by 2002:a2e:9692:: with SMTP id q18mr34382352lji.89.1560082255174;
        Sun, 09 Jun 2019 05:10:55 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id t3sm1423097lfk.59.2019.06.09.05.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 05:10:54 -0700 (PDT)
Date:   Sun, 9 Jun 2019 15:10:52 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 01/10] mm: add missing smp read barrier on getting
 memcg kmem_cache pointer
Message-ID: <20190609121052.kge3w3hv3t5u5bb3@esperanza>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-2-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:45PM -0700, Roman Gushchin wrote:
> Johannes noticed that reading the memcg kmem_cache pointer in
> cache_from_memcg_idx() is performed using READ_ONCE() macro,
> which doesn't implement a SMP barrier, which is required
> by the logic.
> 
> Add a proper smp_rmb() to be paired with smp_wmb() in
> memcg_create_kmem_cache().
> 
> The same applies to memcg_create_kmem_cache() itself,
> which reads the same value without barriers and READ_ONCE().
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/slab.h        | 1 +
>  mm/slab_common.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 739099af6cbb..1176b61bb8fc 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -260,6 +260,7 @@ cache_from_memcg_idx(struct kmem_cache *s, int idx)
>  	 * memcg_caches issues a write barrier to match this (see
>  	 * memcg_create_kmem_cache()).
>  	 */
> +	smp_rmb();
>  	cachep = READ_ONCE(arr->entries[idx]);

Hmm, we used to have lockless_dereference() here, but it was replaced
with READ_ONCE some time ago. The commit message claims that READ_ONCE
has an implicit read barrier in it.

commit 506458efaf153c1ea480591c5602a5a3ba5a3b76
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue Oct 24 11:22:48 2017 +0100

    locking/barriers: Convert users of lockless_dereference() to READ_ONCE()

    READ_ONCE() now has an implicit smp_read_barrier_depends() call, so it
    can be used instead of lockless_dereference() without any change in
    semantics.

    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Link: http://lkml.kernel.org/r/1508840570-22169-4-git-send-email-will.deacon@arm.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

commit 76ebbe78f7390aee075a7f3768af197ded1bdfbb
Author: Will Deacon <will.deacon@arm.com>
Date:   Tue Oct 24 11:22:47 2017 +0100

    locking/barriers: Add implicit smp_read_barrier_depends() to READ_ONCE()

    In preparation for the removal of lockless_dereference(), which is the
    same as READ_ONCE() on all architectures other than Alpha, add an
    implicit smp_read_barrier_depends() to READ_ONCE() so that it can be
    used to head dependency chains on all architectures.

    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Thomas Gleixner <tglx@linutronix.de>
    Link: http://lkml.kernel.org/r/1508840570-22169-3-git-send-email-will.deacon@arm.com
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
