Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B562C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389A520578
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 16:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEBQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 12:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9233 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBQWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 12:22:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 297173D95D;
        Thu,  2 May 2019 16:22:11 +0000 (UTC)
Received: from redhat.com (ovpn-120-112.rdu2.redhat.com [10.10.120.112])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 565455DA35;
        Thu,  2 May 2019 16:22:09 +0000 (UTC)
Date:   Thu, 2 May 2019 12:22:07 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] mm/hmm: add ARCH_HAS_HMM_MIRROR ARCH_HAS_HMM_DEVICE
 Kconfig
Message-ID: <20190502162206.GA13745@redhat.com>
References: <20190417211141.17580-1-jglisse@redhat.com>
 <20190501183850.GA4018@redhat.com>
 <20190501192358.GA21829@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190501192358.GA21829@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 02 May 2019 16:22:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2019 at 12:23:58PM -0700, Guenter Roeck wrote:
> On Wed, May 01, 2019 at 02:38:51PM -0400, Jerome Glisse wrote:
> > Andrew just the patch that would be nice to get in 5.2 so i can fix
> > device driver Kconfig before doing the real update to mm HMM Kconfig
> > 
> > On Wed, Apr 17, 2019 at 05:11:41PM -0400, jglisse@redhat.com wrote:
> > > From: Jérôme Glisse <jglisse@redhat.com>
> > > 
> > > This patch just add 2 new Kconfig that are _not use_ by anyone. I check
> > > that various make ARCH=somearch allmodconfig do work and do not complain.
> > > This new Kconfig need to be added first so that device driver that do
> > > depend on HMM can be updated.
> > > 
> > > Once drivers are updated then i can update the HMM Kconfig to depends
> > > on this new Kconfig in a followup patch.
> > > 
> 
> I am probably missing something, but why not submit the entire series together ?
> That might explain why XARRAY_MULTI is enabled below, and what the series is
> about. Additional comments below.
> 
> > > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > > Cc: Guenter Roeck <linux@roeck-us.net>
> > > Cc: Leon Romanovsky <leonro@mellanox.com>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > > Cc: John Hubbard <jhubbard@nvidia.com>
> > > ---
> > >  mm/Kconfig | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > index 25c71eb8a7db..daadc9131087 100644
> > > --- a/mm/Kconfig
> > > +++ b/mm/Kconfig
> > > @@ -676,6 +676,22 @@ config ZONE_DEVICE
> > >  
> > >  	  If FS_DAX is enabled, then say Y.
> > >  
> > > +config ARCH_HAS_HMM_MIRROR
> > > +	bool
> > > +	default y
> > > +	depends on (X86_64 || PPC64)
> > > +	depends on MMU && 64BIT
> > > +
> > > +config ARCH_HAS_HMM_DEVICE
> > > +	bool
> > > +	default y
> > > +	depends on (X86_64 || PPC64)
> > > +	depends on MEMORY_HOTPLUG
> > > +	depends on MEMORY_HOTREMOVE
> > > +	depends on SPARSEMEM_VMEMMAP
> > > +	depends on ARCH_HAS_ZONE_DEVICE
> 
> This is almost identical to ARCH_HAS_HMM except ARCH_HAS_HMM
> depends on ZONE_DEVICE and MMU && 64BIT. ARCH_HAS_HMM_MIRROR
> and ARCH_HAS_HMM_DEVICE together almost match ARCH_HAS_HMM,
> except for the ARCH_HAS_ZONE_DEVICE vs. ZONE_DEVICE dependency.
> And ZONE_DEVICE selects XARRAY_MULTI, meaning there is really
> substantial overlap.
> 
> Not really my concern, but personally I'd like to see some
> reasoning why the additional options are needed .. thus the
> question above, why not submit the series together ?
> 

There is no serie here, this is about solving Kconfig for HMM given
that device driver are going through their own tree we want to avoid
changing them from the mm tree. So plan is:

1 - Kernel release N add the new Kconfig to mm/Kconfig (this patch)
2 - Kernel release N+1 update driver to depend on new Kconfig ie
    stop using ARCH_HASH_HMM and start using ARCH_HAS_HMM_MIRROR
    and ARCH_HAS_HMM_DEVICE (one or the other or both depending
    on the driver)
3 - Kernel release N+2 remove ARCH_HASH_HMM and do final Kconfig
    update in mm/Kconfig

This has been discuss in the past and while it is bit painfull it
is the easiest solution (outside git topic branch but mm tree is
not merge as git).

Cheers,
Jérôme
