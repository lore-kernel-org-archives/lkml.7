Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71883C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A82C2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="gPHF+412"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfDOSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:55:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46712 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbfDOSzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:55:35 -0400
Received: from zn.tnic (p4FED3D80.dip0.t-ipconnect.de [79.237.61.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 883541EC02AE;
        Mon, 15 Apr 2019 20:55:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555354533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=0pCVoqiyciNTIr+2+iXGtLsu4F0w24JAj2NcPviuQXI=;
        b=gPHF+412dOMhp8ydjlvEebL78q/qUz9vxuKOJ5PGHbHaUt4Iod2DyyZ391P03ms+qAcvWP
        1R+Mf4Pss+65iqfXsi6h3pqM/mQIOWGQvQ91dOtoHEmlj6SRZ1YC0FsoAvZKyfzTE7QgKr
        QXhJVt3I3JyDNfFFFBOe4xV2TNTiJAY=
Date:   Mon, 15 Apr 2019 20:53:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, kirill@shutemov.name,
        keescook@chromium.org, peterz@infradead.org, thgarnie@google.com,
        herbert@gondor.apana.org.au, mike.travis@hpe.com,
        frank.ramsay@hpe.com, yamada.masahiro@socionext.com
Subject: Re: [PATCH v2 RESEND 1/2] x86/mm/KASLR: Fix the size of the direct
 mapping section
Message-ID: <20190415185319.GI29317@zn.tnic>
References: <20190414072804.12560-1-bhe@redhat.com>
 <20190414072804.12560-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190414072804.12560-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 03:28:03PM +0800, Baoquan He wrote:
> kernel_randomize_memory() uses __PHYSICAL_MASK_SHIFT to calculate
> the maximum amount of system RAM supported. The size of the direct
> mapping section is obtained from the smaller one of the below two
> values:
> 
>  (actual system RAM size + padding size) vs (max system RAM size supported)
> 
> This calculation is wrong since commit:
> b83ce5ee91471d ("x86/mm/64: Make __PHYSICAL_MASK_SHIFT always 52").
> 
> In commit b83ce5ee91471d, __PHYSICAL_MASK_SHIFT was changed to be 52,
> regardless of whether it's using 4-level or 5-level page tables.
> It will always use 4 PB as the maximum amount of system RAM, even
> in 4-level paging mode where it should be 64 TB.  Thus the size of
> the direct mapping section will always be the sum of the actual
> system RAM size plus the padding size.
> 
> Even when the amount of system RAM is 64 TB, the following layout will
> still be used. Obviously KALSR will be weakened significantly.
> 
>    |____|_______actual RAM_______|_padding_|______the rest_______|
>    0            64TB                                            ~120TB
> 
> What we want is the following:
> 
>    |____|_______actual RAM_______|_________the rest______________|
>    0            64TB                                            ~120TB
> 
> So the code should use MAX_PHYSMEM_BITS instead. Fix it by replacing
> __PHYSICAL_MASK_SHIFT with MAX_PHYSMEM_BITS.

First of all, wonderful job!

This changelog is *light* *years* away from what you had before so keep
doing them this detailed and on point from now on!

Now, lemme make sure I understand exactly what you're fixing here:
you're fixing the case where CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING is
not 0. Which is the case when CONFIG_MEMORY_HOTPLUG is enabled.

Yes, no?

If so, please extend the commit message with that fact because it is
crucial and the last missing piece in the explanation.

Otherwise, when the padding is 0, the clamping:

        /* Adapt phyiscal memory region size based on available memory */
        if (memory_tb < kaslr_regions[0].size_tb)
                kaslr_regions[0].size_tb = memory_tb;

will "fix" the direct mapping section size.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
