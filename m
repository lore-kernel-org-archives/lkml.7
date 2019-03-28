Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF27AC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2B620823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rVH+m+xL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbfC1Udo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:33:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9382 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfC1Udo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:33:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d2fa50002>; Thu, 28 Mar 2019 13:33:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 13:33:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 13:33:43 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 20:33:43 +0000
Subject: Re: [PATCH v2 01/11] mm/hmm: select mmu notifier when selecting HMM
To:     <jglisse@redhat.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-2-jglisse@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d4889f44-0cc5-3ef6-deeb-7302c93c1f90@nvidia.com>
Date:   Thu, 28 Mar 2019 13:33:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190325144011.10560-2-jglisse@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553805221; bh=o+a/SAiZ8f2SWEWLbL14a/AHxKB3R3uRQE9ibApvFzo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=rVH+m+xL2BxNvS6qdiawWzdzngrp29z3aMootYghbquzyuTBuiD0uULk7EcEdiSxC
         AgPVAWB3MSZxyWqYw/gZuFZrraF7vPcNztWTNwyqRm2NC1H8XVs+OYVhlgIj1sLUO0
         pAbOqrC0xQOMtYZ0srtx3N1GYtooxq6lsFekMrXYmh/rcBNNJgVTG8W5qhnQtZ+DSE
         q+9//0amEirw0w69sh2gmn1qMlahnuCScS28MQNd1DSfAeM0GDe4asvNuU3lzzs5Mq
         PZWb5QgvI6PgWgrQVvBA3AF0dxhscVxvV5r0svpUA5+xM8ElkZjty0CNabpUUOSXL+
         IsSeRPIxnErHg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> To avoid random config build issue, select mmu notifier when HMM is
> selected. In any cases when HMM get selected it will be by users that
> will also wants the mmu notifier.
>=20
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  mm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 25c71eb8a7db..0d2944278d80 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -694,6 +694,7 @@ config DEV_PAGEMAP_OPS
> =20
>  config HMM
>  	bool
> +	select MMU_NOTIFIER
>  	select MIGRATE_VMA_HELPER
> =20
>  config HMM_MIRROR
>=20

Yes, this is a good move, given that MMU notifiers are completely,
indispensably part of the HMM design and implementation.

The alternative would also work, but it's not quite as good. I'm
listing it in order to forestall any debate:=20

  config HMM
  	bool
 +	depends on MMU_NOTIFIER
  	select MIGRATE_VMA_HELPER

...and "depends on" versus "select" is always a subtle question. But in
this case, I'd say that if someone wants HMM, there's no advantage in
making them know that they must first ensure MMU_NOTIFIER is enabled.
After poking around a bit I don't see any obvious downsides either.

However, given that you're making this change, in order to avoid odd
redundancy, you should also do this:

diff --git a/mm/Kconfig b/mm/Kconfig
index 0d2944278d80..2e6d24d783f7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -700,7 +700,6 @@ config HMM
 config HMM_MIRROR
        bool "HMM mirror CPU page table into a device page table"
        depends on ARCH_HAS_HMM
-       select MMU_NOTIFIER
        select HMM
        help
          Select HMM_MIRROR if you want to mirror range of the CPU page tab=
le of a


thanks,
--=20
John Hubbard
NVIDIA
