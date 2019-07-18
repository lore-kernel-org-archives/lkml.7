Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15325C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D28E42173E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389687AbfGRJFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:05:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56628 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbfGRJFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:05:08 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ho2LR-00058c-Iy; Thu, 18 Jul 2019 11:04:57 +0200
Date:   Thu, 18 Jul 2019 11:04:57 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Joerg Roedel <jroedel@suse.de>
cc:     Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] x86/mm: Sync also unmappings in vmalloc_sync_one()
In-Reply-To: <20190718084654.GF13091@suse.de>
Message-ID: <alpine.DEB.2.21.1907181103120.1984@nanos.tec.linutronix.de>
References: <20190717071439.14261-1-joro@8bytes.org> <20190717071439.14261-3-joro@8bytes.org> <alpine.DEB.2.21.1907172337590.1778@nanos.tec.linutronix.de> <20190718084654.GF13091@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg,

On Thu, 18 Jul 2019, Joerg Roedel wrote:
> On Wed, Jul 17, 2019 at 11:43:43PM +0200, Thomas Gleixner wrote:
> > On Wed, 17 Jul 2019, Joerg Roedel wrote:
> > > +
> > > +	if (!pmd_present(*pmd_k))
> > > +		return NULL;
> > >  	else
> > >  		BUG_ON(pmd_pfn(*pmd) != pmd_pfn(*pmd_k));
> > 
> > So in case of unmap, this updates only the first entry in the pgd_list
> > because vmalloc_sync_all() will break out of the iteration over pgd_list
> > when NULL is returned from vmalloc_sync_one().
> > 
> > I'm surely missing something, but how is that supposed to sync _all_ page
> > tables on unmap as the changelog claims?
> 
> No, you are right, I missed that. It is a bug in this patch, the code
> that breaks out of the loop in vmalloc_sync_all() needs to be removed as
> well. Will do that in the next version.

I assume that p4d/pud do not need the pmd treatment, but a comment
explaining why would be appreciated.

Thanks,

	tglx
