Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D0FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD39218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbfC2VPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:15:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40766 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729858AbfC2VPc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B51280E7A;
        Fri, 29 Mar 2019 21:15:32 +0000 (UTC)
Received: from redhat.com (ovpn-125-57.rdu2.redhat.com [10.10.125.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 87C3F5C22E;
        Fri, 29 Mar 2019 21:15:31 +0000 (UTC)
Date:   Fri, 29 Mar 2019 17:15:29 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 01/11] mm/hmm: select mmu notifier when selecting HMM
Message-ID: <20190329211529.GA6124@redhat.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-2-jglisse@redhat.com>
 <d4889f44-0cc5-3ef6-deeb-7302c93c1f90@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4889f44-0cc5-3ef6-deeb-7302c93c1f90@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 29 Mar 2019 21:15:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 01:33:42PM -0700, John Hubbard wrote:
> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > To avoid random config build issue, select mmu notifier when HMM is
> > selected. In any cases when HMM get selected it will be by users that
> > will also wants the mmu notifier.
> > 
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Acked-by: Balbir Singh <bsingharora@gmail.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  mm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 25c71eb8a7db..0d2944278d80 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -694,6 +694,7 @@ config DEV_PAGEMAP_OPS
> >  
> >  config HMM
> >  	bool
> > +	select MMU_NOTIFIER
> >  	select MIGRATE_VMA_HELPER
> >  
> >  config HMM_MIRROR
> > 
> 
> Yes, this is a good move, given that MMU notifiers are completely,
> indispensably part of the HMM design and implementation.
> 
> The alternative would also work, but it's not quite as good. I'm
> listing it in order to forestall any debate: 
> 
>   config HMM
>   	bool
>  +	depends on MMU_NOTIFIER
>   	select MIGRATE_VMA_HELPER
> 
> ...and "depends on" versus "select" is always a subtle question. But in
> this case, I'd say that if someone wants HMM, there's no advantage in
> making them know that they must first ensure MMU_NOTIFIER is enabled.
> After poking around a bit I don't see any obvious downsides either.

You can not depend on MMU_NOTIFIER it is one of the kernel config
option that is not selectable. So any config that need MMU_NOTIFIER
must select it.

> 
> However, given that you're making this change, in order to avoid odd
> redundancy, you should also do this:
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 0d2944278d80..2e6d24d783f7 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -700,7 +700,6 @@ config HMM
>  config HMM_MIRROR
>         bool "HMM mirror CPU page table into a device page table"
>         depends on ARCH_HAS_HMM
> -       select MMU_NOTIFIER
>         select HMM
>         help
>           Select HMM_MIRROR if you want to mirror range of the CPU page table of a

Because it is a select option no harm can come from that hence i do
not remove but i can remove it.

Cheers,
Jérôme
