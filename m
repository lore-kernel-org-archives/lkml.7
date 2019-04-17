Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDFFC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC65206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 20:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfDQUci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 16:32:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40696 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727147AbfDQUch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 16:32:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AEB130ADBCE;
        Wed, 17 Apr 2019 20:32:37 +0000 (UTC)
Received: from redhat.com (unknown [10.20.6.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57BCD5D9D6;
        Wed, 17 Apr 2019 20:32:36 +0000 (UTC)
Date:   Wed, 17 Apr 2019 16:32:34 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: kconfig split HMM address space mirroring from
 device memory
Message-ID: <20190417203234.GA3409@redhat.com>
References: <20190411180326.18958-1-jglisse@redhat.com>
 <20190417182118.GA1477@roeck-us.net>
 <20190417182618.GA11499@redhat.com>
 <20190417193335.GA23825@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417193335.GA23825@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 17 Apr 2019 20:32:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 12:33:35PM -0700, Guenter Roeck wrote:
> On Wed, Apr 17, 2019 at 02:26:18PM -0400, Jerome Glisse wrote:
> > On Wed, Apr 17, 2019 at 11:21:18AM -0700, Guenter Roeck wrote:
> > > On Thu, Apr 11, 2019 at 02:03:26PM -0400, jglisse@redhat.com wrote:
> > > > From: Jérôme Glisse <jglisse@redhat.com>
> > > > 
> > > > To allow building device driver that only care about address space
> > > > mirroring (like RDMA ODP) on platform that do not have all the pre-
> > > > requisite for HMM device memory (like ZONE_DEVICE on ARM) split the
> > > > HMM_MIRROR option dependency from the HMM_DEVICE dependency.
> > > > 
> > > > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > > > Cc: Leon Romanovsky <leonro@mellanox.com>
> > > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > > Tested-by: Leon Romanovsky <leonro@mellanox.com>
> > > 
> > > In case it hasn't been reported already:
> > > 
> > > mm/hmm.c: In function 'hmm_vma_handle_pmd':
> > > mm/hmm.c:537:8: error: implicit declaration of function 'pmd_pfn'; did you mean 'pte_pfn'?
> > 
> > No it is pmd_pfn
> > 
> FWIW, this is a compiler message.
> 
> > > 
> > > and similar errors when building alpha:allmodconfig (and maybe others).
> > 
> > Does HMM_MIRROR get enabled in your config ? It should not
> > does adding depends on (X86_64 || PPC64) to ARCH_HAS_HMM
> > fix it ? I should just add that there for arch i do build.
> > 
> 
> The eror is seen with is alpha:allmodconfig. "make ARCH=alpha allmodconfig".
> It does set CONFIG_ARCH_HAS_HMM=y.
> 
> This patch has additional problems. For arm64:allmodconfig
> and many others, when running "make ARCH=arm64 allmodconfig":
> 
> WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
>   Depends on [n]: ARCH_HAS_HMM_DEVICE [=n] && ZONE_DEVICE [=n]
>   Selected by [m]:
>   - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && ARCH_HAS_HMM [=y] && DRM_NOUVEAU [=m] && STAGING [=y]
> 
> WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
>   Depends on [n]: ARCH_HAS_HMM_DEVICE [=n] && ZONE_DEVICE [=n]
>   Selected by [m]:
>   - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && ARCH_HAS_HMM [=y] && DRM_NOUVEAU [=m] && STAGING [=y]
> 
> WARNING: unmet direct dependencies detected for DEVICE_PRIVATE
>   Depends on [n]: ARCH_HAS_HMM_DEVICE [=n] && ZONE_DEVICE [=n]
>   Selected by [m]:
>   - DRM_NOUVEAU_SVM [=y] && HAS_IOMEM [=y] && ARCH_HAS_HMM [=y] && DRM_NOUVEAU [=m] && STAGING [=y]
> 
> This in turn results in:
> 
> arch64-linux-ld: mm/memory.o: in function `do_swap_page':
> memory.c:(.text+0x798c): undefined reference to `device_private_entry_fault'
> 
> not only on arm64, but on other architectures as well.
> 
> All those problems are gone after reverting this patch.
> 
> Guenter

Andrew let drop this patch i need to fix nouveau Kconfig first.

Cheers,
Jérôme
