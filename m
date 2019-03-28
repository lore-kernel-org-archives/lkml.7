Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1811E2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RunNMqM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbfC1Xra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:47:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbfC1Xra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:47:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2SNiccZ133406;
        Thu, 28 Mar 2019 23:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2018-07-02; bh=YKhHIoTYyJM/435yIx1s2AWNgwh6kvVxpU1hFFuHow4=;
 b=RunNMqM53f2PTc1aTaL863HSzFU5Y20yO6WA/b5ENbcYKGy6uL/Mk11FCpzOzmQbBkRz
 UHsoR0QGvMuLX1VdKwBoGleRvWf9U2++d0SDNEn6HXQsPBMVaI5sZeowoST/a0P38ZwT
 nhE0iL9guZ0GLI+6UztwknnSg4NAou4PcEDTOCTi9KF7NCOaoUDLTjl1wsB2A+g9EIDU
 SWi2yPpYdU+SjWeB01HY8PY/9jsboYWxeHQgOS9JNGaeJlLnN44kLR0b9wzWLaByA8B7
 LgvWo48KbhGmEMTUNPBocd2uxXB+1NqgXEmAVHXFzFpvLSP17iotEADPRLJ9i2+WA+yd jg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2re6djsmec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 23:47:20 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2SNlIZL015595
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 23:47:18 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2SNlEpm015975;
        Thu, 28 Mar 2019 23:47:15 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Mar 2019 16:47:14 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2 0/2] A couple hugetlbfs fixes
Date:   Thu, 28 Mar 2019 16:47:02 -0700
Message-Id: <20190328234704.27083-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9209 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=747 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903280154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I stumbled on these two hugetlbfs issues while looking at other things:
- The 'restore reserve' functionality at page free time should not
  be adjusting subpool counts.
- A BUG can be triggered (not easily) due to temporarily mapping a
  page before doing a COW.

Both are described in detail in the commit message of the patches.
I would appreciate comments from Davidlohr Bueso as one patch is
directly related to code he added in commit 8382d914ebf7.

I did not cc stable as the first problem has been around since reserves
were added to hugetlbfs and nobody has noticed.  The second is very hard
to hit/reproduce.

v2 - Update definition and all callers of hugetlb_fault_mutex_hash as
     the arguments mm and vma are no longer used or necessary.

Mike Kravetz (2):
  huegtlbfs: on restore reserve error path retain subpool reservation
  hugetlb: use same fault hash key for shared and private mappings

 fs/hugetlbfs/inode.c    |  7 ++-----
 include/linux/hugetlb.h |  4 +---
 mm/hugetlb.c            | 43 +++++++++++++++++++++--------------------
 mm/userfaultfd.c        |  3 +--
 4 files changed, 26 insertions(+), 31 deletions(-)

-- 
2.20.1

