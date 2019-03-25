Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FB5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20192075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x18CHogp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbfCYFhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:37:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48032 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfCYFhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:37:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P5XtJf193204;
        Mon, 25 Mar 2019 05:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=0AqGtOQCpOKdaqikKZPNrEdGIP8IYysK1oxEMSNcS9I=;
 b=x18CHogpDcWRj+u+IsPvwFFvw0xCr9lMCgKjSB/RXQF2fObtWdmld2vB3+APx8FQdXZ0
 B6d1bYDeyzZebWXPFOkkNKun69nGJ2f+h5/d7cLIWzK+x/lzK5gZOBHPf5UFgMZfIimg
 AGFiUQk5WvXYbNNXAytiIRICiQQau91f1yehxIUARWVJ3hzsRTH20T1Dj7WkFn7ZESrF
 QOqBBA7qFjpKpXxeekHpZsDBLxSZD8r8vibOKttY2TDUMlx5elmv0l6N0iACMtFP9Zof
 hvJS06LH4UlUY1uP1qmDXOST7HqzefIYVnacrM4utdZ4KG1sgBvRRoou6VL3y+OjCFLV 2A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2re6g0hsab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:36:44 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5ahmT021406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:36:43 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P5agx7009006;
        Mon, 25 Mar 2019 05:36:42 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 22:36:42 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/8] nbd: use blk_mq_queue_tag_inflight_iter
Date:   Mon, 25 Mar 2019 13:28:06 +0800
Message-Id: <1553491689-1730-6-git-send-email-jianchao.w.wang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=977 adultscore=0
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
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 90ba9f4..c48984b 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -747,7 +747,7 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
 static void nbd_clear_que(struct nbd_device *nbd)
 {
 	blk_mq_quiesce_queue(nbd->disk->queue);
-	blk_mq_tagset_busy_iter(&nbd->tag_set, nbd_clear_req, NULL);
+	blk_mq_queue_tag_inflight_iter(nbd->disk->queue, nbd_clear_req, NULL);
 	blk_mq_unquiesce_queue(nbd->disk->queue);
 	dev_dbg(disk_to_dev(nbd->disk), "queue cleared\n");
 }
-- 
2.7.4

