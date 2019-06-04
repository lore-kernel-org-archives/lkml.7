Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D35C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA850240B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfFDMiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:38:09 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42376 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbfFDMiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:38:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 623BCA78;
        Tue,  4 Jun 2019 05:38:08 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A86153F690;
        Tue,  4 Jun 2019 05:38:02 -0700 (PDT)
Date:   Tue, 4 Jun 2019 13:38:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Subject: Re: [PATCH v2] uaccess: add noop untagged_addr definition
Message-ID: <20190604123759.GA6610@arrakis.emea.arm.com>
References: <c8311f9b759e254308a8e57d9f6eb17728a686a7.1559649879.git.andreyknvl@google.com>
 <20190604122841.GB15385@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604122841.GB15385@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 09:28:41AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 04, 2019 at 02:04:47PM +0200, Andrey Konovalov wrote:
> > Architectures that support memory tagging have a need to perform untagging
> > (stripping the tag) in various parts of the kernel. This patch adds an
> > untagged_addr() macro, which is defined as noop for architectures that do
> > not support memory tagging. The oncoming patch series will define it at
> > least for sparc64 and arm64.
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >  include/linux/mm.h | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 0e8834ac32b7..dd0b5f4e1e45 100644
> > +++ b/include/linux/mm.h
> > @@ -99,6 +99,17 @@ extern int mmap_rnd_compat_bits __read_mostly;
> >  #include <asm/pgtable.h>
> >  #include <asm/processor.h>
> >  
> > +/*
> > + * Architectures that support memory tagging (assigning tags to memory regions,
> > + * embedding these tags into addresses that point to these memory regions, and
> > + * checking that the memory and the pointer tags match on memory accesses)
> > + * redefine this macro to strip tags from pointers.
> > + * It's defined as noop for arcitectures that don't support memory tagging.
> > + */
> > +#ifndef untagged_addr
> > +#define untagged_addr(addr) (addr)
> 
> Can you please make this a static inline instead of this macro? Then
> we can actually know what the input/output types are supposed to be.
> 
> Is it
> 
> static inline unsigned long untagged_addr(void __user *ptr) {return ptr;}
> 
> ?
> 
> Which would sort of make sense to me.

This macro is used mostly on unsigned long since for __user ptr we can
deference them in the kernel even if tagged. So if we are to use types
here, I'd rather have:

static inline unsigned long untagged_addr(unsigned long addr);

In addition I'd like to avoid the explicit casting to (unsigned long)
and use some userptr_to_ulong() or something. We are investigating in
parallel on how to leverage static checking (sparse, smatch) for better
tracking these conversions.

-- 
Catalin
