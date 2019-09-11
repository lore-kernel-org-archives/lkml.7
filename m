Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD01C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C9F2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 12:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HOvJOWoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbfIKMwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 08:52:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38640 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfIKMwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 08:52:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BCdQjH098177;
        Wed, 11 Sep 2019 12:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=IQ1uaprAkhL6h68u4f8h/jNHwwMf2X0UUXwYuI2NQ48=;
 b=HOvJOWojd20Ghle9MviSjvqIEk7YDSBw48NAWGKVDnITpXEVfYFHPjnotFYnLRDUV7r7
 qIYVMH2bmrkH3QnZhclumNk4otMxA/tYEpbN36G8plYtr4Ks+muXs9UNVOOlXUujwp++
 XROT5UW8S+mGMUnCwuc5J9Um/Ie5Zjh2jbSo1bjdhcCLx9pqu3zWLnU0NOqh95ZNhSBW
 ali25taOUZx7P5gH7saZrHzrwyx3kyYJcRQ5AYGjirz7qfMRqy+OWeE2ERyUNf6+SaMs
 nZ+jXpnJ0YA40t5LRyHclPUFWhJ5EZGt5MvGnKvYftB+V51TpqTgDlND1vSFPhCxrFRk PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2uw1m91trx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 12:52:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x8BCiMKC171520;
        Wed, 11 Sep 2019 12:52:03 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2uxj88rfe6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Sep 2019 12:52:03 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x8BCq0Ok009037;
        Wed, 11 Sep 2019 12:52:01 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Sep 2019 05:52:00 -0700
Date:   Wed, 11 Sep 2019 15:51:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Sandro Volery <sandro@volery.com>
Cc:     valdis.kletnieks@vt.edu, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v3] Staging: exfat: Avoid use of strcpy
Message-ID: <20190911125154.GI20699@kadam>
References: <20190911124812.GA25324@volery>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911124812.GA25324@volery>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909110117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9376 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909110117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 02:48:12PM +0200, Sandro Volery wrote:
> Use strscpy instead of strcpy in exfat_core.c, and add a check
> for length that will return already known FFS_INVALIDPATH.
> 
> Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Signed-off-by: Sandro Volery <sandro@volery.com>
> ---
> v3: Fixed replacing mistake
> v2: Introduced length check
> v1: Original patch
>  drivers/staging/exfat/exfat_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
> index da8c58149c35..4c40f1352848 100644
> --- a/drivers/staging/exfat/exfat_core.c
> +++ b/drivers/staging/exfat/exfat_core.c
> @@ -2964,7 +2964,8 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
>  	if (strlen(path) >= (MAX_NAME_LENGTH * MAX_CHARSET_SIZE))
            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Get rid of this.

>  		return FFS_INVALIDPATH;
>  
> -	strcpy(name_buf, path);
> +	if (strscpy(name_buf, path, sizeof(name_buf)) < 0)
> +		return FFS_INVALIDPATH;

regards,
dan carpenter


