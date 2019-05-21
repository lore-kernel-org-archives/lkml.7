Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE959C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAC702075E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:13:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vbLZCEXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfEUPNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:13:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:35980 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfEUPNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:13:12 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LF1pIG100322;
        Tue, 21 May 2019 15:13:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=iO87e8oapsoYBD3zmv3BtHcDp0cXYi516sKUqZMvPys=;
 b=vbLZCEXGMm5UNDj4qRSgu28oVsptVtrdFpa5OHgJ5PLPFjEtl5CrsoUu5+w2g1hH1S63
 dyi10F/801xUQ514nWbHn7MwsVhyytAV72cqXevdoLnyJZrgWICVuxVhLg2oRx5VwEfQ
 sM5hpShJRVSiJbVlPb9d+TeeENsRHbVAmwXSZxPb6tH6++cufZg0a/7fYy7DV/DHqMlM
 9s+xU9bH97oCbwpGkm+Th8b3UXR5rHD89QXLdS8juFFQjbUSb4FUSYOYJ0m5aPAlW6AV
 HavjjsV4uRE/yArWHiYC6QqROJmit91lsAnvsPKZPHPEHlZ1+yk/QoyWsfmwYZpNtqzl BA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2sj7jdpadn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:13:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4LFA3ft126309;
        Tue, 21 May 2019 15:11:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2sm0471jqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 15:11:06 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4LFB6HG032315;
        Tue, 21 May 2019 15:11:06 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 15:11:06 +0000
Date:   Tue, 21 May 2019 18:10:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: fieldbus: anybuss: force address space
 conversion
Message-ID: <20190521151059.GM31203@kadam>
References: <20190521145116.24378-1-TheSven73@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521145116.24378-1-TheSven73@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210094
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9264 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:51:16AM -0400, Sven Van Asbroeck wrote:
> The regmap's context (stored as 'void *') consists of a pointer to
> __iomem. Mixing __iomem and non-__iomem addresses generates
> sparse warnings.
> 
> Fix by using __force when converting to/from 'void __iomem *' and
> the regmap's context.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>  drivers/staging/fieldbus/anybuss/arcx-anybus.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> index a167fb68e355..8126e5535ada 100644
> --- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> +++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
> @@ -114,7 +114,7 @@ static void export_reset_1(struct device *dev, bool assert)
>  static int read_reg_bus(void *context, unsigned int reg,
>  			unsigned int *val)
>  {
> -	void __iomem *base = context;
> +	void __iomem *base = (__force void __iomem *)context;


There is no need to use __force.  Just:

	void __iomem *base = (void __iomem *)context;

For the rest as well.

regards,
dan carpenter

