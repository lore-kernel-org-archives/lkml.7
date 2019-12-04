Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A94C432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5814C2073F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 02:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575425959;
	bh=FX0SbHl1Yljp4OhiB2FkaDSP/AYuFcF8lh80Js4Mc/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T5BtzWPjsARnUT6qipnoOFRcL3wVMhKaU2KpImfxfMVQFePqTZeltvJUTRC3euOu7
	 d1yNTahEA8Iu5RMPGI/kgpDNI4KFSBObUY0bvbgrTxjqpCHe8oHJVjpZkam/J19i3Z
	 5cg4HXwQ70bKyucD8o9QSXako2YcXeqKIk8rIhtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfLDCTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:19:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:32830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfLDCTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 21:19:17 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B8C2073C;
        Wed,  4 Dec 2019 02:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575425956;
        bh=FX0SbHl1Yljp4OhiB2FkaDSP/AYuFcF8lh80Js4Mc/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vr3fYKnxYmLmrDqk2Jr6lZOynJiZfJSLzX8Pp8YPusqwp3A8PXmRWEUAI0nnKG9A/
         vwo2NmNoTfqzw8dGnojNcemy6+kQcl023nXPZiXz1ER1PxNojyMAXBA1rzQAPpIw/a
         PTYizRwVD2Slkvb9eF8GO4DUlF+PGVQKuF1bjAwI=
Date:   Wed, 4 Dec 2019 10:19:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH] clk: imx: pll14xx: fix clk_pll14xx_wait_lock
Message-ID: <20191204021908.GN9767@dragon>
References: <1573018178-14939-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573018178-14939-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 05:31:15AM +0000, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The usage of readl_poll_timeout is wrong, the cond should be
> "val & LOCK_STATUS" not "val & LOCK_TIMEOUT_US".

Is this caught just by code inspection or a real world bug?  If you want
this get into -rc (and stable kernel) as a fix, you should add more
information about the bug, like how it's been triggered, what's the
consequence of the bug, and kernel dump message etc.

> 
> Fixes: 8646d4dcc7fb ("clk: imx: Add PLLs driver for imx8mm soc")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V1:
>  Hi Shawn,
>    This patch is made based on 5.4-rc6, not your for-next branch,

Please rebase it on 5.5-rc1 which will be coming next Monday.

>    not sure whether this patch could catch 5.4 release.

You can Cc stable kernel, so that it will be back ported.

Shawn

> 
>  drivers/clk/imx/clk-pll14xx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-pll14xx.c b/drivers/clk/imx/clk-pll14xx.c
> index 7a815ec76aa5..d43b4a3c0de8 100644
> --- a/drivers/clk/imx/clk-pll14xx.c
> +++ b/drivers/clk/imx/clk-pll14xx.c
> @@ -153,7 +153,7 @@ static int clk_pll14xx_wait_lock(struct clk_pll14xx *pll)
>  {
>  	u32 val;
>  
> -	return readl_poll_timeout(pll->base, val, val & LOCK_TIMEOUT_US, 0,
> +	return readl_poll_timeout(pll->base, val, val & LOCK_STATUS, 0,
>  			LOCK_TIMEOUT_US);
>  }
>  
> -- 
> 2.16.4
> 
