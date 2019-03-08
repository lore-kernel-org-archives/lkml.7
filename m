Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853BBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5178920851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 21:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bVqEpM5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCHVDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 16:03:00 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36534 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfCHVDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 16:03:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so15070680pgr.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 13:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OJpFROwChgzZTSFBmKrhhb/VzvkeeuJXo9L7ruuJ3sI=;
        b=bVqEpM5xkhRW0KGI6a3//IuT4u0V+E+rSMUl07TWeU5vl9f1OARUOOmXDrTcCwpFSl
         n2SUTOQZKOZHIjkQt8IRU2U57JbGYDpk2k5NyUrCYDKqKx15JMOkUuAyZW8u3j5alFTz
         6sYqjAhkiaBKsuXlGdZP5eYyDz574vfugp2p/7f+AJRsodOSEGm3whe6ZctP9v8pY1ZE
         hykUfgraPFb4CBD65Dj0YRxtGREj4+fel/3ZRaH9x3vLoSk3bDODqn8gPkYd80vq4LzN
         QIewH4FG5Szf3LFcn++fxKnJfQzC4jcqWhSc7dFnuUncqoNkI/Dcj8w2M5Tzu1nFQyS9
         cYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OJpFROwChgzZTSFBmKrhhb/VzvkeeuJXo9L7ruuJ3sI=;
        b=d7N6db+H7rI/hMXpeyavKQkmboYDChHDs01mumdJP7RNboMwqTjA/809OB9tCiZmpH
         szh7RqPjpNRKlXKbCpp2Cnwd71vZGpi4YSK7hMcChTyo2BYB9xBPjFZ1JAO3DRcFqZoL
         BcwjoSPRQVeKVP9Fi9c3WxVr/2AZ4uLf2fHylDhVoByEV6Y9JWMJm/0z/0gVSeqPXe0A
         kwlH8Gn0kJQEo1tZHLpsZjzr7ztLKu4mlqrtupb8iDJraseHhetDGFKeBvOdrYDNvvdZ
         MNEVgS2i5/NAuO12gKofEkKner/je5x3pfgInTCbQqW+Ia1oUd+WlxE2AYdLf/LB3cHF
         wgnQ==
X-Gm-Message-State: APjAAAUZil+L5GZOtN10wakcBwaBir0nOSkT5a9FoU/incTiSqDIjwPZ
        5kyzp+NiLJsxG0MwDayzr7jLtkmEdWIlWKVjlEI/fw==
X-Google-Smtp-Source: APXvYqzpEbu25WtrmKx/1TIib0DXqNoV1HLf6loSGwbAG+5ezGBF9eUPcsDE2OBBfn7KJ39gCoXQdHs7EpVJ1P74WP4=
X-Received: by 2002:a17:902:e85:: with SMTP id 5mr21023659plx.13.1552078978757;
 Fri, 08 Mar 2019 13:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20190307162101.29204-1-natechancellor@gmail.com> <20190308040239.9400-1-natechancellor@gmail.com>
In-Reply-To: <20190308040239.9400-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 Mar 2019 13:02:47 -0800
Message-ID: <CAKwvOdkjpRVJ=TE8JCoMDJ46s6ToSgo0c2RcsoQ-JOPYMgLUpw@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Avoid one more sometimes uninitialized Clang warning
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 8:02 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with -Wsometimes-uninitialized, Clang warns:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:111:2: error: variable
> 'ns' is used uninitialized whenever 'if' condition is false
> [-Werror,-Wsometimes-uninitialized]
> drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c:111:2: error: variable
> 'ns' is used uninitialized whenever '&&' condition is false
> [-Werror,-Wsometimes-uninitialized]
>
> Clang is concerned with the use of stmmac_do_void_callback (which
> stmmac_get_systime wraps), as it may fail to initialize these values if
> the if condition was ever false (meaning the callback doesn't exist).
> It's not wrong because the callback is what initializes ns. While it's
> unlikely that the callback is going to disappear at some point and make
> that condition false, we can easily avoid this warning by zero
> initializing the variable.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/384
> Fixes: df103170854e ("net: stmmac: Avoid sometimes uninitialized Clang warnings")

Was initially confused by the link (thought I caught the 3 previous
instances in code review of df103170854e).  I see now that I did not
report stmmac_ptp.c (only stmmac_main.c) properly.  Had I, this could
have been bundled up into df103170854e indeed.  Sorry.  Thanks for
circling back and cleaning up this additional instance.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> index 2293e21f789f..cc60b3fb0892 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
> @@ -105,7 +105,7 @@ static int stmmac_get_time(struct ptp_clock_info *ptp, struct timespec64 *ts)
>         struct stmmac_priv *priv =
>             container_of(ptp, struct stmmac_priv, ptp_clock_ops);
>         unsigned long flags;
> -       u64 ns;
> +       u64 ns = 0;
>
>         spin_lock_irqsave(&priv->ptp_lock, flags);
>         stmmac_get_systime(priv, priv->ptpaddr, &ns);
> --
> 2.21.0
>


-- 
Thanks,
~Nick Desaulniers
