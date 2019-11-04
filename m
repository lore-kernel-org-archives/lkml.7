Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E57CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B8D21D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 10:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dwedyjHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfKDKZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 05:25:10 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:24612 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726364AbfKDKZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 05:25:09 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xA4ALRb2015346;
        Mon, 4 Nov 2019 04:24:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=tvEWxqudKUEtH3GCNHkkswnAVX+cybOK1dy7cUIDNZ4=;
 b=dwedyjHKJjs1sQ4mraF9ntTeJ/ZRG2skmM3Cpt/aucD8c/CC7KobLL2YLIOFAeZFEXd/
 tx4BRbzTc7tpyFEVYLw4Sve7xLhVQI43R4XLz1MIARJkJQuMm5YFY8aRiZ5SkaDnTsCq
 9ejJ8HDuVTzg6eNuvGNZQj5u5Oq9IN6ygbFilueEnx6XwA90S4v9lDxanFqvbhCZnNjt
 7mWEl2RoYukNGIqL4I9D9YXPbZnsGDF3K8l8bCDx/OZBy7gUl9ILVUvNX/WaI4fbbNTj
 f6R4ivjBeLtEoPWZSXRq+1z3Tifij31OG0IeykgzAqrQS08auRHfJD9yQ1mak5a4C2ws Vw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2w1772t23t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 Nov 2019 04:24:09 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 4 Nov
 2019 10:24:07 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 4 Nov 2019 10:24:07 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 100392C3;
        Mon,  4 Nov 2019 10:24:07 +0000 (UTC)
Date:   Mon, 4 Nov 2019 10:24:07 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
        "info@metux.net" <info@metux.net>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm8524: Add support S32_LE
Message-ID: <20191104102407.GH31391@ediswmail.ad.cirrus.com>
References: <20191101063349.32222-1-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191101063349.32222-1-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1011 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1908290000
 definitions=main-1911040103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 06:34:54AM +0000, S.j. Wang wrote:
> Allow 32bit sample with this codec.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  sound/soc/codecs/wm8524.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wm8524.c b/sound/soc/codecs/wm8524.c
> index 91e3d1570c45..4e9ab542f648 100644
> --- a/sound/soc/codecs/wm8524.c
> +++ b/sound/soc/codecs/wm8524.c
> @@ -159,7 +159,9 @@ static int wm8524_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
>  
>  #define WM8524_RATES SNDRV_PCM_RATE_8000_192000
>  
> -#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
> +#define WM8524_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
> +			SNDRV_PCM_FMTBIT_S24_LE |\
> +			SNDRV_PCM_FMTBIT_S32_LE)
>  

The device doesn't actually support 32bit though, I guess it will
ignore the extra LSBs so it should work. But is that really
supporting 32 bit?

Thanks,
Charles
