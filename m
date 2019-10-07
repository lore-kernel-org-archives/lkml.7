Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C390AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 958C92070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qlD40uM6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfJGRAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:00:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGRAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:00:06 -0400
Received: from zn.tnic (p200300EC2F06420085D86D94306C6599.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:4200:85d8:6d94:306c:6599])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 507C01EC02C1;
        Mon,  7 Oct 2019 19:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570467604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZvNLEWaQDcZ6eL061D1WLQ0GhGCmCN49SVaTp9ErjJ4=;
        b=qlD40uM6egLVWxGPYM9QUvus7VL5DNAFIg4gaxaXV3+/Dia/8P57RvcZ73xuZ9z8PjT00i
        zoqbuaxC/71qMqdwhbguwQ3r3w4O7eJbuqhT+qbwkBhmuXh6pAq6G+GFa8Nkv2B2siskPZ
        SiQujw8xlIbTLBuN4E3TWRoMFa06uDk=
Date:   Mon, 7 Oct 2019 18:59:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, x86@kernel.org,
        jailhouse-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 2/2] x86/jailhouse: Only enable platform UARTs if
 available
Message-ID: <20191007165958.GE24289@zn.tnic>
References: <20191007123819.161432-1-ralf.ramsauer@oth-regensburg.de>
 <20191007123819.161432-3-ralf.ramsauer@oth-regensburg.de>
 <20191007162636.GD24289@zn.tnic>
 <85502467-d13b-084e-cdb8-d891178e97d8@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <85502467-d13b-084e-cdb8-d891178e97d8@oth-regensburg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 06:44:39PM +0200, Ralf Ramsauer wrote:
> Yep, jailhouse_serial_fixup can become __init, I didn't see that, but
> you're right, thanks. I'm curious, how did you find that?

CONFIG_SECTION_MISMATCH_WARN_ONLY=y

If that it off, it fails the build even:

WARNING: vmlinux.o(.text+0x4fdb0): Section mismatch in reference from the function jailhouse_serial_fixup() to the variable .init.data:can_use_brk_pgt
The function jailhouse_serial_fixup() references
the variable __initdata can_use_brk_pgt.
This is often because jailhouse_serial_fixup lacks a __initdata 
annotation or the annotation of can_use_brk_pgt is wrong.

FATAL: modpost: Section mismatches detected.
Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
make[1]: *** [scripts/Makefile.modpost:66: __modpost] Error 1
make: *** [Makefile:1074: vmlinux] Error 2

Apparently we did that with:

47490ec141b9 ("modpost: Add flag -E for making section mismatches fatal")

> "We" didn't notice yet. :-)

LOL.

> BTW, we refers to the Jailhouse folks, but I will rewrite that.

Thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
