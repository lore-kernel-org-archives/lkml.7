Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD687C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA4220878
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="FAaJNQW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfDXJaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:30:16 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23692 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726176AbfDXJaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:30:15 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3O9S2xl016196;
        Wed, 24 Apr 2019 11:29:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=2o5IGPIQ5p1cWC32IDoQF85xBOwkYPMDHu6k/f7altE=;
 b=FAaJNQW32HeoS4ZvT3oGug14CS4FmZMpfdnCFjhMPEh8nIy3sOj32YHDvja4H4R37lWU
 BmMmv+VnVofzrdK3HRsO97u2TYC5MBKp82GX514qcLaRuGzdbT+4NJXdqhN/Jr3Zazd0
 l89Vz3yMguA4lbKl3/3qhe95hdNR3gvbc5Yh9Lf8X0Y4PQWoMkJdCgLb3oOhOSEPaKtE
 x39y79eN3XT8kwdcv8rcU4eFV7Bv29MnYf/8QTGNVWECO2Fwd8OiGY2RSpj3Kd6kR0Pl
 xCKmi6kiv4JgxnzGNerJcGnpNqEyRu71LeCMCNhO1SReKz23+MJ4x912U1JUsRygA9FE bQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ryrj65yrq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 24 Apr 2019 11:29:50 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 19A323A;
        Wed, 24 Apr 2019 09:29:50 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E89E7157D;
        Wed, 24 Apr 2019 09:29:49 +0000 (GMT)
Received: from [10.48.0.204] (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 24 Apr
 2019 11:29:49 +0200
Subject: Re: [PATCH] pinctrl: stm32: check irq controller availability at
 probe
To:     Fabien Dessenne <fabien.dessenne@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1556093324-1008-1-git-send-email-fabien.dessenne@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <8d65f99f-0874-8012-5e44-3e579cb1f878@st.com>
Date:   Wed, 24 Apr 2019 11:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1556093324-1008-1-git-send-email-fabien.dessenne@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/19 10:08 AM, Fabien Dessenne wrote:
> It is not guaranteed that the IRQ controller driver is probed before
> the pin controller driver gets probed.
> Considering this, check for the irq domain availability during probe
> and return EPROBE_DEFER if needed.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> ---


Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

>   drivers/pinctrl/stm32/pinctrl-stm32.c | 37 +++++++++++++++++++++++++----------
>   1 file changed, 27 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
> index 0aebc31..2317ccf 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
> @@ -1122,23 +1122,35 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl,
>   	return 0;
>   }
>   
> +static struct irq_domain *stm32_pctrl_get_irq_domain(struct device_node *np)
> +{
> +	struct device_node *parent;
> +	struct irq_domain *domain;
> +
> +	if (!of_find_property(np, "interrupt-parent", NULL))
> +		return NULL;
> +
> +	parent = of_irq_find_parent(np);
> +	if (!parent)
> +		return ERR_PTR(-ENXIO);
> +
> +	domain = irq_find_host(parent);
> +	if (!domain)
> +		/* domain not registered yet */
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return domain;
> +}
> +
>   static int stm32_pctrl_dt_setup_irq(struct platform_device *pdev,
>   			   struct stm32_pinctrl *pctl)
>   {
> -	struct device_node *np = pdev->dev.of_node, *parent;
> +	struct device_node *np = pdev->dev.of_node;
>   	struct device *dev = &pdev->dev;
>   	struct regmap *rm;
>   	int offset, ret, i;
>   	int mask, mask_width;
>   
> -	parent = of_irq_find_parent(np);
> -	if (!parent)
> -		return -ENXIO;
> -
> -	pctl->domain = irq_find_host(parent);
> -	if (!pctl->domain)
> -		return -ENXIO;
> -
>   	pctl->regmap = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
>   	if (IS_ERR(pctl->regmap))
>   		return PTR_ERR(pctl->regmap);
> @@ -1264,6 +1276,11 @@ int stm32_pctl_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, pctl);
>   
> +	/* check for IRQ controller (may require deferred probe) */
> +	pctl->domain = stm32_pctrl_get_irq_domain(np);
> +	if (IS_ERR(pctl->domain))
> +		return PTR_ERR(pctl->domain);
> +
>   	/* hwspinlock is optional */
>   	hwlock_id = of_hwspin_lock_get_id(pdev->dev.of_node, 0);
>   	if (hwlock_id < 0) {
> @@ -1294,7 +1311,7 @@ int stm32_pctl_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> -	if (of_find_property(np, "interrupt-parent", NULL)) {
> +	if (pctl->domain) {
>   		ret = stm32_pctrl_dt_setup_irq(pdev, pctl);
>   		if (ret)
>   			return ret;
> 
