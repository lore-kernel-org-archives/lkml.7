Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85585ECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 566BC21A4C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L2GBadGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfIKIwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:52:25 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46568 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfIKIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:52:25 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B8meLM097263;
        Wed, 11 Sep 2019 08:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=9q4LtJAqv0F0QoJlz3XTDUNIJczhe+LxSRL/PZPmYSg=;
 b=L2GBadGJQHoW78Jp6NDSKabKAFE/p2MummzFJ94mxtzDuql2oH4YNTSUwd4MzC96NUP3
 0GBIwotwBC7xFfWfVhxKvIxBoLN8NPxuScODyS4gRaC6MZlOomnOy8aASOufMcIEfipJ
 XKMYPQmGMJ85p+5CBOucLss/TZbme5Xca/azhLHaJKYWA2y76aGsxht4OXpJtyuFlVol
 yB/pVmolTI5H5uQkC/SrDaXqKD+lWqGXQhfdPnvnZwuKYyveuu6LdOGOx6315AIVS8OA
 akOkDfmUFtm9OOgr6OI/vj0ftm9Ntz3wedlB20vCzC4tmXwsbC+r9aWqIdj9G17Eiwmo uQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2uw1m90hyu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 08:52:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8B8m5Ng025016;
        Wed, 11 Sep 2019 08:50:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2uxk0t0gy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 08:50:13 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x8B8o423027882;
        Wed, 11 Sep 2019 08:50:05 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 01:50:04 -0700
Date:   Wed, 11 Sep 2019 11:49:56 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        aaro.koskinen@iki.fi, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: octeon: Avoid several usecases of strcpy
Message-ID: <20190911084956.GH15977@kadam>
References: <20190911062359.GA14886@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911062359.GA14886@volery>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 08:23:59AM +0200, Sandro Volery wrote:
> strcpy was used multiple times in strcpy to write into dev->name.
> I replaced them with strscpy.
> 
> Signed-off-by: Sandro Volery <sandro@volery.com>
> ---
>  drivers/staging/octeon/ethernet.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/octeon/ethernet.c b/drivers/staging/octeon/ethernet.c
> index 8889494adf1f..cf8e9a23ebf9 100644
> --- a/drivers/staging/octeon/ethernet.c
> +++ b/drivers/staging/octeon/ethernet.c
> @@ -784,7 +784,7 @@ static int cvm_oct_probe(struct platform_device *pdev)
>  			priv->imode = CVMX_HELPER_INTERFACE_MODE_DISABLED;
>  			priv->port = CVMX_PIP_NUM_INPUT_PORTS;
>  			priv->queue = -1;
> -			strcpy(dev->name, "pow%d");
> +			strscpy(dev->name, "pow%d", sizeof(dev->name));

Is there a program which is generating a warning for this code?  We know
that "pow%d" is 6 characters and static analysis tools can understand
this code fine so we know it's safe.

regards,
dan carpenter

