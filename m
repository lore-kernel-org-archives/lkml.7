Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53348C31E41
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C49721726
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 15:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbfFJP7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 11:59:25 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60022 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389583AbfFJP7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 11:59:25 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5AFxLhp028833;
        Mon, 10 Jun 2019 10:59:21 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail2.cirrus.com (mail2.cirrus.com [141.131.128.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2t09ep2nn6-1;
        Mon, 10 Jun 2019 10:59:21 -0500
Received: from EDIEX02.ad.cirrus.com (unknown [198.61.84.81])
        by mail2.cirrus.com (Postfix) with ESMTP id 971B6605A6B9;
        Mon, 10 Jun 2019 10:59:20 -0500 (CDT)
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 10 Jun
 2019 16:59:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 10 Jun 2019 16:59:20 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E5BE144;
        Mon, 10 Jun 2019 16:59:19 +0100 (BST)
Date:   Mon, 10 Jun 2019 16:59:19 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH] regulator: wm831x: Convert to use GPIO descriptors
Message-ID: <20190610155919.GQ28362@ediswmail.ad.cirrus.com>
References: <20190609210025.29224-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190609210025.29224-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906100109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2019 at 11:00:25PM +0200, Linus Walleij wrote:
> This converts the Wolfson Micro WM831x DCDC converter to use
> a GPIO descriptor for the GPIO driving the DVS pin.
> 
> There is just one (non-DT) machine in the kernel using this, and
> that is the Wolfson Micro (now Cirrus) Cragganmore 6410 so we
> patch this board to pass a descriptor table and fix up the driver
> accordingly.
> 
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Richard Fitzgerald <rf@opensource.cirrus.com>
> Cc: patches@opensource.cirrus.com
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> +/*
> + * VDDARM is eventually ending up as a regulator hanging on the MFD cell device
> + * "wm831x-buckv.1" spawn from drivers/mfd/wm831x-core.c.
> + *
> + * From the note on the platform data we can see that this is clearly DVS1
> + * and assigned as dcdc1 resource to the MFD core which sets .id of the cell
> + * spawning the DVS1 platform device to 1, resulting in the device name
> + * "wm831x-buckv.1".
> + */
> +static struct gpiod_lookup_table crag_pmic_gpiod_table = {
> +	.dev_id = "wm831x-buckv.1",

This is not correct, the mfd_add_devices in wm831x-core passes an
ID to the MFD core. Which is calculated from wm831x_num  * 10,
taken from the pdata. So this should be "wm831x-buckv.11".

> +	.table = {
> +		GPIO_LOOKUP("GPIOK", 0, "dvs", GPIO_ACTIVE_HIGH),
> +		{ },
> +	},
> +};
> +

<snip>

> -	ret = devm_gpio_request_one(&pdev->dev, pdata->dvs_gpio,
> -				    dcdc->dvs_gpio_state ? GPIOF_INIT_HIGH : 0,
> -				    "DCDC DVS");
> -	if (ret < 0) {
> -		dev_err(wm831x->dev, "Failed to get %s DVS GPIO: %d\n",
> -			dcdc->name, ret);
> +	dcdc->dvs_gpiod = devm_gpiod_get_optional(&pdev->dev, "dvs",
> +			dcdc->dvs_gpio_state ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW);
> +	if (IS_ERR(dcdc->dvs_gpiod)) {
> +		dev_err(wm831x->dev, "Failed to get %s DVS GPIO: %ld\n",
> +			dcdc->name, PTR_ERR(dcdc->dvs_gpiod));
>  		return;
>  	}
>  

Whats the thinking behind using get_optional here? A plain
devm_gpiod_get looks like it would be closer to the original
code. Previously if there was no GPIO we would log an error and
not execute the rest of the function, this is I think no longer
the case after this change.

Thanks,
Charles
