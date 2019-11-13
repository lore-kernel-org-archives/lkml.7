Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382A5C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EE05222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 08:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="RRnBMVhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKMI13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 03:27:29 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:47306 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbfKMI13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 03:27:29 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAD8O2WY011619;
        Wed, 13 Nov 2019 02:25:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=HUlJKxSb206fnxwJaIVeyt16K+PMELRcWcNa+iKeQpI=;
 b=RRnBMVhWz+xv57PxGF/yWVwxG7Ph6hVsaFMNRZrnsmXLW+TO+0DG28iAQuhmnacdcNZl
 mvJuyl7RwNaO6l3hqLQQOCPPZ64UDIv1K2L8QmMOUoV07orx5QslPzR9uJTmGToSFVMC
 LGCTjQOnUPTnCnByXUl+lbYfJRsx8MWJQ2XpZVPDjBKoLrQNu2uF+uEFTLPNBdq+nxnu
 qidM7yFLJ6QKgsQgB7zmHkp6C546/fZ37fIebQObiS2MIhE9LG3LUiL0plcGd+9dUequ
 KNjPpwrCCmRI85vK0Ggh92FcKiFuJGrBHMC+0F4pr/hALLRKoRRJGdjjzmt+/CODju2o 0g== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2w5trnx073-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 13 Nov 2019 02:25:17 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 13 Nov
 2019 08:25:15 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 13 Nov 2019 08:25:15 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3D0302A1;
        Wed, 13 Nov 2019 08:25:15 +0000 (UTC)
Date:   Wed, 13 Nov 2019 08:25:15 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Michael Walle <michael@walle.cc>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: wm8904: fix regcache handling
Message-ID: <20191113082515.GE10439@ediswmail.ad.cirrus.com>
References: <20191112223629.21867-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191112223629.21867-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 clxscore=1015
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 mlxlogscore=614 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911130077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2019 at 11:36:29PM +0100, Michael Walle wrote:
> The current code assumes that the power is turned off in
> SND_SOC_BIAS_OFF. If there are no actual regulator the codec isn't
> turned off and the registers are not reset to their default values but
> the regcache is still marked as dirty. Thus a value might not be written
> to the hardware if it is set to the default value. Do a software reset
> before turning off the power to make sure the registers are always reset
> to their default states.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
