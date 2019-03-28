Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA27EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93CD92173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ggReSSl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfC1I2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 04:28:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37418 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbfC1I2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 04:28:22 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 03F7C1EC0469;
        Thu, 28 Mar 2019 09:28:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553761701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=lq5Mb0Ra5rZ8tmIstnYSAYyb+StPClY09QWs//hTAgU=;
        b=ggReSSl9Q0GvJUVgbufgaKqxtOz/NGPege8ygK1MDb9v+HvrdOxjMk9bI5d5V11Wmtyd8G
        +6wivGqwAE1KioRKBWzP7A59Z/17hBpl9TkbXcGHH/EZ155GXFYe5LTsrhEl9MWn6kwSaH
        uZb9v5Dgl9GgX6SlAiH05yRvA86AXC4=
Date:   Thu, 28 Mar 2019 09:28:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] x86/boot: Convert early_serial_base to unsigned
 long
Message-ID: <20190328082823.GC22720@zn.tnic>
References: <20190319184325.72807-1-andriy.shevchenko@linux.intel.com>
 <20190319184325.72807-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190319184325.72807-2-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 09:43:19PM +0300, Andy Shevchenko wrote:
> As a preparatory of adding flexible serial I/O accessors, convert
> early_serial_base to unsigned long to cover all possible bus addresses
> on the system.
> 
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/boot/boot.h                            | 2 +-
>  arch/x86/boot/compressed/early_serial_console.c | 2 +-
>  arch/x86/boot/compressed/misc.h                 | 4 ++--
>  arch/x86/boot/early_serial_console.c            | 6 +++---
>  arch/x86/boot/tty.c                             | 2 +-
>  5 files changed, 8 insertions(+), 8 deletions(-)

...

> diff --git a/arch/x86/boot/early_serial_console.c b/arch/x86/boot/early_serial_console.c
> index 023bf1c3de8b..2b663beda582 100644
> --- a/arch/x86/boot/early_serial_console.c
> +++ b/arch/x86/boot/early_serial_console.c
> @@ -23,7 +23,7 @@
>  
>  #define DEFAULT_BAUD 9600
>  
> -static void early_serial_init(int port, int baud)
> +static void early_serial_init(unsigned long port, int baud)
>  {
>  	unsigned char c;
>  	unsigned divisor;
> @@ -48,7 +48,7 @@ static void parse_earlyprintk(void)
>  	int baud = DEFAULT_BAUD;
>  	char arg[32];
>  	int pos = 0;
> -	int port = 0;
> +	unsigned long port = 0;
>  
>  	if (cmdline_find_option("earlyprintk", arg, sizeof(arg)) > 0) {
>  		char *e;
> @@ -118,7 +118,7 @@ static void parse_console_uart8250(void)
>  {
>  	char optstr[64], *options;
>  	int baud = DEFAULT_BAUD;
> -	int port = 0;
> +	unsigned long port = 0;

Here and above:

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
