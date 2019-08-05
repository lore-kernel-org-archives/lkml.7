Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B289EC0650F
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86329216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 20:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kpk/QTAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbfHEUTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 16:19:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38502 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEUTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 16:19:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id az7so36863363plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WWEuVYEQjIg+hnBwN/5LSPUc/3g6UGWUiRSIm25OgPM=;
        b=Kpk/QTAlBBoflr9NNvQnMcao+cN8Kr6DqdN1KzmN15u29LUwJrL9tiTCfWNtjLtof4
         OokYcaxAq5E8M8RlF43V0Scp7Fz7xMr/jlcO7hzKbpdd2ut3NPaEqOth6MKpgMUjBd5A
         13XcEfFZ3zmIpQq9h2kwOLMxV5l+eLChJIw8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WWEuVYEQjIg+hnBwN/5LSPUc/3g6UGWUiRSIm25OgPM=;
        b=psCCGFmesQtJv2Zi3+pWyDr2zeqHLWnQ3yjqBvu/VsKutLX1O9vzDwvnxXI0dqjrEX
         RUs4tUQrccD6hAKlg1kJNuzmx9d+v1KE8QRQayO6e38bFdXBj0coQ5VkgZlmgWjLjwGg
         x130HnyTDaVaA3wPceOEoeJRGh6Zay9k5g/UwiXlFnmmDr86+Ikawm9qVKT4tLrHdW21
         U96ZMNpuG8afM508/2a/G3jmH8GOIrbAXhZ59pZVF/8ygCxNurJWuYzOUhbBMBz9u8x6
         fNrL9CWuLuxu+ke65aO4AN2a9ObXR7FJBIcvB4GWrdCJwoA6x8qZ5lrn3CoGhl+eaCvm
         6Kow==
X-Gm-Message-State: APjAAAXbtBQC+NPXYRFdBUhSmd44w54tQhL6j9kN6YYo8d2cHKmYi9OZ
        CfKflDFMIxlOajNtY/qPBBZuKeobyaY=
X-Google-Smtp-Source: APXvYqwFMiy3kA2sp8humX+12XWgx+xISrnymYTBHSBBwOQoGaLOZRnENT3caGcFyp0Mnu3YZ2XwHA==
X-Received: by 2002:a17:902:44f:: with SMTP id 73mr147824631ple.192.1565036361643;
        Mon, 05 Aug 2019 13:19:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 201sm102116909pfz.24.2019.08.05.13.19.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 13:19:20 -0700 (PDT)
Date:   Mon, 5 Aug 2019 13:19:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/ptrace: Mark expected switch fall-through
Message-ID: <201908051319.146A70C@keescook>
References: <20190805195654.GA17831@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805195654.GA17831@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 02:56:54PM -0500, Gustavo A. R. Silva wrote:
> Mark switch cases where we are expecting to fall through.
> 
> Fix the following warning (Building: allnoconfig i386):
> 
> arch/x86/kernel/ptrace.c:202:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    if (unlikely(value == 0))
>       ^
> arch/x86/kernel/ptrace.c:206:2: note: here
>   default:
>   ^~~~~~~
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/kernel/ptrace.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index 0fdbe89d0754..3c5bbe8e4120 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -201,6 +201,7 @@ static int set_segment_reg(struct task_struct *task,
>  	case offsetof(struct user_regs_struct, ss):
>  		if (unlikely(value == 0))
>  			return -EIO;
> +		/* Else, fall through */
>  
>  	default:
>  		*pt_regs_access(task_pt_regs(task), offset) = value;
> -- 
> 2.22.0
> 

-- 
Kees Cook
