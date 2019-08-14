Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0694C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639E5214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565820890;
	bh=UI7guIwUhxj2d7avxjaE7hMxiiSK2A0bwoAKP8qw2sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BlhPo/QgiCxi/ofh6nker27CpyZ39vnLGRKSEEbae+LgFSYcTGaW+J3vIHy/mxWhb
	 ZywriceiCKLWd3wliFsbU4Y3/5bWGcjqPy0jlhPmFfnXXynmdRgejWUPeXfB/odkrh
	 dBKXxMhIoZC3fZEVLVBcl+p6LQ9bEJsGNyLx/pRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfHNWOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:59140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727937AbfHNWOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:14:49 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C652064A;
        Wed, 14 Aug 2019 22:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565820888;
        bh=UI7guIwUhxj2d7avxjaE7hMxiiSK2A0bwoAKP8qw2sk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kgdL+2SiVRNwSW1JH17ZCHCofzHSIpTR4YWsnpsl1DebWSKDpe5dUCISgu8Up/S+V
         wgHLmG+J9tdZ0hOfZk+W2Gz3gtDTZ1kwYLUSkUSYDNbrgubOrLmnymmaQQqM86LjYb
         4pgir0WNhhiFRt0JrlAp8mqwek9vmFjP5iLFjw8w=
Date:   Wed, 14 Aug 2019 15:14:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/5] mm: Check if mmu notifier callbacks are allowed to
 fail
Message-Id: <20190814151447.e9ab74f4c7ed4297e39321d1@linux-foundation.org>
In-Reply-To: <20190814202027.18735-2-daniel.vetter@ffwll.ch>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
        <20190814202027.18735-2-daniel.vetter@ffwll.ch>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2019 22:20:23 +0200 Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> Just a bit of paranoia, since if we start pushing this deep into
> callchains it's hard to spot all places where an mmu notifier
> implementation might fail when it's not allowed to.
> 
> Inspired by some confusion we had discussing i915 mmu notifiers and
> whether we could use the newly-introduced return value to handle some
> corner cases. Until we realized that these are only for when a task
> has been killed by the oom reaper.
> 
> An alternative approach would be to split the callback into two
> versions, one with the int return value, and the other with void
> return value like in older kernels. But that's a lot more churn for
> fairly little gain I think.
> 
> Summary from the m-l discussion on why we want something at warning
> level: This allows automated tooling in CI to catch bugs without
> humans having to look at everything. If we just upgrade the existing
> pr_info to a pr_warn, then we'll have false positives. And as-is, no
> one will ever spot the problem since it's lost in the massive amounts
> of overall dmesg noise.
> 
> ...
>
> --- a/mm/mmu_notifier.c
> +++ b/mm/mmu_notifier.c
> @@ -179,6 +179,8 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
>  				pr_info("%pS callback failed with %d in %sblockable context.\n",
>  					mn->ops->invalidate_range_start, _ret,
>  					!mmu_notifier_range_blockable(range) ? "non-" : "");
> +				WARN_ON(mmu_notifier_range_blockable(range) ||
> +					ret != -EAGAIN);
>  				ret = _ret;
>  			}
>  		}

A problem with WARN_ON(a || b) is that if it triggers, we don't know
whether it was because of a or because of b.  Or both.  So I'd suggest

	WARN_ON(a);
	WARN_ON(b);

