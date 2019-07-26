Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49656C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB0021850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbfGZORZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:17:25 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:34022 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727358AbfGZORY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:17:24 -0400
Received: (qmail 1779 invoked by uid 2102); 26 Jul 2019 10:17:23 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Jul 2019 10:17:23 -0400
Date:   Fri, 26 Jul 2019 10:17:23 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Marek Szyprowski <m.szyprowski@samsung.com>
cc:     linux-usb@vger.kernel.org, <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Chen <peter.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 2/3] usb: exynos: add support for getting PHYs from
 the standard dt array
In-Reply-To: <20190726081453.9456-3-m.szyprowski@samsung.com>
Message-ID: <Pine.LNX.4.44L0.1907261016440.1569-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019, Marek Szyprowski wrote:

> Add the code for getting generic PHYs from standard device tree array
> from the main controller device node. This is a first step in resolving
> the conflict between Exynos EHCI/OHCI sub-nodes and generic USB device
> bindings. Later the sub-nodes currently used for assigning PHYs to root
> ports of the controller will be removed making a place for the generic
> USB device bindings nodes.
> 
> Suggested-by: Måns Rullgård <mans@mansr.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>  drivers/usb/host/ehci-exynos.c | 23 +++++++++++++++++++----
>  drivers/usb/host/ohci-exynos.c | 23 +++++++++++++++++++----
>  2 files changed, 38 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
> index 3a29a1a8519c..01debfd03d4a 100644
> --- a/drivers/usb/host/ehci-exynos.c
> +++ b/drivers/usb/host/ehci-exynos.c
> @@ -41,6 +41,7 @@ struct exynos_ehci_hcd {
>  	struct clk *clk;
>  	struct device_node *of_node;
>  	struct phy *phy[PHY_NUMBER];
> +	bool legacy_phy;
>  };
>  
>  #define to_exynos_ehci(hcd) (struct exynos_ehci_hcd *)(hcd_to_ehci(hcd)->priv)
> @@ -50,10 +51,22 @@ static int exynos_ehci_get_phy(struct device *dev,
>  {
>  	struct device_node *child;
>  	struct phy *phy;
> -	int phy_number;
> +	int phy_number, num_phys;
>  	int ret;
>  
>  	/* Get PHYs for the controller */
> +	num_phys = of_count_phandle_with_args(dev->of_node, "phys",
> +					      "#phy-cells");
> +	for (phy_number = 0; phy_number < num_phys; phy_number++) {
> +		phy = devm_of_phy_get_by_index(dev, dev->of_node, phy_number);
> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +		exynos_ehci->phy[phy_number] = phy;
> +	}
> +	if (num_phys > 0)
> +		return 0;
> +
> +	/* Get PHYs using legacy bindings */
>  	for_each_available_child_of_node(dev->of_node, child) {
>  		ret = of_property_read_u32(child, "reg", &phy_number);
>  		if (ret) {
> @@ -84,6 +97,7 @@ static int exynos_ehci_get_phy(struct device *dev,
>  		}
>  	}
>  
> +	exynos_ehci->legacy_phy = true;
>  	return 0;
>  }
>  
> @@ -205,11 +219,12 @@ static int exynos_ehci_probe(struct platform_device *pdev)
>  	ehci->caps = hcd->regs;
>  
>  	/*
> -	 * Workaround: reset of_node pointer to avoid conflict between Exynos
> -	 * EHCI port subnodes and generic USB device bindings
> +	 * Workaround: reset of_node pointer to avoid conflict between legacy
> +	 * Exynos EHCI port subnodes and generic USB device bindings
>  	 */
>  	exynos_ehci->of_node = pdev->dev.of_node;
> -	pdev->dev.of_node = NULL;
> +	if (exynos_ehci->legacy_phy)
> +		pdev->dev.of_node = NULL;
>  
>  	/* DMA burst Enable */
>  	writel(EHCI_INSNREG00_ENABLE_DMA_BURST, EHCI_INSNREG00(hcd->regs));
> diff --git a/drivers/usb/host/ohci-exynos.c b/drivers/usb/host/ohci-exynos.c
> index 905c6317e0c3..d5ce98e205c7 100644
> --- a/drivers/usb/host/ohci-exynos.c
> +++ b/drivers/usb/host/ohci-exynos.c
> @@ -32,6 +32,7 @@ struct exynos_ohci_hcd {
>  	struct clk *clk;
>  	struct device_node *of_node;
>  	struct phy *phy[PHY_NUMBER];
> +	bool legacy_phy;
>  };
>  
>  static int exynos_ohci_get_phy(struct device *dev,
> @@ -39,10 +40,22 @@ static int exynos_ohci_get_phy(struct device *dev,
>  {
>  	struct device_node *child;
>  	struct phy *phy;
> -	int phy_number;
> +	int phy_number, num_phys;
>  	int ret;
>  
>  	/* Get PHYs for the controller */
> +	num_phys = of_count_phandle_with_args(dev->of_node, "phys",
> +					      "#phy-cells");
> +	for (phy_number = 0; phy_number < num_phys; phy_number++) {
> +		phy = devm_of_phy_get_by_index(dev, dev->of_node, phy_number);
> +		if (IS_ERR(phy))
> +			return PTR_ERR(phy);
> +		exynos_ohci->phy[phy_number] = phy;
> +	}
> +	if (num_phys > 0)
> +		return 0;
> +
> +	/* Get PHYs using legacy bindings */
>  	for_each_available_child_of_node(dev->of_node, child) {
>  		ret = of_property_read_u32(child, "reg", &phy_number);
>  		if (ret) {
> @@ -73,6 +86,7 @@ static int exynos_ohci_get_phy(struct device *dev,
>  		}
>  	}
>  
> +	exynos_ohci->legacy_phy = true;
>  	return 0;
>  }
>  
> @@ -172,11 +186,12 @@ static int exynos_ohci_probe(struct platform_device *pdev)
>  	}
>  
>  	/*
> -	 * Workaround: reset of_node pointer to avoid conflict between Exynos
> -	 * OHCI port subnodes and generic USB device bindings
> +	 * Workaround: reset of_node pointer to avoid conflict between legacy
> +	 * Exynos OHCI port subnodes and generic USB device bindings
>  	 */
>  	exynos_ohci->of_node = pdev->dev.of_node;
> -	pdev->dev.of_node = NULL;
> +	if (exynos_ohci->legacy_phy)
> +		pdev->dev.of_node = NULL;
>  
>  	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
>  	if (err) {
> 

