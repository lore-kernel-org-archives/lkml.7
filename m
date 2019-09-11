Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182DAECDE20
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD1F21928
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 09:17:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PpOdGDMl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfIKJRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:17:33 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfIKJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 05:17:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B99LT8057317;
        Wed, 11 Sep 2019 09:17:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2019-08-05;
 bh=zrFAZD9A5dGz2+B318YMzx/6IL2OQM9UN9vWaQkSluw=;
 b=PpOdGDMl3XXCdBFHPow6gWL+3GVNU2Y8XwCJCRLXbh7+jqCTJhDdevSYFf4sP+jCNCGX
 PZl8yhYY11j/KBwnkY1MxfB4YtsKv7t4mPTDkjeHoXR/BIYLI3oAF3l9uUpvlAKVUK1D
 QvvAgcPw/kfQP8kcrMRRC8YopU2+AL/GsLrxjylo0BFloYWxC/8FCsZ5Z72DRXJuyKoX
 3wkxBlDS/9LOUNLD+TxxE++CDkkDHhCaSPFwyr5jLatFNDeYZFIt933Kk3BvoBZ0/PSa
 OvYrIFcgw3/BClJcJ6U/SbR2LxMVuaO/SB35DkvjRT34dhXCq0UzPZgfnRdecjpCnyDY 6A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2uw1jy8mbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 09:17:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B999YH069125;
        Wed, 11 Sep 2019 09:17:10 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2uxj88k493-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 09:17:10 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8B9H8CA012840;
        Wed, 11 Sep 2019 09:17:09 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 02:17:08 -0700
Date:   Wed, 11 Sep 2019 12:16:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        davem@davemloft.net, linux-kernel@vger.kernel.org,
        aaro.koskinen@iki.fi
Subject: Re: [PATCH] Staging: octeon: Avoid several usecases of strcpy
Message-ID: <20190911091659.GI15977@kadam>
References: <20190911084956.GH15977@kadam>
 <39D8B984-479C-42D5-8431-9FF7BD3A96D6@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39D8B984-479C-42D5-8431-9FF7BD3A96D6@volery.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110088
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 11:04:38AM +0200, Sandro Volery wrote:
> 
> 
> > On 11 Sep 2019, at 10:52, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > ﻿On Wed, Sep 11, 2019 at 08:23:59AM +0200, Sandro Volery wrote:
> >> strcpy was used multiple times in strcpy to write into dev->name.
> >> I replaced them with strscpy.
> >> 
> >> Signed-off-by: Sandro Volery <sandro@volery.com>
> >> ---
> >> drivers/staging/octeon/ethernet.c | 16 ++++++++--------
> >> 1 file changed, 8 insertions(+), 8 deletions(-)
> >> 
> >> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> >> index 8889494adf1f..cf8e9a23ebf9 100644
> >> --- a/drivers/staging/octeon/ethernet.c
> >> +++ b/drivers/staging/octeon/ethernet.c
> >> @@ -784,7 +784,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
> >>            priv->imode = CVMX_HELPER_INTERFACE_MODE_DISABLED;
> >>            priv->port = CVMX_PIP_NUM_INPUT_PORTS;
> >>            priv->queue = -1;
> >> -            strcpy(dev->name, "pow%d");
> >> +            strscpy(dev->name, "pow%d", sizeof(dev->name));
> > 
> > Is there a program which is generating a warning for this code?  We know
> > that "pow%d" is 6 characters and static analysis tools can understand
> > this code fine so we know it's safe.
> 
> Well I was confused too but checkpatch complained about 
> it so I figured I'd clean it up quick

Ah.  It's a new checkpatch warning.  I don't care in that case.  I'm
fine with replacing all of these in that case.

regards,
dan carpenter

