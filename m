Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78273C5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1E72085A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 03:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SgA3ZPil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfGCDwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 23:52:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfGCDwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 23:52:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x633mvR6116181;
        Wed, 3 Jul 2019 03:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=Ca4UQt1E55oPG2rhDmdDwt1k10M1+5TaLsl7kVDIW58=;
 b=SgA3ZPil70nPLwGZjYH2GNn0vbdspEqI4BBeEO3aXWgVoaXtsvbSaVhDIMrd3JBUelHg
 ssxGJi6m+/6iQc26/2x3X+3dL6V6rJiHj9GWtm8ltTby0dNNgE4heVNnJKp5aCRT7hNb
 Q4MGjB3sOm/miieohpp3QDLhnyjtbRoK//aJVEuoWxjweMsNP8ioalqwYSrzRbCyimbO
 yAuh1ESZDpMF15w8Yb1iQxZQzjvp0IigrOSSBY8+nEMxxgrpkTV+qJmn8MN9t9s0yCBh
 lSn9jsBLiU5+POhqvzSW4ogxgdtitPyZg2Lmb6JlgkCb4Lz6Ga9EaXVRTMYAQXXXcaP2 Hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2te5tbpypc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 03:51:53 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x633lxqj071097;
        Wed, 3 Jul 2019 03:51:52 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2tebbk4f8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Jul 2019 03:51:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x633ppsg025995;
        Wed, 3 Jul 2019 03:51:51 GMT
Received: from [10.190.130.61] (/192.188.170.109)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 02 Jul 2019 20:51:51 -0700
Subject: Re: [PATCH -next] btrfs: remove set but not used variable 'offset'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     nborisov@suse.com, linux-kernel@vger.kernel.org
References: <20190702141521.48932-1-yuehaibing@huawei.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <98cd6f89-80f2-ee2c-aa07-6e06e424e79f@oracle.com>
Date:   Wed, 3 Jul 2019 11:51:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190702141521.48932-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907030046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9306 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/19 10:15 PM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> fs/btrfs/volumes.c: In function __btrfs_map_block:
> fs/btrfs/volumes.c:6023:6: warning:
>   variable offset set but not used [-Wunused-but-set-variable]
> 
> It is not used any more since commit 343abd1c0ca9 ("btrfs: Use
> btrfs_get_io_geometry appropriately")
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>


> ---
>   fs/btrfs/volumes.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index d1fd910..5d5a9ff 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6020,7 +6020,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   {
>   	struct extent_map *em;
>   	struct map_lookup *map;
> -	u64 offset;
>   	u64 stripe_offset;
>   	u64 stripe_nr;
>   	u64 stripe_len;
> @@ -6055,7 +6054,6 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
>   	map = em->map_lookup;
>   
>   	*length = geom.len;
> -	offset = geom.offset;
>   	stripe_len = geom.stripe_len;
>   	stripe_nr = geom.stripe_nr;
>   	stripe_offset = geom.stripe_offset;
> 

