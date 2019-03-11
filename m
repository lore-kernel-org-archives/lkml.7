Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB6EC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B71205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iVVVaavH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfCKRLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:11:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40158 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbfCKRLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:11:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BH3gUh117999;
        Mon, 11 Mar 2019 17:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=RUwN8crUDWWKnyy7eddzKF3aCyfFvgmloar1B4ESAXs=;
 b=iVVVaavHdcM9Q4ZrnZLVGV+cD7ciIwZo6D+0uGdX4Gjz5ZjiVZy/VVqsTpttAO3nY5u+
 bKXMeOlQ1Vh+0a6QLsxGLizpBmygK4k+vZcfw4tv4JKhJUEjQHrznJBzMnXhGDBD4ZGY
 FhhI9/vTv3qWXhgXTc0kPvLs5+SrAXqVxpN0vdnMva7MXgfa27zEneGUBiq0nlg9Eg07
 4WEtrpzjoX7nO3yc1OmM10aQcMnMRV0GgZjlflxKubtBF3FlAG75tFTttDtF7K0F7Ooj
 P22JU0b0L2DpVJELXP0TvByOTVFEKll45XNVCl9wrvZCNZIuyUp1vxNqZqwbYW1ngsM8 EQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2r464r7rep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 17:11:30 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2BHBU1r002976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 17:11:30 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2BHBT6f009498;
        Mon, 11 Mar 2019 17:11:29 GMT
Received: from [192.168.1.226] (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 10:11:29 -0700
Subject: Re: [PATCH 1/2] xfs: zero initialize highstale and lowstale in
 xfs_dir2_leaf_addname
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
References: <20190311161948.GC4359@magnolia>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <ca1be50b-7bc1-a797-b25b-02656357e95e@oracle.com>
Date:   Mon, 11 Mar 2019 10:11:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311161948.GC4359@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine.  You can add my review.  Thx!

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

On 3/11/19 9:19 AM, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Smatch complains about the following:
> 
> fs/xfs/libxfs/xfs_dir2_leaf.c:848 xfs_dir2_leaf_addname() error:
> uninitialized symbol 'lowstale'.
> 
> fs/xfs/libxfs/xfs_dir2_leaf.c:849 xfs_dir2_leaf_addname() error:
> uninitialized symbol 'highstale'.
> 
> I don't think there's any incorrect behavior associated with the
> uninitialized variable, but as the author of the previous zero-init
> patch points out, it's best not to be passing around pointers to
> uninitialized stack areas.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>   fs/xfs/libxfs/xfs_dir2_leaf.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_dir2_leaf.c b/fs/xfs/libxfs/xfs_dir2_leaf.c
> index 9a3767818c50..2abf945e5844 100644
> --- a/fs/xfs/libxfs/xfs_dir2_leaf.c
> +++ b/fs/xfs/libxfs/xfs_dir2_leaf.c
> @@ -574,7 +574,7 @@ xfs_dir2_leaf_addname(
>   	xfs_dir2_data_unused_t	*dup;		/* data unused entry */
>   	int			error;		/* error return value */
>   	int			grown;		/* allocated new data block */
> -	int			highstale;	/* index of next stale leaf */
> +	int			highstale = 0;	/* index of next stale leaf */
>   	int			i;		/* temporary, index */
>   	int			index;		/* leaf table position */
>   	struct xfs_buf		*lbp;		/* leaf's buffer */
> @@ -583,7 +583,7 @@ xfs_dir2_leaf_addname(
>   	xfs_dir2_leaf_entry_t	*lep;		/* leaf entry table pointer */
>   	int			lfloglow;	/* low leaf logging index */
>   	int			lfloghigh;	/* high leaf logging index */
> -	int			lowstale;	/* index of prev stale leaf */
> +	int			lowstale = 0;	/* index of prev stale leaf */
>   	xfs_dir2_leaf_tail_t	*ltp;		/* leaf tail pointer */
>   	int			needbytes;	/* leaf block bytes needed */
>   	int			needlog;	/* need to log data header */
> 
