Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8732CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FE521734
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZZoSEWiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfJaSQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:16:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39442 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfJaSQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:16:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id t12so3041958plo.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=K2iXeP4n/LwziPu4ZI0OnTyPorZqTcS6twEPx1hqLdc=;
        b=ZZoSEWiuBiik9RngUZeM0aAoWI9AFCUNVgIOH02T+Zipkev3DGDSdgR04ugiyl+Xjh
         /w/R1/t8Uf/OyFOuZzdsZ2o0wguO61GJAUdq9KcvaQXB30WaHfBQBqNJtj3frvwjpZGW
         DNrZviL6OPWqo7YTYYINjXLQVdc1qRWQJyxExYmhi2EXcQtdi13mFBlEgJdEX/C+bVUu
         EEgHZexKJwTbTO/99HqM5GuZEcJKn8HmquvFjGXsrBjlRhISx5oBspIuE50ZE8KWy6EF
         oxMnUfuJaJlW6Lu2eCY3ofQ6ytmmH4E9Z/6EjUl3CigFKtL88U21b8Fdeb1wvNxAZTh3
         2FBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=K2iXeP4n/LwziPu4ZI0OnTyPorZqTcS6twEPx1hqLdc=;
        b=Y4zB6suYSI/oaed4ENRnCAyf4jYW+RFOcGcyBaTEbIN49HTdo8DUBIs2LedI+6GfOz
         ealcXGS64cjulpK38Uk8YSrSPn5abuD6O7TRSk4S16xMf6Kv/JPB4bLQl4CEmCLBKf8e
         Or9UNWKDa7Le/iewSRjgLB0n4wnYxHtij/P7ohnzzZ0ziDJifxbZMhHE5rVMeB7b35Xg
         E28vHv0FnUkU+Fo5D9IIQjHBoYRW9SheR6MexzOJZ9VOW5fi9K3zVHqExgvBbMx5Bl7i
         sMIJp3O5Abs/3eduya5FK6yqRDwlrmsVKh6iyRirrZxGoT+EM/hC7J6fbEdnqW3CjHMS
         CXAg==
X-Gm-Message-State: APjAAAUlALeSVQsVCI9jWpieROl3NR9Hba7vZ+j0LraADsPxT9vroKfL
        dWGeAJlvkK6EnlS2UKmSviW8SQ==
X-Google-Smtp-Source: APXvYqyubcz1aeS43b5/oVJTOA+Lgv6A7pzeQRkjnlzDj+Vyrx5Aef3FMZd2GCIXWcCCPV3DgS/bEQ==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr7864287pla.8.1572545769038;
        Thu, 31 Oct 2019 11:16:09 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 74sm3620489pgb.62.2019.10.31.11.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 11:16:08 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:16:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Roman Gushchin <guro@fb.com>
cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v2] mm: slab: make page_cgroup_ino() to recognize
 non-compound slab pages properly
In-Reply-To: <20191031012151.2722280-1-guro@fb.com>
Message-ID: <alpine.DEB.2.21.1910311115540.226869@chino.kir.corp.google.com>
References: <20191031012151.2722280-1-guro@fb.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Oct 2019, Roman Gushchin wrote:

> page_cgroup_ino() doesn't return a valid memcg pointer for non-compound
> slab pages, because it depends on PgHead AND PgSlab flags to be set
> to determine the memory cgroup from the kmem_cache.
> It's correct for compound pages, but not for generic small pages. Those
> don't have PgHead set, so it ends up returning zero.
> 
> Fix this by replacing the condition to PageSlab() && !PageTail().
> 
> Before this patch:
> [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
> 0x0000000000000080	        38        0  _______S___________________________________	slab
> 
> After this patch:
> [root@localhost ~]# ./page-types -c /sys/fs/cgroup/user.slice/user-0.slice/user@0.service/ | grep slab
> 0x0000000000000080	       147        0  _______S___________________________________	slab
> 
> Fixes: 4d96ba353075 ("mm: memcg/slab: stop setting page->mem_cgroup pointer for slab pages")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>

Acked-by: David Rientjes <rientjes@google.com>
