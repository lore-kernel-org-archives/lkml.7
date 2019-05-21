Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13C8216B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 04:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YXQBVdGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfEUEhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 00:37:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfEUEhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 00:37:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L4Ylh1150285;
        Tue, 21 May 2019 04:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=LocLl8jGFL6tj5/xpWQWzeKqZ8xj2DlD6pSYk/0CDQE=;
 b=YXQBVdGTKDHPYrt6PKbsI0O3rI3JPVcdXuVB9uWQeIFLOKHh8iEefXDi7IlvHOH//B8k
 ObQoV3/3vErQqdaV/Lu/t8msw48YOZ4RIvHLQgY7TT0qqPYB2TPb8PjKpnt1izluIvD3
 aueINDxQimvkZGnmLKZ0/tgDvtbMZezC0L6lpDN2eEEjd7dxlzewoU18YNuUJHY0UWp1
 TmtpIMshloXiwSZAwj4s9BBNGlj/Sdy0VHx/EPBE74w4e/OX36c1E4BrO8rM9xMFD9Er
 0H9U148JZprI2LDqzsotlu9LCvqU7q713RRjDgTQ/qOqUfsvs9PuNvMzqfSfBkYGFLRU GQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sj9ftascb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 04:37:26 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4L4a1Wl183631;
        Tue, 21 May 2019 04:37:25 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2sm046rgtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 May 2019 04:37:25 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4L4bLIH030062;
        Tue, 21 May 2019 04:37:21 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 May 2019 04:37:21 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, dongli.zhang@oracle.com
Subject: [PATCH 1/1] drm/i915: remove unused IO_TLB_SEGPAGES which should be defined by swiotlb
Date:   Tue, 21 May 2019 12:40:39 +0800
Message-Id: <1558413639-22568-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905210029
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9263 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905210029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes IO_TLB_SEGPAGES which is no longer used since
commit 5584f1b1d73e ("drm/i915: fix i915 running as dom0 under Xen").

As the define of both IO_TLB_SEGSIZE and IO_TLB_SHIFT are from swiotlb,
IO_TLB_SEGPAGES should be defined on swiotlb side if it is required in the
future.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/gpu/drm/i915/i915_gem_internal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem_internal.c b/drivers/gpu/drm/i915/i915_gem_internal.c
index ab627ed..2166217 100644
--- a/drivers/gpu/drm/i915/i915_gem_internal.c
+++ b/drivers/gpu/drm/i915/i915_gem_internal.c
@@ -28,9 +28,6 @@
 #define QUIET (__GFP_NORETRY | __GFP_NOWARN)
 #define MAYFAIL (__GFP_RETRY_MAYFAIL | __GFP_NOWARN)
 
-/* convert swiotlb segment size into sensible units (pages)! */
-#define IO_TLB_SEGPAGES (IO_TLB_SEGSIZE << IO_TLB_SHIFT >> PAGE_SHIFT)
-
 static void internal_free_pages(struct sg_table *st)
 {
 	struct scatterlist *sg;
-- 
2.7.4

