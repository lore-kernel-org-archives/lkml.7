Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF95C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF30D2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xFkS5Gq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbfCYFhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:37:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:59672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbfCYFhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:37:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P5Y5vv005446;
        Mon, 25 Mar 2019 05:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=ss1t3DJAWRqtk33Piyd+aeKtdRJeAop5F6RCCUL08C8=;
 b=xFkS5Gq+43hARkWeK8oqfIGvo7CAhwSBo/prJLfsrWEYBk1H66YtBnGqdjWZXuxKyar2
 1t6cMePhuWnf6241PNLLw629bGn8slCPVdw3q7L7+ZvQve146JgLm7/1K63wL5IGOvYx
 /ZYfK1TG0tAEG0qD4dw35tS6SMyTCesWn1ywW/R3pGgvvKCJFiozT9gzL0KBcrN8NZg7
 L+WmGP1A6eD18ToXee5CVNTa9eloMI7gsfOtZK++zsH0mpS0X2C5GUmD2wuvvusE74p0
 UALRgbv+QlXxtdkuUQTOYeXrL4LCIFilpaVp9NwsefmM8t//j23IBJZxB7U+SxNUo4yG kw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2re6dj1tqt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:36:52 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5akVv021478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:36:46 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P5ajYc009009;
        Mon, 25 Mar 2019 05:36:45 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 22:36:45 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 6/8] skd: use blk_mq_queue_tag_inflight_iter
Date:   Mon, 25 Mar 2019 13:28:07 +0800
Message-Id: <1553491689-1730-7-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 drivers/block/skd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 7d3ad6c..0213b19 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -395,7 +395,7 @@ static int skd_in_flight(struct skd_device *skdev)
 {
 	int count = 0;
 
-	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_inc_in_flight, &count);
+	blk_mq_queue_tag_inflight_iter(skdev->queue, skd_inc_in_flight, &count);
 
 	return count;
 }
@@ -1916,7 +1916,7 @@ static bool skd_recover_request(struct request *req, void *data, bool reserved)
 
 static void skd_recover_requests(struct skd_device *skdev)
 {
-	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_recover_request, skdev);
+	blk_mq_queue_tag_inflight_iter(skdev->queue, skd_recover_request, skdev);
 }
 
 static void skd_isr_msg_from_dev(struct skd_device *skdev)
-- 
2.7.4

