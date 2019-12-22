Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E95C2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4742214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 13:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX7pOrAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLVNZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 08:25:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35851 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfLVNZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 08:25:04 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so5376346plm.3;
        Sun, 22 Dec 2019 05:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yAOtMUwD/qpfStPtispf3vk9JaKfKQUNKLcLxT26P+w=;
        b=TX7pOrAwGAXN6pE7nq78PMMvdr4vJzLvqz44HqMKGqbQsNjK5i6RvG5WMB/hR6KGf6
         4NPr2Qfy5CiPUykEyODKg8lqNrjqq0WnUFUfdnUyt6E5NnM8dPN+ydbjQJFH73UVuK16
         XaupZPv3e96ASYNJlvURztvPFk85Ks1X68k+Fa+J7QyQIaAwqxYR/VRBesLb8DWm6dhg
         5JaD48vFawlXW9c/3fe837M17MBHZR1+09CVwQA+qgVrNPv5QmJQ0dTv2uLH8ZNzbSgw
         rF2icc//h7Vcn1FCO2KphtRVvZYL994ltq/Ldk9k7vltBl6/sPW6bumwtcgKXmI1/ZcK
         x1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yAOtMUwD/qpfStPtispf3vk9JaKfKQUNKLcLxT26P+w=;
        b=USBmtuLNzMuNCaYPVSu3roXvWe78C+Oz7OZCpMLUIyvBI2bnazBM13Kn/iz+0O+A5h
         nmDZgTAaTubszY+3JIixzfF/HYmguEQFRbEf8/ZRsk4jiAEXP3opCtf+Hq16PhhVwrF+
         9hoDM7OVBoDjAIkANmYmlzVA9RYjPAxgU0eqjaS5HD6tCxsHqwkg6dix0ZMQbgB/CbSs
         VtXk2H2qMpapeOdBjsbT1rGqUpJNO1XpkbpnvKYstXRvBTufWJ5qn6s35K8ryOCznXZ1
         ysH24bfPI/NEYuT441bnJfFwQENDT/gJcCp9J3QzCa3jAye2CDwpmlsUHxwdIHLjlpjG
         wv/w==
X-Gm-Message-State: APjAAAVfbjRGD7wYHfF5FKko/gdwthfRfS7OLxBTdzIviiLNL0fA2Qt3
        rNPOK00lpoUhHNJ70EbSw8U=
X-Google-Smtp-Source: APXvYqz7JAli1bhkUSt9KMgUJ/tuA/JNFlY9P88wOQBoqkeETc3LPCu0h3YXwDXQ7y2NnbxuZ+4qMg==
X-Received: by 2002:a17:902:8207:: with SMTP id x7mr1160978pln.286.1577021103598;
        Sun, 22 Dec 2019 05:25:03 -0800 (PST)
Received: from localhost (64.64.229.47.16clouds.com. [64.64.229.47])
        by smtp.gmail.com with ESMTPSA id b4sm20816190pfd.18.2019.12.22.05.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Dec 2019 05:25:03 -0800 (PST)
Date:   Sun, 22 Dec 2019 21:24:59 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] usb: phy: tegra: Use u32 for hardware register
 variables
Message-ID: <20191222132227.GA7096@nuc8i5>
References: <20191220015238.9228-1-digetx@gmail.com>
 <20191220015238.9228-9-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220015238.9228-9-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 04:52:36AM +0300, Dmitry Osipenko wrote:
> There is a mix of u32/ULONG usage in the driver's code. Let's switch to
> u32 uniformly, for consistency.
> 
> Suggested-by: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/usb/phy/phy-tegra-usb.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
> index d5739b6e0b6c..551c94e3877a 100644
> --- a/drivers/usb/phy/phy-tegra-usb.c
> +++ b/drivers/usb/phy/phy-tegra-usb.c
> @@ -202,7 +202,7 @@ static inline struct tegra_usb_phy *to_tegra_usb_phy(struct usb_phy *u_phy)
>  static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	if (phy->soc_config->has_hostpc) {
>  		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
> @@ -221,7 +221,7 @@ static void set_pts(struct tegra_usb_phy *phy, u8 pts_val)
>  static void set_phcd(struct tegra_usb_phy *phy, bool enable)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	if (phy->soc_config->has_hostpc) {
>  		val = readl_relaxed(base + TEGRA_USB_HOSTPC1_DEVLC);
> @@ -320,7 +320,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
>  {
>  	struct tegra_utmip_config *config = phy->config;
>  	void __iomem *base = phy->pad_regs;
> -	unsigned long val, flags;
> +	unsigned long flags;
> +	u32 val;
Why are you still using unsigned long here?

>  	int err;
>  
>  	err = clk_prepare_enable(phy->pad_clk);
> @@ -355,7 +356,8 @@ static int utmip_pad_power_on(struct tegra_usb_phy *phy)
>  static int utmip_pad_power_off(struct tegra_usb_phy *phy)
>  {
>  	void __iomem *base = phy->pad_regs;
> -	unsigned long val, flags;
> +	unsigned long flags;
> +	u32 val;
ditto

>  	int err;
>  
>  	if (!utmip_pad_count) {
> @@ -393,7 +395,7 @@ static int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
>  static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	/*
>  	 * The USB driver may have already initiated the phy clock
> @@ -425,7 +427,7 @@ static void utmi_phy_clk_disable(struct tegra_usb_phy *phy)
>  static void utmi_phy_clk_enable(struct tegra_usb_phy *phy)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	/*
>  	 * The USB driver may have already initiated the phy clock
> @@ -460,7 +462,7 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
>  {
>  	struct tegra_utmip_config *config = phy->config;
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  	int err;
>  
>  	val = readl_relaxed(base + USB_SUSP_CTRL);
> @@ -611,7 +613,7 @@ static int utmi_phy_power_on(struct tegra_usb_phy *phy)
>  static int utmi_phy_power_off(struct tegra_usb_phy *phy)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	utmi_phy_clk_disable(phy);
>  
> @@ -646,7 +648,7 @@ static int utmi_phy_power_off(struct tegra_usb_phy *phy)
>  static void utmi_phy_preresume(struct tegra_usb_phy *phy)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	val = readl_relaxed(base + UTMIP_TX_CFG0);
>  	val |= UTMIP_HS_DISCON_DISABLE;
> @@ -656,7 +658,7 @@ static void utmi_phy_preresume(struct tegra_usb_phy *phy)
>  static void utmi_phy_postresume(struct tegra_usb_phy *phy)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	val = readl_relaxed(base + UTMIP_TX_CFG0);
>  	val &= ~UTMIP_HS_DISCON_DISABLE;
> @@ -667,7 +669,7 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
>  				   enum tegra_usb_phy_port_speed port_speed)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	val = readl_relaxed(base + UTMIP_MISC_CFG0);
>  	val &= ~UTMIP_DPDM_OBSERVE_SEL(~0);
> @@ -687,7 +689,7 @@ static void utmi_phy_restore_start(struct tegra_usb_phy *phy,
>  static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  
>  	val = readl_relaxed(base + UTMIP_MISC_CFG0);
>  	val &= ~UTMIP_DPDM_OBSERVE;
> @@ -698,7 +700,7 @@ static void utmi_phy_restore_end(struct tegra_usb_phy *phy)
>  static int ulpi_phy_power_on(struct tegra_usb_phy *phy)
>  {
>  	void __iomem *base = phy->regs;
> -	unsigned long val;
> +	u32 val;
>  	int err;
>  
>  	err = gpio_direction_output(phy->reset_gpio, 0);
> -- 
> 2.24.0
> 
