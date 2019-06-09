Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24309C468BD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F118F20840
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMj0t7O5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbfFIMNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:13:34 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39186 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfFIMNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:13:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id v18so5455753ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dSKWqv48YjvTpHMzJ6cEr/B8IpdYkbZ87Fgmm26rJBw=;
        b=pMj0t7O5EHRJlyEPeUXPVlEG+b9z/hIeBC5taQwe/qsd6JhvdJUyNGAyqEywm28mwV
         FSyOR5XxKyOL9TfhhQgPIXUu0xpjNy41S0bda15ykJzaAbBRAobLofPaf3yti3xoi8ih
         DIbHxtN4r85xSSPukC+eEDm7hzuauH7nnxUP57Ujcta5b+Ha1u/7saPIJroEdVJtxKqq
         h2Ry9LQ6OcBuTv+XdrUpYPdi+LGB5MgSvOhMkuudsx/c4qQGQ6L7wu/6ZJQOmHNmiWgF
         KqkvkML11VzMonJCNns7Xu2wp9XkhQCK3/crnjdKAtvXyEXOTZcI4oD2wVlifWZ/FnQq
         YtIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dSKWqv48YjvTpHMzJ6cEr/B8IpdYkbZ87Fgmm26rJBw=;
        b=J93CPnejXF7pn2wbPFvsgA8Id03EEIfdOzQ+dLDAZMgsO+N2th5zDRi+xRrxwYvZcI
         qTGgQzjYdK+zQdLOQaX1GZfAsDDIFEFJfY15CopQvTmenR5PtLxuLyqHWYHrd1bgxjgI
         W3nrbTDJzcUTb5BRK111p5LBnZjDw/kA84QP5lh7Ev/3QwZcYqX45+4y/62ar3QztG7m
         1JwlCL7Ud319NGL+zlXLR5icCiC+DjsCmlXofjvK2uZXkJdTCQsMHMH9ARd9XF15E7BE
         GTzRnzFeW9Q+hgB4EbIclhn1BzNWh0DKT4OOjUZg9d0Y+wTQ9qMdaiT+v4wp0hxiNULX
         Y7/Q==
X-Gm-Message-State: APjAAAVtooy7bfyPhOeEcmwOwFi6IJqxw6ex9DYNSTXGi5umJedQCUZG
        sdhjTdMxNjpSPSvTwFBV8A0=
X-Google-Smtp-Source: APXvYqxYVrtnkOtcvtFEQ4emA5XTieW5HptukAIlK1bqxcK9dnvnWv3PlSpIjg8LSFhV9jh6AL+PIQ==
X-Received: by 2002:a2e:2411:: with SMTP id k17mr4072256ljk.136.1560082411340;
        Sun, 09 Jun 2019 05:13:31 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id p15sm1359619lji.80.2019.06.09.05.13.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 05:13:30 -0700 (PDT)
Date:   Sun, 9 Jun 2019 15:13:28 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 03/10] mm: rename slab delayed deactivation functions
 and fields
Message-ID: <20190609121328.xaumeyhu7an6qpru@esperanza>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-4-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-4-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:47PM -0700, Roman Gushchin wrote:
> The delayed work/rcu deactivation infrastructure of non-root
> kmem_caches can be also used for asynchronous release of these
> objects. Let's get rid of the word "deactivation" in corresponding
> names to make the code look better after generalization.
> 
> It's easier to make the renaming first, so that the generalized
> code will look consistent from scratch.
> 
> Let's rename struct memcg_cache_params fields:
>   deact_fn -> work_fn
>   deact_rcu_head -> rcu_head
>   deact_work -> work
> 
> And RCU/delayed work callbacks in slab common code:
>   kmemcg_deactivate_rcufn -> kmemcg_rcufn
>   kmemcg_deactivate_workfn -> kmemcg_workfn
> 
> This patch contains no functional changes, only renamings.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
