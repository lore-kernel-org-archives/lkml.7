Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702ADC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3948E2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 10:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="UWC0CNBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLMK5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 05:57:25 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:60208 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725890AbfLMK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 05:57:24 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBDApeV8018866;
        Fri, 13 Dec 2019 04:57:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=b3XCO3g7n3HWcPlAKBzHSMbVpUVeYqKQIfE9XAkGT/g=;
 b=UWC0CNBfl57fq2VE2ZFB48b+gKVNeedw+x2/bSgHtaJ7uP6Rkg5i/sJQ9bAYCO80FLKk
 VwKKRcCK3mvjm9CsAfBGX4bZ8Mi6ori/WI2LuQ0YIfrRwwdaIj54YIQLop7uF1y0I9pM
 lBgQFLd5gTv2dsWJjYwOYXTNPB9/KokrFhjkCVvYpXojSLdBve4wT0ivN2pOt88Mi9tY
 LSRJAwrTe/RelqnRM1GNYdWHEY25W/XoVFAFRY7PxZJmfwaujOykZ3aBeQWkkcBYdd8K
 Vyma3C+RtOJuJTrrkmOu2hm6JwRXav/ep7TeT8k/NBhjh5XTHn3isfHdcRHJUrkXsr46 FQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2wr9cu00s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 13 Dec 2019 04:57:01 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 13 Dec
 2019 10:56:58 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 13 Dec 2019 10:56:58 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CD3192A1;
        Fri, 13 Dec 2019 10:56:58 +0000 (UTC)
Date:   Fri, 13 Dec 2019 10:56:58 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
CC:     Mark Brown <broonie@kernel.org>, <kstewart@linuxfoundation.org>,
        <guennadi.liakhovetski@linux.intel.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <patches@opensource.cirrus.com>, <tglx@linutronix.de>,
        <allison@lohutok.net>
Subject: Re: [alsa-devel] [PATCH] ASoC: wm8962: fix lambda value
Message-ID: <20191213105658.GE10451@ediswmail.ad.cirrus.com>
References: <1576065442-19763-1-git-send-email-shengjiu.wang@nxp.com>
 <20191212164835.GD10451@ediswmail.ad.cirrus.com>
 <20191212165311.GK4310@sirena.org.uk>
 <CAA+D8AP4XNNmQ72xG6gNevtu8i8TJ7AaQMMgXJMCPmv2VO0_HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA+D8AP4XNNmQ72xG6gNevtu8i8TJ7AaQMMgXJMCPmv2VO0_HA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 clxscore=1011 suspectscore=0 mlxscore=0 mlxlogscore=969
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912130087
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 11:09:09AM +0800, Shengjiu Wang wrote:
> Hi
> 
> On Fri, Dec 13, 2019 at 12:54 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Thu, Dec 12, 2019 at 04:48:35PM +0000, Charles Keepax wrote:
> > > On Wed, Dec 11, 2019 at 07:57:22PM +0800, Shengjiu Wang wrote:
> > > > According to user manual, it is required that FLL_LAMBDA > 0
> > > > in all cases (Integer and Franctional modes).
> >
> > > How well tested is this change, and is it addressing an issue you
> > > have observed? I agree this does better fit the datasheet just a
> > > little nervous as its an older part that has seen a lot of usage.
> >
> > I've got a feeling that requirement might've been added in later
> > versions of the datasheet...
> 
> We encounter an issue that when Integer mode, the lambda=theta=0,
> the output sound is slower than expected. After change lambda=1
> the issue is gone.
> 

Cool alright if there is a real issue here, then we should be
getting it fixed.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
