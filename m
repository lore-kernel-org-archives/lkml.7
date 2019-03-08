Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5835EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296812081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="4hqj/AhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfCHWss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:48:48 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHWss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:48:48 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x28Mhavn022229;
        Fri, 8 Mar 2019 22:48:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=9mYA2OMneODE0ER7VYzeYVrHjR6dxQoAsu+AqTsDnc8=;
 b=4hqj/AhGnV7ErTjU7Vl/dWj1f83Eva1SRhfJSrsQXnXdtLU5dsuTquyZt+FecsPnq5VW
 Hcd3Iyq4DwcAygyYz8bdRTAeMuMjU28IOy2Pxztrzz1zi/A9dRjkbBl4Lt1S1cM1IoZU
 +KyYDyugmzE7/SncsZziA539fCq9MnGOaaxQoLjRnv7Y2hwPy3ZmRg3ySIGRG3tUdJN0
 2Li/Ig+lV/zrQRNaedwMUNTClBOnLdsVjKhHCWswZAJmaajX5Jet0gj0L0BjFop8a6Km
 rIPtwV4QoUkQR3RAfaJccztZgEl25O5CWyX1F9nb/aS+YUgOD89xB6r6TAOzfTD6H01R bA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qyjfs2r3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Mar 2019 22:48:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x28MmaAC009035
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Mar 2019 22:48:37 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x28MmYCc000689;
        Fri, 8 Mar 2019 22:48:35 GMT
Received: from monkey.oracle.com (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Mar 2019 14:48:34 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 0/2] A couple hugetlbfs fixes
Date:   Fri,  8 Mar 2019 14:48:21 -0800
Message-Id: <20190308224823.15051-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.17.2
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9189 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=684 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903080157
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

Mike Kravetz (2):
  huegtlbfs: on restore reserve error path retain subpool reservation
  hugetlb: use same fault hash key for shared and private mappings

 mm/hugetlb.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
2.17.2

