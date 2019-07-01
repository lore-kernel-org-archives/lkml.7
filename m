Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDD9C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA7B206A3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CI3Iq2aA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfGCBXz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:23:55 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33084 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfGCBXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:23:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id u15so671431oiv.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tjr+kTCBfEIGCCG/hrV8Jjghn6dXfiu1H36R2Sz+qKs=;
        b=CI3Iq2aAqa6cTLPMphI0VdIANcgViK5iD5Lpd8O4rNHBubwk9KdlDQ9POIrvOviZza
         WE8pTGwDVFnrE9xAq9cBqRjuxTN8JpzczIec7ftooghgMuZjpGD5rqjeroZHxFl0NfKH
         unyq+yZB36NObk7atWWgkeW849JAneSR2EQr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tjr+kTCBfEIGCCG/hrV8Jjghn6dXfiu1H36R2Sz+qKs=;
        b=ei3lOcwCOUSq0E1WzaAJiKH7DupZHMUJ3EbQ+Iy1gzlmmpWLKQsy0YO3COXMVPwYRk
         aDuq5yZKMx1hqxi1NCxLOe2HJuU+zwsT97wjwHFgFVFNNftUeYlVh4ZuCpu1+O5UCtFR
         t7k+S9Mnfmf1PfZQJUo04deH7Xh6w8JQ3CeEC49TIoSlEgcA1H+SaB0PwTKiUTOXUjLc
         ChLb26OuQvR6L/GdxDK1Qc/3LHxh829IJHvPB8oKCAHK+uJDGjfrQsYCiAHNLnKzDd+6
         +61j8YvKbxMnmcU5kdN9vm0favSJaZStUHEdRSWdceen449WvBsYrX01Jgt4DgTpPLly
         Zm4g==
X-Gm-Message-State: APjAAAVpcGQy2ncbHQgKhZWtTZawBZlCk+evdv0b9pqfZCwnrBixyIb0
        yJUFaJiycFbaGNXsDK6EZYbTKX3PJnw=
X-Google-Smtp-Source: APXvYqwQMqX0GsfERFAKDe0Bwa3AI5eWVof8HlFAef/H5lfWEufbCDM+mSAkN/wC5xVQgT5/PUChtw==
X-Received: by 2002:a63:755e:: with SMTP id f30mr24465931pgn.246.1562101453492;
        Tue, 02 Jul 2019 14:04:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e20sm1431pfh.50.2019.07.02.14.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 14:04:08 -0700 (PDT)
Date:   Mon, 1 Jul 2019 14:51:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Ross Zwisler <zwisler@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Johannes Hirte <johannes.hirte@datenkhaos.de>,
        Klaus Kusche <klaus.kusche@computerix.info>,
        samitolvanen@google.com, Guenter Roeck <groeck@google.com>
Subject: Re: [PATCH] Revert "x86/build: Move _etext to actual end of .text"
Message-ID: <201907011450.100092F32@keescook>
References: <20190701155208.211815-1-zwisler@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701155208.211815-1-zwisler@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 09:52:08AM -0600, Ross Zwisler wrote:
> This reverts commit 392bef709659abea614abfe53cf228e7a59876a4.
> 
> Per the discussion here:
> 
> https://lkml.org/lkml/2019/6/20/830
> 
> the above referenced commit breaks kernel compilation with old GCC
> toolchains as well as current versions of the Gold linker.  Revert it so
> we don't regress and lose the ability to compile the kernel with these
> tools.
> 
> Signed-off-by: Ross Zwisler <zwisler@google.com>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/kernel/vmlinux.lds.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 0850b5149345..4d1517022a14 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -141,10 +141,10 @@ SECTIONS
>  		*(.text.__x86.indirect_thunk)
>  		__indirect_thunk_end = .;
>  #endif
> -	} :text = 0x9090
>  
> -	/* End of text section */
> -	_etext = .;
> +		/* End of text section */
> +		_etext = .;
> +	} :text = 0x9090
>  
>  	NOTES :text :note
>  
> -- 
> 2.20.1

-- 
Kees Cook
