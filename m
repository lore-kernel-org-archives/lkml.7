Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB69CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFE1206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 09:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rQGq/Gkg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfJCJFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 05:05:52 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42916 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfJCJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 05:05:52 -0400
Received: by mail-qt1-f193.google.com with SMTP id w14so2518889qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 02:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=xWvjAJ+vmNMIpeEImL3eN8FbY3mh5BNsK1umkA/yuKA=;
        b=rQGq/GkgmPP0jTIUHjSC8C6/MU5ReIqGZzuX/UwCB/QPQrP0NRhll8Im3UdtgnegtL
         nQCUgQGybFYiMBt339er7ABesjSSw3Aehfcp3Xbud3/76ur/paF9kV3/z3aMv/M7WMhO
         yb+Uq+HZg8zXNIZJbBPO9ZmOrRFUv/9WtbWa6rf8GS2ubKrfn3lEM6Kp+6kiss9xexPw
         pK33gME4N3znz2EKdbkfEKDndziRVplRPIfDcJPi0fbGdzCnLLqKooB7jaiF5DC0MSRT
         bfrW29fGQtLDBCIaewDCpiPWg+FM82o80P2EdaeWdf0KsBKGFpxaFqJKmyeuN1e656F0
         QAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=xWvjAJ+vmNMIpeEImL3eN8FbY3mh5BNsK1umkA/yuKA=;
        b=jTidxPcYpjbP9qKHDIfa7mAVJ1po/mj9LQa0dWt3JNOYTQ/qHrio8BVdiryerQ541K
         8eqbk3RlBqrgF7bPPzoFprjqwGAjrzzqbShrsljyS9g1Bq7P7JlPhuS3ZHIV12dBhLBL
         nrEugVn6w6AUU7wz8AT5cuDTrwcst9twjsOJYN3FJX9VxhQw5JWp4HJTq6DIni4TNO05
         8Jd7gqwBzLv+yIY0KaKPN49/eqLwSQVHjcPMweD60AKnocSzNJuUdGRBnd/uui5Wd8dY
         3AECcY3erruqGs6VJjj07bBov7iZb7kDncLidgHQkJJ9AxcUmHyFHCaENqaOz/WqeN0F
         doGg==
X-Gm-Message-State: APjAAAVqCsP1xK85p8mvmwRm/Wp5OVYFkWjcDusIkBCGYB2jl08+LWdF
        30YT9DrSGGHbD2nvgKb/eCHDBg==
X-Google-Smtp-Source: APXvYqx/K/TFKFb3HVfCLhcINgoNzkLVvgCx7hmM1H+WyJUczpaRihtkRlTjXZCGlfeUHw9JREKM0Q==
X-Received: by 2002:ac8:4304:: with SMTP id z4mr8649614qtm.160.1570093551315;
        Thu, 03 Oct 2019 02:05:51 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c20sm829041qkm.11.2019.10.03.02.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 02:05:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in has_unmovable_pages()
Date:   Thu, 3 Oct 2019 05:05:50 -0400
Message-Id: <7FA7CBE1-E0A9-40E2-B3CA-0896F6D491E5@lca.pw>
References: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1570090257-25001-1-git-send-email-anshuman.khandual@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2019, at 4:10 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> w=
rote:
>=20
> Having unmovable pages on a given pageblock should be reported correctly
> when required with REPORT_FAILURE flag. But there can be a scenario where a=

> reserved page in the page block will get reported as a generic "unmovable"=

> reason code. Instead this should be changed to a more appropriate reason
> code like "Reserved page".

Isn=E2=80=99t this redundant as it dumps the flags in dump_page() anyway?

>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Pavel Tatashin <pavel.tatashin@microsoft.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> mm/page_alloc.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 15c2050c629b..fbf93ea119d2 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -8206,8 +8206,10 @@ bool has_unmovable_pages(struct zone *zone, struct p=
age *page, int count,
>=20
>        page =3D pfn_to_page(check);
>=20
> -        if (PageReserved(page))
> +        if (PageReserved(page)) {
> +            reason =3D "Reserved page";
>            goto unmovable;
> +        }
>=20
>        /*
>         * If the zone is movable and we have ruled out all reserved
> --=20
> 2.20.1
>=20
