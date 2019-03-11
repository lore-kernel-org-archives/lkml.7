Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DC2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96A6205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zTkFa9QA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbfCKRMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:12:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfCKRMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:12:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2BH3dTk114781;
        Mon, 11 Mar 2019 17:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=vAw2Ni0hsorzbpiuWPxTumSrl8r5Pf2nz6NOWAcSetM=;
 b=zTkFa9QAHBeuss380D1KdCVZPihfe+XgCHWkE5UqWG6aV78sgAX6Lcc42zZGroeL1q2D
 +9shWyb5hi0vYg3CY5CrwPQbEJhVqM5V2MpyJ3cg6ONXd7S0k9HNEy1fklLlv4y8iUpj
 M4UKGeXSwSuuKn0Y3YYSl0F3reygzulggeSe5UVQ/fM/LgkZLal0wiMafeWIs1Y2NDo3
 QwVtDih0gabtVEcE1y6JlroD4C6955zFnb0AprvGKClXMCxt5sXWH3RgmaHQQgTxZRg2
 CUkdX1DXaEwDihXfYtcC/B0CqKTf6/b1o70aNzcH5+idH06+ydGD3DoaQ9sdqvlkXsKb Rg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2r44wtyts7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 17:12:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2BHC9Y9004956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Mar 2019 17:12:09 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2BHC9fB022101;
        Mon, 11 Mar 2019 17:12:09 GMT
Received: from [192.168.1.226] (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 10:12:09 -0700
Subject: Re: [PATCH 2/2] xfs: clean up xfs_dir2_leaf_addname
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
References: <20190311161948.GC4359@magnolia> <20190311162232.GD4359@magnolia>
From:   Allison Henderson <allison.henderson@oracle.com>
Message-ID: <b8f9eb73-f29e-9df1-f885-a630cee01e0c@oracle.com>
Date:   Mon, 11 Mar 2019 10:12:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311162232.GD4359@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903110122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok to me.  Thanks for the clean up.

Reviewed-by: Allison Henderson <allison.henderson@oracle.com>

On 3/11/19 9:22 AM, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Remove typedefs and consolidate local variable initialization.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> ---
>   fs/xfs/libxfs/xfs_dir2_leaf.c |   33 +++++++++++++++------------------
>   1 file changed, 15 insertions(+), 18 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_dir2_leaf.c b/fs/xfs/libxfs/xfs_dir2_leaf.c
> index 2abf945e5844..9c2a0a13ed61 100644
> --- a/fs/xfs/libxfs/xfs_dir2_leaf.c
> +++ b/fs/xfs/libxfs/xfs_dir2_leaf.c
> @@ -563,43 +563,40 @@ xfs_dir3_leaf_find_entry(
>    */
>   int						/* error */
>   xfs_dir2_leaf_addname(
> -	xfs_da_args_t		*args)		/* operation arguments */
> +	struct xfs_da_args	*args)		/* operation arguments */
>   {
> +	struct xfs_dir3_icleaf_hdr leafhdr;
> +	struct xfs_trans	*tp = args->trans;
>   	__be16			*bestsp;	/* freespace table in leaf */
> -	int			compact;	/* need to compact leaves */
> -	xfs_dir2_data_hdr_t	*hdr;		/* data block header */
> +	__be16			*tagp;		/* end of data entry */
>   	struct xfs_buf		*dbp;		/* data block buffer */
> -	xfs_dir2_data_entry_t	*dep;		/* data block entry */
> -	xfs_inode_t		*dp;		/* incore directory inode */
> -	xfs_dir2_data_unused_t	*dup;		/* data unused entry */
> +	struct xfs_buf		*lbp;		/* leaf's buffer */
> +	struct xfs_dir2_leaf	*leaf;		/* leaf structure */
> +	struct xfs_inode	*dp = args->dp;	/* incore directory inode */
> +	struct xfs_dir2_data_hdr *hdr;		/* data block header */
> +	struct xfs_dir2_data_entry *dep;	/* data block entry */
> +	struct xfs_dir2_leaf_entry *lep;	/* leaf entry table pointer */
> +	struct xfs_dir2_leaf_entry *ents;
> +	struct xfs_dir2_data_unused *dup;	/* data unused entry */
> +	struct xfs_dir2_leaf_tail *ltp;		/* leaf tail pointer */
> +	struct xfs_dir2_data_free *bf;		/* bestfree table */
> +	int			compact;	/* need to compact leaves */
>   	int			error;		/* error return value */
>   	int			grown;		/* allocated new data block */
>   	int			highstale = 0;	/* index of next stale leaf */
>   	int			i;		/* temporary, index */
>   	int			index;		/* leaf table position */
> -	struct xfs_buf		*lbp;		/* leaf's buffer */
> -	xfs_dir2_leaf_t		*leaf;		/* leaf structure */
>   	int			length;		/* length of new entry */
> -	xfs_dir2_leaf_entry_t	*lep;		/* leaf entry table pointer */
>   	int			lfloglow;	/* low leaf logging index */
>   	int			lfloghigh;	/* high leaf logging index */
>   	int			lowstale = 0;	/* index of prev stale leaf */
> -	xfs_dir2_leaf_tail_t	*ltp;		/* leaf tail pointer */
>   	int			needbytes;	/* leaf block bytes needed */
>   	int			needlog;	/* need to log data header */
>   	int			needscan;	/* need to rescan data free */
> -	__be16			*tagp;		/* end of data entry */
> -	xfs_trans_t		*tp;		/* transaction pointer */
>   	xfs_dir2_db_t		use_block;	/* data block number */
> -	struct xfs_dir2_data_free *bf;		/* bestfree table */
> -	struct xfs_dir2_leaf_entry *ents;
> -	struct xfs_dir3_icleaf_hdr leafhdr;
>   
>   	trace_xfs_dir2_leaf_addname(args);
>   
> -	dp = args->dp;
> -	tp = args->trans;
> -
>   	error = xfs_dir3_leaf_read(tp, dp, args->geo->leafblk, -1, &lbp);
>   	if (error)
>   		return error;
> 
