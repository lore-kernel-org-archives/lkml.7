Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92130C4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CD2222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="X2zUH10m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389671AbfJDPVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:21:45 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:41902 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389165AbfJDPVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:21:45 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94FEqL2023042;
        Fri, 4 Oct 2019 10:21:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=p7+1RJbWg4qn+lD3vb5E/TJ6wjfRTkxdKjhfoIz+FUM=;
 b=X2zUH10mirbj+x/n8RnymRCWE63V6+ujHW7xyrMxoxYqbYGsTLoX60M+kOYD0ALkvOlj
 kJ87bqI1miKgzRN0fnZmJzOb/boYUtKqqWv1detwk7AC1qpBe6EyOiJbHbZ4YVft+NQ8
 3bWibyzYdjqz8kA2+B176enacAdVeUiBiYpm8lTdtbkNHaMp0wjVQ3CcAd8JAUi+e+G4
 9Jxv3iEGBDd6jucXt8wKQHH8Wswcx8gJQs+ZlW1mX/cIsYLOw9EYaI4zH3bLcRTTRQMF
 UAU+COcdZkqCuGK4OD7DE+4ZWoyfPORiLxq/65tgK+b5y+aCPjSMGlDI10XuMUuaa1jJ xw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 2va4x4t7rf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Oct 2019 10:21:37 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Fri, 4 Oct
 2019 16:21:35 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Fri, 4 Oct 2019 16:21:35 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E49EF2A1;
        Fri,  4 Oct 2019 15:21:34 +0000 (UTC)
Date:   Fri, 4 Oct 2019 15:21:34 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 3/3] mfd: madera: Add support for requesting the
 supply clocks
Message-ID: <20191004152134.GA31391@ediswmail.ad.cirrus.com>
References: <20191001134617.12093-1-ckeepax@opensource.cirrus.com>
 <20191001134617.12093-3-ckeepax@opensource.cirrus.com>
 <20191004143410.GJ18429@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191004143410.GJ18429@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=852
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910040136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2019 at 03:34:10PM +0100, Lee Jones wrote:
> On Tue, 01 Oct 2019, Charles Keepax wrote:
> 
> > Add the ability to get the clock for each clock input pin of the chip
> > and enable MCLK2 since that is expected to be a permanently enabled
> > 32kHz clock.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  	/* Init 32k clock sourced from MCLK2 */
> > +	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2].clk);
> > +	if (ret != 0) {
> 
> Nit: Why is this not 'if (ret)' like in the rest of the file?
> 

Apologies will get that fixed up.

Thanks,
Charles
