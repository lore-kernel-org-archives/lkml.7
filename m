Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80A7C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973D0205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWrjXwmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfI0VMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:12:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41094 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfI0VMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:12:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so4102392pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MT3rEIfaJgpzvHmFM2pWeqN2XOEfjsN3Ht7YF+hthq8=;
        b=HWrjXwmyGQrWIktNn2lCfS/WWNp3jM0GJkqLaICHIq/FPWxfdSodtSpyQmZZZSqYKl
         gLWJ5uiWHrbfp7XRrlbm5tcLBi0mF8wxUQGVBvHdC+YrHRlTUWjnN/4obhqljgrPTG3A
         RZtBAyLun1kMIfwj+XzanCaE7pfz5X+1U1DEEWl4a0HFqU4UC+8fia7u1zVDsy87zqmM
         aCnZO4WYMlXyBvwTDY5YzycIIMk8vbQav6mKwEUaLZN6qC6Wase6y5kT8waFE/KYHjR2
         sI+xNuy9ZVIQOG/d3gqTWFx/1AYoGsrnH4KQyKPBRTWgKQPqX7caUSWi/ZiuXFXkwHDR
         u2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MT3rEIfaJgpzvHmFM2pWeqN2XOEfjsN3Ht7YF+hthq8=;
        b=WfoEWlqBdThbPJxcvlekfMQLedP81HHLaobtt9JzOZObgVg2p9xVHex97o6+KXCl/X
         3hEokENMjocfot70XiF0jitrjKDZXVgw95aZJNPCQwEZDPbis4jmIm/KSCVN3HSH5YBS
         cNVkaj+R4XE07gk4K7yrkpWO20rTJyCT1Rp8CE8Q1BlPqQ5dcM8mBnisKWSIHdbvDE8a
         +L6kJTXzAOixfm2g39G8A93XJaXf8lE+5YE2LmPTqNMq/r+p+evsxQnwlmmlSPXuj26x
         76RgZP2U7TNZUx6PYZn7BSSORu4p6LtnfD0nz/cDTIe519+NJfV/9kCGBcbKPofARYK6
         Re5Q==
X-Gm-Message-State: APjAAAXFpfslCETWyR4LeMSdtQU9gZWpUZ4MSIdHItL/DuVXJ1KXCRq9
        jlhnnqRoIePTjFh8DSNUqfJP8aZStgNx+ywQ11fC2Q==
X-Google-Smtp-Source: APXvYqy8O3KoXcSTxHqiytQM1iXWb+WWT9oKskcwqzyLQpgWA96K2vO/7MEIdTwZ75zGDyeYqjyajaWRaH5XxPonWcc=
X-Received: by 2002:a62:798e:: with SMTP id u136mr6912504pfc.3.1569618754157;
 Fri, 27 Sep 2019 14:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1569569778.git.Jose.Abreu@synopsys.com> <80dd26ecf7fc82c88dc378d78210df5dd4138812.1569569778.git.Jose.Abreu@synopsys.com>
In-Reply-To: <80dd26ecf7fc82c88dc378d78210df5dd4138812.1569569778.git.Jose.Abreu@synopsys.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Sep 2019 14:12:23 -0700
Message-ID: <CAKwvOdntD5HNb4Gg04YN7iZwvK3CB4enq4ZPhUM-Bd3huvR2pw@mail.gmail.com>
Subject: Re: [PATCH net 8/8] net: stmmac: xgmac: Fix RSS not writing all Keys
 to HW
To:     Jose Abreu <Jose.Abreu@synopsys.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 12:49 AM Jose Abreu <Jose.Abreu@synopsys.com> wrote:
>
> The sizeof(cfg->key) is != ARRAY_SIZE(cfg->key). Fix it.

I think the warning was from -Wsizeof-array-div.

>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>

I may have reported the kbuild link, but scanning my email, there's
also a report from
Reported-by: Nathan Chancellor <natechancellor@gmail.com>

> Fixes: 76067459c686 ("net: stmmac: Implement RSS and enable it in XGMAC core")
> Signed-off-by: Jose Abreu <Jose.Abreu@synopsys.com>
>
> ---
> Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Jose Abreu <joabreu@synopsys.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: netdev@vger.kernel.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> index 6d8ac2ef4fc2..4a1f52474dbc 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
> @@ -533,7 +533,7 @@ static int dwxgmac2_rss_configure(struct mac_device_info *hw,
>                 return 0;
>         }
>
> -       for (i = 0; i < (sizeof(cfg->key) / sizeof(u32)); i++) {
> +       for (i = 0; i < (ARRAY_SIZE(cfg->key) / sizeof(u32)); i++) {

cfg is an instance of struct stmmac_rss, which looks like:
125 struct stmmac_rss {
126   int enable;
127   u8 key[STMMAC_RSS_HASH_KEY_SIZE];
128   u32 table[STMMAC_RSS_MAX_TABLE_SIZE];
129 };

yep, LGTM. Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


>                 ret = dwxgmac2_rss_write_reg(ioaddr, true, i, cfg->key[i]);
>                 if (ret)
>                         return ret;
> --
> 2.7.4
>


--
Thanks,
~Nick Desaulniers
