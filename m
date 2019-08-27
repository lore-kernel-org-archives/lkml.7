Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C255C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4F422CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 11:52:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8Ra+hm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbfH0LwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:52:00 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35774 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfH0LwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 07:52:00 -0400
Received: by mail-io1-f67.google.com with SMTP id b10so36528497ioj.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpAYaVqXIDzzWCYZGUrTDP575lSiv4NfiGUR8GS0TG4=;
        b=S8Ra+hm/VktuuLKgmXx4Led4HSI634Wn+GEvQh1Ot6rcatTA2Y/lNWklJLiqI0P8Pt
         6OqGGTKtYOiza2E6DKy1zWfQrnZyZBckWn57+KtTa7FXZugmLUD1NSsaEY28WF9jnf+u
         YI07oKFCtQnfaYOmxVsmwtRfn2wttE1TyKmNRUs42e7y338D4atqXpOhzvQQ6+WjZOmN
         wDfenOnM8zUKCRtRzzx+nU1iOUMoLtY27sIBfXsOS09D5fJkDzUipmkxzF/eX8Y51kwt
         aR2//zKKXBf2DJVHcJCI7WM6DgqqrqEX+kGO2T4Q/vVxJnukkJRPxV33X0arScjPvN/i
         9fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpAYaVqXIDzzWCYZGUrTDP575lSiv4NfiGUR8GS0TG4=;
        b=myBm88WG4ojxrVobdcji+2596nEEFq65cfd1UcFggKDQ2VQoDGKZYOs04az2E9MfVy
         oWNnHRVMyqL6zCZhF0hXnp5/sOoZo/ziV6CjXnnonrulEptlEpElTquBzsrat6/1PR4y
         BTHgbZXIWsIKUdCkTTKmMDoBNUjuSpR0jszLz2TlWJyxVuwaiF7Gn0eXLc2gTiCNxCIm
         JyfMTodcfB25kbiP0A7saHhjWHIGAKtyZMNhAsguFdqwrBDy54PZgcaPq4JrtSErWSNc
         mhIytUNZjYkwlqbJaRJ3MZU/xLhVtAZPEWC8lIkwE+eaLZ5o1RE5sRSDgvRYdFCFdM6T
         7I3A==
X-Gm-Message-State: APjAAAU0eNQQv2BrlkOAZsacgIhT0q8wtelgV0jVZ7+j6tyqb3gJCBFa
        erav0WXV1L5S+9yJ0y7E9BhjEtRU8ilKWMP2RVE=
X-Google-Smtp-Source: APXvYqy4z6BwI8sXMDX6dDDYBASFKNHi7rHKynHJNOAjqWi131ChcpUvAK5PPT7mm0ZbhEe5qGwgD/G3K4PRdClYHp0=
X-Received: by 2002:a02:495:: with SMTP id 143mr22026989jab.94.1566906719117;
 Tue, 27 Aug 2019 04:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190824130516.2540-1-hdanton@sina.com>
In-Reply-To: <20190824130516.2540-1-hdanton@sina.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 27 Aug 2019 19:51:23 +0800
Message-ID: <CALOAHbAuY9BnpX6x4KSNURbzybjn5UdSNL7-1Li3R0HSQBqiGQ@mail.gmail.com>
Subject: Re: WARNINGs in set_task_reclaim_state with memory cgroup
 andfullmemory usage
To:     Hillf Danton <hdanton@sina.com>
Cc:     Adric Blake <promarbler14@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 9:05 PM Hillf Danton <hdanton@sina.com> wrote:
>
>
> On Sat, 24 Aug 2019 16:15:38 +0800 Yafang Shao wrote:
> >
> > The memcg soft reclaim is called from kswapd reclam path and direct
> > reclaim path,
> > so why not pass the scan_control from the callsite in these two
> > reclaim paths and use it in memcg soft reclaim ?
> > Seems there's no specially reason that we must introduce a new
> > scan_control here.
> >
> To protect memcg from being over reclaimed?

Not only this, but also makes the reclaim path more clear.

> Victim memcg is selected one after another in a fair way, and punished
> by reclaiming one memcg a round no more than nr_to_reclaim ==
> SWAP_CLUSTER_MAX pages. And so is the flip-flop from global to memcg
> reclaiming. We can see similar protection activities in
> commit a394cb8ee632 ("memcg,vmscan: do not break out targeted reclaim
> without reclaimed pages") and
> commit 2bb0f34fe3c1 ("mm: vmscan: do not iterate all mem cgroups for
> global direct reclaim").
>
> No preference seems in either way except for retaining
> nr_to_reclaim == SWAP_CLUSTER_MAX and target_mem_cgroup == memcg.

Setting  target_mem_cgroup here may be a very subtle change for
subsequent processing.
Regarding retraining nr_to_reclaim == SWAP_CLUSTER_MAX, it may not
proper for direct reclaim, that may cause some stall if we iterate all
memcgs here.

> >
> > I have checked the hisotry why this order check is introduced here.
> > The first commit is 4e41695356fb ("memory controller: soft limit
> > reclaim on contention"),
> > but it didn't explained why.
> > At the first glance it is reasonable to remove it, but we should
> > understand why it was introduced at the first place.
>
> Reclaiming order can not make much sense in soft-limit reclaiming
> under the current protection.
>
> Thanks to Adric Blake again.
>
> Hillf
>
