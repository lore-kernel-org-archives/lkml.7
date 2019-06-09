Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C162AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B05F20652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4YLVhvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfFIRJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:09:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43223 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbfFIRJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:09:09 -0400
Received: by mail-lj1-f194.google.com with SMTP id 16so5794845ljv.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 10:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SVFb92jStOUm7FrDt2zzfDZopbwt0k6o8Y+bNfKiHmE=;
        b=h4YLVhvOorSOqenh/f1Bfik5jof3C1oJr99L3BAEiC30vXLOQLOhta3DqN4cFuMrCR
         kSmzIPGSe/Df4sups5Foy+UBkAZH4ekAUvk9e6N+B66TEvfAFoydIYEVuuwY0NhkwWQ3
         nJLOuQRDuyTRYaLHNZ/ho/m/l2oLJGg6FaQ3C6WST9e48H+dneVBxl/uig9D7xxGUMzs
         4CZGlQ75U1yTg3/yuLOzHmedlR6sJdUekPgbSJ957WA4J970PfsjWWxfPTKUY77cLODe
         IPUjzyXe4PSD22yUDhEx7M9aB7b7lcWkbcDJggLnP9oubHGHtwHHZYY6buIeEGacHViB
         H7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVFb92jStOUm7FrDt2zzfDZopbwt0k6o8Y+bNfKiHmE=;
        b=LNq9QsKDpWlzOD9gjne5OBhcokn+G6wsFPkViC6D/Wd7JKk7MxRWFKrnaLicvyC0RW
         Ou9dFthLsK38u7AiCyx5hgKHP+le/hF0Epbd2CuMd/6t0vvGjaEyeZI6nhpZek9Ffklu
         2UqSHtNkDX3sYl93o3f5gaz357e/TdI9Ty3jwD1LbUkLcXEpp+9QHYBeh5m2J6m6lJnP
         3lcR0/D8nXz5VhMEpZvSqLXj+C67NGrGBkzWby7O+s/JbfTtD9N1dWS2z+4Z6aITPRsq
         CAvqD2E2U+NF+d92FvtxdjQM+h6aIFfQVFMUM1klxCFygLW+wkRKqVZIpJVBEn+uRfnx
         6bDA==
X-Gm-Message-State: APjAAAUFqShF71BqRSvrvFCVIxhZc5ZNzjHzn83kfk7msmf7tH+aN3X3
        Wk1pJRpuZ4CHqmTCij4uoDhunSq5Mkg=
X-Google-Smtp-Source: APXvYqyRZvryIGVQSMSxXuuKTyXUevEcqVa2kex0G0TyMjAyk4fYU9KhM7x7/Cu5vz9PNqHqSRma3Q==
X-Received: by 2002:a2e:9e07:: with SMTP id e7mr15412972ljk.55.1560100147772;
        Sun, 09 Jun 2019 10:09:07 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id x29sm1513881lfg.58.2019.06.09.10.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 10:09:07 -0700 (PDT)
Date:   Sun, 9 Jun 2019 20:09:04 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 08/10] mm: rework non-root kmem_cache lifecycle
 management
Message-ID: <20190609170904.nxa2rb6inkvx3geg@esperanza>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-9-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-9-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:52PM -0700, Roman Gushchin wrote:
> Currently each charged slab page holds a reference to the cgroup to
> which it's charged. Kmem_caches are held by the memcg and are released
> all together with the memory cgroup. It means that none of kmem_caches
> are released unless at least one reference to the memcg exists, which
> is very far from optimal.
> 
> Let's rework it in a way that allows releasing individual kmem_caches
> as soon as the cgroup is offline, the kmem_cache is empty and there
> are no pending allocations.
> 
> To make it possible, let's introduce a new percpu refcounter for
> non-root kmem caches. The counter is initialized to the percpu mode,
> and is switched to the atomic mode during kmem_cache deactivation. The
> counter is bumped for every charged page and also for every running
> allocation. So the kmem_cache can't be released unless all allocations
> complete.
> 
> To shutdown non-active empty kmem_caches, let's reuse the work queue,
> previously used for the kmem_cache deactivation. Once the reference
> counter reaches 0, let's schedule an asynchronous kmem_cache release.
> 
> * I used the following simple approach to test the performance
> (stolen from another patchset by T. Harding):
> 
>     time find / -name fname-no-exist
>     echo 2 > /proc/sys/vm/drop_caches
>     repeat 10 times
> 
> Results:
> 
>         orig		patched
> 
> real	0m1.455s	real	0m1.355s
> user	0m0.206s	user	0m0.219s
> sys	0m0.855s	sys	0m0.807s
> 
> real	0m1.487s	real	0m1.699s
> user	0m0.221s	user	0m0.256s
> sys	0m0.806s	sys	0m0.948s
> 
> real	0m1.515s	real	0m1.505s
> user	0m0.183s	user	0m0.215s
> sys	0m0.876s	sys	0m0.858s
> 
> real	0m1.291s	real	0m1.380s
> user	0m0.193s	user	0m0.198s
> sys	0m0.843s	sys	0m0.786s
> 
> real	0m1.364s	real	0m1.374s
> user	0m0.180s	user	0m0.182s
> sys	0m0.868s	sys	0m0.806s
> 
> real	0m1.352s	real	0m1.312s
> user	0m0.201s	user	0m0.212s
> sys	0m0.820s	sys	0m0.761s
> 
> real	0m1.302s	real	0m1.349s
> user	0m0.205s	user	0m0.203s
> sys	0m0.803s	sys	0m0.792s
> 
> real	0m1.334s	real	0m1.301s
> user	0m0.194s	user	0m0.201s
> sys	0m0.806s	sys	0m0.779s
> 
> real	0m1.426s	real	0m1.434s
> user	0m0.216s	user	0m0.181s
> sys	0m0.824s	sys	0m0.864s
> 
> real	0m1.350s	real	0m1.295s
> user	0m0.200s	user	0m0.190s
> sys	0m0.842s	sys	0m0.811s
> 
> So it looks like the difference is not noticeable in this test.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
