Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21606C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4C9820722
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 17:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="ev5z29XS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbfKZRIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 12:08:42 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:10222 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727309AbfKZRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 12:08:41 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQH480h007261;
        Tue, 26 Nov 2019 11:04:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=Iv/PtGLcU5/lFZn00YMSkCI5yPeSpQhva72OPbmoEfw=;
 b=ev5z29XShzgOtVef/thntsmFpHUnpN/knHoMYxlYe5fTD++rn7pldDKwj/Q4IeDJyax2
 ap2Ycv9TwQ4pgZHw8cZwyHXB/VClBZrFgaz21hrUQ40yTyUJ0l/m1TzcrdrGOcWlzlQt
 /rkIVNaC0RjAfLt+Q0by63zLGoYuXoC+vT6K3UwvpsZxsKIwTchd0TxEiX/4fPHiEC2s
 QPfAqBVMV1cEEGpTqiNPeiXlWs67nsknWykeZGNwcvNdlwEN1ZQn7xTUNuOJRaqeFQE4
 iTST6WiKnfz5g5m9pBOBKl5Ajt8kZrcVWYo51/YGr/YfnYqdCbxa0m3hGyO1VmXgvIGt Kg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2wf328mjy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Nov 2019 11:04:20 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 26 Nov
 2019 17:05:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 26 Nov 2019 17:05:13 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 88F6A2C6;
        Tue, 26 Nov 2019 17:04:18 +0000 (UTC)
Date:   Tue, 26 Nov 2019 17:04:18 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Michael Walle <michael@walle.cc>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8904: fix automatic sysclk configuration
Message-ID: <20191126170418.GL10439@ediswmail.ad.cirrus.com>
References: <20191122232532.22258-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191122232532.22258-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911260142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 12:25:32AM +0100, Michael Walle wrote:
> The simple-card tries to signal the codec to disable rate constraints,
> see commit 2458adb8f92a ("SoC: simple-card-utils: set 0Hz to sysclk when
> shutdown"). This wasn't handled by the codec, instead it would set the
> FLL frequency to 0Hz which isn't working. Since we don't have any rate
> constraints just ignore this request.
> 
> Fixes: 13409d27cb39 ("ASoC: wm8904: configure sysclk/FLL automatically")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
