Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7DFC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A966208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 07:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lz8fzQ6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfEMHbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 03:31:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfEMHbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 03:31:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id b18so3976646wrq.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kGPFbW+hAp4ZfBjUVrsplA4gJ28xyqGrAsYk0A4f3dY=;
        b=lz8fzQ6Gz+asmdxNLtzFcLWkBMrUdSBHelD85bth92l8kTB4hxwCgTqu5/B25eVF5v
         S+B9UiRacIiIjM3Idn833UGwVqpeRUS3e0B6vNsdQnia96Pfnom2j64c6+iPu5PbVFNj
         SyjW4RRVfI8090bOQV3veOlJTBmYKuFaQ8BFp1xhZmc81mgnOF9ywaXeDGQDd7Ifun5m
         U1jw3oz3YobaiK3auuebmGI+u6/RAbT7iSYsE0GKGDxnXZIkSpQaE2LD3qNBPno7ingJ
         1UWVvnlbiXytARZGAgQ5zf8hd7nqLFnizIleWswizIMTQXWTK4hK19EN2XuZIeQ9rr29
         I0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kGPFbW+hAp4ZfBjUVrsplA4gJ28xyqGrAsYk0A4f3dY=;
        b=JFlmnWa6CMMgUoqg0Meu0JJ8tu4yFEVUnlTX/GJw+AxxcaJ9iBIP09bSjkMZCu30w8
         pNPfkp69z6VIySBdqw6G/FtqR5tzqfaJbVl+UaR3ikJG5yGeyKNpfT86LQ4B8FwyHNMF
         G4mcx9kaEkiZ3uCJGzBlRxMcWJ9NIT+4KXjyYd5kFW9gclASKAWDpIlkv/PndDpF7tVG
         42pk7C3Ad6j9oFClWP9fogT8veseLxR/Zq57S6KS+7PGxJA5n8PMi7MYB7zBSJge1Dj2
         bkmd3DJddoZsUMw1ltluixBx38ZUJNXya3qALhSLrj3YL7+iCcwvEhkBJVO3oVE1HKl1
         GOVQ==
X-Gm-Message-State: APjAAAXA7itkj8HW/j/LnLCDUi7V7XmbMmrItpCWi/6I19eYZ/Fp+HiS
        p7RtXblH86qZAILFcUOYDLRgUQ==
X-Google-Smtp-Source: APXvYqzX49vkFGCT6QTfo03i3mfS7qcl2HtkeUZpVM7cWYP9Z4ZY6HQkd2M1j6oCG52utv6rjLNS+Q==
X-Received: by 2002:adf:b3d1:: with SMTP id x17mr16024449wrd.31.1557732661790;
        Mon, 13 May 2019 00:31:01 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id h14sm993503wrt.11.2019.05.13.00.31.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 00:31:01 -0700 (PDT)
Date:   Mon, 13 May 2019 08:30:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Amelie Delaunay <amelie.delaunay@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] mfd: stmfx: Fix macro definition spelling
Message-ID: <20190513073059.GH4319@dell>
References: <20190511012301.2661-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190511012301.2661-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019, Nathan Chancellor wrote:

> Clang warns:
> 
> In file included from drivers/mfd/stmfx.c:13:
> include/linux/mfd/stmfx.h:7:9: warning: 'MFD_STMFX_H' is used as a
> header guard here, followed by #define of a different macro
> [-Wheader-guard]
> 
> Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> Link: https://github.com/ClangBuiltLinux/linux/issues/475
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  include/linux/mfd/stmfx.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
