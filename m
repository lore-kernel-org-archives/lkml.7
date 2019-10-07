Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C78C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDD5A20700
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="NdJbYHTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbfJGQ0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:26:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56098 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfJGQ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:26:03 -0400
Received: from zn.tnic (p200300EC2F06420085D86D94306C6599.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:4200:85d8:6d94:306c:6599])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2D3E91EC0BEA;
        Mon,  7 Oct 2019 18:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1570465558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PMlIdZe0tafGlH4Uo3oE7bPvqYHG4BVme2hKO40zQS4=;
        b=NdJbYHTKsOKpZZNBsd9O9Ims8vs9qNkUadLzrXUm36uhAC+njPtSnt60iN5PAl4DCQcJRt
        v+lmfWNNOKTiuv5zlxuTFKBm+6RiBOULXu0FUux+cPy2FTXkkoVG2mSn8BBZAAvpNA7FqL
        ckzS5Lm2wTXVnQ57gnvKBMUsa3VI/Cg=
Date:   Mon, 7 Oct 2019 18:25:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>, x86@kernel.org,
        jailhouse-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 1/2] x86/jailhouse: improve setup data version
 comparison
Message-ID: <20191007162551.GC24289@zn.tnic>
References: <20191007123819.161432-1-ralf.ramsauer@oth-regensburg.de>
 <20191007123819.161432-2-ralf.ramsauer@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007123819.161432-2-ralf.ramsauer@oth-regensburg.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 02:38:18PM +0200, Ralf Ramsauer wrote:
> We will soon introduce a new setup_data version and extend the

Who is "We"?

There a couple more "we" below. Can you please rewrite that commit message in
passive voice and thus dispense my confusion about who's "we"? :)

> structure. This requires some preparational work for the sanity check of
> the header and the check of the version.
> 
> Use the following strategy:
> 
> 1. Ensure that the header declares at least enough space for the version
>    and the compatible_version as we must hold that fields for any
>    version. Furthermore, the location and semantics of those fields will
>    never change.
> 
> 2. Copy over data -- as much as we can. The length is either limited by
>    the header length, or the length of setup_data.
> 
> 3. Things are now in place -- sanity check if the header length complies
>    the actual version.
> 
> For future versions of the setup_data, only step 3 requires alignment.
> 
> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/x86/include/uapi/asm/bootparam.h | 22 +++++++-----
>  arch/x86/kernel/jailhouse.c           | 50 +++++++++++++++++----------
>  2 files changed, 44 insertions(+), 28 deletions(-)

...

> @@ -180,13 +175,26 @@ static void __init jailhouse_init_platform(void)
>  	if (!pa_data)
>  		panic("Jailhouse: No valid setup data found");
>  
> -	if (setup_data.compatible_version > JAILHOUSE_SETUP_REQUIRED_VERSION)
> -		panic("Jailhouse: Unsupported setup data structure");
> +	/* setup data must at least contain the header */
> +	if (header.len < sizeof(setup_data.hdr))
> +		goto unsupported;
>  
> -	pmtmr_ioport = setup_data.pm_timer_address;
> +	pa_data += offsetof(struct setup_data, data);
> +	setup_data_len = min(sizeof(setup_data), (unsigned long)header.len);

Checkpatch makes sense here:

WARNING: min() should probably be min_t(unsigned long, sizeof(setup_data), header.len)
#165: FILE: arch/x86/kernel/jailhouse.c:183:
+       setup_data_len = min(sizeof(setup_data), (unsigned long)header.len);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
