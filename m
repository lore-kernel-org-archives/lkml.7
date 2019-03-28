Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924C4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DE621773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="X2FSVrcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfC1HYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:24:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55786 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbfC1HYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:24:22 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD71A1EC014B;
        Thu, 28 Mar 2019 08:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553757860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=p3OLiscZsZtjqPCvgObw2kXIgPx1iqgzcZARJexfyvg=;
        b=X2FSVrcRFfcbhVvKevYvwMdDW+NRtOy3OB3qWfQFcILexlxP5rXbZwJNo/DKE56JwCFMN3
        d3xQTWtW4OvbNf0Vif8jL60JeB0XB5PczoCOZbpahEEnFmIBNhmjEDYZ3Ytb6nTyWWtStf
        IpdmWo/SpSjEg7TCKwdXZi2+S5k51yY=
Date:   Thu, 28 Mar 2019 08:24:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.co,
        hpa@zytor.com, x86@kernel.org, linux-kernel@lists.codethink.co.uk,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/asm: add __user on copy_user_handle_tail() pointers
Message-ID: <20190328072421.GA22720@zn.tnic>
References: <20190228185027.2480-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190228185027.2480-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 06:50:27PM +0000, Ben Dooks wrote:
> The copy_user_handle_tail() clearly uses both from and to as pointers
> to user-space memory. This triggers sparse warning on using the calls
> to get and put to user-space. This can be fixed easily by changing the
> call to take __user annotated pointer.s

Well, but copy_user_generic() (which ends up calling the
copy_user_handle_tail() eventually) casts those __user pointers to
(__force void *). Converting them back to __user looks strange to me.

Linus?

Leaving in the rest for reference.

> arch/x86/lib/usercopy_64.c:68:21: warning: incorrect type in argument 1 (different address spaces)
> arch/x86/lib/usercopy_64.c:68:21:    expected void const volatile [noderef] <asn:1>*<noident>
> arch/x86/lib/usercopy_64.c:68:21:    got char *
> arch/x86/lib/usercopy_64.c:70:21: warning: incorrect type in argument 1 (different address spaces)
> arch/x86/lib/usercopy_64.c:70:21:    expected void const volatile [noderef] <asn:1>*<noident>
> arch/x86/lib/usercopy_64.c:70:21:    got char *to
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  arch/x86/include/asm/uaccess_64.h | 2 +-
>  arch/x86/lib/usercopy_64.c        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/uaccess_64.h b/arch/x86/include/asm/uaccess_64.h
> index a9d637bc301d..cbca2cb28939 100644
> --- a/arch/x86/include/asm/uaccess_64.h
> +++ b/arch/x86/include/asm/uaccess_64.h
> @@ -208,7 +208,7 @@ __copy_from_user_flushcache(void *dst, const void __user *src, unsigned size)
>  }
>  
>  unsigned long
> -copy_user_handle_tail(char *to, char *from, unsigned len);
> +copy_user_handle_tail(char __user *to, char __user *from, unsigned len);
>  
>  unsigned long
>  mcsafe_handle_tail(char *to, char *from, unsigned len);
> diff --git a/arch/x86/lib/usercopy_64.c b/arch/x86/lib/usercopy_64.c
> index ee42bb0cbeb3..aa180424e77a 100644
> --- a/arch/x86/lib/usercopy_64.c
> +++ b/arch/x86/lib/usercopy_64.c
> @@ -60,7 +60,7 @@ EXPORT_SYMBOL(clear_user);
>   * it is not necessary to optimize tail handling.
>   */
>  __visible unsigned long
> -copy_user_handle_tail(char *to, char *from, unsigned len)
> +copy_user_handle_tail(char __user *to, char __user *from, unsigned len)
>  {
>  	for (; len; --len, to++) {
>  		char c;
> -- 
> 2.20.1
> 

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
