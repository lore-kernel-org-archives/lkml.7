Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A5AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D011208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 00:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XsReatup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbfHOAKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 20:10:02 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37146 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfHOAKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 20:10:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id y26so662955qto.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 17:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SjWxEd5trWQnubGgd93z8JQghkn2ieuomaNUqpFunr8=;
        b=XsReatupBTmqJdBQODBjcynGCD+EFRZj1C84UwqKxIHDJry1koHSXZhFLNthqLNrdI
         sJvO2xr4Yf8efKKyOEPzz7lmm+x5GdcACC+54eKm4Ge4AB3iU9YvjJ+GUY28eyC1XgX1
         yHn7fdbhBHZEjgohLQ+eJwsIhykXJmXNP4Ad2fzIbW68tY8NtCAmf+n/uw1CrUSltNtz
         Di2z0LFvJ3NxwlbScerLC+k3cfD1cixFWpONt/9P09Wv9Gezy+22yPiI3marKmyMBzcg
         UiogqqKUE89OdisyiimkZeCXTgAaWaEz0svYJBDgWT9nFweVWM05nK9xTUKar+rpAnbC
         nO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SjWxEd5trWQnubGgd93z8JQghkn2ieuomaNUqpFunr8=;
        b=N/ADRpBcB89SOeuK+L3fMxUGXJo1haKY/JONCx6FsmllzXuM7s53prVUbE9Womjhkx
         BxLRb3/ptop0IUvpSto+5GQCNFfe607t42I4fU5WTfw8F32xA/6p/nLCfkPaP29bhRnL
         EfvC8yUGOPpKow9uDXsMh7dx+GeCZT7giYi9jn6gtgu/JQ9KcGOamyqN4E9fykNa2P2O
         uDd8Kb0IGTjet4Dq5K0rc5FctUuSwkNyLWoKqAG23GH1bd6eW4sw4MiVMGP0+2ukDP2s
         IqLG3LEEOulLf27QJ3SvZ1R7MQ8GsE6TMQJJ4CB7KtI4VyX9PhDKvdZy+ApQWfmTdWr6
         cUBw==
X-Gm-Message-State: APjAAAV116ey3t8PE2ExNNfRdy6cVB1o10RI1d5bFjKFWj300+hIhfdc
        SeD4K9JNcaGIDJePB1O02G+tbg==
X-Google-Smtp-Source: APXvYqwC0rxcQM957klycTBJaDgJCD9Gy1ym2szZ/ytVdS5cdCa5lGsUTdGHMpvakUUVdZWkhvfAPQ==
X-Received: by 2002:a0c:fa89:: with SMTP id o9mr1559689qvn.165.1565827800115;
        Wed, 14 Aug 2019 17:10:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n21sm762512qtc.70.2019.08.14.17.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Aug 2019 17:09:59 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hy3L5-0003Ys-7h; Wed, 14 Aug 2019 21:09:59 -0300
Date:   Wed, 14 Aug 2019 21:09:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 4/5] mm, notifier: Add a lockdep map for
 invalidate_range_start
Message-ID: <20190815000959.GD11200@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-5-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190814202027.18735-5-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:20:26PM +0200, Daniel Vetter wrote:
> This is a similar idea to the fs_reclaim fake lockdep lock. It's
> fairly easy to provoke a specific notifier to be run on a specific
> range: Just prep it, and then munmap() it.
> 
> A bit harder, but still doable, is to provoke the mmu notifiers for
> all the various callchains that might lead to them. But both at the
> same time is really hard to reliable hit, especially when you want to
> exercise paths like direct reclaim or compaction, where it's not
> easy to control what exactly will be unmapped.
> 
> By introducing a lockdep map to tie them all together we allow lockdep
> to see a lot more dependencies, without having to actually hit them
> in a single challchain while testing.
> 
> Aside: Since I typed this to test i915 mmu notifiers I've only rolled
> this out for the invaliate_range_start callback. If there's
> interest, we should probably roll this out to all of them. But my
> undestanding of core mm is seriously lacking, and I'm not clear on
> whether we need a lockdep map for each callback, or whether some can
> be shared.

I was thinking about doing something like this..

IMHO only range_end needs annotation, the other ops are either already
non-sleeping or only used by KVM.

BTW, I have found it strange that i915 only uses
invalidate_range_start. Not really sure how it is able to do
that. Would love to know the answer :)

> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
>  include/linux/mmu_notifier.h | 6 ++++++
>  mm/mmu_notifier.c            | 7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
> index b6c004bd9f6a..9dd38c32fc53 100644
> +++ b/include/linux/mmu_notifier.h
> @@ -42,6 +42,10 @@ enum mmu_notifier_event {
>  
>  #ifdef CONFIG_MMU_NOTIFIER
>  
> +#ifdef CONFIG_LOCKDEP
> +extern struct lockdep_map __mmu_notifier_invalidate_range_start_map;
> +#endif

I wonder what the trade off is having a global map vs a map in each
mmu_notifier_mm ?

>  /*
>   * The mmu notifier_mm structure is allocated and installed in
>   * mm->mmu_notifier_mm inside the mm_take_all_locks() protected
> @@ -310,10 +314,12 @@ static inline void mmu_notifier_change_pte(struct mm_struct *mm,
>  static inline void
>  mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>  {
> +	lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
>  	if (mm_has_notifiers(range->mm)) {
>  		range->flags |= MMU_NOTIFIER_RANGE_BLOCKABLE;
>  		__mmu_notifier_invalidate_range_start(range);
>  	}
> +	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
>  }

Also range_end should have this too - it has all the same
constraints. I think it can share the map. So 'range_start_map' is
probably not the right name.

It may also make some sense to do a dummy acquire/release under the
mm_take_all_locks() to forcibly increase map coverage and reduce the
scenario complexity required to hit bugs.

And if we do decide on the reclaim thing in my other email then the
reclaim dependency can be reliably injected by doing:

 fs_reclaim_acquire();
 lock_map_acquire(&__mmu_notifier_invalidate_range_start_map);
 lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 fs_reclaim_release();

If I understand lockdep properly..

Jason
