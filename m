Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD435C31E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68DA20B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="S0baOBWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfFRPWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 11:22:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33703 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729038AbfFRPWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 11:22:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id i11so22351557edq.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 08:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E/qk0N+cIbM6HKj1qhjne1NfpocVmMqaX5q+/tL+ueI=;
        b=S0baOBWqecd8R9Fv9S0yBSLlPx0B4vYX0TvI7oaRAzSf4d2jvMU2DZNwb2RG3dYdoB
         4+rZlzI6OA2RQxSWsdDqUVmzxXcyYpc2/nLIKI8MXqYfLfBjl7BetsvlRKqBiD5NuAUg
         AXHEz2PEzrj8GeuDgxkf0L8t0EXnxlWwtpkRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=E/qk0N+cIbM6HKj1qhjne1NfpocVmMqaX5q+/tL+ueI=;
        b=m4gk/MaJRWhNr0/+SidV6kK9bJQuR2phu2i8irkKu9btjo6vu3vvEDoYdhRctBTwDN
         1nqHyw3TDvuKDkdg1HoNekESKOaC+rIyebPdXB4LLS1knd6R5aTF4VagVbuARuHxhXQe
         MnE4sqSpVbsC9J0ecCk5DG6vDUEuJmk8QvDcHOGCdWdZ20CyiUTJrflACB3Me3RnE52B
         RVTJjQfHTuhgq86UVvyPoUbyFceZb6dA9VFkVBdc1jQd4ObLuIdvPz75yck5CxYo45q/
         WV3l4xi2yGy1AIBe2RbmimWgLGRTZ645J5dTw6Vr/z9DOBhesl4fFVkKLADVMddaHrnK
         A2qg==
X-Gm-Message-State: APjAAAWaNmgg9Gm2Icv8rqwUI9n5Q8YGV4wIzJClxstEkuH7Wp/jjbRh
        hqwT27s4nqOWxCDPAneHZHe5qoVSQ2s=
X-Google-Smtp-Source: APXvYqwy35fNeHyWQSb1sdW5IH38w+mc35q9rAaNur5D3Zl1Sv5PQx84zYiDMSvgBUjPLKdZDrkeAA==
X-Received: by 2002:a50:8825:: with SMTP id b34mr48288557edb.22.1560871338412;
        Tue, 18 Jun 2019 08:22:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id 9sm1439769ejg.49.2019.06.18.08.22.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 08:22:17 -0700 (PDT)
Date:   Tue, 18 Jun 2019 17:22:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Michal Hocko <mhocko@suse.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/4] mm: Check if mmu notifier callbacks are allowed to
 fail
Message-ID: <20190618152215.GG12905@phenom.ffwll.local>
Mail-Followup-To: Jerome Glisse <jglisse@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux MM <linux-mm@kvack.org>, David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
References: <20190520213945.17046-1-daniel.vetter@ffwll.ch>
 <20190521154411.GD3836@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190521154411.GD3836@redhat.com>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 11:44:11AM -0400, Jerome Glisse wrote:
> On Mon, May 20, 2019 at 11:39:42PM +0200, Daniel Vetter wrote:
> > Just a bit of paranoia, since if we start pushing this deep into
> > callchains it's hard to spot all places where an mmu notifier
> > implementation might fail when it's not allowed to.
> > 
> > Inspired by some confusion we had discussing i915 mmu notifiers and
> > whether we could use the newly-introduced return value to handle some
> > corner cases. Until we realized that these are only for when a task
> > has been killed by the oom reaper.
> > 
> > An alternative approach would be to split the callback into two
> > versions, one with the int return value, and the other with void
> > return value like in older kernels. But that's a lot more churn for
> > fairly little gain I think.
> > 
> > Summary from the m-l discussion on why we want something at warning
> > level: This allows automated tooling in CI to catch bugs without
> > humans having to look at everything. If we just upgrade the existing
> > pr_info to a pr_warn, then we'll have false positives. And as-is, no
> > one will ever spot the problem since it's lost in the massive amounts
> > of overall dmesg noise.
> > 
> > v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> > the problematic case (Michal Hocko).
> > 
> > v3: Rebase on top of Glisse's arg rework.
> > 
> > v4: More rebase on top of Glisse reworking everything.
> > 
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Rientjes <rientjes@google.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > Cc: linux-mm@kvack.org
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Reviewed-by: Christian König <christian.koenig@amd.com>
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> 
> Reviewed-by: Jérôme Glisse <jglisse@redhat.com>

-mm folks, is this (entire series of 4 patches) planned to land in the 5.3
merge window? Or do you want more reviews/testing/polish?

I think with all the hmm rework going on, a bit more validation and checks
in this tricky area would help.

Thanks, Daniel

> 
> > ---
> >  mm/mmu_notifier.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
> > index ee36068077b6..c05e406a7cd7 100644
> > --- a/mm/mmu_notifier.c
> > +++ b/mm/mmu_notifier.c
> > @@ -181,6 +181,9 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
> >  				pr_info("%pS callback failed with %d in %sblockable context.\n",
> >  					mn->ops->invalidate_range_start, _ret,
> >  					!mmu_notifier_range_blockable(range) ? "non-" : "");
> > +				if (!mmu_notifier_range_blockable(range))
> > +					pr_warn("%pS callback failure not allowed\n",
> > +						mn->ops->invalidate_range_start);
> >  				ret = _ret;
> >  			}
> >  		}
> > -- 
> > 2.20.1
> > 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
