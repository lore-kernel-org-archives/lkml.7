Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F006CCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D3A2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 20:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZUYU7X1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfJ2UsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 16:48:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33888 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbfJ2UsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 16:48:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TKiW4O115974;
        Tue, 29 Oct 2019 20:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=pI3ti0ePmGZJmgoJvow9aItPjDGChrv+DSqwfVKgoOU=;
 b=ZUYU7X1LDu3k1Td4/HmXAjtE5shf0ZSFxtw1I9QgKjkkrrQdeI+h+pi5r0fncHDlKfRu
 DY2uCVSY5nwCiKkMUhH40iPEBjuSoM5U0ggGY8O5jnaWkv42KMGU/LfpKUNK7aAets2P
 2hXzix2oEGaCTS2y8EXKMAaYWGs+BgQLP9OTNyvHax28BLp5B6kXWvj3eOBxcG0i8spe
 heGo4+e0rYlKMOaTDNMXqUEd3oOxURXVV6mVFF76bRQqm+9dZR/T/+BRjsCciypuUo10
 wj8kB0OLPMyAnkSIfa+F6SHmH04XojpdVu8eVZNUc6uf3TcMtElcjd2wpK6Mi39m7KIh /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vvdjuc1jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 20:47:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TKhZgd177368;
        Tue, 29 Oct 2019 20:47:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vxpenx5w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 20:47:42 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9TKldLr021831;
        Tue, 29 Oct 2019 20:47:40 GMT
Received: from [192.168.1.222] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 13:47:39 -0700
Subject: Re: [PATCH] hugetlbfs: fix error handling in init_hugetlbfs_fs()
To:     cgxu519@mykernel.net
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20191017103822.8610-1-cgxu519@mykernel.net>
 <ba6cd4a4-a1cd-82c0-5ea1-5e20112f8f6b@oracle.com>
 <16e15cd0096.1068d5c9f40168.8315245997167313680@mykernel.net>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <94b6244d-2c24-e269-b12c-e3ba694b242d@oracle.com>
Date:   Tue, 29 Oct 2019 13:47:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <16e15cd0096.1068d5c9f40168.8315245997167313680@mykernel.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290180
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/19 9:36 PM, Chengguang Xu wrote:
>  ---- 在 星期二, 2019-10-29 05:27:01 Mike Kravetz <mike.kravetz@oracle.com> 撰写 ----
>  > Subject: [PATCH] mm/hugetlbfs: fix error handling when setting up mounts
>  > 
>  > It is assumed that the hugetlbfs_vfsmount[] array will contain
>  > either a valid vfsmount pointer or NULL for each hstate after
>  > initialization.  Changes made while converting to use fs_context
>  > broke this assumption.
>  > 
>  > Reported-by: Chengguang Xu <cgxu519@mykernel.net>
>  > Fixes: 32021982a324 ("hugetlbfs: Convert to fs_context")
>  > Cc: stable@vger.kernel.org
>  > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>  > ---
>  >  fs/hugetlbfs/inode.c | 10 ++++++----
>  >  1 file changed, 6 insertions(+), 4 deletions(-)
>  > 
>  > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>  > index a478df035651..178389209561 100644
>  > --- a/fs/hugetlbfs/inode.c
>  > +++ b/fs/hugetlbfs/inode.c
>  > @@ -1470,15 +1470,17 @@ static int __init init_hugetlbfs_fs(void)
>  >      i = 0;
>  >      for_each_hstate(h) {
>  >          mnt = mount_one_hugetlbfs(h);
>  > -        if (IS_ERR(mnt) && i == 0) {
>  > +        if (IS_ERR(mnt)) {
>  > +            hugetlbfs_vfsmount[i] = NULL;
>  >              error = PTR_ERR(mnt);
>  > -            goto out;
>  > +        } else {
>  > +            hugetlbfs_vfsmount[i] = mnt;
>  >          }
>  > -        hugetlbfs_vfsmount[i] = mnt;
>  >          i++;
>  >      }
>  >  
>  > -    return 0;
>  > +    if (hugetlbfs_vfsmount[default_hstate_idx] != NULL)
>  > +        return 0;
> 
> Maybe we should umount other non-null entries and release
> used inodes for safety in error case.

Yes, even the original code did not clean up properly in the case of
all mount errors.  This will explicitly mount the default_hstate_idx
hstate first.  Then, optionally mount other hstates.  It will make the
error handling and cleanup more explicit.

From 7291f1da0d494cb64f6d219943c59a02e6d4fca7 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Mon, 28 Oct 2019 14:08:42 -0700
Subject: [PATCH] mm/hugetlbfs: fix error handling when setting up mounts

It is assumed that the hugetlbfs_vfsmount[] array will contain
either a valid vfsmount pointer or NULL for each hstate after
initialization.  Changes made while converting to use fs_context
broke this assumption.

While fixing the hugetlbfs_vfsmount issue, it was discovered that
init_hugetlbfs_fs never did correctly clean up when encountering
a vfs mount error.

Reported-by: Chengguang Xu <cgxu519@mykernel.net>
Fixes: 32021982a324 ("hugetlbfs: Convert to fs_context")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 fs/hugetlbfs/inode.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a478df035651..26e3906c18fe 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1461,28 +1461,41 @@ static int __init init_hugetlbfs_fs(void)
 					sizeof(struct hugetlbfs_inode_info),
 					0, SLAB_ACCOUNT, init_once);
 	if (hugetlbfs_inode_cachep == NULL)
-		goto out2;
+		goto out;
 
 	error = register_filesystem(&hugetlbfs_fs_type);
 	if (error)
-		goto out;
+		goto out_free;
 
+	/* default hstate mount is required */
+	mnt = mount_one_hugetlbfs(&hstates[default_hstate_idx]);
+	if (IS_ERR(mnt)) {
+		error = PTR_ERR(mnt);
+		goto out_unreg;
+	}
+	hugetlbfs_vfsmount[default_hstate_idx] = mnt;
+
+	/* other hstates are optional */
 	i = 0;
 	for_each_hstate(h) {
+		if (i == default_hstate_idx)
+			continue;
+
 		mnt = mount_one_hugetlbfs(h);
-		if (IS_ERR(mnt) && i == 0) {
-			error = PTR_ERR(mnt);
-			goto out;
-		}
-		hugetlbfs_vfsmount[i] = mnt;
+		if (IS_ERR(mnt))
+			hugetlbfs_vfsmount[i] = NULL;
+		else
+			hugetlbfs_vfsmount[i] = mnt;
 		i++;
 	}
 
 	return 0;
 
- out:
+ out_unreg:
+	(void)unregister_filesystem(&hugetlbfs_fs_type);
+ out_free:
 	kmem_cache_destroy(hugetlbfs_inode_cachep);
- out2:
+ out:
 	return error;
 }
 fs_initcall(init_hugetlbfs_fs)
-- 
2.20.1


