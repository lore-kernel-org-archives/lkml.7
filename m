Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E73FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D16C2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksBzzW/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbfDEOON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:14:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42159 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfDEOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:14:13 -0400
Received: by mail-lj1-f194.google.com with SMTP id v22so5390111lje.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 07:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5nEoLkTSeiBFZVjk0+jSN5qyXpAzgngiHGkBIc3MmFQ=;
        b=ksBzzW/d4cqIF30C8sZrl3a8+pN/UNf3/BN/hEzOGkpRuCgzjzZbw47IJCyQuCKqah
         s0ZYf6vMy2zWn0d3Cbo7wVNaghQsed7p2dOBerfyAxvzjwNgXYT1EAXWSya7h+qERcNU
         5mccVjSKfgxhVe1+R8EnDAYsmQT8Bj8IuqiNbgr5VBXWMr2hu+JZvtsImA8kbvdO9/W5
         6AvcLCck+L8B7BXBVe0izcEzL3rs38MrMwNSIOiQpSPQiWWrsD/Htjzdo5Z/TktgMbAc
         /fRnyNBOMoeQJRMGUx8u0ApeuhepqNpUulVQtSqQ36WLlItQPgxdUZ20QWNrYahJPnFV
         YK8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5nEoLkTSeiBFZVjk0+jSN5qyXpAzgngiHGkBIc3MmFQ=;
        b=jVHCe7pc5vglzitQOYD5RortxrRZXhTRe/xQvaPf5VY03joDTPbdGX5gDQyvB2PXc5
         npng11rM0ro7eW512kZU8HSbGYgOOOax9BQ1SGG+BSkpyL4qPvz+NYixYKQ9PrDnOV6K
         DD8yNHNcFw8lRDp1ISLbGwcaBJdRZ8S0bbqo/WoMJX+kgd5wyPiejVZgQZiVyNDT5jhg
         PYnpC28eeWvJ3+2YuRWiIwydeL+1YqpneXHO9a7qH9kO69B0OvH208qNqYzPX/qHGok5
         mYiz1Ixmr8wFxS2abvP4QaDnXtb3ZsxTU07a+CQxopb9jdL9Oi+lxJGsRouAuYb8rEto
         N4EA==
X-Gm-Message-State: APjAAAW2255UmEDt/IqKCS/FyLtNT6Sh33owPKQaK8Rs57XdCmT3r+fO
        R1ywif9M+EaZk51+exjzOLAENAhbq8L9wOOwZr8=
X-Google-Smtp-Source: APXvYqx0/zaIDQUGBrHNbQGQhFCgPDjr4eLzDzOS9CbzFrecpeueDEDHIvfaIO3/vBORl0FrdKQUE/swqJASvwoJvHc=
X-Received: by 2002:a2e:6a14:: with SMTP id f20mr7555895ljc.65.1554473651048;
 Fri, 05 Apr 2019 07:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190401022413.6682-1-andrew.smirnov@gmail.com> <20190401022413.6682-3-andrew.smirnov@gmail.com>
In-Reply-To: <20190401022413.6682-3-andrew.smirnov@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 5 Apr 2019 11:13:59 -0300
Message-ID: <CAOMZO5Ad89TXBon47oiV1JtUKMEMCDv6c5-DPHM5QQNL+x7hZA@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] arm64: dts: imx8mq: Add a node for SRC IP block
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        "A.s. Dong" <aisheng.dong@nxp.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 11:25 PM Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
>
> Add a node for reset controller IP block found on i.MX8MQ.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Chris Healy <cphealy@gmail.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: "A.s. Dong" <aisheng.dong@nxp.com>
> Cc: Richard Zhu <hongxing.zhu@nxp.com>
> Cc: linux-imx@nxp.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 3de390777af1..656f7cb97703 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -450,6 +450,12 @@
>                                               "clk_ext3", "clk_ext4";
>                         };
>
> +                       src: src@30390000 {

src: reset-controller@30390000 {

Reviewed-by: Fabio Estevam <festevam@gmail.com>
