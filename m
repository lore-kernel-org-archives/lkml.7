Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8190AC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA06207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Zh1oWN4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfLDPd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:33:26 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22716 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728256AbfLDPd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:33:26 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB4FRIox030249;
        Wed, 4 Dec 2019 16:33:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=DQtKxYxpLyCymX7c2WtC2FRksiu3f9j9VGwC5BSuu8A=;
 b=Zh1oWN4l+Y/LuquBQRAkqFTVFgbfJqnt/KkoNnNwpSSY31SW00R/E3Cd7dSMTVNE8JfH
 GcTMPEozk3nmTiFCvi6ZcFes5Jg4SZ1DAOcAS1uowSPp3x4sw6cIP3hhXXdh4F7CPgPx
 PC9JnO+L2QVi4gVj0fBxcUskN4h+q71unavEw4G1XbDKxz0Sn3uKo0scAnFvs41K71UF
 WkdNVS1nP9DOfSl8BQdqjmWdbGvvMLQ3//33MR18mpbAkeBflMwdmmuWJ1+wyVGJe8f6
 OYiOOjRaOLufNPj5g8n4KFK453tFvqLUffJzFMJVzxo0lcr8dNnN2g7O7EMtjhA+26N6 Pg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2wkeea65jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Dec 2019 16:33:15 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 062F410002A;
        Wed,  4 Dec 2019 16:33:14 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0E4D2C38D0;
        Wed,  4 Dec 2019 16:33:14 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.45) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 4 Dec
 2019 16:33:14 +0100
Subject: Re: [PATCH] phy: core: Add consumer device link support
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20191104143713.11137-1-alexandre.torgue@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <faff6224-11b6-b055-1a80-fda0ff7c1724@st.com>
Date:   Wed, 4 Dec 2019 16:33:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104143713.11137-1-alexandre.torgue@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_03:2019-12-04,2019-12-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gentle ping, in case you missed this.

Regards
Alex

On 11/4/19 3:37 PM, Alexandre Torgue wrote:
> In order to enforce suspend/resume ordering, this commit creates link
> between phy consumers and phy devices. This link avoids to suspend phy
> before phy consumers.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> 
> ---
> 
> Hi,
> 
> To manage device_link in phy-core I had to "balance" get and put APIs a bit
> more. Fot this reason, you'll find updates in Renesas usbhs rcar and rza drivers
> as phy API changes.
> 
> Regards
> Alex
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index b04f4fe85ac2..8dfb4868c8c3 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -29,7 +29,7 @@ static void devm_phy_release(struct device *dev, void *res)
>   {
>   	struct phy *phy = *(struct phy **)res;
>   
> -	phy_put(phy);
> +	phy_put(dev, phy);
>   }
>   
>   static void devm_phy_provider_release(struct device *dev, void *res)
> @@ -566,12 +566,12 @@ struct phy *of_phy_get(struct device_node *np, const char *con_id)
>   EXPORT_SYMBOL_GPL(of_phy_get);
>   
>   /**
> - * phy_put() - release the PHY
> - * @phy: the phy returned by phy_get()
> + * of_phy_put() - release the PHY
> + * @phy: the phy returned by of_phy_get()
>    *
> - * Releases a refcount the caller received from phy_get().
> + * Releases a refcount the caller received from of_phy_get().
>    */
> -void phy_put(struct phy *phy)
> +void of_phy_put(struct phy *phy)
>   {
>   	if (!phy || IS_ERR(phy))
>   		return;
> @@ -584,6 +584,20 @@ void phy_put(struct phy *phy)
>   	module_put(phy->ops->owner);
>   	put_device(&phy->dev);
>   }
> +EXPORT_SYMBOL_GPL(of_phy_put);
> +
> +/**
> + * phy_put() - release the PHY
> + * @dev: device that wants to release this phy
> + * @phy: the phy returned by phy_get()
> + *
> + * Releases a refcount the caller received from phy_get().
> + */
> +void phy_put(struct device *dev, struct phy *phy)
> +{
> +	device_link_remove(dev, &phy->dev);
> +	of_phy_put(phy);
> +}
>   EXPORT_SYMBOL_GPL(phy_put);
>   
>   /**
> @@ -651,6 +665,7 @@ struct phy *phy_get(struct device *dev, const char *string)
>   {
>   	int index = 0;
>   	struct phy *phy;
> +	struct device_link *link;
>   
>   	if (string == NULL) {
>   		dev_WARN(dev, "missing string\n");
> @@ -672,6 +687,13 @@ struct phy *phy_get(struct device *dev, const char *string)
>   
>   	get_device(&phy->dev);
>   
> +	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> +	if (!link) {
> +		dev_err(dev, "failed to create device link to %s\n",
> +			dev_name(phy->dev.parent));
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>   	return phy;
>   }
>   EXPORT_SYMBOL_GPL(phy_get);
> @@ -765,6 +787,7 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
>   			    const char *con_id)
>   {
>   	struct phy **ptr, *phy;
> +	struct device_link *link;
>   
>   	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
>   	if (!ptr)
> @@ -778,6 +801,13 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
>   		devres_free(ptr);
>   	}
>   
> +	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> +	if (!link) {
> +		dev_err(dev, "failed to create device link to %s\n",
> +			dev_name(phy->dev.parent));
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>   	return phy;
>   }
>   EXPORT_SYMBOL_GPL(devm_of_phy_get);
> @@ -798,6 +828,7 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
>   				     int index)
>   {
>   	struct phy **ptr, *phy;
> +	struct device_link *link;
>   
>   	ptr = devres_alloc(devm_phy_release, sizeof(*ptr), GFP_KERNEL);
>   	if (!ptr)
> @@ -819,6 +850,13 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
>   	*ptr = phy;
>   	devres_add(dev, ptr);
>   
> +	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> +	if (!link) {
> +		dev_err(dev, "failed to create device link to %s\n",
> +			dev_name(phy->dev.parent));
> +		return ERR_PTR(-EINVAL);
> +	}
> +
>   	return phy;
>   }
>   EXPORT_SYMBOL_GPL(devm_of_phy_get_by_index);
> diff --git a/drivers/usb/renesas_usbhs/rcar2.c b/drivers/usb/renesas_usbhs/rcar2.c
> index 440d213e1749..791908f8cf73 100644
> --- a/drivers/usb/renesas_usbhs/rcar2.c
> +++ b/drivers/usb/renesas_usbhs/rcar2.c
> @@ -34,7 +34,7 @@ static int usbhs_rcar2_hardware_exit(struct platform_device *pdev)
>   	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
>   
>   	if (priv->phy) {
> -		phy_put(priv->phy);
> +		phy_put(&pdev->dev, priv->phy);
>   		priv->phy = NULL;
>   	}
>   
> diff --git a/drivers/usb/renesas_usbhs/rza2.c b/drivers/usb/renesas_usbhs/rza2.c
> index 021749594389..3eed3334a17f 100644
> --- a/drivers/usb/renesas_usbhs/rza2.c
> +++ b/drivers/usb/renesas_usbhs/rza2.c
> @@ -29,7 +29,7 @@ static int usbhs_rza2_hardware_exit(struct platform_device *pdev)
>   {
>   	struct usbhs_priv *priv = usbhs_pdev_to_priv(pdev);
>   
> -	phy_put(priv->phy);
> +	phy_put(&pdev->dev, priv->phy);
>   	priv->phy = NULL;
>   
>   	return 0;
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index 56d3a100006a..19eddd64c8f6 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -234,7 +234,8 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
>   			    const char *con_id);
>   struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
>   				     int index);
> -void phy_put(struct phy *phy);
> +void of_phy_put(struct phy *phy);
> +void phy_put(struct device *dev, struct phy *phy);
>   void devm_phy_put(struct device *dev, struct phy *phy);
>   struct phy *of_phy_get(struct device_node *np, const char *con_id);
>   struct phy *of_phy_simple_xlate(struct device *dev,
> @@ -419,7 +420,11 @@ static inline struct phy *devm_of_phy_get_by_index(struct device *dev,
>   	return ERR_PTR(-ENOSYS);
>   }
>   
> -static inline void phy_put(struct phy *phy)
> +static inline void of_phy_put(struct phy *phy)
> +{
> +}
> +
> +static inline void phy_put(struct device *dev, struct phy *phy)
>   {
>   }
>   
> 
