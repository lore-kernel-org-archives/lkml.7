Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6DFC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F8B21744
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 10:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qGQGHOi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731256AbfHOKJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 06:09:16 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:28520 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbfHOKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 06:09:16 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7FA42U3029326;
        Thu, 15 Aug 2019 05:08:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=b1bBykvPnnxG06cNHLJogBSzoi3BdoXhENT7TdiZJxs=;
 b=qGQGHOi1tp/NK4hX/zxcVeLmRWelx31p6Zu53m01BChsAGZEMOSzDZut0+kGZcFWtwls
 LKLW9cba0VDZkRh82/YBMUly6wiqrV8nwwgXf36XgaAgBgjomoenS9mj2rty2GF5nJJB
 4kOXkZeOobqMWEa/9fRLUDbpMSaV6Ozm9vpvlDekYqkKiyYceWPRuup27zxpDAtFshjN
 FTHQHp5xO3hj62jeSoczXzvR9iFow2C5x4ddOB0yyA8w2WPRtxowlmgPkBmZh91I9KLj
 QduBknYO2Gd40/xiiJ1fMkKMrBAaY27Kg/PjrjrjifP7DltWiwqNZO+EbhoqLXntkGHa 8A== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ubf9bv4ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Aug 2019 05:08:12 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Thu, 15 Aug
 2019 11:08:11 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Thu, 15 Aug 2019 11:08:11 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2079D7C;
        Thu, 15 Aug 2019 11:08:11 +0100 (BST)
Date:   Thu, 15 Aug 2019 11:08:11 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     YueHaibing <yuehaibing@huawei.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <tglx@linutronix.de>, <info@metux.net>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH -next] ASoC: wm8737: Fix copy-paste error in
 wm8737_snd_controls
Message-ID: <20190815100811.GO54126@ediswmail.ad.cirrus.com>
References: <20190815091920.64480-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190815091920.64480-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxlogscore=838
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1906280000 definitions=main-1908150107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 05:19:20PM +0800, YueHaibing wrote:
> sound/soc/codecs/wm8737.c:112:29: warning:
>  high_3d defined but not used [-Wunused-const-variable=]
> 
> 'high_3d' should be used for 3D High Cut-off.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 2a9ae13a2641 ("ASoC: Add initial WM8737 driver")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
