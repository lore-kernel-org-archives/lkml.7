Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BEEC33C99
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9370207E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578446768;
	bh=7zxvCiU+gHGR4GRmG1cvHE0RiTtR7+LpexvhzNKlKpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KUnJM/PzrVGSXiJch2BjbqcFuRe4UFjxnEHvjiCI1FgzdDfA1o4eR/FLC6j9Xusob
	 3UAuD5hXCL7cE4ZJCjip2oriffl86dO6i4KkxhqpWzNzOL7nVC6KmHsaWGQe8yy/dc
	 YPn2zpKDer8MayG3LUUassy+6aXnXG473+ikCgbU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgAHB0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 20:26:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgAHB0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 20:26:07 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD66D20692;
        Wed,  8 Jan 2020 01:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578446767;
        bh=7zxvCiU+gHGR4GRmG1cvHE0RiTtR7+LpexvhzNKlKpg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hQnK0UEw9ZlsNOsV4p4QPfA2+YF/whGABIKaCI7XlawRupGhk/Mkt2NS1qgLRIuwl
         +2hmKYHnJRmWHztA9m8vO4s1qy3dEmoZ5zxn+9PHUx5R+YDvUYho5ff9p0npuOPG7+
         5qfTN85lMMl+a+GnuaL4uIGUj5KP+pRnt80ceECI=
Date:   Wed, 8 Jan 2020 10:26:02 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>, linux-mm@kvack.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Will Deacon <will@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: work around bogus -Wrestrict warning
Message-Id: <20200108102602.43d4c5433eb495cdbf387e9b@kernel.org>
In-Reply-To: <20200107214042.855757-1-arnd@arndb.de>
References: <20200107214042.855757-1-arnd@arndb.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue,  7 Jan 2020 22:40:26 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> gcc -O3 produces some really odd warnings for this file:
> 
> kernel/kallsyms.c: In function 'sprint_symbol':
> kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
>    strcpy(buffer, name);
>    ^~~~~~~~~~~~~~~~~~~~
> kernel/kallsyms.c: In function 'sprint_symbol_no_offset':
> kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
>    strcpy(buffer, name);
>    ^~~~~~~~~~~~~~~~~~~~
> kernel/kallsyms.c: In function 'sprint_backtrace':
> kernel/kallsyms.c:369:3: error: 'strcpy' source argument is the same as destination [-Werror=restrict]
>    strcpy(buffer, name);
>    ^~~~~~~~~~~~~~~~~~~~
> 
> This obviously cannot be since it is preceded by an 'if (name != buffer)'
> check.

Hmm, this looks like a bug in gcc.

> 
> Using sprintf() instead of strcpy() is a bit wasteful but is
> the best workaround I could come up with.
> 
> Fixes: mmtom ("init/Kconfig: enable -O3 for all arches")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index d812b90f4c86..726b8eeb223e 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -366,7 +366,7 @@ static int __sprint_symbol(char *buffer, unsigned long address,
>  		return sprintf(buffer, "0x%lx", address - symbol_offset);
>  
>  	if (name != buffer)
> -		strcpy(buffer, name);
> +		sprintf(buffer, "%s", name);

BTW, this seems not happen. kallsyms_lookup() (and it's subfunctions)
always stores the result into buffer unless name == NULL.
Maybe we can remove these 2 lines?
(and add a comment line for kallsyms_lookup() so that it guarantees the
 symbol name always stored in namebuf argument)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
