Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BEBC742CA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8A021019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562945675;
	bh=0Jq5bytHScmzuaUgkLOcMn+wkYvpVCOyFIY3QFlQlPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=o/E3HDxFivYM26kx/UY6tlnqsPSXZALf8RhxJmFu0UjV1nXIEHhE9pD0wZJrrt9nq
	 nqW6T6HOTjOi3TX4tSg58RCV+WSMUcYT8I6x85KLv3b7F7Ki7PqAHR4TNAabXRU6tH
	 ZgZww4GlobY1JFhMxBuDT2qd554ajtKS8wgqT9rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbfGLPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 11:34:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726967AbfGLPea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:34:30 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8358208E4;
        Fri, 12 Jul 2019 15:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562945669;
        bh=0Jq5bytHScmzuaUgkLOcMn+wkYvpVCOyFIY3QFlQlPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EcsX4XKIQ29y1tUOqb/gQ7R67pM4qGY9wMlQLPjygHdM6CzLF5q6w58H+PNWDbKq7
         jp4bnti/aIq2MeMoqkBEpiswGCsjM/U+6REw5bsOLPNoqagF9OaJUS+5reMSz+blsL
         +29+dJNduIXKl4ANdFw2W3EFliUz3id0zm6OMOKo=
Date:   Fri, 12 Jul 2019 16:34:23 +0100
From:   Will Deacon <will@kernel.org>
To:     "Raslan, KarimAllah" <karahmed@amazon.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yaojun8558363@gmail.com" <yaojun8558363@gmail.com>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "info@metux.net" <info@metux.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "yuzhao@google.com" <yuzhao@google.com>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "anders.roxell@linaro.org" <anders.roxell@linaro.org>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>
Subject: Re: [PATCH] arm: Extend the check for RAM in /dev/mem
Message-ID: <20190712153423.ypyqexfmajrmsa5r@willie-the-truck>
References: <1562883681-18659-1-git-send-email-karahmed@amazon.de>
 <20190712145711.mxmnuyn6kpv2dr7u@willie-the-truck>
 <1562944417.1345.17.camel@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1562944417.1345.17.camel@amazon.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 03:13:38PM +0000, Raslan, KarimAllah wrote:
> On Fri, 2019-07-12 at 15:57 +0100, Will Deacon wrote:
> > On Fri, Jul 12, 2019 at 12:21:21AM +0200, KarimAllah Ahmed wrote:
> > > 
> > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > index 3645f29..cdc3e8e 100644
> > > --- a/arch/arm64/mm/mmu.c
> > > +++ b/arch/arm64/mm/mmu.c
> > > @@ -78,7 +78,7 @@ void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
> > >  pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
> > >  			      unsigned long size, pgprot_t vma_prot)
> > >  {
> > > -	if (!pfn_valid(pfn))
> > > +	if (!memblock_is_memory(__pfn_to_phys(pfn)))
> > 
> > This looks broken to me, since it will end up returning 'true' for nomap
> > memory and we really don't want to map that using writeback attributes.
> 
> True, I will fix this by using memblock_is_map_memory instead. That said, do
> you have any concerns about this approach in general?

If you do that, I don't understand why you need the patch at all given our
implementation of pfn_valid() in arch/arm64/mm/init.c.

Will
