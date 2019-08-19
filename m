Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF09CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87BF12070D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 14:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="mHn3gSC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfHSOrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:47:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32858 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfHSOrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:47:36 -0400
Received: from zn.tnic (p200300EC2F04B7003923E3AC7BEA9973.dip0.t-ipconnect.de [IPv6:2003:ec:2f04:b700:3923:e3ac:7bea:9973])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 096061EC0B07;
        Mon, 19 Aug 2019 16:47:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1566226055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qKxgkmSJofrqLeIUB9lEIsZStEINM5JH2iPOKZPYLpo=;
        b=mHn3gSC8qa8gersFDQSTpGybepIU1Z0MCT0mNeP7c8Ty+Pl6f/wmMq1zKFZg9lGaPTTFkI
        7GcLkjqsbyhKKJax08Jfu0tnxOaeWLyx9v51ILbb73kqERDwJSZTP67TJDELSXvPC/fu3K
        MaGlDa9DfpKttMhutDj3iD3TdV2eav4=
Date:   Mon, 19 Aug 2019 16:47:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 08/28] x86/uaccess: annotate local function
Message-ID: <20190819144734.GB4522@zn.tnic>
References: <20190808103854.6192-1-jslaby@suse.cz>
 <20190808103854.6192-9-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190808103854.6192-9-jslaby@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 12:38:34PM +0200, Jiri Slaby wrote:
> copy_user_handle_tail is a self-standing local function, annotate it as
> such using SYM_FUNC_START_LOCAL.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: x86@kernel.org
> ---
>  arch/x86/lib/copy_user_64.S | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index 4fe1601dbc5d..d163c9566abe 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -230,8 +230,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   * Output:
>   * eax uncopied bytes or 0 if successful.
>   */
> -ALIGN;
> -copy_user_handle_tail:
> +SYM_CODE_START_LOCAL(copy_user_handle_tail)
>  	movl %edx,%ecx
>  1:	rep movsb
>  2:	mov %ecx,%eax
> @@ -239,7 +238,7 @@ copy_user_handle_tail:
>  	ret
>  
>  	_ASM_EXTABLE_UA(1b, 2b)
> -END(copy_user_handle_tail)
> +SYM_CODE_END(copy_user_handle_tail)
>  
>  /*
>   * copy_user_nocache - Uncached memory copy with exception handling
> -- 

Also, s/copy_user_handle_tail/.Lcopy_user_handle_tail/g

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
