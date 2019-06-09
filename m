Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07386C2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D495C212F5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCVFoo7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbfFIM3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:29:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37593 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfFIM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:29:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id 131so5488404ljf.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 05:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MXL4qzS5tDYfPtk0bERwMQ8xPqTAnXucMreBi2SqrNs=;
        b=mCVFoo7ulhKZFDXXA5kN2vuD7BliZW2iWtD8iSLmPJm8KpLV02zs2ncV98/tWXuqGm
         7M0CPaYeUnWZLMHghcjDl7bEeD0p1c1YUW84Vn99W5QD5MY/eWHY8Bnd6ga7oUgs3yWB
         31zs/BymNy8XV61jusfjmH4lZ6gat/66JzJzCZ3jfhRDIv+ASGIj/qwYNNVtuJf3nMcw
         h5NX7BoOxyjemzkNlZ6d7rWXtPJRWdbwJGecgDqOj0jsL4LRKwN8KpozzX0T/mwKHXAe
         8ooHbKQqo659Ur68uoPngVZi18rJw9C+/4r1LaP1I3a9e6xAlxP0+BgVCGfAwIeN60lC
         aHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MXL4qzS5tDYfPtk0bERwMQ8xPqTAnXucMreBi2SqrNs=;
        b=bwHkn5EFwVEsAPraPXaM6Sb9UlwDoLHK+gSXkx8xm46ALVMP/Li2JhfB0lBeif+TOc
         mTsnir0PxXlA8VhWh8PDFz6/xVwjcENY8mtUSVYOcYwlQnGN7cMcMhc2vHfJFtCe2nFN
         d5UUMWxxvPMYcTB+8uPWK9T4rcKCQOQaVU6jlID/1B1L42MzcpsnA66Sroiha0JiBngq
         4PfddVNtxUF2X3H8Mk1tcKF41xYYk4mfgBLOx2n1fu7LkisLbU+xjYWXorYyQLhY8+xj
         PkL5txBfIZAwnWzs5jATxPuJb2lJ8+ODrSsmaZbuXAyKJgftNr3PqodnExaZHVm4N3EM
         +ZFw==
X-Gm-Message-State: APjAAAXGD2hIcLgduAIctdxmgoCYnMJWdCDaRruhkSZ3D6SusPxn+OMj
        5in2Y6NEhYO2IoKc/2WoG3g=
X-Google-Smtp-Source: APXvYqyoBPCE6WKWoKCNyKKaK4VA43l9wIL6YzGk9O3XcYlZCZ0XRvRoRPgTDbDDtZ2uyMI1ay9aJQ==
X-Received: by 2002:a2e:86d1:: with SMTP id n17mr10475622ljj.58.1560083350819;
        Sun, 09 Jun 2019 05:29:10 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id 137sm1337886ljj.46.2019.06.09.05.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 05:29:09 -0700 (PDT)
Date:   Sun, 9 Jun 2019 15:29:07 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 05/10] mm: introduce __memcg_kmem_uncharge_memcg()
Message-ID: <20190609122907.glceyxdaexmau74f@esperanza>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-6-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:49PM -0700, Roman Gushchin wrote:
> Let's separate the page counter modification code out of
> __memcg_kmem_uncharge() in a way similar to what
> __memcg_kmem_charge() and __memcg_kmem_charge_memcg() work.
> 
> This will allow to reuse this code later using a new
> memcg_kmem_uncharge_memcg() wrapper, which calls
> __memcg_kmem_uncharge_memcg() if memcg_kmem_enabled()
> check is passed.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
