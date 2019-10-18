Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44159CA9EC8
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 181A821D7C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 00:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bqC9SYp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503797AbfJRAIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 20:08:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59458 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438886AbfJRAIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 20:08:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I050fh024871;
        Fri, 18 Oct 2019 00:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=HqJmjZeEPYQc4b+zatsyRP/aFQKXc1pGuXSI4rzI+RM=;
 b=bqC9SYp1Q13qSbHd5NIYepo5THNptc+6Vci6usz68tvsToKUJMQKMDUK28VufIRJl2pN
 /soAfQBuy++7bHUJ6yCxAO5vfcPjcoVnsgV1ZdnoAivKFEeN0ls9bli8GJTjjimQgBTS
 9GsOMgQid7bwlydfrcfr+yFUgOoyrH+Y3KXPnrVqo9+kbm9tcCV1j2rzkcUN89N1w0H0
 euo0fev1ma1udu6zcK4smSL2HgIKnDZEnsXxT270uKFYSqwoXx/pW28m2QRtCp4aAWaX
 cCIIvHtnUobDvy8UbV/1VvQOemrda4kR6ItwwjJn9D4GWB9BLQt2t5e4dHkeCcHKU8cb Pw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2vq0q40cq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 00:08:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9I08Gpq109303;
        Fri, 18 Oct 2019 00:08:24 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2vq0dwpea7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 00:08:24 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9I08MmN016450;
        Fri, 18 Oct 2019 00:08:22 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Oct 2019 00:08:22 +0000
Subject: Re: [PATCH] hugetlbfs: fix error handling in init_hugetlbfs_fs()
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191017103822.8610-1-cgxu519@mykernel.net>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ccfddf19-630f-ad38-68b3-16003e740113@oracle.com>
Date:   Thu, 17 Oct 2019 17:08:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191017103822.8610-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910180000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9413 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910170214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc: David
On 10/17/19 3:38 AM, Chengguang Xu wrote:
> In order to avoid using incorrect mnt, we should set
> mnt to NULL when we get error from mount_one_hugetlbfs().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
> ---
>  fs/hugetlbfs/inode.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index a478df035651..427d845e7706 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1470,9 +1470,12 @@ static int __init init_hugetlbfs_fs(void)
>  	i = 0;
>  	for_each_hstate(h) {
>  		mnt = mount_one_hugetlbfs(h);
> -		if (IS_ERR(mnt) && i == 0) {
> -			error = PTR_ERR(mnt);
> -			goto out;
> +		if (IS_ERR(mnt)) {
> +			if (i == 0) {
> +				error = PTR_ERR(mnt);
> +				goto out;
> +			}
> +			mnt = NULL;
>  		}
>  		hugetlbfs_vfsmount[i] = mnt;
>  		i++;

Thanks!

That should be fixed.  It was introduced with commit 32021982a324 ("hugetlbfs:
Convert to fs_context").  

That commit also changed the condition for which init_hugetlbfs_fs() would
'error' and remove the inode cache.  Previously, it would do that if there
was an error creating a mount for the default_hstate_idx hstate.  It now does
that for the '0' hstate, and 0 is not always equal to default_hstate_idx.

David was that intentional or an oversight?  I can fix up, just wanted to
make sure there was not some reason for the change.

-- 
Mike Kravetz
