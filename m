Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A719C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D58B2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rguid/CD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfHOIbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:31:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730456AbfHOIbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:31:11 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8TBQx020959;
        Thu, 15 Aug 2019 08:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=O+FokAWjhc+SD6T9nhAi78pTurLwDooPTqZWvPAkhdU=;
 b=Rguid/CDCd8P9Ka9TG9Ypz7zZuEtQ2wB/3r5XbAODziM7gISBDmyz5dVZkCNggXT/SuO
 j3flnBNVj3dccblHRa4Ynter++3FqwvMdDzZ7AKlGXk/oaJ3Ad6Vy4M8frECUxdJWGx1
 Z2E6AV28Jva5375z6L39ohIQ6W9iiY/MuiYCbgfP1ZccRe/PObkvDqsvH/9+xdaboZk1
 NYgcPjEt4MNNNOMbb3fi4MzyiVg5Cj5eAUK5EUhiUI6Vpk79H+d5M3hNhxyqzoUv6YMw
 bGuTtqQFj7P+BxMtkU7c++Gb1/QynZwPwgbZ44DuPIUi/Q59J54WVyBJPVEdM6ufN0eT fg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 2u9nvphqkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:31:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7F8Rhr9030338;
        Thu, 15 Aug 2019 08:31:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2ucpys55a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Aug 2019 08:31:04 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x7F8UvRg010467;
        Thu, 15 Aug 2019 08:30:58 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Aug 2019 01:30:57 -0700
Date:   Thu, 15 Aug 2019 11:30:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/vmwgfx: Fix double free in vmw_recv_msg()
Message-ID: <20190815083050.GC27238@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908150090
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9349 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908150090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently added a kfree() after the end of the loop:

	if (retries == RETRIES) {
		kfree(reply);
		return -EINVAL;
	}

There are two problems.  First the test is wrong and because retries
equals RETRIES if we succeed on the last iteration through the loop.
Second if we fail on the last iteration through the loop then the kfree
is a double free.

When you're reading this code, please note the break statement at the
end of the while loop.  This patch changes the loop so that if it's not
successful then "reply" is NULL and we can test for that afterward.

Fixes: 6b7c3b86f0b6 ("drm/vmwgfx: fix memory leak when too many retries have occurred")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
index 59e9d05ab928..0af048d1a815 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
@@ -353,7 +353,7 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 				     !!(HIGH_WORD(ecx) & MESSAGE_STATUS_HB));
 		if ((HIGH_WORD(ebx) & MESSAGE_STATUS_SUCCESS) == 0) {
 			kfree(reply);
-
+			reply = NULL;
 			if ((HIGH_WORD(ebx) & MESSAGE_STATUS_CPT) != 0) {
 				/* A checkpoint occurred. Retry. */
 				continue;
@@ -377,7 +377,7 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 
 		if ((HIGH_WORD(ecx) & MESSAGE_STATUS_SUCCESS) == 0) {
 			kfree(reply);
-
+			reply = NULL;
 			if ((HIGH_WORD(ecx) & MESSAGE_STATUS_CPT) != 0) {
 				/* A checkpoint occurred. Retry. */
 				continue;
@@ -389,10 +389,8 @@ static int vmw_recv_msg(struct rpc_channel *channel, void **msg,
 		break;
 	}
 
-	if (retries == RETRIES) {
-		kfree(reply);
+	if (!reply)
 		return -EINVAL;
-	}
 
 	*msg_len = reply_len;
 	*msg     = reply;
-- 
2.20.1

