Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638EEC35280
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3703520842
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 12:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="c9rl2ouY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfI3Mtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 08:49:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45366 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbfI3Mtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 08:49:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id c21so16772972qtj.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6K4t2QaanAjiyfaxIbACT2mjoEJYSRRvAaJqq+DnP1g=;
        b=c9rl2ouYw3vJgLERGSrEISkC9A+UUnX6Ofv3pCbqI9nmR7zvAB6flw3hQoCTlo0Wko
         aKs/+s38bsVMP0aLoRI7CbKkcVTeMwsX4QzE891hXgojixue3ygkbwDyoQLqq7fwTGqm
         8jPh+RbyYmadBcSUnDauljg9YrRjq0IK2rcXcGlrkIAJAkIl2fsUVuUmYiqqFmj5NWoA
         ImIzVpmL3Op/kpZoDtVBUh//19yHDjh/WdQE74s6QUU/aytZXLoIFKTd2GsVZj9TRNF+
         oCUPrMBDp12tlNOFgIVkEprEN4phihsulPK7G3eQVwEQFAdXIzRTLOTmG+WFi9STLtpk
         6ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6K4t2QaanAjiyfaxIbACT2mjoEJYSRRvAaJqq+DnP1g=;
        b=Bliua51JDOIwSs44iDGH9Zb0YzwHetlVJu5PaCp4BOC8f3hMZDbN2G53aDRR/lKppv
         6GncNMXI9l+nnkHBUXxy5G9lZST3jtMIEdqnBfZAZlBT5GOrT/tX5q29mE3rTi5l+4hw
         pQdCRY9fPIY0neltmO58eIE8Y0RGf4DUHRwjPXRp1ZWKo9lysBrxLfRleK1UEqtzYCfl
         IkXam3cdz4H458CoBi/M/moAbefzyDd3xSJlzO072Y0CmXiAczhur4FPLkoeVdKUup24
         VJ1dbZVyz5UBHWh2feTBNYoM1KPhLEyRJ6BsTWBm+zCPx/rHVRJo70hG7RkeJ8zHO9wG
         K9vw==
X-Gm-Message-State: APjAAAUETwJr6ps7z9DB+jA+m7rSutSSBVhTmOTQHjTm301E88EXYSMd
        gm9l+AWm69p+fA24a15Bf9Ebvg==
X-Google-Smtp-Source: APXvYqwe6tj3QoB3PHebpJKdfxVIK3o6VVGtOXmL0DJDcuzZS+0wTwEaSEnijNE5GeAZB0r39jqS1g==
X-Received: by 2002:ac8:110a:: with SMTP id c10mr1071249qtj.259.1569847790073;
        Mon, 30 Sep 2019 05:49:50 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a134sm5923647qkc.95.2019.09.30.05.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 05:49:49 -0700 (PDT)
Message-ID: <1569847787.5576.244.camel@lca.pw>
Subject: Re: [PATCH v2 2/3] mm, page_owner: decouple freeing stack trace
 from debug_pagealloc
From:   Qian Cai <cai@lca.pw>
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Date:   Mon, 30 Sep 2019 08:49:47 -0400
In-Reply-To: <20190930122916.14969-3-vbabka@suse.cz>
References: <20190930122916.14969-1-vbabka@suse.cz>
         <20190930122916.14969-3-vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-09-30 at 14:29 +0200, Vlastimil Babka wrote:
> The commit 8974558f49a6 ("mm, page_owner, debug_pagealloc: save and dump
> freeing stack trace") enhanced page_owner to also store freeing stack trace,
> when debug_pagealloc is also enabled. KASAN would also like to do this [1] to
> improve error reports to debug e.g. UAF issues. Kirill has suggested that the
> freeing stack trace saving should be also possible to be enabled separately.
> 
> This patch therefore introduces a new kernel parameter page_owner_free to
> enable the functionality in addition to the existing page_owner parameter.
> The free stack saving is thus enabled in these cases:
> 1) booting with page_owner=on and debug_pagealloc=on
> 2) booting a KASAN kernel with page_owner=on
> 3) booting with page_owner=on and page_owner_free=on
> 
> To minimize runtime CPU and memory overhead when not boot-time enabled, the
> patch introduces a new static key and struct page_ext_operations.
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=203967
> 
> Suggested-by: Dmitry Vyukov <dvyukov@google.com>
> Suggested-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  .../admin-guide/kernel-parameters.txt         |  8 ++
>  Documentation/dev-tools/kasan.rst             |  3 +
>  include/linux/page_owner.h                    |  1 +
>  mm/page_ext.c                                 |  1 +
>  mm/page_owner.c                               | 90 +++++++++++++------
>  5 files changed, 78 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 944e03e29f65..14dcb66e3457 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3237,6 +3237,14 @@
>  			we can turn it on.
>  			on: enable the feature
>  
> +	page_owner_free=
> +			[KNL] When enabled together with page_owner, store also
> +			the stack of who frees a page, for error page dump
> +			purposes. This is also implicitly enabled by
> +			debug_pagealloc=on or KASAN, so only page_owner=on is
> +			sufficient in those cases.
> +			on: enable the feature
> +

If users are willing to set page_owner=on, what prevent them from enabling KASAN
as well? That way, we don't need this additional parameter. I read that KASAN
supposes to be semi-production use ready, so the overhead is relatively low.
There is even a choice to have KASAN_SW_TAGS on arm64 to work better with small
devices.
