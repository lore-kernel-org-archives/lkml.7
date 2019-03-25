Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C556C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C28C2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 05:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="teoIyRCO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbfCYFhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 01:37:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47734 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbfCYFhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 01:37:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P5Xw1t193902;
        Mon, 25 Mar 2019 05:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=7aA4xWq/tfGdYTPt4hOCXVnTHtj21qv2ydS8SKqRloY=;
 b=teoIyRCOvRsf2FYglfMaTvtgDKe5LUbFVwsWw6Vga9siQtQk71AdKFf+u85iRchnuhrG
 J0wg45Q2BuAD5N87y8iAraSQEpAJ5Tj/AIkm+I1iEWk/m0esNX8++zYys6iWVSx2PQMP
 ROp2zVziesHExnV+5VpDNzrrACCXdCHRqXbz+A5R/y6tK/eKqIRg+SqQrhqb2MDFSDCL
 +0bRp1Niydfzhcx27u289I0NJvyCQ8jnbJa72V3GaLYbcIPIk6IgiTHb880Pa3Kv1dSl
 MOq1vNdskjREectzPZHULn6cT5tQyT40n1ADGmrESL2mBc9xg2XFkEIJggUaAZs6an64 JA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2re6g0ssd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:36:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2P5abWj021269
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 05:36:37 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P5aaZu008897;
        Mon, 25 Mar 2019 05:36:36 GMT
Received: from will-ThinkCentre-M93p.cn.oracle.com (/10.182.71.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 24 Mar 2019 22:36:36 -0700
From:   Jianchao Wang <jianchao.w.wang@oracle.com>
To:     axboe@kernel.dk
Cc:     hch@lst.de, jthumshirn@suse.de, hare@suse.de, josef@toxicpanda.com,
        bvanassche@acm.org, sagi@grimberg.me, keith.busch@intel.com,
        jsmart2021@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/8] blk-mq: use blk_mq_queue_tag_inflight_iter in debugfs
Date:   Mon, 25 Mar 2019 13:28:04 +0800
Message-Id: <1553491689-1730-4-git-send-email-jianchao.w.wang@oracle.com>
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
 block/blk-mq-debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index ec1d18c..b7f2538 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -438,7 +438,7 @@ static int hctx_busy_show(void *data, struct seq_file *m)
 	struct blk_mq_hw_ctx *hctx = data;
 	struct show_busy_params params = { .m = m, .hctx = hctx };
 
-	blk_mq_tagset_busy_iter(hctx->queue->tag_set, hctx_show_busy_rq,
+	blk_mq_queue_tag_inflight_iter(hctx->queue, hctx_show_busy_rq,
 				&params);
 
 	return 0;
-- 
2.7.4

