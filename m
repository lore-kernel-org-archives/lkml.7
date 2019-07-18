Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D152EC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764822173B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbfGRJRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:17:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:56048 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbfGRJRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:17:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 055D1AF77;
        Thu, 18 Jul 2019 09:17:47 +0000 (UTC)
Date:   Thu, 18 Jul 2019 11:17:45 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
Message-ID: <20190718091745.GG13091@suse.de>
References: <20190717071439.14261-1-joro@8bytes.org>
 <20190717071439.14261-4-joro@8bytes.org>
 <CALCETrXfCbajLhUixKNaMfFw91gzoQzt__faYLwyBqA3eAbQVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXfCbajLhUixKNaMfFw91gzoQzt__faYLwyBqA3eAbQVA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Jul 17, 2019 at 02:24:09PM -0700, Andy Lutomirski wrote:
> On Wed, Jul 17, 2019 at 12:14 AM Joerg Roedel <joro@8bytes.org> wrote:
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 4fa8d84599b0..322b11a374fd 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -132,6 +132,8 @@ static void vunmap_page_range(unsigned long addr, unsigned long end)
> >                         continue;
> >                 vunmap_p4d_range(pgd, addr, next);
> >         } while (pgd++, addr = next, addr != end);
> > +
> > +       vmalloc_sync_all();
> >  }
> 
> I'm confused.  Shouldn't the code in _vm_unmap_aliases handle this?
> As it stands, won't your patch hurt performance on x86_64?  If x86_32
> is a special snowflake here, maybe flush_tlb_kernel_range() should
> handle this?

Imo this is the logical place to handle this. The code first unmaps the
area from the init_mm page-table and then syncs that page-table to all
other page-tables in the system, so one place to update the page-tables.

Performance-wise it makes no difference if we put that into
_vm_unmap_aliases(), as that is called in the vmunmap path too. But it
is right that vmunmap/iounmap performance on x86-64 will decrease to
some degree. If that is a problem for some workloads I can also
implement a complete separate code-path which just syncs unmappings and
is only implemented for x86-32 with !SHARED_KERNEL_PMD.

Regards,

	Joerg
