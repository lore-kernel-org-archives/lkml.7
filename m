Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3952C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D9E2177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="vyHi0SP2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfCLA5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:57:19 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52900 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfCLA5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:57:16 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2C0o0jd128359;
        Tue, 12 Mar 2019 00:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=1RhjuITrn9cox+8jXcbmFqWu9tAMKGSvxu5o3kklT1Q=;
 b=vyHi0SP2bD8LMKlnkyO4Tn5LGeG+zNKM2VLU/iTWXrsQIJSwsToVvMIhh318+Oy8rwZr
 NEht6PaDDteyuF5AdtWelWn0O/BEsjhdpdm6t/4m9FrCbV4u1THIDFEwY0RFD390y/HT
 S4Sz/B6OvEqA/Xt++Jy/tWnyYLPZoJoOUkkZmmuCsjdugm6dXC2o2MHgtbFhZO4UY2Wc
 ue3XUJF4odn19pzvRbkX1DBn2/cR1nAbwQrxvHLnnulwdTvm/NJezut1ug1eahBEIF4o
 6uCdvkQWGXLRjar763ea4OJ9Pmg1hAJwZYL2hy1aPildsUB8ZB8lZ+Pc37+10I10XvYF sA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r430ej3jg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 00:57:10 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2C0vAhs024671
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 00:57:10 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2C0vAJC014183;
        Tue, 12 Mar 2019 00:57:10 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 17:57:09 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-scsi@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        linux-kernel@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, esc.storagedev@microsemi.com,
        dongli.zhang@oracle.com
Subject: [PATCH 2/4] scsi: virtio_scsi: replace 0 by HCTX_TYPE_DEFAULT to index blk_mq_tag_set->map
Date:   Tue, 12 Mar 2019 09:00:29 +0800
Message-Id: <1552352431-18821-3-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
References: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=861 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use HCTX_TYPE_DEFAULT instead of 0 to avoid hardcoding.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/scsi/virtio_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 1a6f150..e5de26b 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -661,7 +661,7 @@ static int virtscsi_abort(struct scsi_cmnd *sc)
 static int virtscsi_map_queues(struct Scsi_Host *shost)
 {
 	struct virtio_scsi *vscsi = shost_priv(shost);
-	struct blk_mq_queue_map *qmap = &shost->tag_set.map[0];
+	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	return blk_mq_virtio_map_queues(qmap, vscsi->vdev, 2);
 }
-- 
2.7.4

