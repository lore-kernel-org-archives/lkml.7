Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6049FC76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4261621851
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 14:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729343AbfGSOB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 10:01:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:57178 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbfGSOBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 10:01:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77F1CAE86;
        Fri, 19 Jul 2019 14:01:24 +0000 (UTC)
Date:   Fri, 19 Jul 2019 16:01:22 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] x86/mm: Sync also unmappings in vmalloc_sync_one()
Message-ID: <20190719140122.GF19068@suse.de>
References: <20190717071439.14261-1-joro@8bytes.org>
 <20190717071439.14261-3-joro@8bytes.org>
 <alpine.DEB.2.21.1907172337590.1778@nanos.tec.linutronix.de>
 <20190718084654.GF13091@suse.de>
 <alpine.DEB.2.21.1907181103120.1984@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907181103120.1984@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 11:04:57AM +0200, Thomas Gleixner wrote:
> Joerg,
> 
> On Thu, 18 Jul 2019, Joerg Roedel wrote:
> > On Wed, Jul 17, 2019 at 11:43:43PM +0200, Thomas Gleixner wrote:
> > > On Wed, 17 Jul 2019, Joerg Roedel wrote:
> > > > +
> > > > +	if (!pmd_present(*pmd_k))
> > > > +		return NULL;
> > > >  	else
> > > >  		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
> > > 
> > > So in case of unmap, this updates only the first entry in the pgd_list
> > > because vmalloc_sync_all() will break out of the iteration over pgd_list
> > > when NULL is returned from vmalloc_sync_one().
> > > 
> > > I'm surely missing something, but how is that supposed to sync _all_ page
> > > tables on unmap as the changelog claims?
> > 
> > No, you are right, I missed that. It is a bug in this patch, the code
> > that breaks out of the loop in vmalloc_sync_all() needs to be removed as
> > well. Will do that in the next version.
> 
> I assume that p4d/pud do not need the pmd treatment, but a comment
> explaining why would be appreciated.

Actually there is already a comment in this function explaining why p4d
and pud don't need any treatment:

        /*
         * set_pgd(pgd, *pgd_k); here would be useless on PAE
         * and redundant with the set_pmd() on non-PAE. As would
         * set_p4d/set_pud.
         */ 

I couldn't say it with less words :)


Regards,

	Joerg
