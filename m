Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FE4C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536932082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 03:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HKJwsJ7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbfDIDlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 23:41:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38200 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbfDIDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 23:41:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x393dOtf162562;
        Tue, 9 Apr 2019 03:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=ONVtKo0uDdHdIhWczgt9AKJ2iNIIT0tFiKK9zof6icE=;
 b=HKJwsJ7gkohhHKcA/FaXhUbUP0rfPME9XZkOL9LhZBKyz0npRlAvrRNMhBSRyysIHvXB
 HVPY1FME6USRRe2N23BzB0ZWQhmsGX6/FVvb5bdY1ZkPYzgjJ6dWNqYXg+Q/6nZvL3KC
 rs6LJL2ek4V7z0Jdu9TkRjXqk9TOENnzuI4brKZX66Rt5CGdlr9/RHgzbX2WQ/7uyz9p
 mtP7csYtQl7HiF8PzmpcS8AdXRelnpEsLjyufai8y6vax7MJ2CB3VTdjLvNmoqcL20ms
 hSnzT8l6CzrW+sWo1C8LOJTCbKphLtIUGJVaGPOwKxnEJLQBPk9jbrYSpvHi6zXWpXOo Gg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2rpmrq253u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 03:41:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x393daBr004590;
        Tue, 9 Apr 2019 03:41:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2rpytbcq3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Apr 2019 03:41:03 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x393f1Rm000594;
        Tue, 9 Apr 2019 03:41:01 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 08 Apr 2019 20:41:01 -0700
Date:   Mon, 8 Apr 2019 20:41:00 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Hou Tao <houtao1@huawei.com>
Cc:     hirofumi@mail.parknet.co.jp, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fat: issue flush after the writeback of FAT
Message-ID: <20190409034100.GF1177@magnolia>
References: <20190409030158.136316-1-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409030158.136316-1-houtao1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=974
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904090024
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9221 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=997 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904090024
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 11:01:58AM +0800, Hou Tao wrote:
> fsync() needs to make sure the data & meta-data of file are persistent
> after the return of fsync(), even when a power-failure occurs later.
> In the case of fat-fs, the FAT belongs to the meta-data of file,
> so we need to issue a flush after the writeback of FAT instead before.
> 
> Also bail out early when any stage of fsync fails.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  fs/fat/file.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/fat/file.c b/fs/fat/file.c
> index b3bed32946b1..0e3ed79fcc3f 100644
> --- a/fs/fat/file.c
> +++ b/fs/fat/file.c
> @@ -193,12 +193,17 @@ static int fat_file_release(struct inode *inode, struct file *filp)
>  int fat_file_fsync(struct file *filp, loff_t start, loff_t end, int datasync)
>  {
>  	struct inode *inode = filp->f_mapping->host;
> -	int res, err;
> +	int err;
> +
> +	err = __generic_file_fsync(filp, start, end, datasync);
> +	if (err)
> +		return err;
>  
> -	res = generic_file_fsync(filp, start, end, datasync);
>  	err = sync_mapping_buffers(MSDOS_SB(inode->i_sb)->fat_inode->i_mapping);

Huh.  I would've thought that flushing the FAT would also be required
at the end of a WB_SYNC_ALL (aka data integrity) writepages call?

The patch itself seems good, though.

--D

> +	if (err)
> +		return err;
>  
> -	return res ? res : err;
> +	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
>  }
>  
>  
> -- 
> 2.16.2.dirty
> 
