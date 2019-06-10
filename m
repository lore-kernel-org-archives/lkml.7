Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17E8C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771A4208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JeDugfY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbfFJVe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:34:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36025 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389362AbfFJVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:34:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id a3so5708100pgb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pteaYwusSv1qv4P2op3THXOYAUVIJihXku4KOl16Zg4=;
        b=JeDugfY0nBQLUyJ8NNKi0czU62TUohv7xo5lv+lX1+btLEQAiU+AwqhR4QyxssKqCF
         xbQy3Tbzk5Z/6xR3MPKNwApNRGQvO4zbAisnDlge/d2NJQwI6etPbgu4PFg8m1vvqeAd
         Iohr4E5mhLtChm+VN9wtD9M28ewP8llVW9pbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pteaYwusSv1qv4P2op3THXOYAUVIJihXku4KOl16Zg4=;
        b=morXb2A6m2ASZq1/OS4YBDTRJhOlOLd+ScTCf6DiqIpUcr+a926P2Lu0NUrfmKWsuF
         Qm5vF9kbfWISdnoxW/PDg4DixKo3WkuKrZXsev6q30f93OZ3Fk0B0NIOUTOZM9/K3WM7
         rLrzGdwQwqMkoEqPdFqBzxNql+ZzSnZuYuAFeCE3lbjQ739Jslydx9ENtKnJOp4054or
         /kWkf7Y3+umBNQs/Lr1nqKjAH1QneOhS5k5NdNoiR1hfMTU/pAtP4Dqa1IvqvQZeNz1F
         ipzhR1NrMMapI516jIT85klReLx34jCEdKp4XZ8aVfY6/+aIoihYWkVWJhq3qEKExOzr
         l17A==
X-Gm-Message-State: APjAAAVNh70aMr0ramu+S+jC+7BTMdOc76TCs2ZtBRggSTvXYX2TJ23Y
        5R+t5CLQFZwl6xL0yIMep3/syg==
X-Google-Smtp-Source: APXvYqwNZMiOvutv3Rp3VcasZg78NdLKjQBKzBhlnHUB2nT2vU+bNnhXVPKquqGWuVAsKl12MA239A==
X-Received: by 2002:a17:90a:7184:: with SMTP id i4mr23657923pjk.49.1560202495619;
        Mon, 10 Jun 2019 14:34:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id a25sm12281912pfn.1.2019.06.10.14.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 14:34:54 -0700 (PDT)
Date:   Mon, 10 Jun 2019 14:34:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Garnier <thgarnie@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/12] x86: pm-trace - Adapt assembly for PIE support
Message-ID: <201906101434.D20FDB0A9@keescook>
References: <20190520231948.49693-1-thgarnie@chromium.org>
 <20190520231948.49693-7-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-7-thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 04:19:31PM -0700, Thomas Garnier wrote:
> From: Thomas Garnier <thgarnie@google.com>
> 
> Change assembly to use the new _ASM_MOVABS macro instead of _ASM_MOV for
> the assembly to be PIE compatible.
> 
> Position Independent Executable (PIE) support will allow to extend the
> KASLR randomization range below 0xffffffff80000000.
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/include/asm/pm-trace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/pm-trace.h b/arch/x86/include/asm/pm-trace.h
> index bfa32aa428e5..972070806ce9 100644
> --- a/arch/x86/include/asm/pm-trace.h
> +++ b/arch/x86/include/asm/pm-trace.h
> @@ -8,7 +8,7 @@
>  do {								\
>  	if (pm_trace_enabled) {					\
>  		const void *tracedata;				\
> -		asm volatile(_ASM_MOV " $1f,%0\n"		\
> +		asm volatile(_ASM_MOVABS " $1f,%0\n"		\
>  			     ".section .tracedata,\"a\"\n"	\
>  			     "1:\t.word %c1\n\t"		\
>  			     _ASM_PTR " %c2\n"			\
> -- 
> 2.21.0.1020.gf2820cf01a-goog
> 

-- 
Kees Cook
