Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1132C31E40
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78BAE20B1F
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 11:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="An+K5eaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbfHFLx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 07:53:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50690 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfHFLx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 07:53:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76BdYZI188043;
        Tue, 6 Aug 2019 11:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=owLXiqktrM00YzMKT+B/Oi/Ts6nHaTvaxCYeIhR23nM=;
 b=An+K5eaQPLFGr/w6URupkufgy4qM97Etr+/eGePkK8Uz9aWqiI/FVRY245pQy5iRGNSQ
 cT9KpS1ICtrZc9b3g4mP3Cc2vTREpD/wIHVW4kID7g+B4Ml9MnIWx9ubrv58ADL0pF/4
 g8puGXT13BKvg5lxFnFB+PvZsDUxOVzOWdzC9Bs7/aIFSgz5K31o0RVb9nmTEnxjvlvP
 ONNGVcv5pVQzFIa83tXSNCR7wT8PLsSgl0b2hpcY5xYLQC25dzTugOSb4hpFsldCTJP4
 2Pnmhz7DNTUxloq2k0VOkqgoPCz4ZoVXQMHoS5WDDA6WTh6VwnBEKcbcPNOKSA9BfB0M zw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2u52wr5kfa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 11:53:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x76BcEYx055575;
        Tue, 6 Aug 2019 11:53:16 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2u7576xe45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Aug 2019 11:53:16 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x76BrEb9008513;
        Tue, 6 Aug 2019 11:53:14 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Aug 2019 04:53:13 -0700
Date:   Tue, 6 Aug 2019 14:53:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] rtl8712: rtl871x_ioctl_linux.c: fix unnecessary typecast
Message-ID: <20190806115305.GF1974@kadam>
References: <20190806013329.28574-1-joseespiriki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190806013329.28574-1-joseespiriki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908060119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9340 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908060119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 10:33:29PM -0300, Jose Carlos Cazarin Filho wrote:
> Fix checkpath warning:
> WARNING: Unnecessary typecast of c90 int constant
> 
> Signed-off-by: Jose Carlos Cazarin Filho <joseespiriki@gmail.com>
> ---
>  Hello all!
>  This is my first commit to the Linux Kernel, I'm doing this to learn and be able
>  to contribute more in the future
>  Peace all! 
>  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> index 944336e0d..da371072e 100644
> --- a/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> +++ b/drivers/staging/rtl8712/rtl871x_ioctl_linux.c
> @@ -665,8 +665,8 @@ static int r8711_wx_set_freq(struct net_device *dev,
>  
>  /* If setting by frequency, convert to a channel */
>  	if ((fwrq->e == 1) &&
> -	  (fwrq->m >= (int) 2.412e8) &&
> -	  (fwrq->m <= (int) 2.487e8)) {
> +	  (fwrq->m >= 2.412e8) &&
> +	  (fwrq->m <= 2.487e8)) {

I don't think we can do this.  You're not allowed to use floats in the
kernel (because they make context switching slow).  I could have sworn
that we use the -nofp to stop the compile when people use floats but
this compiles fine for me.

regards,
dan carpenter

