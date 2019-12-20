Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472AFC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C130206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ke0F3drZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfLTRz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:55:26 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45513 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfLTRzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:55:22 -0500
Received: by mail-pg1-f193.google.com with SMTP id b9so5276893pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 09:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xoXHEXUCOBtDITY/XcLLcf4lJLLHDCF5oZRbMuonV/U=;
        b=Ke0F3drZ3Jpd1lr7gPZpD/wYuUs+3JD06nHt+mn89KuV0JtSg1p5AoBawc9s5ahkLw
         ftfFZu0PeaZx/eMQ3fpD3SU5JFKH2ix953eWB+GM5yls6Z1OkU14KuFwInjcCpNFACK0
         xdjuXtxv+mHzq+2c1534zYifCHZ26vI5sPOpDs2NtCSiNuhpbLSOxuz4+Qc+X3tOD69m
         HrDyGn5H+00VHAl71JokGv0FE8cJ0QGc17fUujyqQ9MyUKe8iB9qTwQXvsGQ9c1Zw1MV
         JKdyZtOWayV9P8KNw5QoMNjgWCoEAKmHGt0OOeITOr49WKZJdRYOE3/ksL+IgTENSjy0
         FRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xoXHEXUCOBtDITY/XcLLcf4lJLLHDCF5oZRbMuonV/U=;
        b=WEohDRcAOeRJF8h67Si6CLsMlewtTrrLBaOr2R0hSfoNOkPlfOJUAPeX3Y2c53GglH
         lfOTGK0vI3rpIQEcJA11QEX3kitMUu8ZjFWkChXuXGpKswNlPyBRTWuExfhSqvZ5vcze
         f1McF0OTdjyMEzdY2VbvOgDy8cIYM8Tutp49ZNkXTfvupeVjbGxAOJ/5GRr9Npwf7oSP
         hPKZSI6HQju5M73dZqGn6TXit7mR2eQhlUxlLYwimTTQPucUG72AGhn0uvS9GA1yTPSS
         g/PxjRsvwaOCnTb4MkBvsdf1GHS2K2EeAp8HRl/ohf7lA1jnj6/m/fq9aEqX7YzjviYU
         Tiww==
X-Gm-Message-State: APjAAAVWicPBdsOIQgh72J1dld9tr+kwSFpsP+GpkCnwL5UW2eHhoB/h
        OH5n9DG5oyRBhV8OYNQoqT8t16iglDSmmhePGF2v1w==
X-Google-Smtp-Source: APXvYqzv8FL4X96ovaTwjhjPCE3PhKMmXmXKR1EZP13tNuwsYvj6hY1pGNeEJQ6qzMGyi485e8uTgaZ6/55PPXKthP0=
X-Received: by 2002:aa7:946a:: with SMTP id t10mr17562534pfq.165.1576864521638;
 Fri, 20 Dec 2019 09:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20191218011545.40557-1-natechancellor@gmail.com>
In-Reply-To: <20191218011545.40557-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 20 Dec 2019 09:55:10 -0800
Message-ID: <CAKwvOd=S6HBP5RTTgm=+1r51t9cSNt+sCHrwkK_fAVFqVcZ-1A@mail.gmail.com>
Subject: Re: [PATCH] hostap: Adjust indentation in prism2_hostapd_add_sta
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 5:15 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> ../drivers/net/wireless/intersil/hostap/hostap_ap.c:2511:3: warning:
> misleading indentation; statement is not part of the previous 'if'
> [-Wmisleading-indentation]
>         if (sta->tx_supp_rates & WLAN_RATE_5M5)
>         ^
> ../drivers/net/wireless/intersil/hostap/hostap_ap.c:2509:2: note:
> previous statement is here
>         if (sta->tx_supp_rates & WLAN_RATE_2M)
>         ^
> 1 warning generated.
>
> This warning occurs because there is a space before the tab on this
> line. Remove it so that the indentation is consistent with the Linux
> kernel coding style and clang no longer warns.
>
> Fixes: ff1d2767d5a4 ("Add HostAP wireless driver.")
> Link: https://github.com/ClangBuiltLinux/linux/issues/813
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Sorry for sending a patch for an "Obselete" driver (especially one as
> trivial as this) but it is still a warning from clang and shows up on
> all{yes,mod}config.
>
>  drivers/net/wireless/intersil/hostap/hostap_ap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intersil/hostap/hostap_ap.c b/drivers/net/wireless/intersil/hostap/hostap_ap.c
> index 0094b1d2b577..3ec46f48cfde 100644
> --- a/drivers/net/wireless/intersil/hostap/hostap_ap.c
> +++ b/drivers/net/wireless/intersil/hostap/hostap_ap.c
> @@ -2508,7 +2508,7 @@ static int prism2_hostapd_add_sta(struct ap_data *ap,
>                 sta->supported_rates[0] = 2;
>         if (sta->tx_supp_rates & WLAN_RATE_2M)
>                 sta->supported_rates[1] = 4;
> -       if (sta->tx_supp_rates & WLAN_RATE_5M5)
> +       if (sta->tx_supp_rates & WLAN_RATE_5M5)
>                 sta->supported_rates[2] = 11;
>         if (sta->tx_supp_rates & WLAN_RATE_11M)
>                 sta->supported_rates[3] = 22;
> --
> 2.24.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191218011545.40557-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
