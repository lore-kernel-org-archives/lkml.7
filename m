Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 093D4C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A672084D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 11:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eZ3fntW5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbfIJL4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 07:56:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:54656 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbfIJL4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 07:56:18 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ABrjjQ183698;
        Tue, 10 Sep 2019 11:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=ivdH+jkLdC2yHvpK29OWsjhzVtybUeJgo5z2e3uXc10=;
 b=eZ3fntW5pgwadibllzOdiuvGQQ4GkoD+0OHfJnnreNWlKwq3gOohSS7YUY7NHvQYQ1M+
 mnlaQyYRl+dsrqCT7JVOOR6yDsE3lLuou5QTv8u9Eg/GjEIAKRCFeILeGQ7pb+H9K00D
 o8sB50Y2Y1mZAPMkTpC2zqwApR8ZZKRNdCYtCxlSOtxU4VJcrkqCDIN2kS0KDYnu8VSR
 Xv3v3WIddvK+fJRdWqGrFu32QnqMw08nwMzB6ZMEAVlILL8gIGa0SJjp/I2u4U5ebjYu
 2qUbqWhiqt1IN3INIQC3H7hQzUJ7yDFkJMf0R9elOBC9R2l6cy2Bk/ISympMW0GFlDKZ uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2uw1jy2u0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 11:56:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8ABsLD0060248;
        Tue, 10 Sep 2019 11:56:02 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2uwqktmp1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 11:56:02 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8ABu0GM028873;
        Tue, 10 Sep 2019 11:56:00 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Sep 2019 04:56:00 -0700
Date:   Tue, 10 Sep 2019 14:55:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Adam Zerella <adam.zerella@gmail.com>
Cc:     labbott@redhat.com, sumit.semwal@linaro.org,
        devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] staging: android: ion: Replace strncpy() for stracpy()
Message-ID: <20190910115550.GA15977@kadam>
References: <20190908043450.1078-1-adam.zerella@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190908043450.1078-1-adam.zerella@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909100119
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9375 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909100119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 02:34:50PM +1000, Adam Zerella wrote:
> Using strncpy() does not always terminate the destination string.
> stracpy() is a alternative function that does, by using this new
> function we will no longer need to insert a null separator.
> 
> Signed-off-by: Adam Zerella <adam.zerella@gmail.com>
> ---
>  drivers/staging/android/ion/ion.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/ion/ion.c
> index e6b1ca141b93..17901bd626be 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -433,8 +433,7 @@ static int ion_query_heaps(struct ion_heap_query *query)
>  	max_cnt = query->cnt;
>  
>  	plist_for_each_entry(heap, &dev->heaps, node) {
> -		strncpy(hdata.name, heap->name, MAX_HEAP_NAME);
> -		hdata.name[sizeof(hdata.name) - 1] = '\0';
> +		stracpy(hdata.name, heap->name, MAX_HEAP_NAME);

stracpy() only takes two arguments.  This doesn't compile.

regards,
dan carpenter

