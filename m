Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DD3C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF26214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMYdzWgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388230AbfDRIPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:15:42 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42664 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRIPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:15:42 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so1123471lje.9;
        Thu, 18 Apr 2019 01:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N323ote5HssxsLbgpRKGomemLtnlwkK3ixDMsYVRR2E=;
        b=WMYdzWgQaP+pXUvSIR0Au7VkGGsnRl6OCThTg4EgOhwD8wOevcHwx+wJU11rkan+k9
         mCfqu5ph/kf5FsMAwMRbizVoepAdM6+vYV8m+xe3GqrGQZLrsB5esZVa91DzWZxaG6Ps
         CQI0D1agoPwX01DUSe5CHaLm8J7aoOzub6m+L+4eXpRxTVNMFl63TopOk4asM/HDoQlS
         SIgpzsz5OVI5ASSTTtdc2vJHlGZOiKZr3LDH9KGpW+udXkX4/irjjCCJYf3woOXsCdc+
         bYiVHodrDUaDggrr7a987OZYleMblygMql7e4P6dBn4GyZqk4Q+uLeM0JfRQKuTgb1Yr
         1exA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N323ote5HssxsLbgpRKGomemLtnlwkK3ixDMsYVRR2E=;
        b=Z1sNjBfpwvoonEgqxaoPpuflaaQ8+hh/yyi8vbcJ+pSMf5uLP8+YYXlLN2yUWsl1dK
         NvWlQEk8u4stK6t84sISyGybmVDX+xWh1YnYoVosC3IHCls/0SHvVSUe2OhegJJTB39g
         YuN7jyudQXn2hACYm0J/kKLLCvSndHz93OHF9NZX09LoHMyudTn54IyOSF/GA6tv+07N
         AafFLreN5oYj7TL2hrlyMTONdp4F+oF7ZQO3UTL4LIrEDkV4LnCPsKpy5lrynUco82+a
         6+qx7OAEZJ1FHQ1Tp2DluksUiTwCVFZ0FWEGXuzaoC1UBrdtVKImDw3ml1T5/Z9vXCkG
         VvQg==
X-Gm-Message-State: APjAAAWmMWRya0eAm66a2Rmg4y/pE8UFDbRhyrtMBJ4yoAED3TYQKStb
        qsc6g4HDdvdSnAoQYFytXak=
X-Google-Smtp-Source: APXvYqzjkJpTHMK9RphN01MaAEQ8Cpo3cxvjAigAn5Tcf7lTFuZs3fK5+TNTiM3+kSzXVyIh+XiNCw==
X-Received: by 2002:a2e:8316:: with SMTP id a22mr10057018ljh.171.1555575340347;
        Thu, 18 Apr 2019 01:15:40 -0700 (PDT)
Received: from esperanza ([176.120.239.149])
        by smtp.gmail.com with ESMTPSA id v11sm296970lfb.68.2019.04.18.01.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 01:15:39 -0700 (PDT)
Date:   Thu, 18 Apr 2019 11:15:38 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>, david@fromorbit.com,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>, cgroups@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH 0/5] mm: reparent slab memory on cgroup removal
Message-ID: <20190418081538.prspe27lqudvvu3u@esperanza>
References: <20190417215434.25897-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417215434.25897-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Roman,

On Wed, Apr 17, 2019 at 02:54:29PM -0700, Roman Gushchin wrote:
> There is however a significant problem with reparenting of slab memory:
> there is no list of charged pages. Some of them are in shrinker lists,
> but not all. Introducing of a new list is really not an option.

True, introducing a list of charged pages would negatively affect
SL[AU]B performance since we would need to protect it with some kind
of lock.

> 
> But fortunately there is a way forward: every slab page has a stable pointer
> to the corresponding kmem_cache. So the idea is to reparent kmem_caches
> instead of slab pages.
> 
> It's actually simpler and cheaper, but requires some underlying changes:
> 1) Make kmem_caches to hold a single reference to the memory cgroup,
>    instead of a separate reference per every slab page.
> 2) Stop setting page->mem_cgroup pointer for memcg slab pages and use
>    page->kmem_cache->memcg indirection instead. It's used only on
>    slab page release, so it shouldn't be a big issue.
> 3) Introduce a refcounter for non-root slab caches. It's required to
>    be able to destroy kmem_caches when they become empty and release
>    the associated memory cgroup.

Which means an unconditional atomic inc/dec on charge/uncharge paths
AFAIU. Note, we have per cpu batching so charging a kmem page in cgroup
v2 doesn't require an atomic variable modification. I guess you could
use some sort of per cpu ref counting though.

Anyway, releasing mem_cgroup objects, but leaving kmem_cache objects
dangling looks kinda awkward to me. It would be great if we could
release both, but I assume it's hardly possible due to SL[AU]B
complexity.

What about reusing dead cgroups instead? Yeah, it would be kinda unfair,
because a fresh cgroup would get a legacy of objects left from previous
owners, but still, if we delete a cgroup, the workload must be dead and
so apart from a few long-lived objects, there should mostly be cached
objects charged to it, which should be easily released on memory
pressure. Sorry if somebody's asked this question before - I must have
missed that.

Thanks,
Vladimir
