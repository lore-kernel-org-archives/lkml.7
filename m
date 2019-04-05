Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAF8C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088D82146F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 20:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5XdNNIY5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfDEUxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 16:53:24 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41658 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfDEUxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 16:53:24 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35KiHo7076971;
        Fri, 5 Apr 2019 20:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=/wiGaL8KBO5La3rMfmp4c8G/b2nDVKkYa+pBxyh9Eb0=;
 b=5XdNNIY58aO95dxCQiR+tqMTIk+ySOS4jxOeyP9Ue+cwq3khfr51KM0aAO09AbLYsl7V
 ApW2UA5mIvl4y78DnGcYa6e7Hoya2na01hVXuqIVh5Ef1eUyMFUWx0Rt4HYwDqZCf/QR
 6ZnO4XJivOi82cKuSFiNUlR2OWELdlzGfax0bPsSUcT/xTjor/ysLugZLNLG2CXXR4YK
 ipAgKa0blUuTETGGErTEn+/EJa+4SClFzPdm3jKU2YXvfV9y5JqiZetA+D5PbNQ06Tig
 L1rG0PYYz3Q9zF66yMMo0Ao7OqiusJffUvYAXRxCfltpYSxUXZWjt1odo+VasjGUtTmZ TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2rj13qpwph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 20:53:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x35KqIOV023190;
        Fri, 5 Apr 2019 20:53:17 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2rp357tv2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Apr 2019 20:53:16 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x35KrFSg004231;
        Fri, 5 Apr 2019 20:53:15 GMT
Received: from kadam (/41.202.241.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 05 Apr 2019 13:53:14 -0700
Date:   Fri, 5 Apr 2019 23:53:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: greybus: Fix spinlock_t definition without
 comment
Message-ID: <20190405205304.GS32590@kadam>
References: <20190405200046.20600-1-madhumithabiw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405200046.20600-1-madhumithabiw@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=909
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904050138
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9218 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=942 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904050138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 03:00:46PM -0500, Madhumitha Prabakaran wrote:
> Fix spinlock_t definition without comment.
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/greybus/connection.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/connection.h b/drivers/staging/greybus/connection.h
> index 5ca3befc0636..0aedd246e94a 100644
> --- a/drivers/staging/greybus/connection.h
> +++ b/drivers/staging/greybus/connection.h
> @@ -47,7 +47,7 @@ struct gb_connection {
>  	unsigned long			flags;
>  
>  	struct mutex			mutex;
> -	spinlock_t			lock;
> +	spinlock_t			lock; /* Protect structure fields */
>  	enum gb_connection_state	state;

What does the mutex do then?  Why can't we just use the spinlock for
everything?

I did glance at the code and it wasn't immediately obvious to me.

regards,
dan carpenter

