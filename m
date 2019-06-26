Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6CFC48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52BE20665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 00:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ah/LPaiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFZAPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 20:15:25 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:38394 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfFZAPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 20:15:24 -0400
Received: by mail-yw1-f67.google.com with SMTP id k125so163366ywe.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 17:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KKVa5Ei85vO/xl8eKxbG6qTUC2Z/5faLfHmHsNuzkTM=;
        b=Ah/LPaiXFjkiiPD77qZcdlWGO13E2LGO4ZIJGolulIyLP4ucxhY+XFE2dcLhlYzbB3
         6BqGf1qlPAtAc4t51PD4a5o866Hrmru/gdSHFEzovDQZawzBoAmkSZ8fFpw548ilFx/U
         hnfAWZHGRpPl++/3NbDHb7UL2MqkpXcoHip/NaD4nWPEpNVYFxN+5K5gOJhjm4n4pJwF
         z5BEw8DVUKjWxZ31//Fk0/K3hkUP81CYNDfewsLGwCbrHqwf9U2z6ZddYpT9BiQxdPcu
         1La96rfXWbZp9VkK4Sf3sAbCvIrp9EIT93lB0PPTIR47atoSKU+g8l6XtC4AZgsbqRmz
         qSFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KKVa5Ei85vO/xl8eKxbG6qTUC2Z/5faLfHmHsNuzkTM=;
        b=Z7MKdSWxfXjbwMbR68w5O/oMJAnC1MiF/ZCszFhoMFCi6LJntBQoeAWp67c7MKLTKI
         hhmkGIOVh40pAhq9fUwsWNOgRqwwTqjt9QabF0pCboXkowLqrogOMspxDCIa/ExVL4gf
         VsI4p8qMwUiN/Jq5qo0a5eNsVuvxco9/MzEK4lqmTMNKj3rWeAY+tvRq52r0JTMjtSqI
         lThQhAOur/kLi/ZM8jHPqDIcCQ6xHU+meXdg9RMm5stpaq4Hq/ajkkykFOHKXntulY8H
         J5ctdM1N6FbvgEehgQsXvEXwAMrDaUvN9NnjVutPOa6mqKZNDpN3n91i0qFB2ukyrH4x
         M0Tg==
X-Gm-Message-State: APjAAAV8jwlmNmiX+Ols8VKg4znx4EUQ3DoLcI56nikueRkzqIiHEBjQ
        h3IAAW1ejjDOjIHNwsUuyHJXj/MTXatar5qHGRY/Jw==
X-Google-Smtp-Source: APXvYqynzG0duVfTH8jitCp8dKbdD8azxAbifWP6sAGnrQlrTRm3+PLFaapULGqEPf0anL+TKNdFDILsHzx56cfQMVA=
X-Received: by 2002:a81:4c44:: with SMTP id z65mr1001089ywa.4.1561508123747;
 Tue, 25 Jun 2019 17:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190611231813.3148843-1-guro@fb.com> <20190611231813.3148843-11-guro@fb.com>
In-Reply-To: <20190611231813.3148843-11-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Jun 2019 17:15:12 -0700
Message-ID: <CALvZod7AuMLQP32P=aRJqwLMeGVUx3G86ANoM_f1Eii9f6EqbQ@mail.gmail.com>
Subject: Re: [PATCH v7 10/10] mm: reparent memcg kmem_caches on cgroup removal
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
> Let's reparent non-root kmem_caches on memcg offlining. This allows us
> to release the memory cgroup without waiting for the last outstanding
> kernel object (e.g. dentry used by another application).
>
> Since the parent cgroup is already charged, everything we need to do
> is to splice the list of kmem_caches to the parent's kmem_caches list,
> swap the memcg pointer, drop the css refcounter for each kmem_cache
> and adjust the parent's css refcounter.
>
> Please, note that kmem_cache->memcg_params.memcg isn't a stable
> pointer anymore. It's safe to read it under rcu_read_lock(),
> cgroup_mutex held, or any other way that protects the memory cgroup
> from being released.
>
> We can race with the slab allocation and deallocation paths. It's not
> a big problem: parent's charge and slab global stats are always
> correct, and we don't care anymore about the child usage and global
> stats. The child cgroup is already offline, so we don't use or show it
> anywhere.
>
> Local slab stats (NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE)
> aren't used anywhere except count_shadow_nodes(). But even there it
> won't break anything: after reparenting "nodes" will be 0 on child
> level (because we're already reparenting shrinker lists), and on
> parent level page stats always were 0, and this patch won't change
> anything.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

The reparenting of top level memcg and "return true" is fixed in the
later patch.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
