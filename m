Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B63FC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED2D2063F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 20:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbfFYUFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 16:05:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44379 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfFYUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 16:05:38 -0400
Received: from p5b06daab.dip0.t-ipconnect.de ([91.6.218.171] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hfrgx-0007xf-Q9; Tue, 25 Jun 2019 22:05:24 +0200
Date:   Tue, 25 Jun 2019 22:05:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/boot/64: Fix crash if kernel images crosses page
 table boundary
In-Reply-To: <alpine.DEB.2.21.1906252155430.32342@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1906252204590.32342@nanos.tec.linutronix.de>
References: <20190620112345.28833-1-kirill.shutemov@linux.intel.com> <alpine.DEB.2.21.1906252100290.32342@nanos.tec.linutronix.de> <20190625193053.g5zngehu3ozgzkeg@box> <alpine.DEB.2.21.1906252155430.32342@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2019, Thomas Gleixner wrote:

> On Tue, 25 Jun 2019, Kirill A. Shutemov wrote:
> > On Tue, Jun 25, 2019 at 09:04:39PM +0200, Thomas Gleixner wrote:
> > 
> > > > +		pmd[idx % PTRS_PER_PMD] = pmd_entry + i * PMD_SIZE;
> > > 
> > > This part is functionally equivivalent. So what's the value of this change?
> > 
> > Precedence of operators were broken
> > 
> > 	idx =  i + (physaddr >> PMD_SHIFT) % PTRS_PER_PMD;
> > 
> > reads by compiler as
> > 
> > 	idx = i + ((physaddr >> PMD_SHIFT) % PTRS_PER_PMD);
> > 
> > not as
> > 
> > 	idx =  (i + (physaddr >> PMD_SHIFT)) % PTRS_PER_PMD;
> > 
> > Therefore 'idx' can become >= PTRS_PER_PMD.
> 
> Indeed. Please mention it in the change log. I did not spot it right away.

I fixed it up already. No need to resend.

Thanks,

	tglx
