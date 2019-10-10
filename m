Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C896C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEDC206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="rBl0cx6+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbfJJXBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:01:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45212 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfJJXBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:01:21 -0400
Received: by mail-qt1-f193.google.com with SMTP id c21so11136013qtj.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 16:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=hKb1hJiJoZr7sDzi9awmt+z6YG7rgK/yyFTSM1pIHvc=;
        b=rBl0cx6+eIElwhvMYT30TfWDTrbVzMZqR9vc1u08+8UkgRFWwsWJItiHPlbIz75bbO
         yjErSPaO+d+mOXOukCkpOiBJnqGmHKu50/Uyz9FW/epJCtKe8478nPgRPB6CcvAY1a1I
         Ceuu7vL7cH8gJEFTgdiOM8xNWMPqzJ4hpm14bppd6CQU3FROOOIgnoJhKh5GJ4rvJ7G7
         trLU5f3s1a3fEC2JtQtzqks393lZwdH9IdblrWwCQZ01vQ7JRdlrHsiigbRxkJSzRSvm
         +LnPGfJbwjrZh5kS1fHLpLjgKlFwoFNpuGaKfGkNdVIg8LEUr2UFHovhiakkDrFMacbh
         yd9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=hKb1hJiJoZr7sDzi9awmt+z6YG7rgK/yyFTSM1pIHvc=;
        b=CPl9n9qn+9NTDMKTLJw0da1qQ4HkCii0XZ6oz5AMhLfjiuQmS/ROFpT3ZYvBkzsgzQ
         MInGwT+Io0kpCTFFM8BV0guPJYZNz85a2DDiQr7ZrqOF3elzqzQ+f5gIR9OIQgEbRnyZ
         JtU4YuWMApo5pl2/gJdvhayqWV+idicHYAvdAiRozngOQPwXNfqMB3gL7ZALa6i9OTXG
         j5UzgrV/cCAMkR7PW/nQg4lWbpAO1XBEyj5AUYeXXhNs0LfhMFKVmHvTk8/MxzNESA0G
         QN7vJkdVx3MnQ+bjnHhDdm/5V0ob6R003nNWrG6YJF1Vl6puenoZCP6bH41EgDBAesQN
         RVcw==
X-Gm-Message-State: APjAAAUxKBq1+159snRn0qyX97fT47NNDiDhhTVfnti72TY1Z7NgufNb
        EarOOvjzWAh6+9HyeXCEg0QfZA==
X-Google-Smtp-Source: APXvYqzlvVcUTrNNKzaif/kXN8GZwkAMecaGfYJIaGrr9Y2IjFLnQDpHQHTA/hY/Sd8K4BincCEN3w==
X-Received: by 2002:a0c:f8cd:: with SMTP id h13mr12808457qvo.53.1570748480202;
        Thu, 10 Oct 2019 16:01:20 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id 64sm3058098qkk.63.2019.10.10.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 16:01:20 -0700 (PDT)
Date:   Thu, 10 Oct 2019 16:01:03 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Biao Huang <biao.huang@mediatek.com>
Cc:     <davem@davemloft.net>, Jose Abreu <joabreu@synopsys.com>,
        <andrew@lunn.ch>, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yt.shen@mediatek.com>,
        <jianguo.zhang@mediatek.com>, <boon.leong.ong@intel.com>
Subject: Re: [PATCH] net: stmmac: disable/enable ptp_ref_clk in
 suspend/resume flow
Message-ID: <20191010160103.63c3c0ed@cakuba.netronome.com>
In-Reply-To: <20191009085649.6736-1-biao.huang@mediatek.com>
References: <20191009085649.6736-1-biao.huang@mediatek.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 16:56:49 +0800, Biao Huang wrote:
> disable ptp_ref_clk in suspend flow, and enable it in resume flow.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index c7c9e5f162e6..b592aeecc3dd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4469,6 +4469,8 @@ int stmmac_suspend(struct device *dev)
>  		stmmac_mac_set(priv, priv->ioaddr, false);
>  		pinctrl_pm_select_sleep_state(priv->device);
>  		/* Disable clock in case of PWM is off */
> +		if (priv->plat->clk_ptp_ref)
> +			clk_disable_unprepare(priv->plat->clk_ptp_ref);

I don't know much embedded, but it seems like this should perhaps just
be clk_disable() without the unprepare? stmmac_hw_teardown() is called
when driver is removed so it needs to unprepare as well.

Please feel free to explain to me why this needs to be
clk_disable_unprepare(), as I said - not an expert.

Also - if this is a bug fix and you'd like to have it backported to
older releases you need to add a Fixes tag.

Thanks!

>  		clk_disable(priv->plat->pclk);
>  		clk_disable(priv->plat->stmmac_clk);
>  	}
> @@ -4535,6 +4537,8 @@ int stmmac_resume(struct device *dev)
>  		/* enable the clk previously disabled */
>  		clk_enable(priv->plat->stmmac_clk);
>  		clk_enable(priv->plat->pclk);
> +		if (priv->plat->clk_ptp_ref)
> +			clk_prepare_enable(priv->plat->clk_ptp_ref);
>  		/* reset the phy so that it's ready */
>  		if (priv->mii)
>  			stmmac_mdio_reset(priv->mii);

