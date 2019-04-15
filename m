Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6816C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 816F520825
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 06:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z0anamEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfDOGgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 02:36:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58150 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfDOGgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 02:36:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F6YFNm146314;
        Mon, 15 Apr 2019 06:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=HBVN9Oew8CO3FlB07+eRsEriqJIP3A0g5gOqFa2y+s4=;
 b=Z0anamEPHhvDiVt/T1tBbe3bfwmP8v2UGcse/iEa8VcUMVupOE4hpsYbKXBYTBMlo6M3
 hlaikw6EwERERvd0jCz7L2OoNVX9nr/pfov0Adnc1wzKQtpa5S1vQQawepFSEoiqq0zq
 CMSqPyaUaLRS8p75F7HwHgY2yImnlrbM3q2TVLMJEwrOM04yD55UUGOQX5DCMyaMrOcz
 epm1bKgRcUZQOnWj93AfBx0XuIRAgQUjq7TkQI2pOQ5ZD0ppkF4ti2yOgkj8r2no3AVQ
 NNkXtHRbPmXVIikYucFlC3MEV8DpwAjeJ3dJR48dBVpjrBgxs5GakI9gxj1i8fP9o8P+ pg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2ru59cvtpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 06:35:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3F6WsAY085151;
        Mon, 15 Apr 2019 06:33:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ru4vsegd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Apr 2019 06:33:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x3F6XT6R024864;
        Mon, 15 Apr 2019 06:33:29 GMT
Received: from kadam (/197.157.0.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 14 Apr 2019 23:33:28 -0700
Date:   Mon, 15 Apr 2019 09:32:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: android: vsoc: fix copy_from_user overrun
Message-ID: <20190415063244.GM6095@kadam>
References: <20190414153726.25362-1-vincent.stehle@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190414153726.25362-1-vincent.stehle@laposte.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904150043
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9227 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904150044
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2019 at 05:37:26PM +0200, Vincent Stehlé wrote:
> The `np->permission' structure is smaller than the `np' structure but
> sizeof(*np) worth of data is copied in there. Fix the size passed to
> copy_from_user() to avoid overrun.
> 
> Fixes: 3d2ec9dcd5539d42 ("staging: Android: Add 'vsoc' driver for cuttlefish.")
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/android/vsoc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
> index 8a75bd27c4133..00a1ec7b91549 100644
> --- a/drivers/staging/android/vsoc.c
> +++ b/drivers/staging/android/vsoc.c
> @@ -259,7 +259,8 @@ do_create_fd_scoped_permission(struct vsoc_device_region *region_p,
>  	atomic_t *owner_ptr = NULL;
>  	struct vsoc_device_region *managed_region_p;
>  
> -	if (copy_from_user(&np->permission, &arg->perm, sizeof(*np)) ||
> +	if (copy_from_user(&np->permission,
> +			   &arg->perm, sizeof(np->permission)) ||

The original code was probably correct...  This is a common thing where
people use "&p->first_struct_member" to represent the whole struct.
It seems like kind of a horrible thing to do and I can't explain why
people do it, but they do...

regards,
dan carpenter

