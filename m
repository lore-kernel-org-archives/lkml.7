Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EDFC282E3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11092077C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfDWNep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:34:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfDWNep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:34:45 -0400
Received: from p5de0b374.dip0.t-ipconnect.de ([93.224.179.116] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hIvZ0-0007x3-5X; Tue, 23 Apr 2019 15:34:22 +0200
Date:   Tue, 23 Apr 2019 15:34:14 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Laurent Dufour <ldufour@linux.vnet.ibm.com>
cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, rguenther@suse.de,
        mhocko@suse.com, vbabka@suse.cz, luto@amacapital.net,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mpx: fix recursive munmap() corruption
In-Reply-To: <6718ede2-1fcb-1a8f-a116-250eef6416c7@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1904231533190.9956@nanos.tec.linutronix.de>
References: <20190401141549.3F4721FE@viggo.jf.intel.com> <alpine.DEB.2.21.1904191248090.3174@nanos.tec.linutronix.de> <87d0lht1c0.fsf@concordia.ellerman.id.au> <6718ede2-1fcb-1a8f-a116-250eef6416c7@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-995733783-1556026462=:9956"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-995733783-1556026462=:9956
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Tue, 23 Apr 2019, Laurent Dufour wrote:
> Le 20/04/2019 à 12:31, Michael Ellerman a écrit :
> > Thomas Gleixner <tglx@linutronix.de> writes:
> > > Aside of that the powerpc variant looks suspicious:
> > > 
> > > static inline void arch_unmap(struct mm_struct *mm,
> > >                                unsigned long start, unsigned long end)
> > > {
> > >   	if (start <= mm->context.vdso_base && mm->context.vdso_base < end)
> > >                  mm->context.vdso_base = 0;
> > > }
> > > 
> > > Shouldn't that be:
> > > 
> > >   	if (start >= mm->context.vdso_base && mm->context.vdso_base < end)
> > > 
> > > Hmm?
> > 
> > Yeah looks pretty suspicious. I'll follow-up with Laurent who wrote it.
> > Thanks for spotting it!
> 
> I've to admit that I had to read that code carefully before answering.
> 
> There are 2 assumptions here:
>  1. 'start' and 'end' are page aligned (this is guaranteed by __do_munmap().
>  2. the VDSO is 1 page (this is guaranteed by the union vdso_data_store on
> powerpc).
> 
> The idea is to handle a munmap() call surrounding the VDSO area:
>       | VDSO |
>  ^start         ^end
> 
> This is covered by this test, as the munmap() matching the exact boundaries of
> the VDSO is handled too.
> 
> Am I missing something ?

Well if this is the intention, then you missed to add a comment explaining it :)

Thanks,

	tglx
--8323329-995733783-1556026462=:9956--
