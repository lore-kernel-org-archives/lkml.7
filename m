Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BA7C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C07420652
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 18:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfEASi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 14:38:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfEASi4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 14:38:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 935233082E6A;
        Wed,  1 May 2019 18:38:56 +0000 (UTC)
Received: from redhat.com (ovpn-126-26.rdu2.redhat.com [10.10.126.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C3D031001DE1;
        Wed,  1 May 2019 18:38:54 +0000 (UTC)
Date:   Wed, 1 May 2019 14:38:51 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: add ARCH_HAS_HMM_MIRROR ARCH_HAS_HMM_DEVICE
 Kconfig
Message-ID: <20190501183850.GA4018@redhat.com>
References: <20190417211141.17580-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417211141.17580-1-jglisse@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 01 May 2019 18:38:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew just the patch that would be nice to get in 5.2 so i can fix
device driver Kconfig before doing the real update to mm HMM Kconfig

On Wed, Apr 17, 2019 at 05:11:41PM -0400, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> This patch just add 2 new Kconfig that are _not use_ by anyone. I check
> that various make ARCH=somearch allmodconfig do work and do not complain.
> This new Kconfig need to be added first so that device driver that do
> depend on HMM can be updated.
> 
> Once drivers are updated then i can update the HMM Kconfig to depends
> on this new Kconfig in a followup patch.
> 
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/Kconfig | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 25c71eb8a7db..daadc9131087 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -676,6 +676,22 @@ config ZONE_DEVICE
>  
>  	  If FS_DAX is enabled, then say Y.
>  
> +config ARCH_HAS_HMM_MIRROR
> +	bool
> +	default y
> +	depends on (X86_64 || PPC64)
> +	depends on MMU && 64BIT
> +
> +config ARCH_HAS_HMM_DEVICE
> +	bool
> +	default y
> +	depends on (X86_64 || PPC64)
> +	depends on MEMORY_HOTPLUG
> +	depends on MEMORY_HOTREMOVE
> +	depends on SPARSEMEM_VMEMMAP
> +	depends on ARCH_HAS_ZONE_DEVICE
> +	select XARRAY_MULTI
> +
>  config ARCH_HAS_HMM
>  	bool
>  	default y
> -- 
> 2.20.1
> 
