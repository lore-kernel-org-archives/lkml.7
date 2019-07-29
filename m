Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54511C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2654720644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UExwS/mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfG2ITb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:19:31 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:42774 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbfG2ITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:19:30 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6T8EAvi014828;
        Mon, 29 Jul 2019 03:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=WRFRbbdfaf0Y2ROtu21La93Edhg0Qj+U7zL+OJ4cOJo=;
 b=UExwS/mu1oC8AJJIO+I3MLnokg1b4ditpCvaNSLlHge7MQ5JZLyRa22nZ19JYdzqKZwn
 j7TgIew0AuMbfCF3yWZAJoFE86kpOdPQaoM1rQ1BZAfKce4Ulaq8m2jbMmzcQb1Tg1/f
 xQdS9+lyOrBZbDBubz0KMVXDBiESrbEHjvySeiYOBnrGMPEJI/312L+Q/0PESJQshGuW
 04tEWJo3db01NMlfHiX0hjE8mBoopot479VdCgWt9nWtHhXYT2E2f7gIj14lISnDDsa5
 UB1OPcRXbaaPrcEL7hRXaPUW6CMMxJtqp/IV0vU3vE8OVur5s2OWOpCIZWIDsQa76jlK qA== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2u0k1qthc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jul 2019 03:18:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 29 Jul
 2019 09:18:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 29 Jul 2019 09:18:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AB50F2A1;
        Mon, 29 Jul 2019 09:18:35 +0100 (BST)
Date:   Mon, 29 Jul 2019 09:18:35 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
CC:     <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] [ASoC][soc-dapm] : memory leak in the func
 snd_soc_dapm_new_dai
Message-ID: <20190729081835.GE54126@ediswmail.ad.cirrus.com>
References: <20190725161335.4162-1-thakursatendra2003@yahoo.co.in>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190725161335.4162-1-thakursatendra2003@yahoo.co.in>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=2
 mlxlogscore=830 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1907290098
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 09:43:35PM +0530, Satendra Singh Thakur wrote:
> In the func snd_soc_dapm_new_dai, if the inner func
> snd_soc_dapm_alloc_kcontrol fails, there will be memory leak.
> The label param_fail wont free memory which is allocated by
> the func devm_kcalloc. Hence new label is created for this purpose.
> 
> Signed-off-by: Satendra Singh Thakur <thakursatendra2003@yahoo.co.in>
> ---
>  sound/soc/soc-dapm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index f013b24c050a..f62d41ee6d68 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -4095,7 +4095,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
>  						w_param_text, &private_value);
>  		if (!template.kcontrol_news) {
>  			ret = -ENOMEM;
> -			goto param_fail;
> +			goto outfree_w_param;
>  		}
>  	} else {
>  		w_param_text = NULL;
> @@ -4114,6 +4114,7 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
>  
>  outfree_kcontrol_news:
>  	devm_kfree(card->dev, (void *)template.kcontrol_news);
> +outfree_w_param:
>  	snd_soc_dapm_free_kcontrol(card, &private_value,
>  				   rtd->dai_link->num_params, w_param_text);

This is not necessary snd_soc_dapm_alloc_kcontrol calls
snd_soc_dapm_free_kcontrol on its internal error path.

Thanks,
Charles
