Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356E3C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0491A206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 12:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WW27iPvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfG3M3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:29:35 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49830 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728186AbfG3M3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 08:29:35 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6UCPbL5001281;
        Tue, 30 Jul 2019 07:27:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=pY3zCtDyo2UN0OhyrBjrLt7xNrI8TidRHw7Z/SoxObk=;
 b=WW27iPvGmca6/6RHRPK/lJRXcfi9WBFDVrdgvCdTiffzT8wuSG8QbF93YWX6sM7gm1aq
 rvpkB0RxNVL+b7GpnujcaK32Kteg6fClR0Ik/f9eCLdM8kPxXgw2hzyVcC1jKb1QAPSw
 kN8JUdfsG8nvjCfb0x1JXjoCzLx1NfLRD2zNacySmbjzuri1mf5R38vl3D567POpqX1K
 899bLpgZsM+k90VVHSeCO1ciXdm7oeeLyYkW7sgkDMVV3Ei3hd86ZgJpokbq2UhkLfVH
 gOfzSnkdTom8LBMlCkgYRTj/WkgS9dCubfnBs+MRjQwSPumnfduWbI6PvbtymZzPFSZy ag== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2u0k1qvkeb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jul 2019 07:27:50 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 30 Jul
 2019 13:27:48 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 30 Jul 2019 13:27:48 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B7C512A1;
        Tue, 30 Jul 2019 13:27:48 +0100 (BST)
Date:   Tue, 30 Jul 2019 13:27:48 +0100
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
        <linux-kernel@vger.kernel.org>, Patrick Glaser <pglaser@tesla.com>,
        Rob Duncan <rduncan@tesla.com>, Nate Case <ncase@tesla.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: ASoC: Add TDA7802 amplifier
Message-ID: <20190730122748.GF54126@ediswmail.ad.cirrus.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-2-thomas.preston@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190730120937.16271-2-thomas.preston@codethink.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1907300130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 01:09:35PM +0100, Thomas Preston wrote:
> Signed-off-by: Thomas Preston <thomas.preston@codethink.co.uk>
> Cc: Patrick Glaser <pglaser@tesla.com>
> Cc: Rob Duncan <rduncan@tesla.com>
> Cc: Nate Case <ncase@tesla.com>
> ---
>  .../devicetree/bindings/sound/tda7802.txt     | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tda7802.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/tda7802.txt b/Documentation/devicetree/bindings/sound/tda7802.txt
> new file mode 100644
> index 000000000000..f80aaf4f1ba0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tda7802.txt
> @@ -0,0 +1,26 @@
> +ST TDA7802 audio processor
> +
> +This device supports I2C only.
> +
> +Required properties:
> +
> +- compatible : "st,tda7802"
> +- reg : the I2C address of the device
> +- enable-supply : a regulator spec for the PLLen pin
> +
> +Optional properties:
> +
> +- st,gain-ch13 : gain for channels 1 and 3 (range: 1-4)
> +- st,gain-ch24 : gain for channels 2 and 3 (range: 1-4)

I wouldn't have expected the gains to be available as a device
tree setting.

> +- st,diagnostic-mode-ch13 : diagnotic mode for channels 1 and 3
> +                            values: "Speaker" (default), "Booster"
> +- st,diagnostic-mode-ch24 : diagnotic mode for channels 2 and 4
> +                            values: "Speaker" (default), "Booster"
> +
> +Example:
> +
> +amp: tda7802@6c {
> +	compatible = "st,tda7802";
> +	reg = <0x6c>;
> +	enable-supply = <&amp_enable_reg>;
> +};
> -- 
> 2.21.0
> 

Thanks,
Charles
