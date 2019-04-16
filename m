Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0BFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BA220663
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Tiy6nao3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbfDPTBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:01:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45982 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfDPTBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:01:50 -0400
Received: from zn.tnic (p200300EC2F0D6900BD7AE2FF560FC812.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:bd7a:e2ff:560f:c812])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 682451EC013F;
        Tue, 16 Apr 2019 21:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555441308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=9TrmgWa/nK4TPdD944ckv6crBu5mexR5sMAjX7q2AGw=;
        b=Tiy6nao3HpBSVjI1C+BAIKki5CT2qFKBdNbnbsDv1zSfzM7H/3F1moHX0dvZJUPpVS0Qin
        k3p+L2p8c7+Pk86usceu332L4+55dHCyMPCTZR71s/I/wc2UeLICstmL+5P9GRHT0lDnOk
        FuGgfR6RGQnPy5d5imsoWpXwEAbggYs=
Date:   Tue, 16 Apr 2019 21:01:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] kernel/crash_core: separate the parsing routines
 to lib/parse_crashkernel.c
Message-ID: <20190416190148.GM31772@zn.tnic>
References: <1554703115-15299-1-git-send-email-kernelfans@gmail.com>
 <1554703115-15299-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554703115-15299-2-git-send-email-kernelfans@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2019 at 01:58:34PM +0800, Pingfan Liu wrote:
> Beside kernel, at early boot stage, the KASLR code also needs to parse the
> crashkernel=x@y or crashkernel=ramsize-range:size[,...][@offset] option,
> and avoid to put randomized kernel in the region.
> 
> Extracting the parsing related routines to lib/parse_crashkernel.c, so it
> will be handy included by other
> files.

Use this commit message for your next submission:

    crash: Carve out crashkernel= cmdline parsing

    Make the "crashkernel=" parsing functionality available to the early
    KASLR code. Will be used by a later patch to parse crashkernel regions
    which KASLR should aviod.

> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> CC: Hari Bathini <hbathini@linux.vnet.ibm.com>
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/crash_core.c     | 273 ---------------------------------------------
>  lib/Makefile            |   2 +
>  lib/parse_crashkernel.c | 289 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 291 insertions(+), 273 deletions(-)

And this is not how you carve out code.

First, you do a patch which does only code move. Nothing more.

In a follow on patch, you make the changes to the moved code so that it
is immediately visible what you're changing.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
