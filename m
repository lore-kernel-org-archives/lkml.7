Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6392CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 335B52087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KSPzsrqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfCLA5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:57:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35500 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfCLA5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:57:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2C0oNgn095913;
        Tue, 12 Mar 2019 00:57:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=nnV6H9FJS4i2wnzUHNPyAlTy8d7aIhy7zs6wyAONp9o=;
 b=KSPzsrqXj3PbfxCwltz3t+Ti99/7SVh1EZVtRqGdp56I9fmaE/h6E4S0X3ECGVRxCHsh
 FbCg1ojxqsbd0jQUOyzZlg0xOQ4hTtXny4QOTbzB/mcXN0b7tl2A3XBfH2aM2ifbiLk+
 JOVsmiTnWx10WRIGAdiT9CaVYxE4BgBIsDPvokwvwi9EF+RQGnj83C3G/yZoTSEu8R5Z
 rto5LaG6hZVi7L2u5uP5qkrKko0mWNXTRfZ2a6iRfgXdtuun11TUI4bvR4J6VH8dnr+k
 qT9du2QRXmE3+DBUibHqVowFsmABAdsSDQTjM2U2EkAQPlNcHizMtd1w7npHH9TsmamW OQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2r464r9jr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 00:57:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2C0vFgW024802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 00:57:15 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x2C0vFUH019866;
        Tue, 12 Mar 2019 00:57:15 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Mar 2019 17:57:14 -0700
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-scsi@vger.kernel.org, qla2xxx-upstream@qlogic.com,
        linux-kernel@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        don.brace@microsemi.com, esc.storagedev@microsemi.com,
        dongli.zhang@oracle.com
Subject: [PATCH 4/4] scsi: smartpqi: replace 0 by HCTX_TYPE_DEFAULT to index blk_mq_tag_set->map
Date:   Tue, 12 Mar 2019 09:00:31 +0800
Message-Id: <1552352431-18821-5-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
References: <1552352431-18821-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9192 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=901 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903120004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use HCTX_TYPE_DEFAULT instead of 0 to avoid hardcoding.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 5d9ccba..68aea2a 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -5789,7 +5789,7 @@ static int pqi_map_queues(struct Scsi_Host *shost)
 {
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	return blk_mq_pci_map_queues(&shost->tag_set.map[0],
+	return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
 					ctrl_info->pci_dev, 0);
 }
 
-- 
2.7.4

