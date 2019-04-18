Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384F7C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0502C217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SwnFKNon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390118AbfDRUac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:30:32 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17090 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbfDRUab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:30:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cb8de6c0001>; Thu, 18 Apr 2019 13:30:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 18 Apr 2019 13:30:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 18 Apr 2019 13:30:31 -0700
Received: from [10.2.163.72] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 18 Apr
 2019 20:30:29 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
CC:     <mhocko@suse.com>, <kirill.shutemov@linux.intel.com>,
        <rppt@linux.vnet.ibm.com>, <corbet@lwn.net>,
        <akpm@linux-foundation.org>, <linux-doc@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] doc: mm: migration doesn't use FOLL_SPLIT anymore
Date:   Thu, 18 Apr 2019 16:30:27 -0400
X-Mailer: MailMate (1.12.4r5622)
Message-ID: <C8CBF3A3-5ADA-4CA6-8AEB-4836AE9146D7@nvidia.com>
In-Reply-To: <1555618624-23957-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1555618624-23957-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1555619436; bh=T3JD0sgSOXk1vRSr1uVe9SorhMd4n+SS+HWTi6IFNCc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=SwnFKNonXOE1zQVJWCyAkBVjCLR/gdo0c98WcA4gmTZefaRGQCthtZhxg/jleQzpb
         9ey3mfNA2l5uwtSrjts4734cmnAQzrvuHJkA0/uVgRhdrUSqaEEH5iSCLqsgZ+z1mf
         eeg11NLcYkIb/mqsgxPlqRYvLKPIDYGdSbrtnlZUeJ4SkRHOQlXkM81nzq/VmKWoBq
         F+ZustVToSp/Ww2x7qBHKYszHEDGptzDItgUiSNegC2a4t8wVt2Udzszw5zk7EYoRl
         T2VVXWCXJVBoGCwEAjqmLJrf4butHZI6agSmOQ0mGBaG9CzXgI07vrYyRDygRIjFSL
         N81lBCiahYjRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Apr 2019, at 16:17, Yang Shi wrote:

> When demonstrating FOLL_SPLIT in transhuge document, migration is used
> as an example.  But, since commit 94723aafb9e7 ("mm: unclutter THP
> migration"), the way of THP migration is totally changed.  FOLL_SPLIT 
> is
> not used by migration anymore due to the change.
>
> Remove the obsolete example to avoid confusion.
>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
>  Documentation/vm/transhuge.rst | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/Documentation/vm/transhuge.rst 
> b/Documentation/vm/transhuge.rst
> index a8cf680..8df3806 100644
> --- a/Documentation/vm/transhuge.rst
> +++ b/Documentation/vm/transhuge.rst
> @@ -55,13 +55,7 @@ prevent page from being split by anyone.
>  In case you can't handle compound pages if they're returned by
>  follow_page, the FOLL_SPLIT bit can be specified as parameter to
>  follow_page, so that it will split the hugepages before returning
> -them. Migration for example passes FOLL_SPLIT as parameter to
> -follow_page because it's not hugepage aware and in fact it can't work
> -at all on hugetlbfs (but it instead works fine on transparent
> -hugepages thanks to FOLL_SPLIT). migration simply can't deal with
> -hugepages being returned (as it's not only checking the pfn of the
> -page and pinning it during the copy but it pretends to migrate the
> -memory in regular page sizes and with regular pte/pmd mappings).
> +them.
>
>  Graceful fallback
>  =================
> -- 
> 1.8.3.1

Thanks for updating the document.

Reviewed-by: Zi Yan <ziy@nvidia.com>



--
Best Regards,
Yan Zi
