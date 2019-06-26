Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293E1C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0123F208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pVlUNDcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFZAQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 20:16:00 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:40146 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFZAQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 20:16:00 -0400
Received: by mail-yb1-f196.google.com with SMTP id i14so273711ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 17:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hBC31XsM1drX/BZAp0N2OzT0r+e6co+lkmZ6G0GOVU=;
        b=pVlUNDcM4cTi+agb1ezQeSRdpds872gA7cb6ZJ+baveCQCZw167X+Pb0NoSrYCPnIZ
         sf2SLj7IntgrbvnK4d70pRjkOHGKLkGjpCUUeY1KiNj4MKlhKC7A60xtgR4RarZVhHa8
         wUZY/HAv8uD8BwX9pcaLVVV9tVpVaTKtHLevMa/qA4Y4yPsSIy/xJzezpaGNRWYRP9dL
         rUx+O8OaqM4GcgiHUT/QEEjFbkksKz10UfVJ98MwhivQPhcj7ocX9O1xHW8OSBY7TaUw
         YHKHz2eNMBMhLFeUUtjp5QOHRhrZ9fxu2wmFJEC2OJjqXK3sJenC0N1OVW3pJNyS1pxO
         BwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hBC31XsM1drX/BZAp0N2OzT0r+e6co+lkmZ6G0GOVU=;
        b=aoeuuNCYiqixpwhLq0zKz5QtPQajsyXT54QMYsV+SbHN1pM5cEPzqhpFSsrhgSm2sw
         FLfwAF1pnhBm1o/3QsieDXYnq0olmdEWHzkXVfLQiVyVMxYuPMYzdSM9rhHDKGoZp7KU
         EVXsosLz1Q8DNuCxUqsbsnKYQENxtnO+vcM+PJ73a6I9BnGJ1BjOoJPVThAiojMwK75T
         Lp+EjIUCVR4KGnWl33gP2vwIVZ0M3SelzI1poVXFn208C1WjLo3FVyIZ0gLcKTRpHX1D
         MOdZJsEVVQjB7Vqj2ZdgQjVPJj4JZD2JvQ1NUkjXujkjJQ61vJDPy/aGJqilhk7pNGxc
         mS3Q==
X-Gm-Message-State: APjAAAXuJy1XtW+rC/QE2koOJ25FXm0tEqE4sb9T17zbq7BtKtlskj4X
        5WWP12E3qndUpVX6QMGNxMybiuLTXCrxZbvl3lT2gw==
X-Google-Smtp-Source: APXvYqziwXiEu45zHzvz6AOVywxIKSFUF9xqlnDZnM9NN4/TdLcixitnoMQV0xS/KG+Sf7SbappnvvAohrHdZMKzwm8=
X-Received: by 2002:a25:a107:: with SMTP id z7mr790646ybh.165.1561508159394;
 Tue, 25 Jun 2019 17:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190611231813.3148843-1-guro@fb.com> <20190611231813.3148843-10-guro@fb.com>
In-Reply-To: <20190611231813.3148843-10-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Jun 2019 17:15:48 -0700
Message-ID: <CALvZod4YoO0eoQmocHEFP7zrYpf3SzvaBEDpfDHS=_fiCyYcAA@mail.gmail.com>
Subject: Re: [PATCH v7 09/10] mm: stop setting page->mem_cgroup pointer for
 slab pages
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 4:18 PM Roman Gushchin <guro@fb.com> wrote:
>
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
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
