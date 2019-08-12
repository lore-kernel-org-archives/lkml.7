Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4309EC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D6BA2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="clZMOrgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfHLXAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:00:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45938 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfHLXAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:00:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id o13so50205108pgp.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 16:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2ksXWqG62EfbmUuHI0nKd4a7rlKac00A3mrtP5kn5Ls=;
        b=clZMOrgpPeiUsSiOQGc7xPtSCJ1+tYlCEalNf0FrCYLJfEA+0uy4k2IMsGT3jc2cFu
         QPuYWIpFCQhxAals/OKuaPNf8mppQVTkf6D4zIbGyKu4gOrWVhA2o9ZKUIPwXfJVrcoG
         avMIYarRQn3GMlD+OUwXFSElhTGkglyd3QZD1GJQSaZP8jC6QiZ2xLFtEuUdnjR3mnni
         sRQtw5csmi7PfDU+Ql+QaQ1NKyhCIKJ3a40cFUmsKMpgHBOzlU8Y+4Tu8Q9zJCvCmZsb
         tOC9AwuoxVLSsc9XXteA5o+ppMTBTFjDr7sDywYo3lo2UATZPZ7kYu0zrGDtAc9pwsi5
         IbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2ksXWqG62EfbmUuHI0nKd4a7rlKac00A3mrtP5kn5Ls=;
        b=n/ZrtasiwlkIIfpphd1kmISanj+U22JcsjTcPkZliQX6749vM16o4kBT9HA5kDhAVe
         ibAkzWiNUBn1Pr1tMYbkRazEXcKserdUQT6QWvHq/+wtcJ5JdBnW5q2/0wngqaYdREK7
         7qBecTHYFk2I6gnJ3B+uASayBMZuFu3c0EiModWO1LVDYMC7wimlxNflvqKRkn+LIdgG
         ztglazvz0COwSr0SButxt2l8aBqcT1hxnJXsw2XGeazsABgUL2ArjJx0yTH25zbGW1t7
         whW/8RThiMlpOzr0jtkC8P+qBEkmDEx7K8QWTrZwT35a1fhSb9lT4jD1W5kk70m4d+hj
         hwiQ==
X-Gm-Message-State: APjAAAX6jzR8hoK4UWgsm+QIjF7E0iy454tv/5NGjo3ORk7mEy+tY6Ql
        XGeSEgEYI/UIvlWiXIKrEta2zg==
X-Google-Smtp-Source: APXvYqyb883Z7rrcgcBtXgV+QnSSy8ZT99o+mRBxe/N1CFP0iCEGlwsPbuGd5lBVkMaokl9X9DPeAA==
X-Received: by 2002:a62:6083:: with SMTP id u125mr37305269pfb.208.1565650845803;
        Mon, 12 Aug 2019 16:00:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:f08])
        by smtp.gmail.com with ESMTPSA id z13sm110232784pfa.94.2019.08.12.16.00.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:00:45 -0700 (PDT)
Date:   Mon, 12 Aug 2019 19:00:43 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH] mm: vmscan: do not share cgroup iteration between
 reclaimers
Message-ID: <20190812230043.GA18948@cmpxchg.org>
References: <20190812192316.13615-1-hannes@cmpxchg.org>
 <20190812210723.GA9423@tower.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812210723.GA9423@tower.dhcp.thefacebook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 09:07:27PM +0000, Roman Gushchin wrote:
> On Mon, Aug 12, 2019 at 03:23:16PM -0400, Johannes Weiner wrote:
> > @@ -2679,7 +2675,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  		nr_reclaimed = sc->nr_reclaimed;
> >  		nr_scanned = sc->nr_scanned;
> >  
> > -		memcg = mem_cgroup_iter(root, NULL, &reclaim);
> > +		memcg = mem_cgroup_iter(root, NULL, NULL);
> 
> I wonder if we can remove the shared memcg tree walking at all? It seems that
> the only use case left is the soft limit, and the same logic can be applied
> to it. The we potentially can remove a lot of code in mem_cgroup_iter().
> Just an idea...

It's so tempting! But soft limit reclaim starts at priority 0 right
out of the gate, so overreclaim is an actual concern there. We could
try to rework it, but it'll be hard to avoid regressions given how
awkward the semantics and behavior around the soft limit already are.

> >  		do {
> >  			unsigned long lru_pages;
> >  			unsigned long reclaimed;
> > @@ -2724,21 +2720,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> >  				   sc->nr_scanned - scanned,
> >  				   sc->nr_reclaimed - reclaimed);
> >  
> > -			/*
> > -			 * Kswapd have to scan all memory cgroups to fulfill
> > -			 * the overall scan target for the node.
> > -			 *
> > -			 * Limit reclaim, on the other hand, only cares about
> > -			 * nr_to_reclaim pages to be reclaimed and it will
> > -			 * retry with decreasing priority if one round over the
> > -			 * whole hierarchy is not sufficient.
> > -			 */
> > -			if (!current_is_kswapd() &&
> > -					sc->nr_reclaimed >= sc->nr_to_reclaim) {
> > -				mem_cgroup_iter_break(root, memcg);
> > -				break;
> > -			}
> > -		} while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
> > +		} while ((memcg = mem_cgroup_iter(root, memcg, NULL)));
> >  
> >  		if (reclaim_state) {
> >  			sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> > -- 
> > 2.22.0
> >
> 
> Otherwise looks good to me!
> 
> Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
