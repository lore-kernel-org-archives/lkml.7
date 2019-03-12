Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756AAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DAE2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kd4PdPEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfCLA5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:57:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52972 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbfCLA5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:57:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2C0nLb1127739;
        Tue, 12 Mar 2019 00:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=jmqg6cwuM9pF9cQJHAkY8+UNvfl1e0+MDGToL7DvFA8=;
 b=kd4PdPEkxxrhLHjoFc5nLmbbwsAtE8amLO5EvtaJah+HLYOfzqOh9rKlmBZQPc7vB5Nd
 5mQtpSgKRYquwnd0vo2P/rn3r48LoyN8eLXPYLv1RxO9gE6HYFKiVRy0vi0Nm96y2AON
 rjOFWZhKo2cxlVtPCE8/nk1AdXKjZICIgWEJ6KhPhWm4W3qD3tYaBnLtrMjYow+adYdQ
 OqkqAWFeu183i/DaXGqPoBsBhzxvQX9fe5UDpYrRBiLjAGCsxkDJjvOnOEM7V43HnDJ2
 wvG67sZ77zcy6cbqeOZW84HPwLJ+XbaSuo/G2x3DCMATNKRMoMCaz/z6Q1ouDivMfGgQ cg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2r430ej3jt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 00:57:14 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2C0v81R030623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 00:57:08 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2C0v7wE014168;
        Tue, 12 Mar 2019 00:57:07 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 17:57:07 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-scsi@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        linux-kernel@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, esc.storagedev@microsemi.com,
        dongli.zhang@oracle.com
Subject: [PATCH 1/4] scsi: replace 0 by HCTX_TYPE_DEFAULT to index blk_mq_tag_set->map
Date:   Tue, 12 Mar 2019 09:00:28 +0800
Message-Id: <1552352431-18821-2-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
References: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use HCTX_TYPE_DEFAULT instead of 0 to avoid hardcoding.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 2018967..985cfc2 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1759,7 +1759,7 @@ static int scsi_map_queues(struct blk_mq_tag_set *set)
 
 	if (shost->hostt->map_queues)
 		return shost->hostt->map_queues(shost);
-	return blk_mq_map_queues(&set->map[0]);
+	return blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
 }
 
 void __scsi_init_queue(struct Scsi_Host *shost, struct request_queue *q)
-- 
2.7.4

