Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFB5C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A0620684
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="EpK/aD4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbfFEQmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:42:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42989 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbfFEQma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:42:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6so11433636pgd.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IR/5u8R+ftfvePhhPnEG7rK5T0D9AZJGfobf430HZK0=;
        b=EpK/aD4eGRpEC9hMVO208gbI/muqvw8jBmuMlOGu+QCJFEebWFWSoFCERzvwGvuL6K
         ZsZW1YedQmJCDs8eKJRuqXLHpxRuF8EZ0fn2kX/QObnsB/BRL2omZKd+WbVgXyaemLx6
         nIziz08WC5m6Od5vkSTLH9UrAqUvEideQSFn7Kek1qFQR0L0B9Lr6mu9mZtZkMWsYh68
         Lh26494NJ/EqpF12bz4dOK09y5nJtxJbA5Jt04y7H3ZUrW/7ymTys04XVtMiWIRbFDoZ
         avUuRe2ACDkCiyz75JTnDTlW2XCPbiknHuhU5mk9t7MeLU10/Q07/2PW5oCPCQB+ZlqU
         FFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IR/5u8R+ftfvePhhPnEG7rK5T0D9AZJGfobf430HZK0=;
        b=tjzB9oI8I6UPFyolH53EPEsFhhds16CHVGUlCdC4QyKqCXP+z9LtmoLY0ILndoi+FG
         FUSGZ3TjYwHr4U1sBzL4p6+EFjg5PH/kMOOp66fPFWd9fMzbfap2uJ+f6H/OOuaOA9Xf
         zGC1ZcfOqUC4pey0j7DR4TgViIv0fbERc3NNFfVzlwyE5RO1t0PAJxzAK4WqPZTvtPox
         4WEMBy1amlcMdoMcBqSQkuvcoGkAcJk3r6YJcOC/tFfFrIwel7Zmx8EfzbLLHU/tURBN
         eGbub/8rn0DPWd2+lp61DVOBP+JOPDwWV6+ub5bIEaJP8+O+SWuRUjZWiXrKgAIPZeRt
         cGEg==
X-Gm-Message-State: APjAAAUKLkB0xyeQeqhFc1yeqt9Q6klW1Ky73eB9QrlbMRybSwr6WZ7O
        HauGfqgcKzmaCVUAXAZn3o8GTQQ9tGM=
X-Google-Smtp-Source: APXvYqxGZGo/d/XJokbeKLqRlqfQUskb3FoYJTPKNFpIC57YsPlwoH1CmnWwVKyEBqoYUEgWRbnDhQ==
X-Received: by 2002:aa7:9e51:: with SMTP id z17mr48511176pfq.212.1559752950079;
        Wed, 05 Jun 2019 09:42:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:cd0c])
        by smtp.gmail.com with ESMTPSA id q125sm44812419pfq.62.2019.06.05.09.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 09:42:28 -0700 (PDT)
Date:   Wed, 5 Jun 2019 12:42:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 01/10] mm: add missing smp read barrier on getting
 memcg kmem_cache pointer
Message-ID: <20190605164227.GB12453@cmpxchg.org>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-2-guro@fb.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
