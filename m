Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE0C32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FB52073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 08:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578558782;
	bh=K/8jTc/G+/G9KpLYm2RrQRaA/2Ksqd3676QEmOVLgSY=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=Ev1XxUCIXqZJrJLvU24TJnMg2439pr8bTI08tEWlIHj2IfcnsRto5hnW+xN7R/93+
	 Xj1Wc76MujRaBpup9HGFndE+6d2gUOUJfnrdNF24Bcna62M6NnoG2MMfqgcodBG4nl
	 PmYBBDD0cn7GoTv+0eN2LNXI24jjb7b78jPYQJSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgAIIdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 03:33:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:59582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbgAIIdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 03:33:01 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F20C20673;
        Thu,  9 Jan 2020 08:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578558780;
        bh=K/8jTc/G+/G9KpLYm2RrQRaA/2Ksqd3676QEmOVLgSY=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=ZW24qfX6vZYfde10oWKxf9doyhrwmVhaLRivKfvaF5mR/fSL/C16gzZHTAQ4nT/3U
         6ySBgEy6Xf8tUj3pT9Ux/29vphkZezo7EaYvT819taR+g978O9qOri3Drqs+vad1iD
         rQoeyPPniBw4IlEyCE3lH7ePUIpPr/RMxZnPiPds=
Date:   Thu, 9 Jan 2020 08:32:55 +0000
From:   Will Deacon <will@kernel.org>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        pasha.tatashin@soleen.com, catalin.marinas@arm.com,
        will.deacon@arm.com, robh+dt@kernel.org, frowand.list@gmail.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/2] arm64: kexec_file: add crash dump support
Message-ID: <20200109083254.GA7280@willie-the-truck>
References: <20191216021247.24950-1-takahiro.akashi@linaro.org>
 <20191216021247.24950-3-takahiro.akashi@linaro.org>
 <20200108174839.GB21242@willie-the-truck>
 <20200109004654.GA28530@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109004654.GA28530@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:46:55AM +0900, AKASHI Takahiro wrote:
> On Wed, Jan 08, 2020 at 05:48:39PM +0000, Will Deacon wrote:
> > On Mon, Dec 16, 2019 at 11:12:47AM +0900, AKASHI Takahiro wrote:
> > > Enabling crash dump (kdump) includes
> > > * prepare contents of ELF header of a core dump file, /proc/vmcore,
> > >   using crash_prepare_elf64_headers(), and
> > > * add two device tree properties, "linux,usable-memory-range" and
> > >   "linux,elfcorehdr", which represent respectively a memory range
> > >   to be used by crash dump kernel and the header's location
> > > 
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Reviewed-by: James Morse <james.morse@arm.com>
> > > Tested-and-reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
> > > ---
> > >  arch/arm64/include/asm/kexec.h         |   4 +
> > >  arch/arm64/kernel/kexec_image.c        |   4 -
> > >  arch/arm64/kernel/machine_kexec_file.c | 106 ++++++++++++++++++++++++-
> > >  3 files changed, 106 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
> > > index 12a561a54128..d24b527e8c00 100644
> > > --- a/arch/arm64/include/asm/kexec.h
> > > +++ b/arch/arm64/include/asm/kexec.h
> > > @@ -96,6 +96,10 @@ static inline void crash_post_resume(void) {}
> > >  struct kimage_arch {
> > >  	void *dtb;
> > >  	unsigned long dtb_mem;
> > > +	/* Core ELF header buffer */
> > > +	void *elf_headers;
> > > +	unsigned long elf_headers_mem;
> > > +	unsigned long elf_headers_sz;
> > >  };
> > 
> > This conflicts with the cleanup work from Pavel. Please can you check my
> > resolution? [1]
> 
> I don't know why we need to change a type of dtb_mem,
> otherwise it looks good.
> 
> (I also assume that you notice that kimage_arch is of no use for kexec.)

Yes, that's why I'd like the resolution checked. If you reckon it's cleaner
to drop Pavel's patch altogether in light of your changes, we can do that
instead.

Thoughts?

Will
