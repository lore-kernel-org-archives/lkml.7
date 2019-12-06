Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B820C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E02B2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JGYVJCRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfLFKfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:35:51 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:55916 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfLFKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:35:51 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6AXb4K012056;
        Fri, 6 Dec 2019 04:34:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=gODTI0lW1pdRgw8ARzPT2hG/hZAyqOBktg59aJ0itXo=;
 b=JGYVJCRKfWlj4U1CRVRaNLheVAXMN0UpKhO5wWhF1OVVjzTtLapt6rXwRwuiQLvvWYOq
 ZqzmENVuZie+QlP8jdkmkcrlsA5R9SKs49XH+Ko7CyKJQ0JfsWo9Lf6QfsVFpyHjcb+2
 6dZ7LTkDPM7fgSDWDvPQnpMd7Wg9c710J3WXJXOceQJ/k9+wC+s++QSfLq0h7Hn/IrwK
 Y4Su51rR09YwwUzh7HxBBZDkJOSz8vCukobzSho6xbRMQq5jOvWbaK3GncRrWTZHS/Ez
 Sjll2JKiW8K73nM/LPN0bGnhFRucaro9iU4jq//KRCfM034+IKggAlYHpq8vvia8JsBW hQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2wqmq101fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 06 Dec 2019 04:34:57 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 6 Dec
 2019 10:34:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 6 Dec 2019 10:34:53 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D991F2D1;
        Fri,  6 Dec 2019 10:34:53 +0000 (UTC)
Date:   Fri, 6 Dec 2019 10:34:53 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Chuhong Yuan <hslester96@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: wm5100: add missed regulator_bulk_disable
Message-ID: <20191206103453.GC10451@ediswmail.ad.cirrus.com>
References: <20191206075300.18182-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191206075300.18182-1-hslester96@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 suspectscore=2 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 mlxlogscore=977 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912060091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 03:53:00PM +0800, Chuhong Yuan wrote:
> The driver forgets to call regulator_bulk_disable() in remove like that
> in probe failure.
> Add the missed call to fix it.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>  sound/soc/codecs/wm5100.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
> index 91cc63c5a51f..d985b2061169 100644
> --- a/sound/soc/codecs/wm5100.c
> +++ b/sound/soc/codecs/wm5100.c
> @@ -2653,6 +2653,8 @@ static int wm5100_i2c_remove(struct i2c_client *i2c)
>  		gpio_set_value_cansleep(wm5100->pdata.ldo_ena, 0);
>  		gpio_free(wm5100->pdata.ldo_ena);
>  	}
> +	regulator_bulk_disable(ARRAY_SIZE(wm5100->core_supplies),
> +			       wm5100->core_supplies);
>  

This is a bit trickier than this since these regulators are being
controlled by PM runtime, and it doesn't necessarily leave things
in an enabled state when it is disabled.

Thanks,
Charles
