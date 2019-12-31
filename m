Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9044206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 08:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577780433;
	bh=83SkJ5U4qt8cGpALTMPAtCqZv2hXGLYY7N1ppWznu20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Ig25RZdhumDpAKvqZ5JkHOzHDGx2iCMCg+N4lbexw8+LOEnHxp6yR7Ib8Io995I6
	 5167KPSYm9WNrlYKpPk7UiTWB/PHw09sDXnDF1+vuaCt4ZATk1u9VkHL2VbIz7G8Nf
	 JVL7BTEPyPYzpgJT7QIEhEUZfPPJBInY4TsAKT+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbfLaIUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 03:20:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41500 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfLaIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 03:20:32 -0500
Received: by mail-ed1-f68.google.com with SMTP id c26so34723090eds.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Dec 2019 00:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OCioKZCCJQ7tT73SyyKzkO9RMHazBLb5Wt3QDWkITuY=;
        b=c8pe6da5culV4fCK/YEMQF6A+9HUwa8avPJWypUWrVIsc45xWq3FcJDC/NOGhuFtRP
         Jehf2V7B6ZfCxR5IqyrhOgImMVsaVxamhE5k37Nr7e+IcBsJJ/NkDb/6AEwDPX/NTnIR
         Iyj0qN3J1UKFktwakBEDdmL9zpA9Bu075S+zJzlY8PQ8AfAifSiD6OVgi5oIRwPu1u8A
         DMRLKX4SHmeomjqNYq0qrgkh+6SewEXmvLj2g1tVJ2n9AdWHoeNPExYLAADBKD9xr1V0
         oUq1kinSMNR3YFQXk/Zzy5j3qakJlwT8TzBMdJO7y+fN5/Ilsm87TApCByLA5LcLIcdG
         vc/w==
X-Gm-Message-State: APjAAAXTh3P1x6Uh1VowMjv4EjanvJEALrV3riNlhUyol7k+HrsT7qNm
        AUzu9W+DzNBarLq+5S4Jpeo=
X-Google-Smtp-Source: APXvYqyY2gPXd0BiQQrtUFNJI/5iVX0C/CtQWvEacT6jWsjUbweBcqZjXhfz4qpJbuWs2pkwg5NIgQ==
X-Received: by 2002:aa7:cf81:: with SMTP id z1mr75335663edx.234.1577780431167;
        Tue, 31 Dec 2019 00:20:31 -0800 (PST)
Received: from pi3 ([194.230.155.138])
        by smtp.googlemail.com with ESMTPSA id r24sm5708609edp.15.2019.12.31.00.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 00:20:30 -0800 (PST)
Date:   Tue, 31 Dec 2019 09:20:28 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] phy: Enable compile testing for some of drivers
Message-ID: <20191231082028.GC6804@pi3>
References: <20191230172449.17648-1-krzk@kernel.org>
 <20191230172449.17648-2-krzk@kernel.org>
 <791d83ef-faee-d6e6-445e-a8088c5ac654@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <791d83ef-faee-d6e6-445e-a8088c5ac654@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 30, 2019 at 12:10:51PM -0800, Florian Fainelli wrote:
> Hi Krzysztof,
> 
> On 12/30/19 9:24 AM, Krzysztof Kozlowski wrote:
> > Some of the phy drivers can be compile tested to increase build
> > coverage.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> This looks fine, you could also consider adding a bunch of other
> Broadcom PHY drivers which are not currently under COMPILE_TEST, yet
> build fine:

I'll send a v2 with them as well. They seem to compile fine.

Best regards,
Krzysztof

> 
> diff --git a/drivers/phy/broadcom/Kconfig b/drivers/phy/broadcom/Kconfig
> index d3d983c128ea..d56db6d375e1 100644
> --- a/drivers/phy/broadcom/Kconfig
> +++ b/drivers/phy/broadcom/Kconfig
> @@ -50,7 +50,7 @@ config PHY_BCM_NS_USB3
> 
>  config PHY_NS2_PCIE
>         tristate "Broadcom Northstar2 PCIe PHY driver"
> -       depends on OF && MDIO_BUS_MUX_BCM_IPROC
> +       depends on (OF && MDIO_BUS_MUX_BCM_IPROC) || COMPILE_TEST
>         select GENERIC_PHY
>         default ARCH_BCM_IPROC
>         help
> @@ -83,7 +83,7 @@ config PHY_BRCM_SATA
> 
>  config PHY_BRCM_USB
>         tristate "Broadcom STB USB PHY driver"
> -       depends on ARCH_BRCMSTB
> +       depends on ARCH_BRCMSTB || COMPILE_TEST
>         depends on OF
>         select GENERIC_PHY
>         select SOC_BRCMSTB
> 
