Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE7CC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC320659
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HWMR49/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfG3OTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:19:53 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:7460 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726937AbfG3OTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:19:52 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6UEEUj1010238;
        Tue, 30 Jul 2019 09:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=16TtY1AqhnRkUXcrlSdlYeSs6q0dlo2RqTFOF7duXMs=;
 b=HWMR49/XS0fWtn/X6ImxVX/kKU4meBn+91iR6j5k88+HhNyK/5yr3+UyjZ53XTfpqtnF
 skkTu3ULE67+GQkuNj3GrJgsfKGTkDc1BlezFXyKDlcdTooBq+nSibsDqSv+/u9hhfL8
 m3K9F9o1qAGIRUPXidKbxoh503yFFBFcrXJIEd21U3jsL3lbMaaFeR8PMBQhv56p7xkP
 EnP8oQ6w8YGzVxYGvXsxSvPWe9sEOQ42sCJUQj6cuosjENwDLTQO2eaZkUsdUkO7j2XX
 S8BtNJPKm5aGA23PGFvzge9HdyOSWNmQkiTh8acX0l60VBOoL72PHmH452aCys+Y1EYy dw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2u0mapmxef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jul 2019 09:18:25 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 30 Jul
 2019 15:18:22 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 30 Jul 2019 15:18:22 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id DD3C42C5;
        Tue, 30 Jul 2019 15:18:22 +0100 (BST)
Date:   Tue, 30 Jul 2019 15:18:22 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Thomas Preston <thomas.preston@codethink.co.uk>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Kirill Marinushkin <kmarinushkin@birdec.tech>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on
 diagnostic routine
Message-ID: <20190730141822.GI54126@ediswmail.ad.cirrus.com>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730124158.GH54126@ediswmail.ad.cirrus.com>
 <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e7a879d3-36c2-2df8-97c0-3c4bbd2e7ea2@codethink.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=820 priorityscore=1501 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1907300147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 03:04:19PM +0100, Thomas Preston wrote:
> On 30/07/2019 13:41, Charles Keepax wrote:
> >> +static int tda7802_bulk_update(struct regmap *map, struct reg_update *update,
> >> +		size_t update_count)
> >> +{
> >> +	int i, err;
> >> +
> >> +	for (i = 0; i < update_count; i++) {
> >> +		err = regmap_update_bits(map, update[i].reg, update[i].mask,
> >> +				update[i].val);
> >> +		if (err < 0)
> >> +			return err;
> >> +	}
> >> +
> >> +	return i;
> >> +}
> > 
> > This could probably be removed using regmap_multi_reg_write.
> > 
> 
> The problem is that I want to retain the state of the other bits in those
> registers. Maybe I should make a copy of the backed up state, set the bits
> I want to off-device, then either:
> 
> 1. Write the changes with regmap_multi_reg_write
> 2. Write all six regs again (if my device doesn't support the multi_reg)
> 

Nah sorry my bad you are probably better off they way you are.

Thanks,
Charles
