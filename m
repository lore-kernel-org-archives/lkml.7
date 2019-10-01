Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54DFC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788DD2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IeYUUoTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbfJAOkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:40:10 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34987 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388925AbfJAOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:40:09 -0400
Received: by mail-qt1-f194.google.com with SMTP id m15so21935056qtq.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9VDIX95q75l1fcGPHAGCoexbF88NYXczf33Qn1D7mVs=;
        b=IeYUUoTk8eThv+72jp/pu8xdlXAAX3/zY7+IYupoKCxoermZheJWI2mo/kCxoX9snx
         axePe7gr3wV54BxZqT/+17qIbHZ7OBZwdPCzV3bvxJW064GLwtbydfK8IG03nph4oexj
         VdPBwQumivhwrAaBWPsJv1sWgC25P8FIgxuzWJKhmJw25hkWNqen/jbydTfC5Yh1LGzA
         qh9CmPBeE9R4aXGYkDViCY+fox3lMgOFu471rQJ3cDyGzPLktOYX1FDYoQDKH2EKrjQ8
         E2zZ/g0fWndeRA309yMCUTfJ3uRFlKpj6BQtWyUfSSsrMSJIjg8gSg5DVJc+Lfzn6Tgp
         Vzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9VDIX95q75l1fcGPHAGCoexbF88NYXczf33Qn1D7mVs=;
        b=f3BvyDLA7aEaB3yfa8Jhj4oGHHdd7P/qd1c1hQSrRa0S04FppzDXc/zYKFfeO5pUqo
         Ix8q/ziDiRDWXyXdeCJhX20wH6ZLeZnsjHehyPnXFymVyvLpqYeqoAzUIgzYYE8bNGVn
         sJ9Abmw/7lqajTVLOPzlLBun0cW/Ki6//x2c0igPjM47ea1fvUdpOITFcknv1JVajDAR
         26SgY592pdBarhEfkvenKBt+Jx/EItifue6dSGr/UD7XdVp+vQFPjqFTsWV7lqhA3d3F
         CusxFb6WYIdg7QptK24sOybV5hlKbqA4ls/0wV161FsWxd7RJQEb0K+VARXIMCyBYWi9
         Lc2Q==
X-Gm-Message-State: APjAAAXijXsnSRuS6QWpiaUVTBZITTvYWioKnZS+w0xQd4fYRb/WQKAO
        WDs0+o2BlG5IZG2ri5DBIPb+0g==
X-Google-Smtp-Source: APXvYqzJ4rqvFAJEgTDf25ELUEziBgh6eojZxo/BhgpnqhUElgq0KqGYVa27C4uPjU2WvJ+a3QRC7A==
X-Received: by 2002:a05:6214:180a:: with SMTP id o10mr25687114qvw.51.1569940808438;
        Tue, 01 Oct 2019 07:40:08 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q2sm7515437qkc.68.2019.10.01.07.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 07:40:07 -0700 (PDT)
Message-ID: <1569940805.5576.257.camel@lca.pw>
Subject: Re: [PATCH] mm/memcontrol.c: fix another unused function warning
From:   Qian Cai <cai@lca.pw>
To:     Arnd Bergmann <arnd@arndb.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>, Tejun Heo <tj@kernel.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Tue, 01 Oct 2019 10:40:05 -0400
In-Reply-To: <20191001142227.1227176-1-arnd@arndb.de>
References: <20191001142227.1227176-1-arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-01 at 16:22 +0200, Arnd Bergmann wrote:
> Removing the mem_cgroup_id_get() stub function introduced a new warning
> of the same kind when CONFIG_MMU is disabled:

Shouldn't CONFIG_MEMCG depends on CONFIG_MMU instead?

> 
> mm/memcontrol.c:4929:13: error: unused function 'mem_cgroup_id_get_many' [-Werror,-Wunused-function]
> 
> Address this using a __maybe_unused annotation.
> 
> Note: alternatively, this could be moved into an #ifdef block.  Marking it
> 'static inline' would not work here as that would still produce the
> warning on clang, which only ignores unused inline functions declared
> in header files instead of .c files.
> 
> Fixes: 4d0e3230a56a ("mm/memcontrol.c: fix a -Wunused-function warning")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/memcontrol.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index c313c49074ca..5f9f90e3cef8 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -4921,7 +4921,8 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
>  	}
>  }
>  
> -static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
> +static void __maybe_unused
> +mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>  {
>  	refcount_add(n, &memcg->id.ref);
>  }
