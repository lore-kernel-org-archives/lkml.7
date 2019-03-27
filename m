Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A36C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C74A92087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 11:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NKBokYG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfC0L7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 07:59:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51868 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfC0L7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 07:59:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2RBwh0X134577;
        Wed, 27 Mar 2019 11:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=VFWKFuSwLV/4A6SoUjdbQFm8al6ndpn+nV25n+zRhkE=;
 b=NKBokYG3blLVTERw6vVi8ztQPZXCo/zsJy0KBkR0woPvVAfiB7BiUrY9EQe7n0q94JuA
 0zZwaRqqivWvjNJGXA8AqIK7dD/Cha8MGC++le5VPo0fiFw/KpPUddn1xggplSSDxbWd
 5iu1iC0gxRQ+hNmszqisgeP1c8O4zB2ku1il8DReVZlWeDFQLMH+C/lgL7UX99TZbIkB
 IMLImTpF4kEVwER0/2R9WBnatOdNPSaXRtHxFx+Jkzz5/Yi2U60zJOzz21NS2neb5LGh
 sD1hiYnEpbW2jjuHawUPQX3Zy75xpGvYjrgOEEERG0a46QDJf47zWbZzBE26pyJHMdcW 8w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2re6djg33r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 11:59:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2RBxUGO011580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 11:59:30 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2RBxT1s011980;
        Wed, 27 Mar 2019 11:59:29 GMT
Received: from kadam (/197.157.0.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Mar 2019 04:59:28 -0700
Date:   Wed, 27 Mar 2019 14:59:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sidong Yang <realwakka@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: Fix rf69_set_tx_cfg() logic
Message-ID: <20190327115811.GE32590@kadam>
References: <20190327081120.11152-1-realwakka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190327081120.11152-1-realwakka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9207 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903270086
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 08:11:20AM +0000, Sidong Yang wrote:
> Moved code to configure sync to where check enable_sync option before.
> There is no need to check enable_sync twice. Configuring sync should be
> executed immediately after enabling sync.
> 
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  drivers/staging/pi433/pi433_if.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
> index 53928af696a6..0a48d6cb9547 100644
> --- a/drivers/staging/pi433/pi433_if.c
> +++ b/drivers/staging/pi433/pi433_if.c
> @@ -318,10 +318,17 @@ rf69_set_tx_cfg(struct pi433_device *dev, struct pi433_tx_cfg *tx_cfg)
>  			return ret;
>  	}
>  
> +	/* configure sync, if enabled */

This comment is obvious.  Just delete it.

>  	if (tx_cfg->enable_sync == OPTION_ON) {
>  		ret = rf69_enable_sync(dev->spi);
>  		if (ret < 0)
>  			return ret;
> +		ret = rf69_set_sync_size(dev->spi, tx_cfg->sync_length);
> +		if (ret < 0)
> +			return ret;
> +		ret = rf69_set_sync_values(dev->spi, tx_cfg->sync_pattern);
> +		if (ret < 0)
> +			return ret;

It's weird that we enable sync before we et the size or sync values...

regards,
dan carpenter

