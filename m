Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771CEC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4875820883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FMYkmme4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbfDARak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:30:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52828 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfDARah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:30:37 -0400
Received: from zn.tnic (p200300EC2F148A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F1A81EC05A6;
        Mon,  1 Apr 2019 19:30:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1554139835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=j/WS3lJjsV+M5Fg2UK2oZqlqiN9cIoFUxP3NKl6nmRs=;
        b=FMYkmme4Z4SedqJSUCT/YKAGR4rK4c2eXXgQHMXDXwDe3fx2Rbf4Q8HK4vJGpNtOsXNV4+
        MO/09j4+y5y/LgDO0KnWgarYss5Fk0cW4m/sWCcFl5SihRWNqFbnbfq9xnG7vsYn2KGYkG
        YZH1r36HVJgbsk6AZu7apeUBA1VZYOQ=
Date:   Mon, 1 Apr 2019 19:30:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Qiaowei Ren <qiaowei.ren@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH v3 2/4] x86/microcode: Fix __user annotations around
 generic_load_microcode()
Message-ID: <20190401173031.GK28264@zn.tnic>
References: <20190329214652.258477-1-jannh@google.com>
 <20190329214652.258477-2-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190329214652.258477-2-jannh@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:46:50PM +0100, Jann Horn wrote:
> generic_load_microcode() deals with a pointer that can be either a kernel
> pointer or a user pointer. Pass it around as a __user pointer so that it
> can't be dereferenced accidentally while its address space is unknown.
> Use explicit casts to convert between __user and __kernel to inform the
> checker that these address space conversions are intentional.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 16936a24795c..e8ef65c275c7 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -861,11 +861,13 @@ static enum ucode_state apply_microcode_intel(int cpu)
>  	return ret;
>  }
>  
> -static enum ucode_state generic_load_microcode(int cpu, void *data, size_t size,
> -				int (*get_ucode_data)(void *, const void *, size_t))
> +static enum ucode_state generic_load_microcode(int cpu,
> +		const void __user *data, size_t size,
> +		int (*get_ucode_data)(void *, const void __user *, size_t))

Ok, how about something completely different?

This ->get_ucode_data() BIOS-code-like contraption has always bugged me
for being too ugly to live.

How about we vmalloc() a properly sized buffer - both
generic_load_microcode() callers have the size - and then hand that
buffer into generic_load_microcode() ?

That solves the __user annotation fun immediately and would simplify
generic_load_microcode() additionally.

The disadvantage would be having to vmalloc() a couple of... , I think
it is megabytes, with that old loading method request_microcode_user()
but then if vmalloc() fails, then it was clearly too big. I don't think
the blob can ever be that big though, to fail vmalloc(), but I'm not
going to bet on it...

Hmmm...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
