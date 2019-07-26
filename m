Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA100C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4C422CEB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbfGZN6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:58:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41812 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387753AbfGZN6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:58:45 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4F8FD5449E7E1747B8BC;
        Fri, 26 Jul 2019 21:58:43 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 26 Jul 2019
 21:58:33 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>, <hch@lst.de>,
        <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] scsi: initio: Make some functions static
Date:   Fri, 26 Jul 2019 21:58:14 +0800
Message-ID: <20190726135814.48760-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warnings:

drivers/scsi/initio.c:881:22: warning: symbol 'initio_find_busy_scb' was not declared. Should it be static?
drivers/scsi/initio.c:919:22: warning: symbol 'initio_find_done_scb' was not declared. Should it be static?
drivers/scsi/initio.c:1657:5: warning: symbol 'initio_state_7' was not declared. Should it be static?
drivers/scsi/initio.c:1743:5: warning: symbol 'initio_xpad_in' was not declared. Should it be static?
drivers/scsi/initio.c:1767:5: warning: symbol 'initio_xpad_out' was not declared. Should it be static?
drivers/scsi/initio.c:1792:5: warning: symbol 'initio_status_msg' was not declared. Should it be static?
drivers/scsi/initio.c:1842:5: warning: symbol 'int_initio_busfree' was not declared. Should it be static?
drivers/scsi/initio.c:1912:5: warning: symbol 'int_initio_resel' was not declared. Should it be static?
drivers/scsi/initio.c:2368:5: warning: symbol 'initio_bus_device_reset' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/scsi/initio.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 41fd64c..ed9e87a 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -864,7 +864,8 @@ static void initio_unlink_busy_scb(struct initio_host * host, struct scsi_ctrl_b
 	return;
 }
 
-struct scsi_ctrl_blk *initio_find_busy_scb(struct initio_host * host, u16 tarlun)
+static struct
+scsi_ctrl_blk *initio_find_busy_scb(struct initio_host *host, u16 tarlun)
 {
 	struct scsi_ctrl_blk *tmp, *prev;
 	u16 scbp_tarlun;
@@ -902,7 +903,8 @@ static void initio_append_done_scb(struct initio_host * host, struct scsi_ctrl_b
 	}
 }
 
-struct scsi_ctrl_blk *initio_find_done_scb(struct initio_host * host)
+static struct
+scsi_ctrl_blk *initio_find_done_scb(struct initio_host *host)
 {
 	struct scsi_ctrl_blk *tmp;
 
@@ -1640,7 +1642,7 @@ static int initio_state_6(struct initio_host * host)
  *
  */
 
-int initio_state_7(struct initio_host * host)
+static int initio_state_7(struct initio_host *host)
 {
 	int cnt, i;
 
@@ -1726,7 +1728,7 @@ static int initio_xfer_data_out(struct initio_host * host)
 	return 0;		/* return to OS, wait xfer done , let jas_isr come in */
 }
 
-int initio_xpad_in(struct initio_host * host)
+static int initio_xpad_in(struct initio_host *host)
 {
 	struct scsi_ctrl_blk *scb = host->active;
 	struct target_control *active_tc = host->active_tc;
@@ -1750,7 +1752,7 @@ int initio_xpad_in(struct initio_host * host)
 	}
 }
 
-int initio_xpad_out(struct initio_host * host)
+static int initio_xpad_out(struct initio_host *host)
 {
 	struct scsi_ctrl_blk *scb = host->active;
 	struct target_control *active_tc = host->active_tc;
@@ -1775,7 +1777,7 @@ int initio_xpad_out(struct initio_host * host)
 	}
 }
 
-int initio_status_msg(struct initio_host * host)
+static int initio_status_msg(struct initio_host *host)
 {				/* status & MSG_IN */
 	struct scsi_ctrl_blk *scb = host->active;
 	u8 msg;
@@ -1825,7 +1827,7 @@ int initio_status_msg(struct initio_host * host)
 
 
 /* scsi bus free */
-int int_initio_busfree(struct initio_host * host)
+static int int_initio_busfree(struct initio_host *host)
 {
 	struct scsi_ctrl_blk *scb = host->active;
 
@@ -1895,7 +1897,7 @@ static int int_initio_scsi_rst(struct initio_host * host)
  *	and continue processing that command.
  */
 
-int int_initio_resel(struct initio_host * host)
+static int int_initio_resel(struct initio_host *host)
 {
 	struct scsi_ctrl_blk *scb;
 	struct target_control *active_tc;
@@ -2351,7 +2353,7 @@ static void initio_select_atn3(struct initio_host * host, struct scsi_ctrl_blk *
  *	Perform a device reset and abort all pending SCBs for the
  *	victim device
  */
-int initio_bus_device_reset(struct initio_host * host)
+static int initio_bus_device_reset(struct initio_host *host)
 {
 	struct scsi_ctrl_blk *scb = host->active;
 	struct target_control *active_tc = host->active_tc;
-- 
2.7.4


