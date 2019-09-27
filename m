Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48980C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F1C20872
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 19:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qDzk9fny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfI0TdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 15:33:06 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39600 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbfI0TdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 15:33:06 -0400
Received: by mail-oi1-f193.google.com with SMTP id w144so6179171oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 12:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isDPGCReaiK37P8mK6pZ6yGM/s1VY4mHCre4SI/h+uk=;
        b=qDzk9fny20uBp5VR9KMYd1Fac7VhmA3xZ0QbUkwiP80EbKY9RaCkA/4U4Qe7pi6TsI
         zDEsEtbKHF8GpyEsQPTtGod2U4zBxqctjrd4sOKYfMmeJXF6SAxWVZ16/wp4AKGS5xv6
         3apcUl+LXf1XdM/yu/zw1Uw97EfZ9XGnzwGMCbc919wDt95/CpOPUnrVC9TbFVA3DgnX
         k826ZjdZJgOP0qVA9oleHpg4fFUebyz8hqjPBGPaHvhd7R/id1utbwGeNqZuwRQdicVO
         zyrcK+uCKeiCSFtqsitZuUVl82lvIty2M8HzrYh0u6W2pvLlVz29fB2DhcjV0n04fay/
         2OoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isDPGCReaiK37P8mK6pZ6yGM/s1VY4mHCre4SI/h+uk=;
        b=trDCr9RTDLDv167ztRDrClLtHN0t/TA3GtKv9e4f095RoBR9Q/xthM8ydMXXsMVkcJ
         ZdoUcCQP3ynNaRG8k1TKx4D+Aubyw1YAhp0kXxB8DU5D/7lOTS+dGJHYLblad2aOLUex
         F9+DRa3z++3DOFqtFVcVc4alrMlkaz95mZmrbpzbz/fAanboVZazEotPAjdzljYb4l6d
         RwwbP0mu1NI13xQXVHLWQbDMaIbgLX42JkkaN3yf7jHb+xtRR1m/Oa54Vm2qySh7UYSy
         7D4B8SFtyXRBPUGe+xmau6ihEaH5Krw/8U3nTs36PtQZPnjxl5+a005uaJO+1XScvF6I
         Yy1g==
X-Gm-Message-State: APjAAAUjMEauU91DWBXY2s+shCf6fnxS8istUoo9JBVAnu+lYoA1nfK4
        DXoGFHzQTkr9mInzb4zJnCuOOha1EMpyAGusk/7d0A==
X-Google-Smtp-Source: APXvYqzAZY40Bk8ZksTVV+s3FcueJU0jeqVy/scpmyhn0c0F1MSet8HaXinRuhaCTO9u6YjIBS9thk00YJposzWuWaA=
X-Received: by 2002:aca:eb09:: with SMTP id j9mr8863477oih.105.1569612785882;
 Fri, 27 Sep 2019 12:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190927161416.62293-1-pilgrimtao@gmail.com>
In-Reply-To: <20190927161416.62293-1-pilgrimtao@gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 27 Sep 2019 12:32:54 -0700
Message-ID: <CAPcyv4imXWDSoVet4a0CYtO3JxN__f1hq+LCKTnjjF+4HB+6Kw@mail.gmail.com>
Subject: Re: [PATCH] mm, page_alloc: drop pointless static qualifier in build_zonelists()
To:     Kaitao Cheng <pilgrimtao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pasha Tatashin <pavel.tatashin@microsoft.com>,
        Alexander Potapenko <glider@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 9:14 AM Kaitao Cheng <pilgrimtao@gmail.com> wrote:
>
> There is no need to make the 'node_order' variable static
> since new value always be assigned before use it.
>
> Signed-off-by: Kaitao Cheng <pilgrimtao@gmail.com>
> Signed-off-by: Muchun Song <smuchun@gmail.com>
> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3334a769eb91..c473c304d09f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5597,7 +5597,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
>
>  static void build_zonelists(pg_data_t *pgdat)
>  {
> -       static int node_order[MAX_NUMNODES];
> +       int node_order[MAX_NUMNODES];

This isn't pointless. This prevents 4KB stack allocation which might overflow.
