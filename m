Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA3DC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B822063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 22:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="APnj14df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfF0Wcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 18:32:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42884 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfF0Wcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 18:32:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay6so2031025plb.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 15:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IhP7OCM25XXvVoqn42DaxOsI4TszTgSwcMwliaWKfKU=;
        b=APnj14df+CUg5mOEsoFJjH7YBNebYWhtkQjolLJgYPARmsWJQImqMpyxDo8U2saVad
         Ot+T60wL7vukQ2mTuVDLfeK+PAtXkQ5z70JhplcMeNdhqbHS7MzK9GbLPf8uZIN+s+iU
         Mw5Vi5zl9rWOLviihNFfDmQervkxHqbOtE6F/jEFk3QrR7nEJQgti7gB+2egkK5Lg2bP
         yfvTEhzhGPHsb+HO9RZ0gudIUHJL5R5z5b4qCIc1dJ0SbbwKmw918vZsuQ0Jg9JCzTtc
         S1t/jcjDk/mJbKmEiJi5o0ZDhgx+zWgEpe+lpe4686gCe12wvwmY3j+kceVdjwkxr8f0
         BvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IhP7OCM25XXvVoqn42DaxOsI4TszTgSwcMwliaWKfKU=;
        b=X5oq40UCMy+4uGLaQLqUTWlquYOEMLaX3EJGnQf/cx/zoq5okf8wB3X3XSCRCvd1FE
         i7pcoHaRNcRuJnOWfIJe4wj0fvEoViC63ALToMGrcUeX5dYCmoMHdedEcuKbUfw4q/jd
         VSoOBMDUrKO2366UIxSvR5XfdY8IIO/kxOWeR+VGdZ14q4vWDYBHaiMTOiGjf02E6Mlr
         IRcPjKltedBZo65+ZcdCbHCKlhjPv8YwXyL4N9x/n4pQY+5u1z0JrBerZhT6qC8hOJ9v
         8fE/wsKn5NZkGHn7ZsYeAxjooDgbQDrhBQB8Mu9GeXP8STT3zy+Ncvqw93WHnWruiDvw
         bPkw==
X-Gm-Message-State: APjAAAVpefyTcRH/xZovuoK/OAdz2SKWUCPQ4cuBdacJ4wTO61n4SOH8
        mhmXVlIdhjkMxFY1Risv2RYX2yKhyf701KbZMr0MIA==
X-Google-Smtp-Source: APXvYqzy9jb/It/pkCG4p03Ml+J2Pe8uvS0xgOJ5bJFDSuWv5BAe2P4TqaToD+bMcK566LHPLHIuAYf3Iz61pFm3gpk=
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr7307719plq.223.1561674769064;
 Thu, 27 Jun 2019 15:32:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190627222220.89175-1-nhuck@google.com>
In-Reply-To: <20190627222220.89175-1-nhuck@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Jun 2019 15:32:38 -0700
Message-ID: <CAKwvOd=RhoKvXzuGVe0PaQik8NEFhDkxuwv-T_s6KAtXCDVVvg@mail.gmail.com>
Subject: Re: [PATCH] clk: rockchip: Fix -Wunused-const-variable
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, heiko@sntech.de,
        andy.yan@rock-chips.com, zhangqing@rock-chips.com,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 3:22 PM 'Nathan Huckleberry' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang produces the following warning
>
> drivers/clk/rockchip/clk-rv1108.c:125:7: warning: unused variable
> 'mux_pll_src_3plls_p' [-Wunused-const-variable]
> PNAME(mux_pll_src_3plls_p)      = { "apll", "gpll", "dpll" };
>
> Looks like this variable was never used. Deleting it to remove the
> warning.

Indeed, looks like it was dead when introduced in:
commit e44dde279492 ("clk: rockchip: add clock controller for rk1108")

I don't see a pattern between when mux_pll_src_4plls_p vs
mux_pll_src_2plls_p is used, so it's not clear where or even if
mux_pll_src_3plls_p should be used.  Given that there hasn't been a
response to your original question
(https://groups.google.com/forum/#!topic/clang-built-linux/NqJT9OPH5C8)
and this patch is no functional change as the variable is already
dead, I don't think it will hurt to remove it.  It should also boost
the signal to noise ratio of this warning.

Thanks for looking into it, and the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> diff --git a/drivers/clk/rockchip/clk-rv1108.c b/drivers/clk/rockchip/clk-rv1108.c
> index 96cc6af5632c..5947d3192866 100644
> --- a/drivers/clk/rockchip/clk-rv1108.c
> +++ b/drivers/clk/rockchip/clk-rv1108.c
> @@ -122,7 +122,6 @@ PNAME(mux_usb480m_pre_p)    = { "usbphy", "xin24m" };
>  PNAME(mux_hdmiphy_phy_p)       = { "hdmiphy", "xin24m" };
>  PNAME(mux_dclk_hdmiphy_pre_p)  = { "dclk_hdmiphy_src_gpll", "dclk_hdmiphy_src_dpll" };
>  PNAME(mux_pll_src_4plls_p)     = { "dpll", "gpll", "hdmiphy", "usb480m" };
> -PNAME(mux_pll_src_3plls_p)     = { "apll", "gpll", "dpll" };

Thanks,
~Nick Desaulniers
