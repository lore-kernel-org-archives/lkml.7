Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF932C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ED2521924
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Wowt4+gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfKHQJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:09:15 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46160 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfKHQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:09:14 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA8G4LnJ006738;
        Fri, 8 Nov 2019 10:07:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=8sfSVCnGboedt/b1ZhqJ7bI2jbmOSniGz207iomPpS4=;
 b=Wowt4+gy6hEErv+Hrv/3ESKn9QBAXk4FtrZigukHe5fLSbLoIkUkAvcXg29t5BoJX2nB
 6SgSxUQDIAaYndZIKvVXS8yWXNhm+2qyNj2yIIyBg5zI8DQusVOhUYm/13ITXvzw569Q
 co+uuMb6y42zWICCo9yhVfjT5djMr2CiP7AMEBnMhVFoUq7viwkBKU9X0NEkjE7H3Lm/
 n2TAkKcVOqLUdACAJjwrHkSPPAKB6Fc4b2fAvzzcItljtNlSToprwBp7VCvun68Iiqfr
 +qHJ9dZUGTEJk0JHGezzGu7KfNvKkrLnt5hU80I+/g9QjHnx+EkVRFzoomWfqlsKx1mj 4A== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2w41w6udan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 08 Nov 2019 10:07:06 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 8 Nov
 2019 16:07:04 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 8 Nov 2019 16:07:04 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 7C5B92A1;
        Fri,  8 Nov 2019 16:07:04 +0000 (UTC)
Date:   Fri, 8 Nov 2019 16:07:04 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Michael Walle <michael@walle.cc>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8904: configure sysclk/FLL automatically
Message-ID: <20191108160704.GA10439@ediswmail.ad.cirrus.com>
References: <20191107231548.17454-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191107231548.17454-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=805
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911080160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 12:15:48AM +0100, Michael Walle wrote:
> This adds a new mode WM8904_CLK_AUTO which automatically enables the FLL
> if a frequency different than the MCLK is set.
> 
> These additions make the codec work with the simple-card driver in
> general and especially in systems where the MCLK doesn't match the
> requested clock.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> +static int wm8904_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> +			     unsigned int freq, int dir)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct wm8904_priv *priv = snd_soc_component_get_drvdata(component);
> +	unsigned long mclk_freq;
> +	int ret;
> +
> +	switch (clk_id) {
> +	case WM8904_CLK_AUTO:
> +		mclk_freq = clk_get_rate(priv->mclk);
> +		/* enable FLL if a different sysclk is desired */
> +		if (mclk_freq != freq) {
> +			priv->sysclk_src = WM8904_CLK_FLL;
> +			ret = wm8904_set_fll(dai, WM8904_FLL_MCLK,
> +					     WM8904_FLL_MCLK,
> +					     clk_get_rate(priv->mclk), freq);

minor nit, might as well use mclk_freq rather than calling
clk_get_rate again, other than that though I think this looks
good.

Thanks,
Charles
