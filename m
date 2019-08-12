Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30151C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA29D20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GE3zqRpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfHLQJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:09:45 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:29562 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725843AbfHLQJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:09:44 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7CG91AI031365;
        Mon, 12 Aug 2019 11:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=BOhCFqPI+D+pfHpXRqMVBc4hjnBNRMAkRbGZXOwrg7c=;
 b=GE3zqRpy8+qSWmKA+FLstRshm5giHjftIlH6/AzPrWnru0jVWba1WNWWfi8xzlPoN18Q
 KPeUNcRPrYVRAdC4Y8jMfuZ38a5xl8eCLNY1vjtoHz//JJ9u1Osgd5ekHXXbFmVVEMhk
 qqjaWkMo/m3eKKAhc49iP17GkAZnbTQADLqW06J9h3OWAHeKj0KYzox61VjBrei1xMvR
 i/3xJSD4cCe+KpoFsF8afe8M4z29KGa1L4EQUUH8BG1r6EutdK6UVuIv3IwSjb7ULVYc
 wvmpLxLdTn0NcGr4P/tEwo6FnbWK+H1CbtWEhp6kreW6J6motBjSQIlOIZCf9kW4Rm3Q kw== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 2u9tbru2tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 12 Aug 2019 11:09:38 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Mon, 12 Aug
 2019 17:09:37 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Mon, 12 Aug 2019 17:09:37 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 183FD448;
        Mon, 12 Aug 2019 17:09:37 +0100 (BST)
Date:   Mon, 12 Aug 2019 17:09:37 +0100
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] mfd: madera: Add support for requesting the supply
 clocks
Message-ID: <20190812160937.GM54126@ediswmail.ad.cirrus.com>
References: <20190806151321.31137-1-ckeepax@opensource.cirrus.com>
 <20190806151321.31137-2-ckeepax@opensource.cirrus.com>
 <20190812103853.GM26727@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190812103853.GM26727@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1906280000
 definitions=main-1908120180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:38:53AM +0100, Lee Jones wrote:
> On Tue, 06 Aug 2019, Charles Keepax wrote:
> 
> > Add the ability to get the clock for each clock input pin of the chip
> > and enable MCLK2 since that is expected to be a permanently enabled
> > 32kHz clock.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  int madera_dev_init(struct madera *madera)
> >  {
> > +	static const char * const mclk_name[] = { "mclk1", "mclk2", "mclk3" };
> >  	struct device *dev = madera->dev;
> >  	unsigned int hwid;
> >  	int (*patch_fn)(struct madera *) = NULL;
> > @@ -450,6 +451,17 @@ int madera_dev_init(struct madera *madera)
> >  		       sizeof(madera->pdata));
> >  	}
> >  
> > +	BUILD_BUG_ON(ARRAY_SIZE(madera->mclk) != ARRAY_SIZE(mclk_name));
> 
> Not sure how this could happen.  Surely we don't need it.
> 

mclk_name is defined locally in this function and the mclk array in
include/linux/mfd/madera/core.h. This is to guard against one of
them being updated but not the other. It is by no means essential
but it feels like a good trade off given there is really limited
downside.

> > +	for (i = 0; i < ARRAY_SIZE(madera->mclk); i++) {
> > +		madera->mclk[i] = devm_clk_get_optional(madera->dev,
> > +							mclk_name[i]);
> > +		if (IS_ERR(madera->mclk[i])) {
> > +			dev_warn(madera->dev, "Failed to get %s: %ld\n",
> > +				 mclk_name[i], PTR_ERR(madera->mclk[i]));
> 
> Do we even want to warn on the non-acquisition of an optional clock?
> 
> Especially with a message that looks like something actually failed.
> 

devm_clk_get_optional will return NULL if the clock was not
specified, so this is silent in that case. A warning in the case
something actually went wrong seems reasonable even if the clock
is optional as the user tried to do something and it didn't
behave as they intended.

> > +			madera->mclk[i] = NULL;
> > +		}
> > +	}
> > +
> >  	ret = madera_get_reset_gpio(madera);
> >  	if (ret)
> >  		return ret;
> > @@ -660,13 +672,19 @@ int madera_dev_init(struct madera *madera)
> >  	}
> >  
> >  	/* Init 32k clock sourced from MCLK2 */
> > +	ret = clk_prepare_enable(madera->mclk[MADERA_MCLK2]);
> > +	if (ret != 0) {
> > +		dev_err(madera->dev, "Failed to enable 32k clock: %d\n", ret);
> > +		goto err_reset;
> > +	}
> 
> What happened to this being optional?
> 

The device needs the clock but specifying it through DT is
optional (the clock framework functions are no-ops and return
success if the clock pointer is NULL). Normally the 32kHz
clock is always on, and more importantly no existing users of
the driver will be specifying one.

We could remove the optional status for MCLK2, but it could break
existing users who don't yet specify the clock until they update
their DT and it will complicate the code as the other clocks are
definitely optional, so MCLK2 will need special handling.

> >  	ret = regmap_update_bits(madera->regmap,
> >  			MADERA_CLOCK_32K_1,
> >  			MADERA_CLK_32K_ENA_MASK | MADERA_CLK_32K_SRC_MASK,
> >  			MADERA_CLK_32K_ENA | MADERA_32KZ_MCLK2);
> >  	if (ret) {
> >  		dev_err(madera->dev, "Failed to init 32k clock: %d\n", ret);
> > -		goto err_reset;
> > +		goto err_clock;
> >  	}
> >  
> >  	pm_runtime_set_active(madera->dev);
> > @@ -687,6 +705,8 @@ int madera_dev_init(struct madera *madera)
> >  
> >  err_pm_runtime:
> >  	pm_runtime_disable(madera->dev);
> > +err_clock:
> > +	clk_disable_unprepare(madera->mclk[MADERA_MCLK2]);
> 
> Where are the other clocks consumed?
> 

Other clocks will be consumed by the ASoC part of the driver for
clocking the audio functionality and running the FLLs. I haven't
sent those patches yet, but was planning on doing so once this
was merged.

Thanks,
Charles
