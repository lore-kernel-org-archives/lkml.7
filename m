Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2C1C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBC820874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jIzMPWZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbfHZHPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:15:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60230 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbfHZHPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:15:45 -0400
Received: from zn.tnic (p200300EC2F065700C590DC7B9886C27F.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:5700:c590:dc7b:9886:c27f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 426691EC058B;
        Mon, 26 Aug 2019 09:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566803744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nkHKAm1vG91TpwR2bDOsp87e2mUi6js2MU6LPCkxmLE=;
        b=jIzMPWZxihiD3BLqrMZz1hXq6CiTahUEYCk0n125DtF5zEYbqEabFLaLwskqP/xAOJsTgd
        aBFYFIwJgrQlyV/HTTqAdm+wL2CKNkMu4G9lqP2tLsGru3YYT/oVteP5MIfb1k0rrztVro
        mU7wrhYsrfdxKsoM75Ox7ZkS1a+cfYo=
Date:   Mon, 26 Aug 2019 09:15:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     tglx@linutronix.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, x86@kernel.org, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, kirill@shutemov.name,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/boot/compressed/64: Fix boot on machines
 with broken E820 table
Message-ID: <20190826071539.GB27636@zn.tnic>
References: <20190813131654.24378-1-kirill.shutemov@linux.intel.com>
 <tip-0a46fff2f9108c2c44218380a43a736cf4612541@git.kernel.org>
 <caa30daa-9ed5-e293-f6cd-ff261c995e1e@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <caa30daa-9ed5-e293-f6cd-ff261c995e1e@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 25, 2019 at 10:33:15PM -0500, Gustavo A. R. Silva wrote:
> Hi all,
> 
> On 8/19/19 9:16 AM, tip-bot for Kirill A. Shutemov wrote:
> [..]
> > 
> > diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> > index 5f2d03067ae5..2faddeb0398a 100644
> > --- a/arch/x86/boot/compressed/pgtable_64.c
> > +++ b/arch/x86/boot/compressed/pgtable_64.c
> > @@ -72,6 +72,8 @@ static unsigned long find_trampoline_placement(void)
> >  
> >  	/* Find the first usable memory region under bios_start. */
> >  	for (i = boot_params->e820_entries - 1; i >= 0; i--) {
> > +		unsigned long new;
> > +
> >  		entry = &boot_params->e820_table[i];
> >  
> >  		/* Skip all entries above bios_start. */
> > @@ -84,15 +86,20 @@ static unsigned long find_trampoline_placement(void)
> >  
> >  		/* Adjust bios_start to the end of the entry if needed. */
> >  		if (bios_start > entry->addr + entry->size)
> 
> Notice that if this condition happens to be false, we end up with an
> uninitialized variable *new*.

Yap, good catch.

> What would be the right value to assign to *new* at declaration under
> this condition?

Looking at the changed flow of the loop, how we use new instead of
bios_start and how we assign new back to bios_start, I think we should
do:

		unsigned long new = bios_start;

at the beginning...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
