Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6163FA372C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9625E218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 02:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YWUaaCR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733113AbfKGCwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:52:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44226 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732382AbfKGCwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 21:52:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id c19so682131otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 18:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QrlsmiSp9MaTLUUYnVA3xTtIb+I1YUcCTslV0/OmSFI=;
        b=YWUaaCR128DURGqWr9aDknrAFS+YYlD99jyCFzrnkBJytTen48x97ZotJo5kZT3QYa
         ZjUE1oID3Dz3eEh0vpwgEwGeKs1IlCU141yRD3Ii3VpOrdmuUt1pXff6VBBrmPDXf5BR
         qXBM00zj3eBtlE8qYCpEysmNqZNhlKyUyCZKV/BxMWYzxoRprgj3lbp8NIAqz2rLFUpO
         z7KJKXpi8gtqrRNZgvaqQz1TR+YS3y5+HWIU9XjnZ22K3cvZzhrU+m8RD2I10tL57kPA
         EJd3iqWEZrVXgSl0eXR0vr+OCwqGyOaSN396/nYQDmw7ApNC7AemBk6nrILEpvaB45N8
         B34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QrlsmiSp9MaTLUUYnVA3xTtIb+I1YUcCTslV0/OmSFI=;
        b=pv9iIM+EDvyskq7iePwt62BjfrQrXZ3jBAy/Cwllf564mXf0pLbX9IcjHaD5yNisYs
         UQPAwapdXlsbC9uEebhGBvFdjx64JMPBYB8y9+k3N7RoqNdYBwOFZ/HZ2ggqC/DplU1f
         pNstOs4SiLsV8aS0JsZKam710MT9HwVCSTx915k93+hrQCTIx5fMVZ4SY0SVG/s183TI
         RXktvqcL8dvuF1iWTF+vFnYPTt1EsfMfx2hu5hQEKGhBSZ94nFy5xSxYV/3fgB8rQBC/
         P8VYCgJdh0sP657Ey3yAOhMNMIdZE/HCvETlMoyOoCdglmR6GS59z5QCd2hA3+FW9Qb/
         Pz5g==
X-Gm-Message-State: APjAAAVpnBv9vAfy7tYssRmueh+Z7dVqr0nCr3Nwq5HzV8yxk7NJM8D0
        eIu0PChacOB2BfdaVw/IRM9l45ANzu9ur3nfSMQiWg==
X-Google-Smtp-Source: APXvYqxOEA6/MtSOLc+2Sk75LPiZD356yYgPUUdsBFVv+mxA1p5VnjYskNRQd2hJyi8yasnt75D22lhdfdnhROetgTM=
X-Received: by 2002:a9d:5e10:: with SMTP id d16mr886624oti.191.1573095130142;
 Wed, 06 Nov 2019 18:52:10 -0800 (PST)
MIME-Version: 1.0
References: <20190603210746.15800-1-hannes@cmpxchg.org> <20190603210746.15800-8-hannes@cmpxchg.org>
In-Reply-To: <20190603210746.15800-8-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 6 Nov 2019 18:51:59 -0800
Message-ID: <CALvZod7EFBD0SCoUFHacEtZqi7hcZ3S6FEZRmfJJORre3dxRtQ@mail.gmail.com>
Subject: Re: [PATCH 07/11] mm: vmscan: split shrink_node() into node part and
 memcgs part
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 3:00 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> This function is getting long and unwieldy. The new shrink_node()
> handles the generic (node) reclaim aspects:
>   - global vmpressure notifications
>   - writeback and congestion throttling
>   - reclaim/compaction management
>   - kswapd giving up on unreclaimable nodes
>
> It then calls shrink_node_memcgs() which handles cgroup specifics:
>   - the cgroup tree traversal
>   - memory.low considerations
>   - per-cgroup slab shrinking callbacks
>   - per-cgroup vmpressure notifications
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>


> ---
>  mm/vmscan.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b85111474ee2..ee79b39d0538 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2665,24 +2665,15 @@ static bool pgdat_memcg_congested(pg_data_t *pgdat, struct mem_cgroup *memcg)
>                 (memcg && memcg_congested(pgdat, memcg));
>  }
>
> -static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> +static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  {
> -       struct reclaim_state *reclaim_state = current->reclaim_state;
>         struct mem_cgroup *root = sc->target_mem_cgroup;
>         struct mem_cgroup_reclaim_cookie reclaim = {
>                 .pgdat = pgdat,
>                 .priority = sc->priority,
>         };
> -       unsigned long nr_reclaimed, nr_scanned;
> -       bool reclaimable = false;
>         struct mem_cgroup *memcg;
>
> -again:
> -       memset(&sc->nr, 0, sizeof(sc->nr));
> -
> -       nr_reclaimed = sc->nr_reclaimed;
> -       nr_scanned = sc->nr_scanned;
> -
>         memcg = mem_cgroup_iter(root, NULL, &reclaim);
>         do {
>                 struct lruvec *lruvec = mem_cgroup_lruvec(memcg, pgdat);
> @@ -2750,6 +2741,22 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>                         break;
>                 }
>         } while ((memcg = mem_cgroup_iter(root, memcg, &reclaim)));
> +}
> +
> +static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
> +{
> +       struct reclaim_state *reclaim_state = current->reclaim_state;
> +       struct mem_cgroup *root = sc->target_mem_cgroup;
> +       unsigned long nr_reclaimed, nr_scanned;
> +       bool reclaimable = false;
> +
> +again:
> +       memset(&sc->nr, 0, sizeof(sc->nr));
> +
> +       nr_reclaimed = sc->nr_reclaimed;
> +       nr_scanned = sc->nr_scanned;
> +
> +       shrink_node_memcgs(pgdat, sc);
>
>         if (reclaim_state) {
>                 sc->nr_reclaimed += reclaim_state->reclaimed_slab;
> @@ -2757,7 +2764,7 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>         }
>
>         /* Record the subtree's reclaim efficiency */
> -       vmpressure(sc->gfp_mask, sc->target_mem_cgroup, true,
> +       vmpressure(sc->gfp_mask, root, true,
>                    sc->nr_scanned - nr_scanned,
>                    sc->nr_reclaimed - nr_reclaimed);
>
> --
> 2.21.0
>
