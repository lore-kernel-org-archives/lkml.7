Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920B6CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF7020578
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 21:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LDp32IYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfJ1V1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 17:27:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55562 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ1V1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 17:27:22 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SLA8wS108048;
        Mon, 28 Oct 2019 21:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=PW9pf13B0pYFKcplz7rhY3fpsO99QodYsDktraAILi8=;
 b=LDp32IYaHeNpv+a0AVzfRNuLxCWY+8UWwn35oJoo6w7phQqfAQtODbigzHgzZnwwbMbD
 UTW5nJlF/JFAmDhyrENgxT8DzbQKUwbMIbzPoTkv+GWjbLUtx2CmlNNmrn8IDTEGSj+1
 3MSkAVsoDTl+kTsJTKaHzlQo7Rz3XfqIyY0QEmnvCogLpCWF6hWoyJ7eKt3LU9Xwqk3z
 mTaN2YGyWuqSaO1f9SCpO/YM4XywoTqSTsi1o815H09US63UuI1Jnf/QnBR06axRCC3k
 B00/H3j/5S4HiXMuQ3ZVpmE92GKQqzbb5qtoxYzaUwefiVMkSHWuKtQ2dzVWRVNzxmn/ Vw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vvdju4w80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 21:27:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9SLDCo5126307;
        Mon, 28 Oct 2019 21:27:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vw09gg7h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Oct 2019 21:27:05 +0000
Received: from abhmp0021.oracle.com (abhmp0021.oracle.com [141.146.116.27])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9SLR2E2008538;
        Mon, 28 Oct 2019 21:27:02 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Oct 2019 14:27:02 -0700
Subject: Re: [PATCH] hugetlbfs: fix error handling in init_hugetlbfs_fs()
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191017103822.8610-1-cgxu519@mykernel.net>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ba6cd4a4-a1cd-82c0-5ea1-5e20112f8f6b@oracle.com>
Date:   Mon, 28 Oct 2019 14:27:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017103822.8610-1-cgxu519@mykernel.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910280200
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9424 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910280200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/19 3:38 AM, Chengguang Xu wrote:
> In order to avoid using incorrect mnt, we should set
> mnt to NULL when we get error from mount_one_hugetlbfs().
> 
> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>

Thanks for noticing this issue.  As mentioned in a previous e-mail,
there are additional issues that need to be addressed.  This loop
needs to initialize entries in the hugetlbfs_vfsmount array for all
hstates.  How about this patch?

From 3144f0a9d18f1408e831fb3eb49a06636a11d902 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 28 Oct 2019 14:08:42 -0700
Subject: [PATCH] mm/hugetlbfs: fix error handling when setting up mounts

It is assumed that the hugetlbfs_vfsmount[] array will contain
either a valid vfsmount pointer or NULL for each hstate after
initialization.  Changes made while converting to use fs_context
broke this assumption.

Reported-by: Chengguang Xu <cgxu519@mykernel.net>
Fixes: 32021982a324 ("hugetlbfs: Convert to fs_context")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a478df035651..178389209561 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1470,15 +1470,17 @@ static int __init init_hugetlbfs_fs(void)
 	i = 0;
 	for_each_hstate(h) {
 		mnt = mount_one_hugetlbfs(h);
-		if (IS_ERR(mnt) && i == 0) {
+		if (IS_ERR(mnt)) {
+			hugetlbfs_vfsmount[i] = NULL;
 			error = PTR_ERR(mnt);
-			goto out;
+		} else {
+			hugetlbfs_vfsmount[i] = mnt;
 		}
-		hugetlbfs_vfsmount[i] = mnt;
 		i++;
 	}
 
-	return 0;
+	if (hugetlbfs_vfsmount[default_hstate_idx] != NULL)
+		return 0;
 
  out:
 	kmem_cache_destroy(hugetlbfs_inode_cachep);
-- 
2.20.1

