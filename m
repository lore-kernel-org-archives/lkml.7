Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E20C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D0220665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 17:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kbat1qAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfHPRTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 13:19:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37042 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbfHPRTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 13:19:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so6876621qto.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 10:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=aAuJkx3tYtzzL6W59IWOcvDtZCZIe1mJoCimZUlEFnw=;
        b=kbat1qAeKGkrmhubzeBSEX8UlXXey9lnVfQ/Vx0g766LW7GP2lpryQR7t+0vkFRRGb
         Jbg7BZUZkb7DQaUs/r2IBK+ejH2xzPCnmBv1XUEwYR4RJushKgYjcaKQFI1RQe5rxK2u
         iur/yAF+59Yi7khOcb0j1JRo9YgGqPOFo6YmToQ8a2GmkZUYQJzcSUeijq+xHVelXCf1
         SOBFkRoNZd6kH5Ae3nP7KGtraL7KLomnzgXBrJ+y2e8mrPRSpM/Bdc74HMV39ga4awdz
         VMW6PcO2Z8gNJRCIQXyLtl+PzOxTnwGROhY174YQjkrcOzSPj7hlg9pNW9UlEhadULXM
         hQ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=aAuJkx3tYtzzL6W59IWOcvDtZCZIe1mJoCimZUlEFnw=;
        b=QIWK/wWSU5aUk7FnJqYOKWObTMxOayPP2zSXOcG1K8YXr5iX1SXw0G6sy9GmlKP+72
         TWpwa6/OYWxh2yjNc8joFrJv94O606guqGk7iVegvXXnYrexTNFXw8CD/qPyDiw74jUo
         vnS4Np0TA6BnGE10ah2roYOrTW972Huk2BdREB1AFKON5Qzj/TKp1ORc8Q8Ux8ovGk/z
         w8ApsxPqwxPJoc2xSwuxD77nYkRjG4kfh/QrKLTPY92/QLKkzskLRvoBRCxnIFtXjkT2
         ryO0V9svdT+PG/kabFGQdCOoYB3Co0ujQM3ENfNRK11sCCLr86eERVXgUsWOOBwPoJFG
         xQIQ==
X-Gm-Message-State: APjAAAXvu8+bB4azA7ZagBj5XTk62BYyD0Di7WiGwh/s0UOiPH8xsj+B
        pvEvCmQxlhxT+8jMRS2U5K5zew==
X-Google-Smtp-Source: APXvYqwT9qpP8xS/SEWzOUT0qxlqBNBY2XPEKDcBsyQzLY2w+EuruYBh4SnhqRD+DeiOPjnm58LqcA==
X-Received: by 2002:ac8:450c:: with SMTP id q12mr9723027qtn.298.1565975945646;
        Fri, 16 Aug 2019 10:19:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id f133sm3160880qke.62.2019.08.16.10.19.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Aug 2019 10:19:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyfsW-0000pk-Hu; Fri, 16 Aug 2019 14:19:04 -0300
Date:   Fri, 16 Aug 2019 14:19:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Rientjes <rientjes@google.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/5] mm: Check if mmu notifier callbacks are allowed to
 fail
Message-ID: <20190816171904.GA3166@ziepe.ca>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190814202027.18735-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 10:20:23PM +0200, Daniel Vetter wrote:
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
> v2: Drop the full WARN_ON backtrace in favour of just a pr_warn for
> the problematic case (Michal Hocko).
> 
> v3: Rebase on top of Glisse's arg rework.
> 
> v4: More rebase on top of Glisse reworking everything.
> 
> v5: Fixup rebase damage and also catch failures != EAGAIN for
> !blockable (Jason). Also go back to WARN_ON as requested by Jason, so
> automatic checkers can easily catch bugs by setting panic_on_warn.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: linux-mm@kvack.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  mm/mmu_notifier.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to hmm.git, thanks

Jason
