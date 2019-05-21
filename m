Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA59C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 519E02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HTDoWsxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfEUUXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:23:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36414 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfEUUXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:23:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id v80so40027pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jL1S7zFzjAxE4JNqh4L9FDfG4cAz8JcsD74o794kTBQ=;
        b=HTDoWsxi7QDqVixev1f6cqXoZsue3n3xEMiTeFWZaXgqKnKMwHNLfC3f+dJJhqMBRw
         nDQtVaPP/Z0+mQW6Cy9frq6SwMcF66bdeErddgk7YrYR0WJIYRfOZsfwALK2a95aELQF
         DAIWkjIYzMPYDvGxpWXquPJ9JJRDVKkErl4fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jL1S7zFzjAxE4JNqh4L9FDfG4cAz8JcsD74o794kTBQ=;
        b=YBo8EDRHlPh2pSgkMaNUq4KBZw6WW16lRUtEleC1B8hJBBleorasrBCm5HQH1Oubq/
         OTEq1D53V8azP0q4aiJDKc4slmvhbcRqsZNZStIzr9ORvfa7nqdwUfDUXD/sG5p8PXnL
         Tq/mnYuMPKHeYCD2HYMlSu8UyYDXUq+Ub2fL0AQaN7eibg72SqPnMGKP4hYkkdwSRqQO
         1tGl0QG7NI+Fc/GuyW7junY0YYTCFLPRcYYF2kfw+0LqiCTdOPTZW5blcWhq1IK892K/
         m2l1LBu99uGLS2nWSL9mGymnLMUghsdIBDuo/MhWudVDOYq3H8ViAQlOUlOCRY3btV4F
         qiEw==
X-Gm-Message-State: APjAAAU7ic6e57WL00xhTE0Rx7J0z8UzCikVZ+kGEt9Vv4XmVtgJQ4TP
        ejiBKAwnMmHfNgxd5dV07IZ8/Q==
X-Google-Smtp-Source: APXvYqxOxJPANXcitp87yHMwwlb908gqPaSxiqSVECmGo+Kntyeadkzvfnc3UlOr5MMFdZisu7CwHg==
X-Received: by 2002:a63:1061:: with SMTP id 33mr58636901pgq.328.1558470232784;
        Tue, 21 May 2019 13:23:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q75sm32078478pfa.175.2019.05.21.13.23.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:23:52 -0700 (PDT)
Date:   Tue, 21 May 2019 13:23:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Philippe Mazenauer <philippe.mazenauer@outlook.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: add missing include <linux/elf-randomize.h>
Message-ID: <201905211323.7064F60D@keescook>
References: <VI1PR07MB44324E07A6AFE89A920444AFFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR07MB44324E07A6AFE89A920444AFFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 03:54:36PM +0000, Philippe Mazenauer wrote:
> Include corresponding header file <linux/elf-randomize.h> for function
> arch_randomize_brk().
> 
> ../arch/arm/kernel/process.c:325:15: warning: no previous prototype for ‘arch_randomize_brk’ [-Wmissing-prototypes]
>  unsigned long arch_randomize_brk(struct mm_struct *mm)
>                ^~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Philippe Mazenauer <philippe.mazenauer@outlook.de>

Acked-by: Kees Cook <keescook@chromium.org>

> ---
>  arch/arm/kernel/process.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index 72cc0862a30e..73782012d403 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -23,6 +23,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/init.h>
>  #include <linux/elfcore.h>
> +#include <linux/elf-randomize.h>
>  #include <linux/pm.h>
>  #include <linux/tick.h>
>  #include <linux/utsname.h>
> -- 
> 2.17.1
> 

-- 
Kees Cook
