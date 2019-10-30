Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E035CA9EAF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283FB20856
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 08:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4rh9H+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfJ3IoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 04:44:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35778 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfJ3IoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 04:44:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id x5so1163230wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r8+wN7r4BrgoWGfrY7VXP4mHc/bPGpidu8v8LPP2YUc=;
        b=Z4rh9H+22xLXETaMo+PSqs80h6xxtBjz58NKJRTXfIHYnvYxG4qsk/qTPRZc5w3rSz
         IaYfVX548vJpJJOpwCjeb9GR4LiRuqdLkIP5Y45r5GgJuW8v1Oy8gt0wsND9oKgGtdtM
         OOaDZsNZfFYvSauMwEzJGHHJiVJQRNBWpLsdeCmj2MmrHUZ3NNWJARzBmVY/n6A6D0Dh
         9BsmO4XwhXOdoBZ+nuo+EhlcTL2drFa/dPRmAzQDtl8AScWe+QR6A0XhEEPvQ6jvjMlC
         dv/0S4msE94jk2DH0WkCWWVMKIXE/3o3p7/oZNPc7sQEkzDkcA03jf5JGH3HjALAFNud
         ULCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r8+wN7r4BrgoWGfrY7VXP4mHc/bPGpidu8v8LPP2YUc=;
        b=OLUED/QcZZT97WFmWzDv7HCEFIpYlphwHbL0KsgUHRpKhUZzFWvKidhjT76ha9VQlP
         xI7BGH7r/UzSOIqHbVz0l7huYlLWlqIgCfGwYy8lxHeNQuu/44e2FPfpf6C7F8mRyllT
         V5RJjIN4bfkat8aKV4t5VLBUmEWvo3NALkfHm6iTYV2ROD3+h8CNr9Y3d+fJMtq5x/ZL
         dauWPpSmN7NdDJKmt1I8rZLM7cMJ175LNAQ6c3UN4cC9a+Ule1GftaeXGnRbQht1KidC
         HHtPNeKn7NVVYU3pPE4hUKt606MaYLX0RqnWGNQ8B6I5WgAPpud346jApukxr9u0Jsxk
         67Cg==
X-Gm-Message-State: APjAAAV7+ZpCh8L1nXUH2lrv4VuQ6Z+k9L1m/JnbIOpvzb8ap+KK5E2V
        mpUV1WraC7G9jrIjJWBNxgHQ8dIghR3KSA==
X-Google-Smtp-Source: APXvYqyf/bgbpTbw1ikl55tZ1ofxh+SXQtEBmKYIHB9qzbVXVvoo7WtSZFMTd0FPH0oxU1jIoJrwng==
X-Received: by 2002:a05:600c:2215:: with SMTP id z21mr3508726wml.22.1572425052624;
        Wed, 30 Oct 2019 01:44:12 -0700 (PDT)
Received: from pine ([91.217.168.176])
        by smtp.gmail.com with ESMTPSA id d10sm1327109wme.47.2019.10.30.01.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Oct 2019 01:44:11 -0700 (PDT)
Date:   Wed, 30 Oct 2019 09:44:10 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        joe@perches.com
Subject: Re: [PATCH] sh: kgdb: Mark expected switch fall-throughs
Message-ID: <20191030084410.c7x2sa4ak3m2h2l7@pine>
References: <878sp2d7mm.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sp2d7mm.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 04:17:53PM +0900, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following error:
> 
> LINUX/arch/sh/kernel/kgdb.c: In function 'kgdb_arch_handle_exception':
> LINUX/arch/sh/kernel/kgdb.c:267:6: error: this statement may fall through [-Werror=implicit-fallthrough=]
> if (kgdb_hex2long(&ptr, &addr))
> ^
> LINUX/arch/sh/kernel/kgdb.c:269:2: note: here
> case 'D':
> ^~~~
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

Just FYI this is likely to be converted to be the fallthrough
pseudo-keyword shortly after introductionb but IIRC the keyword is only
available in linux-next right now (and the conversion, from Joe Perches,
is script based so it is likely the change will get picked up by the
script without you having to do anything explicit).


Daniel.

> ---
>  arch/sh/kernel/kgdb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
> index 6d61f8c..0d5f3c9 100644
> --- a/arch/sh/kernel/kgdb.c
> +++ b/arch/sh/kernel/kgdb.c
> @@ -266,6 +266,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
>  		ptr = &remcomInBuffer[1];
>  		if (kgdb_hex2long(&ptr, &addr))
>  			linux_regs->pc = addr;
> +		/* fallthrough */
>  	case 'D':
>  	case 'k':
>  		atomic_set(&kgdb_cpu_doing_single_step, -1);
> -- 
> 2.7.4
> 
