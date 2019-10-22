Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E9CA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A4120679
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 21:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="RH2e1j+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbfJVVmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 17:42:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40026 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbfJVVmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 17:42:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id o49so21317557qta.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UkVKcIoIjwq/4A0nvuIrRwIJe7BfuWm5uRD47GZUEfM=;
        b=RH2e1j+TaBj5hLQezyCMTCJMMgTJv8iyXFP6oi7yBda7boYLxE/75IqlCvdSqkfjKo
         UI0vJQI+QQgcRd86+pdAoij4fnL4PuIwY/xMdr7ya84mJKI0lQl+3HHjmDEiOVGMS4UY
         FGtgYoOm+eWSvAhmhs/crmTiyzht0NFTlsEAjD5ZNL99YfRZhBz50+Lqf9f80deynnWG
         Wx1Su905GSpJZxfD/2akXjNl4UKi9cWGl9eZccJhfeO16I/VQoWCRLH7nqV1MWwqgVVr
         l/LP3JAJr5reGl4bakvVttU+XEWyxTVQtiUne915oAXSj34XHfRjYFmxaI2K1135QTii
         ZlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkVKcIoIjwq/4A0nvuIrRwIJe7BfuWm5uRD47GZUEfM=;
        b=f6jXtaekJmdcSJfvyGH17rA8wC/3VAblorxJACmSX5qXIQlz15OB8mYqZbzNIelZTH
         YgQstRyKOXtunXvs3hLxNQmH4F11kjAKmB/HATAf/vJzR4Etz6U63yI0Sk2F2K2eKDAG
         0MvxxbqjaPM0DBQjc8ElEOa96Aher/oOADX1Cx/X5z5MhRHACPyBvh1vsS28ooLMBeYq
         mXXbHAA5OX6syIg1OpTxOf0rKHKrsYYuDg7173+TCuSCPoY196L1EcNEs5UXB6A7m8Fg
         jPVMjBEMNVq2edPKijibJnGsSNm1pmCM3s7rBXGkgSqD4UWf3KJFrR4STNkH9UKkm7+x
         iDtQ==
X-Gm-Message-State: APjAAAVRvH8Hkzgi19YKQxDIzSf9eiqAc9hOu7WCXsqItRd85WERpLco
        EGmGfa9VD7Wwbd1xJED7toZNGw==
X-Google-Smtp-Source: APXvYqxB7Z1O/1QPWUmZvZR2n/xFeF+vKMTbbtldyTA1/Ksng4TKY3QDjSFoUj8HOcKtIUvzxGt84A==
X-Received: by 2002:a0c:f952:: with SMTP id i18mr5363328qvo.131.1571780570446;
        Tue, 22 Oct 2019 14:42:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:869e])
        by smtp.gmail.com with ESMTPSA id n4sm10492844qkc.61.2019.10.22.14.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 14:42:49 -0700 (PDT)
Date:   Tue, 22 Oct 2019 17:42:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 5/8] mm: vmscan: replace shrink_node() loop with a retry
 jump
Message-ID: <20191022214249.GB361040@cmpxchg.org>
References: <20191022144803.302233-1-hannes@cmpxchg.org>
 <20191022144803.302233-6-hannes@cmpxchg.org>
 <20191022195629.GA24142@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022195629.GA24142@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 07:56:33PM +0000, Roman Gushchin wrote:
> On Tue, Oct 22, 2019 at 10:48:00AM -0400, Johannes Weiner wrote:
> > -			/* Record the group's reclaim efficiency */
> > -			vmpressure(sc->gfp_mask, memcg, false,
> > -				   sc->nr_scanned - scanned,
> > -				   sc->nr_reclaimed - reclaimed);
> > -
> > -		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> > +		reclaimed = sc->nr_reclaimed;
> > +		scanned = sc->nr_scanned;
> > +		shrink_node_memcg(pgdat, memcg, sc);
> >  
> > -		if (reclaim_state) {
> > -			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> > -			reclaim_state->reclaimed_slab = 0;
> > -		}
> > +		shrink_slab(sc->gfp_mask, pgdat->node_id, memcg,
> > +			    sc->priority);
> >  
> > -		/* Record the subtree's reclaim efficiency */
> > -		vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> > -			   sc->nr_scanned - nr_scanned,
> > -			   sc->nr_reclaimed - nr_reclaimed);
> > +		/* Record the group's reclaim efficiency */
> > +		vmpressure(sc->gfp_mask, memcg, false,
> > +			   sc->nr_scanned - scanned,
> > +			   sc->nr_reclaimed - reclaimed);
> 
> It doesn't look as a trivial change. I'd add some comments to the commit message
> why it's safe to do.

It's an equivalent change - it's just really misleading because the
+++ lines are not the counter-part of the --- lines here!

There are two vmpressure calls in this function: one against the
individual cgroups, and one against the tree. The diff puts them
adjacent here, but the counter-part for the --- lines is here:

> > +	/* Record the subtree's reclaim efficiency */
> > +	vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> > +		   sc->nr_scanned - nr_scanned,
> > +		   sc->nr_reclaimed - nr_reclaimed);

And the counter-part to the +++ lines is further up (beginning of the
quoted diff).
