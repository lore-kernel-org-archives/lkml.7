Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD436C28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63C9205ED
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRanUUu1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388990AbfFIRJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 13:09:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42273 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388549AbfFIRJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 13:09:33 -0400
Received: by mail-lj1-f194.google.com with SMTP id t28so5793875lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LznUc87kOzY43gG7GqM3uuB+dRBgbcnhswA/OnlhqSI=;
        b=iRanUUu1JtHll99gtTKBlOGAMCDt8WvFcIqAZrrJoVIxcg56HvmrRG2hEUVZqosEjY
         Oo/YhOn8KaZV9XTNdFolb091lW/+VrIJnibQnj14x2yT0UPHDUY9fUAS8dH0V29tW1xf
         4O7Dxvd4my18SNZvsB/sjKMXcE6cuvl8yNyVGZ7mtOyIm49EjP9YQDirCIdYKf0Np0Pg
         MAaGRfC/jvONh+OhXxtd+P8/856HGdn3/Rdjn3LcGBLXLtwRnF2kScbn9d0+BeW8603f
         tWAzG7rkKyEwSwXhJTmaL6qfX27aB65/m9HS9p6eTNEmC4sY6bDEK9zVR+klP5E/Vaq4
         jPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LznUc87kOzY43gG7GqM3uuB+dRBgbcnhswA/OnlhqSI=;
        b=ExMdGjnloVakWolK4B0Redvj2UBzWlm13KuBOBJ0IXoUkt4CBt16rb5C5ViFWreq+d
         58MFgTIwA7GigLUhd4fbyZGXOugOvCMHSJqiFdz1nrkxm0BjOe+KcIoYt69XHIcmqEmw
         uhwFZnpImi6ushc+ZuilRnGaYWHwkg8Lgc6UoO23LwPQeOKnSXTnLf40U9Fdzs+goFPQ
         O8OT5g09OJJ260yBlYN4ekCjPlqEiwrpyyd0OweUp/R26ZaCbYPV7EzMI3njp4wePFd8
         8txhumayw8ehpidcqT1aqncT0WUpwswzgkEM2x9D+3TYlwa5hsxFD+T8lFBuBR6H41qs
         Lc4Q==
X-Gm-Message-State: APjAAAWkoVljjDQObND9+uEbekeapPSJFea7WLSv6JjsPxJM4P3DTx8d
        zGYdWaVhTHkYnD8IRHojQ+U=
X-Google-Smtp-Source: APXvYqxBPS20PyWYhWunBvHAxE3Ys+hxIXMtjHYOBfOTkjSdU2FCtQMlvCeRqA75p0u3fD1jWFjOTA==
X-Received: by 2002:a2e:8195:: with SMTP id e21mr12057526ljg.62.1560100171209;
        Sun, 09 Jun 2019 10:09:31 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id u18sm396497ljj.32.2019.06.09.10.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 10:09:30 -0700 (PDT)
Date:   Sun, 9 Jun 2019 20:09:28 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v6 09/10] mm: stop setting page->mem_cgroup pointer for
 slab pages
Message-ID: <20190609170928.wetyjpueslcj3qft@esperanza>
References: <20190605024454.1393507-1-guro@fb.com>
 <20190605024454.1393507-10-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605024454.1393507-10-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 07:44:53PM -0700, Roman Gushchin wrote:
> Every slab page charged to a non-root memory cgroup has a pointer
> to the memory cgroup and holds a reference to it, which protects
> a non-empty memory cgroup from being released. At the same time
> the page has a pointer to the corresponding kmem_cache, and also
> hold a reference to the kmem_cache. And kmem_cache by itself
> holds a reference to the cgroup.
> 
> So there is clearly some redundancy, which allows to stop setting
> the page->mem_cgroup pointer and rely on getting memcg pointer
> indirectly via kmem_cache. Further it will allow to change this
> pointer easier, without a need to go over all charged pages.
> 
> So let's stop setting page->mem_cgroup pointer for slab pages,
> and stop using the css refcounter directly for protecting
> the memory cgroup from going away. Instead rely on kmem_cache
> as an intermediate object.
> 
> Make sure that vmstats and shrinker lists are working as previously,
> as well as /proc/kpagecgroup interface.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>
