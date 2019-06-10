Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF5CC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF622082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 20:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="xzuzhYxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389570AbfFJUdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 16:33:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37237 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbfFJUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 16:33:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so5113607pfa.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QntknNlUMZ8JI/1goGczbuHi72H8zQ1C3B8XCCIqc74=;
        b=xzuzhYxwoNBu8erHlLCrxSF6MyfWGF1hKTX+tKC7Hnyu/qw9Tj+eRX3C62ggnJnCN4
         tg1sy2avRP+ogUk9rkB6oxWVwW96l1plZ/wS2FgBg9ov5ZHfQD01osPiIMw9+s45gWyY
         GGXQZoJP/K2EQ4oq1dCL3nRh6zdkvZtN3sDwEjTz28wEzhHh0solkY3gANj5poClnBQT
         XSIBZ/r7EK9XzaDLWHwvHR99AFFP1HcBQWTc/qlpPiE93EVyQJHzrAVsG5nJX8onEPlp
         pOyyL1FTk0PCBlHw5ymm1gYsRTCXcT0eaXT0qFfdhfKjR67fqwACSYKwOZWVE2hRWy1F
         wgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QntknNlUMZ8JI/1goGczbuHi72H8zQ1C3B8XCCIqc74=;
        b=ZscyPCt4HdlWfF7D0FSYl8XsaUlxA247TEWZ/FUFunWHwoVJWiDU7fG5beOJnk6p85
         q0U+mPNpyqnmwf6gqwpTpdqp7kkrY3UkgZWc7MsEDfDS8gRrwM0ZxEG2Y8DEoyJW1/MZ
         Vgn3sVUR3CAWn9JbZUBNhpIUCyPgLwBu8+yRPcGFxEaZmYtdcwUaAkyf4l8EbSlM5Zey
         jBDdGgpnHCud3D61kxi4IlnkyOwSvdbOHOrlSmFlNsNIUkVQIl4rrQri5SlQfihamOFS
         jsKa2aO6a0f3rzJrZ+1XZD3wabHQzDFIJyD7FrpfUtbGG0HhtyvbVbjyvc1/a4SsroP2
         QhXg==
X-Gm-Message-State: APjAAAUlN8XeLrbI+TwJGG+1QbinVfPaAjg/T1Lt5Ma7xKX8gSbj3Cpq
        vF7SftFhcH/KBGs7TQM2hsb0Hq3QExM=
X-Google-Smtp-Source: APXvYqycry2VoGdYVSIQMIzoqz01wpBKdkO8o/o7K8OkM2VlKWAUhszB+cuq+ZnAXmc4MT74TSv4Yg==
X-Received: by 2002:a62:6145:: with SMTP id v66mr75694199pfb.144.1560198827276;
        Mon, 10 Jun 2019 13:33:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:8cbd])
        by smtp.gmail.com with ESMTPSA id v4sm14441747pff.45.2019.06.10.13.33.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 13:33:46 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:33:44 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 01/10] mm: add missing smp read barrier on getting
 memcg kmem_cache pointer
Message-ID: <20190610203344.GA7789@cmpxchg.org>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-2-guro@fb.com>
 <20190609121052.kge3w3hv3t5u5bb3@esperanza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190609121052.kge3w3hv3t5u5bb3@esperanza>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 03:10:52PM +0300, Vladimir Davydov wrote:
> On Tue, Jun 04, 2019 at 07:44:45PM -0700, Roman Gushchin wrote:
> > Johannes noticed that reading the memcg kmem_cache pointer in
> > cache_from_memcg_idx() is performed using READ_ONCE() macro,
> > which doesn't implement a SMP barrier, which is required
> > by the logic.
> > 
> > Add a proper smp_rmb() to be paired with smp_wmb() in
> > memcg_create_kmem_cache().
> > 
> > The same applies to memcg_create_kmem_cache() itself,
> > which reads the same value without barriers and READ_ONCE().
> > 
> > Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > ---
> >  mm/slab.h        | 1 +
> >  mm/slab_common.c | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/slab.h b/mm/slab.h
> > index 739099af6cbb..1176b61bb8fc 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -260,6 +260,7 @@ cache_from_memcg_idx(struct kmem_cache *s, int idx)
> >  	 * memcg_caches issues a write barrier to match this (see
> >  	 * memcg_create_kmem_cache()).
> >  	 */
> > +	smp_rmb();
> >  	cachep = READ_ONCE(arr->entries[idx]);
> 
> Hmm, we used to have lockless_dereference() here, but it was replaced
> with READ_ONCE some time ago. The commit message claims that READ_ONCE
> has an implicit read barrier in it.

Thanks for catching this Vladimir. I wasn't aware of this change to
the memory model. Indeed, we don't need to change anything here.
