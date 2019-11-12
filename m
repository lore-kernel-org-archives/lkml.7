Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8398C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC4F214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 19:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RFjq9dmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfKLTqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 14:46:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38026 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfKLTq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 14:46:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACJhpu2145320;
        Tue, 12 Nov 2019 19:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2019-08-05; bh=Mgice0PsP+2rYW3UuaIWPsJNJJ4IqSh/scGtKkNeBwY=;
 b=RFjq9dmHDCA2pKYnoXgUVm2px+s964Waf7KhL+cl1g8cabRtqMQuKz416P65UbG1FECg
 2bGMLSAqhfKCnREoyMv5QtRkL0MvtOLB3AVOT1J+1OUhpm0qMjp+IW6jGA9AgCWyAMeM
 0np9E5DAZb9dtm3twhy/U4zUjcfn6Rv7slkd23DIM3djK6TgefuDPZPZy05kbvvuJ+/e
 pnUGMtUcI0bua5WScf5xR4g2Nl6rehflVw2peH7XR9ske0V/ksA8FE1ExgUYIfGehAIb
 LygiLsiNLar9eUNlZ/VNAEfqBJMEfDBxCHKr1C3yhBMaSsgF6Q9iCfZig4m5Vg1WKh5F 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2w5mvtq81r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 19:46:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xACJcllC041598;
        Tue, 12 Nov 2019 19:46:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2w7vpmurny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Nov 2019 19:46:06 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xACJk2f6008676;
        Tue, 12 Nov 2019 19:46:03 GMT
Received: from monkey.oracle.com (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 Nov 2019 11:46:02 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Jason Gunthorpe <jgg@ziepe.ca>, kbuild@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/2] hugetlbfs: convert macros to static inline, fix sparse warning
Date:   Tue, 12 Nov 2019 11:45:56 -0800
Message-Id: <20191112194558.139389-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=573
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1910280000 definitions=main-1911120166
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9439 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=639 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1910280000
 definitions=main-1911120167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition for huge_pte_offset() in <linux/hugetlb.h> causes a sparse
warning in the !CONFIG_HUGETLB_PAGE.  Fix this as well as converting
all macros in this block of definitions to static inlines for better type
checking.

When making the above changes, build errors were found in powerpc due to
duplicate definitions.  A separate powerpc specific patch is included as
a requisite to remove the definitions and get them from <linux/hugetlb.h>.

Cc: kbuild@lists.01.org in an attmept to flush out any other build issues.

Mike Kravetz (2):
  powerpc/mm: remove pmd_huge/pud_huge stubs and include hugetlb.h
  hugetlbfs: convert macros to static inline, fix sparse warning

 .../include/asm/book3s/64/pgtable-4k.h        |   3 -
 .../include/asm/book3s/64/pgtable-64k.h       |   3 -
 arch/powerpc/mm/book3s64/radix_pgtable.c      |   1 +
 include/linux/hugetlb.h                       | 137 +++++++++++++++---
 4 files changed, 116 insertions(+), 28 deletions(-)

-- 
2.23.0

