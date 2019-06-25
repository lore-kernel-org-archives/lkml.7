Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299ECC48BD6
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069412085A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 18:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0zhknit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732845AbfFYSRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 14:17:18 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:43908 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbfFYSRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 14:17:17 -0400
Received: by mail-yb1-f193.google.com with SMTP id 5so4289949ybj.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 11:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LV+Pj0XizZBoM+Zg/sXCVKPC66eQENrb7Ey4RHKp69s=;
        b=Q0zhknitW1nMpsuYODap81b+Kff2FM//a6CrncKspkGXfz6ukAPtuB4vDq/ujO0Q4P
         Bsvo/811XJHJD4y7+vKLSA/Ir2MSraBJu1zfY7Ur/9MpBPG4tVWAqZ0jr0eO8XThScKm
         xkqUTB8U2/BXKwnxr8KaKQa0aN0JevXkYQ69KDF/7ktoFH4lAScTbmdbKfbbvpKrOqoU
         TR/V28hTfDInSozjEuFH6hvQG5RrZ7ArINs68zsK+twdmu9MvlXJ0/NGt9d0YeHILF2Y
         c/CInQ8UrQAjnUW8ZYJsWyQmUXrZMU1tGH5UpJoxnMPkgQzkmJRhTP3vClkIrGpwa82o
         lQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LV+Pj0XizZBoM+Zg/sXCVKPC66eQENrb7Ey4RHKp69s=;
        b=UU+tKqyrY7Ocbp4adKc0uZVLoXnO+X5nelR/rI+aXYN+R3xVGs9VG0/Wdc1RKPT0T7
         fNgzx0Wa59E1mJfQFzYjrcr6JkNR8lHGWU8avxXpfULW8ndSeJ29JldXYzvJX/rBDQwn
         tfw8RgdW6MzvMsocxY1beaH8Z8k8SfFb5okJ9vSLsqqUU4/lNe92mzLutim7bSqj15TX
         C7LHhREZ0xATJ4sxExIXPT1fCgFmkkpjvFbW7erREL2lr+PW2cr/RBMwpoUy45dOjsMD
         fpURhvfswBkQRhoormkFSBIIKn8G+iEbUU33zuDjo64JtZm7RonfLXxnqawzV6Fcd6d0
         8eYw==
X-Gm-Message-State: APjAAAXeryX/IL7yHU0cIKMIwhDKdR2+offcJPCQYqq8yvK9GkEzOmsA
        vm/C4hxSnogB9d6H/XCHXJKIwn28Xj2xEPsoroXKcQ==
X-Google-Smtp-Source: APXvYqyOBKfMA9lKTfCv08MGlGUTAUGGHiNLkjP3FZ0Jpmnx5mxfL+mlmmC/u6PckTvZybw780vm3EK1meJ5YTRbNwU=
X-Received: by 2002:a25:1ed6:: with SMTP id e205mr81985599ybe.467.1561486636279;
 Tue, 25 Jun 2019 11:17:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190611231813.3148843-1-guro@fb.com> <20190611231813.3148843-3-guro@fb.com>
In-Reply-To: <20190611231813.3148843-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Jun 2019 11:17:05 -0700
Message-ID: <CALvZod41GMxCdsp_XSHSYAri5NpO5suimJ3y8D5=LLai2=qd7Q@mail.gmail.com>
Subject: Re: [PATCH v7 02/10] mm: rename slab delayed deactivation functions
 and fields
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
> Acked-by: Vladimir Davydov <vdavydov.dev@gmail.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
