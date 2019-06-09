Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA56C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:23:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BB2212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:23:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR31kyMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfFIMXk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:23:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36600 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFIMXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:23:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so5477006ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iFbsAteAWCOB8EYWVkTmBCNQWQgWWukwnbyxrLkrB0g=;
        b=CR31kyMKqJssQbVi1JNiJC/mpUqUbB9GeHhEnWXxUYEm/NFvtyAwx+ibkWn73vB8s1
         ijmN8IVbIB6z7z2Xw7lOxf+6NAJ94vILodRFkmRNak6nbqnti1w7Vec83AbVODQti+Kg
         7iZr/mfEAgiffcNh//LPD7cgzTHZYJwM9cu/zGu5dgHfwIT/9Yo8YMZFtBELx50wYa0F
         rbPp54YHrqXeg1OAS9y5SI2EhI+hVbTYKJJdL1LP54ucpmGb/21rizHKTKR6QAjKJzsX
         SYmGj1j3ACblLdnWniEQFA6KCwJKI0YxvpBvj6O7nu3fu2xWUvqQV5NL2r+mOCMSZlEB
         WSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iFbsAteAWCOB8EYWVkTmBCNQWQgWWukwnbyxrLkrB0g=;
        b=TycUlR1sTWcyCPeQ760BTIWYntYTlmKsKclrW/1ukoIxCrtgJPfHK8nr+FqOBpatet
         DruIvcfHFA4iveuGH7Jt795/Nslen0sd24n5OJQR+bCq+EMvARlN17Lec70t5iKWni9P
         T0AqusoGeBkjKAh5rbmA7VfYsjmwUMfksYqiKyTOy6/JMPhnplSBIxorRiCqjKmqg/3h
         nopFqLWd6Kf/POlpa3vleZhhJ55pDenemDIz3wvevFG7mCpxTRWZJjVfVbk3EMWPjHsU
         l+bKO4KDxpYXA6yAVT39c6oGqWxITshQkhtG1o0Lvu22WisZaoxkXmUU20kTGHhqU0gW
         s11Q==
X-Gm-Message-State: APjAAAV4FJs2FgsYRLrZeCu3mBWt3Px+gTOA2o2kmnXShRtB3QzUc7Ds
        oAoiQ4BreDRMijJZoQCMfpQ=
X-Google-Smtp-Source: APXvYqy8PsCjFxIJXLZEqVIOqouGGmLPoWA0WKXKYrav3RxdCeb2sgrOXhs44ORw1QLgIMf7oUBMtA==
X-Received: by 2002:a2e:b0d0:: with SMTP id g16mr21038731ljl.161.1560083018160;
        Sun, 09 Jun 2019 05:23:38 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id c8sm1354240ljk.77.2019.06.09.05.23.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 05:23:37 -0700 (PDT)
Date:   Sun, 9 Jun 2019 15:23:35 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 04/10] mm: generalize postponed non-root kmem_cache
 deactivation
Message-ID: <20190609122334.6jbpiwgrdzs4xill@esperanza>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-5-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:48PM -0700, Roman Gushchin wrote:
> Currently SLUB uses a work scheduled after an RCU grace period
> to deactivate a non-root kmem_cache. This mechanism can be reused
> for kmem_caches release, but requires generalization for SLAB
> case.
> 
> Introduce kmemcg_cache_deactivate() function, which calls
> allocator-specific __kmem_cache_deactivate() and schedules
> execution of __kmem_cache_deactivate_after_rcu() with all
> necessary locks in a worker context after an rcu grace period.
> 
> Here is the new calling scheme:
>   kmemcg_cache_deactivate()
>     __kmemcg_cache_deactivate()                  SLAB/SLUB-specific
>     kmemcg_rcufn()                               rcu
>       kmemcg_workfn()                            work
>         __kmemcg_cache_deactivate_after_rcu()    SLAB/SLUB-specific
> 
> instead of:
>   __kmemcg_cache_deactivate()                    SLAB/SLUB-specific
>     slab_deactivate_memcg_cache_rcu_sched()      SLUB-only
>       kmemcg_rcufn()                             rcu
>         kmemcg_workfn()                          work
>           kmemcg_cache_deact_after_rcu()         SLUB-only
> 
> For consistency, all allocator-specific functions start with "__".
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Much easier to review after extracting renaming, thanks.

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
