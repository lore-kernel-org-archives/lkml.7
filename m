Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1D9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E96214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552379299;
	bh=jZirjo9XoP+WJTKzvU1KMFFOPs9e6fF0EwD5ghYcX80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nCMQZPd6nask6P7fJe57DAdZUSJ5m0Y05cAa2Czy1Mo7ZT5tCeyZ3hZlWE9VxCDh9
	 k8NJ5/zURjClxtg0in/HCsKmytiXdPSB0wJh3+aG5CuYMCmXsA0VtBjuToh4B1v2bG
	 fU4u84HUMAfbixChSc6SrXEFn+YEErKv9Vyg2sDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfCLI2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:45866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726735AbfCLI2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:28:16 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A772171F;
        Tue, 12 Mar 2019 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552379296;
        bh=jZirjo9XoP+WJTKzvU1KMFFOPs9e6fF0EwD5ghYcX80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lEiabhXNrjc+vUb1pKGa24aEELX3M0nxIdhPwRivSuiBEIRaPcicamJ9UHJElYKfE
         CPk6/t+HCVPJ89wEpbeFOiNcXL4sPfY2/jTgYq4pH8EutTmG+izWJWpa7rMJxwLBRM
         Bp3jmENsoh9jwL5z+7E8bmrrVsaBPTYbUSmJMGGU=
Received: by mail-wr1-f49.google.com with SMTP id g18so1655834wru.3;
        Tue, 12 Mar 2019 01:28:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUe8lepWUHiR2Wi6cxGwhnCcho7RB+3ez+x6jiYrqddbki9Rquw
        kZMCZhoq4dmz25EuTowHeACwLIp8l3PjBgKVE18=
X-Google-Smtp-Source: APXvYqzfIaMx6yCHo345BdiT1k/wlIeUlQosE7RoLWPPReeP0P1F/DeelCObWYHeMDCwjjLglbfKAtJU4CiBrU49fJQ=
X-Received: by 2002:a5d:4741:: with SMTP id o1mr3694066wrs.188.1552379294450;
 Tue, 12 Mar 2019 01:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190312073241.27495-1-kjlu@umn.edu>
In-Reply-To: <20190312073241.27495-1-kjlu@umn.edu>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 12 Mar 2019 16:28:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v66GgA9zc_7ZU_Sb_PkgcYwbFoa+JFS3A-7RKApR31pOow@mail.gmail.com>
Message-ID: <CAGb2v66GgA9zc_7ZU_Sb_PkgcYwbFoa+JFS3A-7RKApR31pOow@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, pakki001@umn.edu,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 3:32 PM Kangjie Lu <kjlu@umn.edu> wrote:
>
> In case of_device_get_match_data fails, the fix return -ENOMEM
> to avoid the NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index 3256e5cbad27..344ead5949b1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -485,6 +485,8 @@ static int dwc_eth_dwmac_remove(struct platform_device *pdev)
>         int err;
>
>         data = of_device_get_match_data(&pdev->dev);
> +       if (!data)
> +               return -EINVAL;

You say -ENOMEM in the commit message, but -EINVAL here.

Also, all compatible strings within this driver have data attached
to them. The only possible case for this to return NULL is if the
user is screwing around with the kernel, such as creating a platform
device matching the driver name. This is not the intended way to
use it, and IMHO the kernel has the right to blow up in the user's
face.

ChenYu

>
>         err = stmmac_dvr_remove(&pdev->dev);
>         if (err < 0)
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
