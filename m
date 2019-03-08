Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 945922081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LXSg3pRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfCHWs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:48:56 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60692 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHWsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:48:55 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28Mhaic022226;
        Fri, 8 Mar 2019 22:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=3IApX+ff+PN7FBEvogPd9vgxa4QqAsqb3qIGJTQfIzQ=;
 b=LXSg3pRSyzoFxVwwJJj6ZyK/EgUfqoJe1+3eSW24zye2++DcnRnvgE2e3fChV8tR7Fo6
 kEUhAv775oyvS3cu0ertrbN9BJ/xm5/L0KnMnzvhv+/rhPlziEZZomryG+SqjQhCeiC5
 okqbFeviivTh/4zG5uIkZzTUgYlWXWxoxlJaZqKiUyK5TgJ2rE6+a9RgWCu+8Ya5qPgw
 NraN1d+71QYuq8X7TeNfszD4/X2CtV3ND7GaX3kseyfCXipJIIQc5hFkBCBZ86QvxVWw
 ZEW9R+hPfSROA3AQJtVKhOLUYO6Xg047jB6TXJ9eBrW8PTtsuEWrcXXyp/xbnt1Plfwf ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qyjfs2r3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 22:48:44 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x28MmhpL009210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 22:48:43 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x28Mmhrh027803;
        Fri, 8 Mar 2019 22:48:43 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 14:48:43 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/2] hugetlb: use same fault hash key for shared and private mappings
Date:   Fri,  8 Mar 2019 14:48:23 -0800
Message-Id: <20190308224823.15051-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190308224823.15051-1-mike.kravetz@oracle.com>
References: <20190308224823.15051-1-mike.kravetz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9189 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=734 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb uses a fault mutex hash table to prevent page faults of the
same pages concurrently.  The key for shared and private mappings is
different.  Shared keys off address_space and file index.  Private
keys off mm and virtual address.  Consider a private mappings of a
populated hugetlbfs file.  A write fault will first map the page from
the file and then do a COW to map a writable page.

Hugetlbfs hole punch uses the fault mutex to prevent mappings of file
pages.  It uses the address_space file index key.  However, private
mappings will use a different key and could temporarily map the file
page before COW.  This causes problems (BUG) for the hole punch code
as it expects the mutex to prevent additional uses/mappings of the page.

There seems to be another potential COW issue/race with this approach
of different private and shared keys as notes in commit 8382d914ebf7
("mm, hugetlb: improve page-fault scalability").

Since every hugetlb mapping (even anon and private) is actually a file
mapping, just use the address_space index key for all mappings.  This
results in potentially more hash collisions.  However, this should not
be the common case.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 64ef640126cd..0527732c71f0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3904,13 +3904,8 @@ u32 hugetlb_fault_mutex_hash(struct hstate *h, struct mm_struct *mm,
 	unsigned long key[2];
 	u32 hash;
 
-	if (vma->vm_flags & VM_SHARED) {
-		key[0] = (unsigned long) mapping;
-		key[1] = idx;
-	} else {
-		key[0] = (unsigned long) mm;
-		key[1] = address >> huge_page_shift(h);
-	}
+	key[0] = (unsigned long) mapping;
+	key[1] = idx;
 
 	hash = jhash2((u32 *)&key, sizeof(key)/sizeof(u32), 0);
 
-- 
2.17.2

