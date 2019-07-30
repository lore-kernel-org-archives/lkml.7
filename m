Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBC9C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1676208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GW2kU84g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfG3MoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:44:02 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:21498 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729175AbfG3MoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:44:00 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6UCdccW014128;
        Tue, 30 Jul 2019 07:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Mrlv2PUoXkr+l4StNndTN+CgAg0kqXB7QvANfqsxeW8=;
 b=GW2kU84gJK5qWGjsOQ7EeUFRdlFcMil2qW3Ek5Fhfnco/Em5PxE//NTo5GGTK+/gK9ZR
 ihSHrZf1eb/GTA6ysppLmDUG6fPRK/Nv8D3iaIIzq78fc1tzqSzm8mJrEFlKd6GmkjIH
 wA+f90IYjd8Spj/1ZT5SWcc6RKQ3GPQFqES/m4qqXQZQbh+16xZu0bbmTocKcMuAGuai
 Yom15pOpF/ix7Rz1h4DwFjQcdtUwxsJjsgQWQe9MyxxoegbuTQwPmSGf4G++f759KQLk
 Q8MYW5+MnT0zTRe++1Mxiv9AFI3BZo5NXXLlaxURpnRvaCLHvBasZOEkmeEz3Rs0snx/ Cg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2u0k1qvm0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jul 2019 07:42:00 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 30 Jul
 2019 13:41:58 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 30 Jul 2019 13:41:58 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 91F4645;
        Tue, 30 Jul 2019 13:41:58 +0100 (BST)
Date:   Tue, 30 Jul 2019 13:41:58 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic routine
Message-ID: <20190730124158.GH54126@ediswmail.ad.cirrus.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-4-thomas.preston@codethink.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1907300133
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 01:09:37PM +0100, Thomas Preston wrote:
> Add a debugfs device node which initiates the turn-on diagnostic routine
> feature of the TDA7802 amplifier. The four status registers (one per
> channel) are returned.
> 
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> ---
> Changes since v1:
> - Rename speaker-test to (turn-on) diagnostics
> - Move turn-on diagnostic to debugfs as there is no standard ALSA
>   interface for this kind of routine.
> 
>  sound/soc/codecs/tda7802.c | 186 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 185 insertions(+), 1 deletion(-)
> 
> +static int tda7802_bulk_update(struct regmap *map, struct reg_update *update,
> +		size_t update_count)
> +{
> +	int i, err;
> +
> +	for (i = 0; i < update_count; i++) {
> +		err = regmap_update_bits(map, update[i].reg, update[i].mask,
> +				update[i].val);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return i;
> +}

This could probably be removed using regmap_multi_reg_write.

> +static int tda7802_probe(struct snd_soc_component *component)
> +{
> +	struct tda7802_priv *tda7802 = snd_soc_component_get_drvdata(component);
> +	struct device *dev = &tda7802->i2c->dev;
> +	int err;
> +
> +	tda7802->debugfs = debugfs_create_dir(dev_name(dev), NULL);
> +	if (IS_ERR_OR_NULL(tda7802->debugfs)) {
> +		dev_info(dev,
> +			"Failed to create debugfs node, err %ld\n",
> +			PTR_ERR(tda7802->debugfs));
> +		return 0;
> +	}
> +
> +	mutex_init(&tda7802->diagnostic_mutex);
> +	err = debugfs_create_file("diagnostic", 0444, tda7802->debugfs, tda7802,
> +			&tda7802_diagnostic_fops);
> +	if (err < 0) {
> +		dev_err(dev,
> +			"debugfs: Failed to create diagnostic node, err %d\n",
> +			err);
> +		goto cleanup_diagnostic;
> +	}

You shouldn't be failing the driver probe if debugfs fails, it
should be purely optional.

Thanks,
Charles
