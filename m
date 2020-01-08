Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F32C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07383206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Z4rje0WJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgAHIqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:46:44 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:49712 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726481AbgAHIqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:46:43 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0088b6h7025138;
        Wed, 8 Jan 2020 02:46:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=5vloF2tu2Sx4S6BQ3fMbJ4Y4FSx5v/rQY3RGNTFnX/k=;
 b=Z4rje0WJGLs9oD3+dBeRKR433H0E1IFrO+Rc7isUvv/3Y4gapOi+15dBNKUtMldIgERN
 lGzy1RMcQJu54NeCJ40CeUAzoO/j9b0gTgOO5RGHry3NJYzOVAQvbIOnOjZE2SJyGb37
 KWVnpwLM4wyrBc16pxGuKzDiBDuES+vMMY8r/LrTVRhooIJmDe/ZftrY4ECMbIZg6VmJ
 zOERFRxLfLLSt1G9qlTo7iMiZQqrI6syd54V6w9NviHX/1Icw8WqJJTwiXNCufon1ho9
 D5DGVhfQ80boQYVKJ01VaHCKLDU+uwepd4Gs0znr71w1NqUiLxU9SAlSQFLC+g6ifptU xQ== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2xar0tcsbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Jan 2020 02:46:41 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 8 Jan
 2020 08:46:40 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 8 Jan 2020 08:46:40 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 25AB32B1;
        Wed,  8 Jan 2020 08:46:40 +0000 (UTC)
Date:   Wed, 8 Jan 2020 08:46:40 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 1/2] mfd: madera: Allow more time for hardware reset
Message-ID: <20200108084640.GI10451@ediswmail.ad.cirrus.com>
References: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
 <20200107142742.GN14821@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200107142742.GN14821@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001080074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:27:42PM +0000, Lee Jones wrote:
> On Mon, 06 Jan 2020, Charles Keepax wrote:
> 
> > Both manual and power on resets have a brief period where the chip will
> > not be accessible immediately afterwards. Extend the time allowed for
> > this from a minimum of 1mS to 2mS based on newer evaluation of the
> > hardware and ensure this reset happens in all reset conditions. Whilst
> > making the change also remove the redundant NULL checks in the reset
> > functions as the GPIO functions already check for this.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/mfd/madera-core.c | 18 ++++++++++--------
> >  1 file changed, 10 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
> > index a8cfadc1fc01e..f41ce408259fb 100644
> > --- a/drivers/mfd/madera-core.c
> > +++ b/drivers/mfd/madera-core.c
> > @@ -238,6 +238,11 @@ static int madera_wait_for_boot(struct madera *madera)
> >  	return ret;
> >  }
> >  
> > +static inline void madera_reset_delay(void)
> > +{
> > +	usleep_range(2000, 3000);
> > +}
> 
> Hmm ... We usually shy away from abstraction for the sake of
> abstraction.  What's preventing you from using the preferred method of
> simply calling the abstracted function from each of the call-sites?
> 
> I could understand (a little) if you needed to frequently change these
> values, since changing them in once place is obviously simpler than
> changing them in 3, but even then it's marginal.
> 

I don't mind manually inline it, we don't plan on changing the
values very often certainly. It really was just to avoid future
bugs if someone adds a new place that needs the delay or does
indeed change the delay. Would you mind if I used a define for
the time instead, if I am manually inlining? That keeps the same
single place to update, but without the extra function.

Thanks,
Charles
