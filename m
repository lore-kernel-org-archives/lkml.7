Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0723C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA84C2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q5N3qceQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732906AbfDXOzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:55:33 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36520 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbfDXOzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:55:32 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OEsQY1109685;
        Wed, 24 Apr 2019 14:55:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=fOabZzNNPbDPWxs/MtZBwO8yZbXdEKt/TCUa74zqlhI=;
 b=q5N3qceQzc1RXmCqj8Dc+tKvpJkEEDXmYsvLXC0SBwH0NP2xlwRi8XWriXpp0aBzmKwc
 qccDtyXYghCoCQvmlxpAVPgJP5aLMZaVT4VlDJiMJlimAPiIjmQcHMnFMnbUVGFqoQIQ
 EytfXFmB2CzE8UTmWGw4gm+lwYNbs+d2LXDmtb4uBYFrLciI6lZGqvx0Fl2qw9GBJ+ib
 GJTeCCnZU93fKEL7pHaGQ+p3iniaSdtK+SP5FkIxUdgqhPoNLwjRVbVjwrm8a3+3ZUqn
 wuBc0oa3SphHRD0mkrpil+EA/vtuHdPBjX1naiv+tdrB+/hT3Kph2HOasvIZxjLwVrTM dw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ryv2qauw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:55:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3OEsZ6B125625;
        Wed, 24 Apr 2019 14:55:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2s0fv3m76p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Apr 2019 14:55:22 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3OEtJPQ026396;
        Wed, 24 Apr 2019 14:55:20 GMT
Received: from kadam (/196.111.187.26)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 24 Apr 2019 07:55:19 -0700
Date:   Wed, 24 Apr 2019 17:55:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     gregkh@linuxfoundation.org, christian.gromm@microchip.com,
        colin.king@canonical.com, andrey.shvetsov@k2l.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: protect potential string overflow
Message-ID: <20190424145505.GE14798@kadam>
References: <20190423022018.12214-1-tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423022018.12214-1-tsu.yubo@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904240116
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9236 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904240116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 10:20:18PM -0400, Bo YU wrote:
> There maybe cause potential string overflow issue due to use
> strcpy without checking the length
> 
> Detected By CoversityScan CID# 1444760
> 
> Fixes: 131ac62253dba:(staging: most: core: use device description as name)

It doesn't really fix anything, it just silences a static checker
warning.

> Signed-off-by: Bo YU <tsu.yubo@gmail.com>
> ---
>  drivers/staging/most/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/most/core.c b/drivers/staging/most/core.c
> index 956daf8c3bd2..0f26cebac91a 100644
> --- a/drivers/staging/most/core.c
> +++ b/drivers/staging/most/core.c
> @@ -1431,7 +1431,7 @@ int most_register_interface(struct most_interface *iface)
>  
>  	INIT_LIST_HEAD(&iface->p->channel_list);
>  	iface->p->dev_id = id;
> -	strcpy(iface->p->name, iface->description);
> +	strlcpy(iface->p->name, iface->description, sizeof(iface->p->name));

We prefer strscpy() more than strlcpy() these days.

regards,
dan carpenter

