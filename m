Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2657C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B50206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJIYehn2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfKKUH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:07:59 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35492 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfKKUH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:07:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id n16so12648207oig.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nwqx7QWQGsC3I4CJNnbzWwRJdYPwJji/UODQxE0sPQU=;
        b=tJIYehn2kw6unw0OwdiFgOkyUDNrINJx43lzHBVIhcCikfiewRFeH0wz19EHFmCPqi
         iOq5Xm9cCQrN4riVXpzA2ONUrp4iIIuzmn1qxbj1rlSE9fP4rLhPkw1QXUDgfDlDP822
         sS/DhORtaU51kFXKb/e2Bp3iMp3mhdxKiH6RxfXhvTrD9GYS8YVJ/Qf9+cxS1bJM8KNh
         vM5ZdFjwBhduSApuEABZyV8IPIWZo2mzYp0dOTTjScZzGQ1Y8CasCIIf30c0MURDOl8b
         1CEOlCMTgqRP5/L+QKc654nXmPyu5UDlgUOYuJmo4QpkwS8OjPb1rlkarO6Kz/YWW0JG
         pFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nwqx7QWQGsC3I4CJNnbzWwRJdYPwJji/UODQxE0sPQU=;
        b=sOMxwVHpoqiag+YOtac3LX2FknryQ8aAOmYM5zEkGVrBVTSVgSmnwBfRTMiKvKE/ly
         4CDpB9ExM6FGDmrG65/dh3a3G3gon1CeiQnZ4MfqtjRuowJ/OM8dsVnP/IW7xHQaOTCb
         5s03Q2bxSviw46ciKaIWJuQf3EZYARXa9fnBCcb/sIeJaD8G+yaZQ2+cTkYWSFzjIGgj
         o5rzvQ1AcfzibvQq1SS6N2AA0jEinGYBLLkh/t9v6bFtHVhQjNS3RbW8hhUqwxpTl+yE
         3NPdDwc1w+q9VJpqGwDabFM7qB8PMzBcnvfW5EfFgH3sIOeAvfRUD8vrm19svMJKPXyj
         sxcg==
X-Gm-Message-State: APjAAAXczWv7RvAWboj0Jqboww+sSG4FDs2i5n917pMkgyVWSDQQLCxj
        5Y001DgWtPyz28z2mD/79XY=
X-Google-Smtp-Source: APXvYqxFp3PdUYMAB+G6kG11oigcGErslKKXE/y6y8IuzAxeYHF1sdk6mMMKXXdx4wFiItpFcnGCyw==
X-Received: by 2002:aca:5145:: with SMTP id f66mr649745oib.0.1573502877903;
        Mon, 11 Nov 2019 12:07:57 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id e193sm5295951oib.53.2019.11.11.12.07.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 12:07:57 -0800 (PST)
Date:   Mon, 11 Nov 2019 13:07:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dmitry Golovin <dima@golovin.in>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Matthias Maennich <maennich@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Pitre <nico@fluxnic.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Stefan Agner <stefan@agner.ch>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ARM: kbuild: use correct nm executable
Message-ID: <20191111200755.GA2881@ubuntu-m2-xlarge-x86>
References: <20191110153043.111710-1-dima@golovin.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191110153043.111710-1-dima@golovin.in>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 10, 2019 at 05:30:39PM +0200, Dmitry Golovin wrote:
> Since $(NM) variable can be easily overridden for the whole build, it's
> better to use it instead of $(CROSS_COMPILE)nm. The use of $(CROSS_COMPILE)
> prefixed variables where their calculated equivalents can be used is
> incorrect. This fixes issues with builds where $(NM) is set to llvm-nm.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/766
> Signed-off-by: Dmitry Golovin <dima@golovin.in>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Matthias Maennich <maennich@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
