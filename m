Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E56AC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E17C2089E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:28:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfHAG21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:28:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726783AbfHAG21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:28:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x716SKgY186621
        for <linux-kernel@vger.kernel.org>; Thu, 1 Aug 2019 02:28:25 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u3rhb522u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 02:28:24 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 1 Aug 2019 07:28:21 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 1 Aug 2019 07:28:20 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x716S2GR39190790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Aug 2019 06:28:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75CAF11C050;
        Thu,  1 Aug 2019 06:28:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F54311C05C;
        Thu,  1 Aug 2019 06:28:18 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Aug 2019 06:28:18 +0000 (GMT)
Received: by rapoport-lnx (sSMTP sendmail emulation); Thu, 01 Aug 2019 09:28:17 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] mm/madvise: reduce code duplication in error handling paths
Date:   Thu,  1 Aug 2019 09:28:16 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 19080106-0028-0000-0000-00000389E300
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19080106-0029-0000-0000-0000244A3637
Message-Id: <1564640896-1210-1-git-send-email-rppt@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=505 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908010063
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The madvise_behavior() function converts -ENOMEM to -EAGAIN in several
places using identical code.

Move that code to a common error handling path.

No functional changes.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/madvise.c | 52 ++++++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 968df3a..55d78fd 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -105,28 +105,14 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	case MADV_MERGEABLE:
 	case MADV_UNMERGEABLE:
 		error = ksm_madvise(vma, start, end, behavior, &new_flags);
-		if (error) {
-			/*
-			 * madvise() returns EAGAIN if kernel resources, such as
-			 * slab, are temporarily unavailable.
-			 */
-			if (error == -ENOMEM)
-				error = -EAGAIN;
-			goto out;
-		}
+		if (error)
+			goto out_convert_errno;
 		break;
 	case MADV_HUGEPAGE:
 	case MADV_NOHUGEPAGE:
 		error = hugepage_madvise(vma, &new_flags, behavior);
-		if (error) {
-			/*
-			 * madvise() returns EAGAIN if kernel resources, such as
-			 * slab, are temporarily unavailable.
-			 */
-			if (error == -ENOMEM)
-				error = -EAGAIN;
-			goto out;
-		}
+		if (error)
+			goto out_convert_errno;
 		break;
 	}
 
@@ -152,15 +138,8 @@ static long madvise_behavior(struct vm_area_struct *vma,
 			goto out;
 		}
 		error = __split_vma(mm, vma, start, 1);
-		if (error) {
-			/*
-			 * madvise() returns EAGAIN if kernel resources, such as
-			 * slab, are temporarily unavailable.
-			 */
-			if (error == -ENOMEM)
-				error = -EAGAIN;
-			goto out;
-		}
+		if (error)
+			goto out_convert_errno;
 	}
 
 	if (end != vma->vm_end) {
@@ -169,15 +148,8 @@ static long madvise_behavior(struct vm_area_struct *vma,
 			goto out;
 		}
 		error = __split_vma(mm, vma, end, 0);
-		if (error) {
-			/*
-			 * madvise() returns EAGAIN if kernel resources, such as
-			 * slab, are temporarily unavailable.
-			 */
-			if (error == -ENOMEM)
-				error = -EAGAIN;
-			goto out;
-		}
+		if (error)
+			goto out_convert_errno;
 	}
 
 success:
@@ -185,6 +157,14 @@ static long madvise_behavior(struct vm_area_struct *vma,
 	 * vm_flags is protected by the mmap_sem held in write mode.
 	 */
 	vma->vm_flags = new_flags;
+
+out_convert_errno:
+	/*
+	 * madvise() returns EAGAIN if kernel resources, such as
+	 * slab, are temporarily unavailable.
+	 */
+	if (error == -ENOMEM)
+		error = -EAGAIN;
 out:
 	return error;
 }
-- 
2.7.4

