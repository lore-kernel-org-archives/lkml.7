Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1F5C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AFCF2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="AME6hCYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfKRMAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:00:00 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16066 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726506AbfKRL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 06:59:59 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAIBsbju014603;
        Mon, 18 Nov 2019 05:57:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=a90LFI+4UGRRN7SiN+NnHb60zo8aNl0u0NCeb9mxiHk=;
 b=AME6hCYHgFoi0so5ng3/aZ9wLRPM0wv8J2BwCeJTZG1j97yGsixViaaHImVHmjKErj/V
 /yz5WiIuZPyqTatpNGCt1ihqyAgCgWsG18tPf1vzLd98824To4FwNYBmfFWPxLPS7Msv
 mPdXoJY4xsQKIHr+t+M4tmahSXAGZCCKs0dRGxwkwVucrG2WaKHE13Sduyo8xAy7SW8G
 nyjRZm9Tb/64Pb6C7ptlkXJneP3mfCE7l5eFpvXUNdQPUwe5kjv4kZFHCcrOBTcNP5nF
 1XKpeA4XRhyb5DlCikLQJ/vreHfCNF0WgQuJywb+7bSDGr2KR6qHR4fE3yR5VDFPC6Yl XA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wafd6teh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 18 Nov 2019 05:57:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 18 Nov
 2019 11:57:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 18 Nov 2019 11:57:48 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F17672C6;
        Mon, 18 Nov 2019 11:57:47 +0000 (UTC)
Date:   Mon, 18 Nov 2019 11:57:47 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm2200: add missed operations in remove and probe
 failure
Message-ID: <20191118115747.GG10439@ediswmail.ad.cirrus.com>
References: <20191118073633.28237-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191118073633.28237-1-hslester96@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=2 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911180108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 03:36:33PM +0800, Chuhong Yuan wrote:
> This driver misses calls to pm_runtime_disable and regulator_bulk_disable
> in remove and a call to free_irq in probe failure.
> Add the calls to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  sound/soc/codecs/wm2200.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
> index cf64e109c658..7b087d94141b 100644
> --- a/sound/soc/codecs/wm2200.c
> +++ b/sound/soc/codecs/wm2200.c
> @@ -2410,6 +2410,8 @@ static int wm2200_i2c_probe(struct i2c_client *i2c,
>  
>  err_pm_runtime:
>  	pm_runtime_disable(&i2c->dev);
> +	if (i2c->irq)
> +		free_irq(i2c->irq, wm2200);

Might be worth also adding a return if the request of the IRQ
fails. We will get a large WARN in the log if the IRQ request
failed, then we fall down this error path.

>  err_reset:
>  	if (wm2200->pdata.reset)
>  		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
> @@ -2426,12 +2428,15 @@ static int wm2200_i2c_remove(struct i2c_client *i2c)
>  {
>  	struct wm2200_priv *wm2200 = i2c_get_clientdata(i2c);
>  
> +	pm_runtime_disable(&i2c->dev);
>  	if (i2c->irq)
>  		free_irq(i2c->irq, wm2200);
>  	if (wm2200->pdata.reset)
>  		gpio_set_value_cansleep(wm2200->pdata.reset, 0);
>  	if (wm2200->pdata.ldo_ena)
>  		gpio_set_value_cansleep(wm2200->pdata.ldo_ena, 0);
> +	regulator_bulk_disable(ARRAY_SIZE(wm2200->core_supplies),
> +			       wm2200->core_supplies);

This one is a bit trickier since this regulator is being
controlled by PM runtime, and I don't think it necessarily leaves
things in an enabled state when it is disabled.

Thanks,
Charles
