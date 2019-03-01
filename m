Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F23C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E738A2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sG3dZWqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732879AbfCAIjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:39:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42817 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbfCAIjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:39:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id p1so17392791lfk.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2019 00:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnyFKua0Ma32Sx5B0QpXHBKkuP+Q5Kg1stVhtIDMIX8=;
        b=sG3dZWqgA5FRR3DHZ21C2LtXUuYzUbMwmm40oOBmGxStSvL9weTGNbaiKykOuPAiVK
         1Hf7pzcpFz0Hacot/mz3PFr3tmM+afJ4FnE6mDxgzMp8CW9hzV4LYlgIqxa0r55i65P2
         TOcRqJ3/LGPJmAoCJcuqytQ9iXbcN7NbLENL2ugxRyHVGj5MUqUu1+wphbzsXfTJpkqz
         02mOx+pa4iFrGsCsf5/DUEPYnN8fL8eEDiDghOtjBoGUm46D0m3UduPIrfvoUwOkCeDL
         8SbeMq1k4cMEWrfPQWZJaVAE49CMpgEKiIzwaTXSV/q755DNphwffmzIJKKAvvVYn68W
         0zwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnyFKua0Ma32Sx5B0QpXHBKkuP+Q5Kg1stVhtIDMIX8=;
        b=WMQGXQTLUy0lAoSQlMKRcG1Ci28ZRkf14L1846yH625roNQcMyMEo/79R6Fj51IMhH
         ThKN4qP0p0DO/QgnUnV+FubP3iiYL00omGyhzg7xpM6XZc36gTaoHmMPcF5rtJ9TS/LY
         mEY8/9k4QM2RrsBmM7hiF4zOaX3lVGLYqt+E2a1ZeszAJojfoFH0UF4Ast5cHIlXlGHX
         vf7r4OthNqdAG7Oq1SIOX/xKqo7GM8a3jnLhcQzGwCxA4zZRtxZ8kMwHLrb+1j/hD2Cp
         Ep9kw5FhAnOKDdi+zaUEXCNnSU3u3TXEJjqusUGacEZH3Pwgkr7SXxWyDbaw8eed6iK+
         tKQQ==
X-Gm-Message-State: APjAAAX6uo7oaYVSCX4PBg24vLo5ris1vYNFCWgB8RvEbn2PfRowHgV+
        WZFaNddrOrEdjhpmCqsQgrYKdLK4DX9HiOXK4J0=
X-Google-Smtp-Source: APXvYqy5PcgDQYb1oYkgk2pPVnrAPHJ6sZPWqn5OfCb3xjll6lhXw3UFaD6I9nG2MYc8DKEueHBjx++6JBbPWVnh6dw=
X-Received: by 2002:a19:c616:: with SMTP id w22mr2281551lff.31.1551429542532;
 Fri, 01 Mar 2019 00:39:02 -0800 (PST)
MIME-Version: 1.0
References: <1551421452-5385-1-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1551421452-5385-1-git-send-email-laoar.shao@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 1 Mar 2019 14:08:50 +0530
Message-ID: <CAFqt6zZAjt2gmYPT_KPosfeDKnWNeBJoveKEytOJZeDHh=ZjzA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: vmscan: add tracepoints for node reclaim
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        shaoyafang@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 1, 2019 at 11:54 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> In the page alloc fast path, it may do node reclaim, which may cause
> latency spike.
> We should add tracepoint for this event, and also measure the latency
> it causes.
>
> So bellow two tracepoints are introduced,
>         mm_vmscan_node_reclaim_begin
>         mm_vmscan_node_reclaim_end
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
(for the comment on v1).

> ---
>  include/trace/events/vmscan.h | 32 ++++++++++++++++++++++++++++++++
>  mm/vmscan.c                   |  6 ++++++
>  2 files changed, 38 insertions(+)
>
> diff --git a/include/trace/events/vmscan.h b/include/trace/events/vmscan.h
> index a1cb913..c1ddf28 100644
> --- a/include/trace/events/vmscan.h
> +++ b/include/trace/events/vmscan.h
> @@ -465,6 +465,38 @@
>                 __entry->ratio,
>                 show_reclaim_flags(__entry->reclaim_flags))
>  );
> +
> +TRACE_EVENT(mm_vmscan_node_reclaim_begin,
> +
> +       TP_PROTO(int nid, int order, gfp_t gfp_flags),
> +
> +       TP_ARGS(nid, order, gfp_flags),
> +
> +       TP_STRUCT__entry(
> +               __field(int, nid)
> +               __field(int, order)
> +               __field(gfp_t, gfp_flags)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->nid = nid;
> +               __entry->order = order;
> +               __entry->gfp_flags = gfp_flags;
> +       ),
> +
> +       TP_printk("nid=%d order=%d gfp_flags=%s",
> +               __entry->nid,
> +               __entry->order,
> +               show_gfp_flags(__entry->gfp_flags))
> +);
> +
> +DEFINE_EVENT(mm_vmscan_direct_reclaim_end_template, mm_vmscan_node_reclaim_end,
> +
> +       TP_PROTO(unsigned long nr_reclaimed),
> +
> +       TP_ARGS(nr_reclaimed)
> +);
> +
>  #endif /* _TRACE_VMSCAN_H */
>
>  /* This part must be outside protection */
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ac4806f..2bee5d1 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -4241,6 +4241,9 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>                 .reclaim_idx = gfp_zone(gfp_mask),
>         };
>
> +       trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
> +                                          sc.gfp_mask);
> +
>         cond_resched();
>         fs_reclaim_acquire(sc.gfp_mask);
>         /*
> @@ -4267,6 +4270,9 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>         current->flags &= ~PF_SWAPWRITE;
>         memalloc_noreclaim_restore(noreclaim_flag);
>         fs_reclaim_release(sc.gfp_mask);
> +
> +       trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);
> +
>         return sc.nr_reclaimed >= nr_pages;
>  }
>
> --
> 1.8.3.1
>
