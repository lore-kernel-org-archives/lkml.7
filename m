Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5318DC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2325B205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 19:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FF0ThfX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbfHETnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 15:43:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35005 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHETno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 15:43:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id n4so4981212pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 12:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WWvuvR2gfG7sLdu6K+RYuoog4fh46SnlfKdpfISWizo=;
        b=FF0ThfX/bzXj/27mCqPHlsBMwiIYZlOM9RmNphVdMiLTKFTSIINwJ461YEYbUUwEJN
         m26UyZ3XWL77w/tHksUHW1PeyGzJyWNY13DjAPzELJZneSPxWuZasvz9dNFt6/2JPtgv
         qVIywLEuv+OpFrpLPJjL+0VyhOS8hmp386H5C28ioO5TYQorFdFX3xnvENVjSQvV2tyZ
         q5GaWw0MT+HdTeGMxeem1WwEcjvhWzGYE8bRKhHOmp1odj0KsF0vBeTfIHRfi7j/yTkA
         pxF6+yVEj8pUlTHwytLp4HNKWrEMSHivN64CPzymFxxqOyFjW9elvIgLCJFiY5lCLGUn
         dOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWvuvR2gfG7sLdu6K+RYuoog4fh46SnlfKdpfISWizo=;
        b=ABhGdJmQ9jHCjaCXterjNCYtFFr7Kk9IeNOD+5tCeEJJ3IexJV3ONKMeV5owfVn92s
         OpnlrzHl+EqYel5jugjQi107y3QvLaJcoM7q/FJSae+Mvw37H6s16g0SDwJ7ezAIW7vS
         C1y9QLcrk1ZR0qxJySwrqkEg7cqDmAa15ZZI1ekgIrKPauTXbLeCfr9351EfMGYkWJtm
         p+M7xYn1swF4UcYDecZqDQ2BMA0rCvXb9ftztdY89NN26p6IHt3QVHw0F9qf+PMz7s1k
         cUT4NVczM1CZqFDlMGfSxR5I6+dD+h7CgXZs73MlHUTUHrIwc0aozjT1ga33AoweEksF
         HKsQ==
X-Gm-Message-State: APjAAAUueYeyb0TJqFTcy3IWmWuyMVY9dS7HB+o3Dr+iItIUi4nDNIhM
        m0phZUsf56JvREj8fWEIZPE=
X-Google-Smtp-Source: APXvYqxdSjvwIdE9asbvH0WVb955oASYdklotIVD6HjXgjlLwa8lAFefTwAseLg4dhaPLTUjv300/g==
X-Received: by 2002:a62:6083:: with SMTP id u125mr73381751pfb.208.1565034223953;
        Mon, 05 Aug 2019 12:43:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::26a1])
        by smtp.gmail.com with ESMTPSA id h26sm89520864pfq.64.2019.08.05.12.43.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 12:43:43 -0700 (PDT)
Date:   Mon, 5 Aug 2019 15:43:41 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: workingset: fix vmstat counters for shadow nodes
Message-ID: <20190805194341.GA6260@cmpxchg.org>
References: <20190801233532.138743-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801233532.138743-1-guro@fb.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:35:32PM -0700, Roman Gushchin wrote:
> Memcg counters for shadow nodes are broken because the memcg pointer is
> obtained in a wrong way. The following approach is used:
> 	virt_to_page(xa_node)->mem_cgroup
> 
> Since commit 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup
> pointer for slab pages") page->mem_cgroup pointer isn't set for slab pages,
> so memcg_from_slab_page() should be used instead.
> 
> Also I doubt that it ever worked correctly: virt_to_head_page() should be
> used instead of virt_to_page(). Otherwise objects residing on tail pages
> are not accounted, because only the head page contains a valid mem_cgroup
> pointer. That was a case since the introduction of these counters by the
> commit 68d48e6a2df5 ("mm: workingset: add vmstat counter for shadow nodes").

You're right. slub uses order-2 compound pages for radix_tree_node, so
we've been underreporting shadow nodes placed in the three tail pages.

Nice catch.

> Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
