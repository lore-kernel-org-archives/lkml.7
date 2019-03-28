Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0777BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF01217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="F5MdQU3v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbfC1MfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:35:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48366 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfC1Me7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:34:59 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A4281EC038F;
        Thu, 28 Mar 2019 13:34:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553776498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ux1PDQnCC6U5nigYAmGda/APJ12GEh1SpOdVNh3+KZo=;
        b=F5MdQU3vX0cTRct4BPzGrM7MGDgCMb5SMsr2wOWiEt8hq3virvcdlZBdHzUSFyArGpYRc6
        S6L2KWdxmown7C84ur4J8IsGHQ8AhcdHjGGq6sYCQi1Wfx8UR0+B1KoDxiQS/O/sfCwnUm
        TB1DN8USh0GXfarFSrY+w7KcvQEqFDc=
Date:   Thu, 28 Mar 2019 13:35:04 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] x86/boot: Split out parse_serial_port() helper
 for earlyprintk
Message-ID: <20190328123504.GF22720@zn.tnic>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319184325.72807-4-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:43:21PM +0300, Andy Shevchenko wrote:
> The newly introduced helper will be used later on to parse serial port
> in different type of earlyprintk command line arguments.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/boot/early_serial_console.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
> index 05d02cd4de99..85a227a21f95 100644
> --- a/arch/x86/boot/early_serial_console.c
> +++ b/arch/x86/boot/early_serial_console.c
> @@ -66,6 +66,20 @@ static void early_serial_init(unsigned long port, int baud)
>  	early_serial_base = port;
>  }
>  
> +static unsigned long parse_serial_port(const char *arg, int off, int *pos)
> +{
> +	unsigned long port;
> +	char *e;
> +
> +	port = simple_strtoull(arg + off, &e, 16);

WARNING: simple_strtoull is obsolete, use kstrtoull instead
#41: FILE: arch/x86/boot/early_serial_console.c:74:
+       port = simple_strtoull(arg + off, &e, 16);

Please do a conversion patch ontop.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
