Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0F1C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE812465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="U9cHXkPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfLSUPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:15:33 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44460 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfLSUPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:15:33 -0500
Received: by mail-qk1-f194.google.com with SMTP id w127so5689622qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 12:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PQjMXND29ZOsAnerzkU8MnmW/ZfdROUZu9qjhxqG6EY=;
        b=U9cHXkPP72WvtcADClYC4DRQZ5M9c6gavTG4jpBe5tnz0P1dbHdjkyNQIWHFb7REgV
         OU1lHIoA9ockLBIBMzzu298VqW4UBfWXuOZCXpX+uPXItDxIXEC8HO1TbE4DkkL4o70d
         l4uxkJ0tU2czRYZwVB4DcWQZN+2DE4CIgNvIkZ76H+bkje/KoyMvIZ+VrCU88Qz3biQu
         pIvJaydN73S20ffqz0xQT4TcjYpgveoRn3QYKhXZoHsjQtIp6gBibHSes3ZHyw2GLyh0
         g6o8Ogkl4cY5CLlC0RXVFXz0Wl0lwj4K9GQlbkG5eecE1EqYjDsvo3K+6hkInGRMTqzd
         +0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PQjMXND29ZOsAnerzkU8MnmW/ZfdROUZu9qjhxqG6EY=;
        b=ECE9aTVsuskfbzE+pJFu4RAJPA4uPqAaiAHNR7K5J/sADNIadNeRkoTRftNuPIBTxF
         6C5cILZDN3LcpWC6N4wL/4r3BrOPCapDZbQDuz4uzXvPj5DBGQoR7YCmhCvObFTCkpu7
         us4IC1aaVc9g/PhpyFBPdrNxJjLHk8RHCcntwrtIB+4dJS/ChMBBqvUIZMWGxARMgyeF
         9M3AYPFZyiSXp5Vx1VpXmjCjw5IIgc0gOobOWg9C9c3htBW9lMJybbBqjcLr5miBBV3V
         I0kkIdRTMD52ilju85VfBUB0mensBjgQ3VOvHKAqJSgy4G0C4AJY2ckALKjv83fuIY5b
         GHoQ==
X-Gm-Message-State: APjAAAWVAKGCjgj2Rj3Y8yjjNGXoMche1doIUpt/AceNM7uTe9LdPjXc
        1vryjQ5LlO3W3F0dxGOT4YwWxA==
X-Google-Smtp-Source: APXvYqyRYyW05k3AdGpltsQgBfP/jVScYLnn+lr2hLrvDn9gjqevIFa5OGfLlQB1Pz3gmzV/mkhgDQ==
X-Received: by 2002:a05:620a:147c:: with SMTP id j28mr9051619qkl.13.1576786530431;
        Thu, 19 Dec 2019 12:15:30 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::91a1])
        by smtp.gmail.com with ESMTPSA id 53sm2260936qtu.40.2019.12.19.12.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:15:29 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:15:29 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm: memcg/slab: fix percpu slab vmstats flushing
Message-ID: <20191219201529.GA15960@cmpxchg.org>
References: <20191218230501.3858124-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218230501.3858124-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 03:05:01PM -0800, Roman Gushchin wrote:
> Currently slab percpu vmstats are flushed twice: during the memcg
> offlining and just before freeing the memcg structure.

Please explain here why this double flushing is done. You allude to it
below in how it goes wrong, but it'd be better to describe the intent
when describing the current implementation, to be clear about the
trade offs we are making with this patch.

> Each time percpu counters are summed, added to the atomic counterparts
> and propagated up by the cgroup tree.
> 
> The problem is that percpu counters are not zeroed after the first
> flushing. So every cached percpu value is summed twice. It creates
> a small error (up to 32 pages per cpu, but usually less) which
> accumulates on parent cgroup level. After creating and destroying
> of thousands of child cgroups, slab counter on parent level can
> be way off the real value.
> 
> For now, let's just stop flushing slab counters on memcg offlining.
> It can't be done correctly without scheduling a work on each cpu:
> reading and zeroing it during css offlining can race with an
> asynchronous update, which doesn't expect values to be changed
> underneath.
> 
> With this change, slab counters on parent level will become eventually
> consistent. Once all dying children are gone, values are correct.
> And if not, the error is capped by 32 * NR_CPUS pages per dying
> cgroup.
> 
> It's not perfect, as slab are reparented, so any updates after
> the reparenting will happen on the parent level. It means that
> if a slab page was allocated, a counter on child level was bumped,
> then the page was reparented and freed, the annihilation of positive
> and negative counter values will not happen until the child cgroup is
> released. It makes slab counters different from others, and it might
> want us to implement flushing in a correct form again.
> But it's also a question of performance: scheduling a work on each
> cpu isn't free, and it's an open question if the benefit of having
> more accurate counters is worth it.
> 
> We might also consider flushing all counters on offlining, not only
> slab counters.
> 
> So let's fix the main problem now: make the slab counters eventually
> consistent, so at least the error won't grow with uptime (or more
> precisely the number of created and destroyed cgroups). And think
> about the accuracy of counters separately.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Fixes: bee07b33db78 ("mm: memcontrol: flush percpu slab vmstats on kmem offlining")
> Cc: stable@vger.kernel.org

Other than that, the change looks reasonable to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
