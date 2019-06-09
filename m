Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6ACC2BCA1
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 14:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D6A2083D
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 14:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW4V5sXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfFIOxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 10:53:39 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40431 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727500AbfFIOxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 10:53:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so9114477eds.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 07:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1qNdnBxzQ1sxPLfepsayWvIRtgHis1fEHl61OHimm90=;
        b=TW4V5sXzdBVgH5DT3NU7dehMs7b9QS54DmeQvAWdt7RcWFRca8ZYHjqYYm8Z4gxzrT
         qkMe7MjtwR5yj158Llt6gg9NPtkyL5EXV3lFx0thDKbEdEZjjYf4/iuI5KKImi9iuBfJ
         qaBANa+HUY8ZtO4fhNyPGW9atPAR9xPuklJOMTim1DYPWYhzmqubIGQOIymVFKu0RXyG
         rxV6uc/0v73XKetD8Ca6M7FFRRhpYahmSym6XD5JJJoKSo+z7dP8OUadbag28tEQeLGM
         GCXWmAEiBBaUU7PaED6QGBk69ILS3dI5UYzuro79KWFCpmm2VqCFsIke2Z/fBMtq79Fz
         Ljlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1qNdnBxzQ1sxPLfepsayWvIRtgHis1fEHl61OHimm90=;
        b=QC9aXBvX9iI5MmXra/VNDxM52DnmTRGNuEquKVzm2QC6kE98ORMxz8tydvsYzowdIL
         lQ08smxQHVTVQSsxUfV+GvK1cZ7vmREmiHvaZhu1/NDFikDTBgATHkH5y573ZE3HBwYe
         7k1s/rCLOc0ontBjfvW9xetvqIWZmp+VrVlIpYXZ8WsdOBEheYzs46NvbsFhCkwLXjkI
         0OwD8umuZ3vBApxaJcldmKf41rN3naA+JD1m2IfQQWSDB+t/cPNWX6dA8KWOHQdgJhz4
         +jXxPutmQDSSJrpbYSW3npaP2kJ6W2p2I8UnC2EyRK+kNUm52/AbhfGLPkmrBxTRBCkC
         t5Og==
X-Gm-Message-State: APjAAAXfGHBVZl8zHyaETMqc4rZYQPaSFAVD8PKlHbEW6KbpNtNOlFU2
        y8HbPjlUoAxKega6YsgfT9A=
X-Google-Smtp-Source: APXvYqx5Bvmblo5CLoyi+ttNFMxoRY0Kzk8ncfNmEkFAOwQxlxqMMwxKuHs3lo+Eaxy342sAj5E03g==
X-Received: by 2002:a17:906:ca9:: with SMTP id k9mr49364733ejh.4.1560092017397;
        Sun, 09 Jun 2019 07:53:37 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t54sm2193349edd.17.2019.06.09.07.53.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Jun 2019 07:53:36 -0700 (PDT)
Date:   Sun, 9 Jun 2019 14:53:35 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     ChenGang <cg.chen@huawei.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        osalvador@suse.de, pavel.tatashin@microsoft.com,
        mgorman@techsingularity.net, rppt@linux.ibm.com,
        richard.weiyang@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: align up min_free_kbytes to multipy of 4
Message-ID: <20190609145335.yzx4irt4mczmlvno@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <1560071428-24267-1-git-send-email-cg.chen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560071428-24267-1-git-send-email-cg.chen@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 05:10:28PM +0800, ChenGang wrote:
>Usually the value of min_free_kbytes is multiply of 4,
>and in this case ,the right shift is ok.
>But if it's not, the right-shifting operation will lose the low 2 bits,

But PAGE_SHIFT is not always 12.

>and this cause kernel don't reserve enough memory.
>So it's necessary to align the value of min_free_kbytes to multiply of 4.
>For example, if min_free_kbytes is 64, then should keep 16 pages,
>but if min_free_kbytes is 65 or 66, then should keep 17 pages.
>
>Signed-off-by: ChenGang <cg.chen@huawei.com>
>---
> mm/page_alloc.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index d66bc8a..1baeeba 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -7611,7 +7611,8 @@ static void setup_per_zone_lowmem_reserve(void)
> 
> static void __setup_per_zone_wmarks(void)
> {
>-	unsigned long pages_min = min_free_kbytes >> (PAGE_SHIFT - 10);
>+	unsigned long pages_min =
>+		(PAGE_ALIGN(min_free_kbytes * 1024) / 1024) >> (PAGE_SHIFT - 10);

In my mind, pages_min is an estimated value. Do we need to be so precise?

> 	unsigned long lowmem_pages = 0;
> 	struct zone *zone;
> 	unsigned long flags;
>-- 
>1.8.5.6

-- 
Wei Yang
Help you, Help me
