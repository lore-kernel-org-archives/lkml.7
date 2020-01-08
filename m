Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7703AC00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A2A206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="XCN6f8uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgAHImY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:42:24 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:5284 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726313AbgAHImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:42:23 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0088fDpq012604;
        Wed, 8 Jan 2020 02:42:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=lisIv/cYYX3/XbCnto9J4u5jwGUifUtblow0rZiTlcU=;
 b=XCN6f8uB2wDbFU9kd/K9t8s9VRSyCzUTNAdncVw+TmFENG3j6cUHjATN8GhyXky6S8A1
 iFntn33FgexHjd/vg9VFh/NGC9HQx5anREelhyspG/WIQHBwprA96Jj4IxkeCRdUM/U0
 FUOK58Hmzw6VCcTYJ5LS2NCsyjuN28QMQT+bfq17tsz5bVRPUcIoKUrdG4O8usVVZ9Ym
 Yq9dbWsiazjDadFKrCi8iIeTtjDNIv104fH9n9aar8InKBI1mnjISGoMHKqqVfhoYAu4
 eT2GblWHX0G6/6r+DJ/u8s1eZLy3oYVt8wrs6fl/knqWAwLIZUe0aH5WbWzs9AUjDIxl bg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
        by mx0a-001ae601.pphosted.com with ESMTP id 2xas06vw31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 08 Jan 2020 02:42:22 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Wed, 8 Jan
 2020 08:42:20 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Wed, 8 Jan 2020 08:42:20 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 40F7E2B1;
        Wed,  8 Jan 2020 08:42:20 +0000 (UTC)
Date:   Wed, 8 Jan 2020 08:42:20 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] mfd: madera: Wait for boot done before accessing any
 other registers
Message-ID: <20200108084220.GH10451@ediswmail.ad.cirrus.com>
References: <20200106102834.31301-1-ckeepax@opensource.cirrus.com>
 <20200106102834.31301-2-ckeepax@opensource.cirrus.com>
 <20200107142942.GO14821@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200107142942.GO14821@dell>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 mlxlogscore=802
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080074
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 02:29:42PM +0000, Lee Jones wrote:
> On Mon, 06 Jan 2020, Charles Keepax wrote:
> 
> > It is advised to wait for the boot done bit to be set before reading
> > any other register, update the driver to respect this.
> > 
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  drivers/mfd/madera-core.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> I'm assuming this patch is orthogonal to the last?
> 
> Can I take it on its own?
> 

Yeah these can be taken separately to the other series we are
waiting on Mark to review.

Thanks,
Charles

> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
