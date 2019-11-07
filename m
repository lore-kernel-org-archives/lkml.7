Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F1AFA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E328A2084C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DEq2d9wP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732987AbfKGCcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:32:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34505 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfKGCcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:32:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id l202so649718oig.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AHeH+k3q1YGRdVcK71lwkaCtcvgP7dVsV5GnTtoj2xs=;
        b=DEq2d9wPFiLHlbBQh4T+yaRBQsYILaoQXq1yI4S1YiUQbtgMwYBgOoYV88hwOdZMU5
         GHnkt3p84ev9URkfVlSTUApIfb/xp6J1w6wbf46IFkrE2Uxi1de+IGf2+F/G3Skls/0Z
         h8H060f0oB8KOVdroNFU9e3cmJh4yB18mqmI6UcP7NAgoNNy+AYMzlK/Ti9N0lVdmrW4
         +J+jisaNy7CTzmhSNNM7yNU5UDAMsZQEsTKcmn1S3cqaefQc5PxCFavlItazoFxA8BEq
         QUAXc5NnNs0sbaxmyPfFC326BfQypv4XYu8MYRzOmSzdgHUETuJdpFv9Me35Ho33B8sT
         +RVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AHeH+k3q1YGRdVcK71lwkaCtcvgP7dVsV5GnTtoj2xs=;
        b=BlMY+cMxV74eFH3TLVQQvAlToEWi5SFtdx+Refd3IqQrtpPUNseMSwWlmCpqo17T9X
         7zW4FvpgJabS+vNFo7bCoTLV7llN9/4fhBDoFY3DfLqLHkSlvOZTMhS/sh+v53lTacq3
         orRXFaQ6QEAKhhQV5hk55OcZOw+PrzipBQP+2xCt8cLKVNZCfpESs82mZKCNlnVTsA3H
         DvllqY/voT6Maq1qI6LBIldKqZCMJDiKPpiEBxc61xs0Kjx54mV3NJ3xx+2dB9U1xsKC
         tjDAPPthjCjezyTsCOOTLc8SGglf6KLMGIoEsS/NaiusPLboQ5UUE/oAM0tgNHlkywqO
         QU0g==
X-Gm-Message-State: APjAAAUUs9ZuFZspBvcEUcSUOgdLRaVuvRExTa2xFPOwWPjZ6cQe6jeI
        Qn3EIA/mEmeWeFya4wal2LmC1RCC+ysbcrbZH7/3RA==
X-Google-Smtp-Source: APXvYqztwmeiDA0mnICKAU44hM1wSeOw3WVwMf8C7tYj7HDrnvdXLqu1dNly6uEYJyDZNXKBi9CKk4/YwHZaxpI2HLo=
X-Received: by 2002:a05:6808:9ae:: with SMTP id e14mr1055079oig.79.1573093927619;
 Wed, 06 Nov 2019 18:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20191106225131.3543616-1-guro@fb.com> <20191106225131.3543616-2-guro@fb.com>
In-Reply-To: <20191106225131.3543616-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:31:56 -0800
Message-ID: <CALvZod7ickiX_D=7cJ_q4qjXebr93B7kh+WU61dagskA3Ye+0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: hugetlb: switch to css_tryget() in hugetlb_cgroup_charge_cgroup()
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>, stable@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 6, 2019 at 2:53 PM Roman Gushchin <guro@fb.com> wrote:
>
> An exiting task might belong to an offline cgroup. In this case
> an attempt to grab a cgroup reference from the task can end up
> with an infinite loop in hugetlb_cgroup_charge_cgroup(), because
> neither the cgroup will become online, neither the task will
> be migrated to a live cgroup.
>
> Fix this by switching over to css_tryget(). As css_tryget_online()
> can't guarantee that the cgroup won't go offline, in most cases
> the check doesn't make sense. In this particular case users of
> hugetlb_cgroup_charge_cgroup() are not affected by this change.
>
> A similar problem is described by commit 18fa84a2db0e ("cgroup: Use
> css_tryget() instead of css_tryget_online() in task_get_css()").
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> Cc: stable@vger.kernel.org
> Cc: Tejun Heo <tj@kernel.org>
> ---
>  mm/hugetlb_cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index f1930fa0b445..2ac38bdc18a1 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -196,7 +196,7 @@ int hugetlb_cgroup_charge_cgroup(int idx, unsigned long nr_pages,
>  again:
>         rcu_read_lock();
>         h_cg = hugetlb_cgroup_from_task(current);
> -       if (!css_tryget_online(&h_cg->css)) {
> +       if (!css_tryget(&h_cg->css)) {
>                 rcu_read_unlock();
>                 goto again;
>         }
> --
> 2.17.1
>
