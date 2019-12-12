Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB6AC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326FF21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="FSoOnz2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729990AbfLLQuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:50:50 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:31066 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729762AbfLLQuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:50:50 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCGfE7x019441;
        Thu, 12 Dec 2019 10:48:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Y5UjW/iCL1Sg9lvY5uXhCGfChrkY/+BGEyhe0F7nTj4=;
 b=FSoOnz2OD+7PkuvLAppfrLau4qkp5IvCDS61w9a3557LTss4kFKVQwQlC20v8VFUNYt8
 0IRsQIGpnwvEy0bDwoxmvbLLt9CaS/EsMwuiWn1hyMLDd1hNbCQ3mnyVLQkps3q8m3A3
 nbCBYqdhSjAaMmpblirUYeTlp26Ebju4YIpx6hZaHAG8vv1ZwusLWsS297O5v+U2rWEO
 ZD3APpOZUp/ySSNKJoClqNUf/5RYnHcKx/4jYa13IahTLTDfr404/Ow0O82gcrM4ypJ8
 MW6OVJLzZ/TPitZrzkG59o5Av33OOlsKoxdF22TuiW4qUORfI5HBBqVWDKeKNIb5PMjs 8w== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2wr9ctxxcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 10:48:38 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 12 Dec
 2019 16:48:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 12 Dec 2019 16:48:35 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6D0192A1;
        Thu, 12 Dec 2019 16:48:35 +0000 (UTC)
Date:   Thu, 12 Dec 2019 16:48:35 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>, <allison@lohutok.net>,
        <guennadi.liakhovetski@linux.intel.com>, <tglx@linutronix.de>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8962: fix lambda value
Message-ID: <20191212164835.GD10451@ediswmail.ad.cirrus.com>
References: <1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912120130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 07:57:22PM +0800, Shengjiu Wang wrote:
> According to user manual, it is required that FLL_LAMBDA > 0
> in all cases (Integer and Franctional modes).
> 
> Fixes: 9a76f1ff6e29 ("ASoC: Add initial WM8962 CODEC driver")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8962.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 3e5c69fbc33a..d9d59f45833f 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -2788,7 +2788,7 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
>  
>  	if (target % Fref == 0) {
>  		fll_div->theta = 0;
> -		fll_div->lambda = 0;
> +		fll_div->lambda = 1;
>  	} else {
>  		gcd_fll = gcd(target, fratio * Fref);
>  
> @@ -2858,7 +2858,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
>  		return -EINVAL;
>  	}
>  
> -	if (fll_div.theta || fll_div.lambda)
> +	if (fll_div.theta)
>  		fll1 |= WM8962_FLL_FRAC;

How well tested is this change, and is it addressing an issue you
have observed? I agree this does better fit the datasheet just a
little nervous as its an older part that has seen a lot of usage.

Thanks,
Charles
