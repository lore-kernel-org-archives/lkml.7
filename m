Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFCEC742CF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79866208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfGLQPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:15:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbfGLQPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:15:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CG4FmN044055;
        Fri, 12 Jul 2019 12:15:43 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpw8y0vnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 12:15:43 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x6CGETpO016229;
        Fri, 12 Jul 2019 16:15:41 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 2tjk974tcn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 16:15:41 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CGFexf45285788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 16:15:40 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2CF6AE062;
        Fri, 12 Jul 2019 16:15:40 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BCFAAE05F;
        Fri, 12 Jul 2019 16:15:40 +0000 (GMT)
Received: from oc6220003374.ibm.com (unknown [9.40.45.99])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Fri, 12 Jul 2019 16:15:40 +0000 (GMT)
From:   KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Subject: [PATCH] lpfc: Fix Buffer Overflow Error
Date:   Fri, 12 Jul 2019 11:15:35 -0500
Message-Id: <1562948135-5533-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Power and x86 have different page sizes so rather than allocate the
buffer based on number of pages we should allocate space by using
max_sectors. There is also code in lpfc_scsi.c to be sure we don't
write past the end of this buffer.

Signed-off-by: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 41 +++++++----------------------------------
 drivers/scsi/lpfc/lpfc_scsi.c | 14 ++++++++++++--
 2 files changed, 19 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index eaaef68..59b52a0 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -39,6 +39,7 @@
 #include <linux/msi.h>
 #include <linux/irq.h>
 #include <linux/bitops.h>
+#include <linux/vmalloc.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_device.h>
@@ -7549,7 +7550,6 @@ struct lpfc_rpi_hdr *
 	uint32_t old_mask;
 	uint32_t old_guard;
 
-	int pagecnt = 10;
 	if (phba->cfg_prot_mask && phba->cfg_prot_guard) {
 		lpfc_printf_log(phba, KERN_INFO, LOG_INIT,
 				"1478 Registering BlockGuard with the "
@@ -7588,23 +7588,9 @@ struct lpfc_rpi_hdr *
 	}
 
 	if (!_dump_buf_data) {
-		while (pagecnt) {
-			spin_lock_init(&_dump_buf_lock);
-			_dump_buf_data =
-				(char *) __get_free_pages(GFP_KERNEL, pagecnt);
-			if (_dump_buf_data) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
-					"9043 BLKGRD: allocated %d pages for "
-				       "_dump_buf_data at 0x%p\n",
-				       (1 << pagecnt), _dump_buf_data);
-				_dump_buf_data_order = pagecnt;
-				memset(_dump_buf_data, 0,
-				       ((1 << PAGE_SHIFT) << pagecnt));
-				break;
-			} else
-				--pagecnt;
-		}
-		if (!_dump_buf_data_order)
+		_dump_buf_data = (char *) vmalloc(shost->hostt->max_sectors * 512);
+		_dump_buf_data_order = get_order(shost->hostt->max_sectors * 512);
+		if (!_dump_buf_data)
 			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
 				"9044 BLKGRD: ERROR unable to allocate "
 			       "memory for hexdump\n");
@@ -7613,22 +7599,9 @@ struct lpfc_rpi_hdr *
 			"9045 BLKGRD: already allocated _dump_buf_data=0x%p"
 		       "\n", _dump_buf_data);
 	if (!_dump_buf_dif) {
-		while (pagecnt) {
-			_dump_buf_dif =
-				(char *) __get_free_pages(GFP_KERNEL, pagecnt);
-			if (_dump_buf_dif) {
-				lpfc_printf_log(phba, KERN_ERR, LOG_BG,
-					"9046 BLKGRD: allocated %d pages for "
-				       "_dump_buf_dif at 0x%p\n",
-				       (1 << pagecnt), _dump_buf_dif);
-				_dump_buf_dif_order = pagecnt;
-				memset(_dump_buf_dif, 0,
-				       ((1 << PAGE_SHIFT) << pagecnt));
-				break;
-			} else
-				--pagecnt;
-		}
-		if (!_dump_buf_dif_order)
+		_dump_buf_dif = (char *) vmalloc(shost->hostt->max_sectors * 512);
+		_dump_buf_dif_order = get_order(shost->hostt->max_sectors * 512);
+		if (!_dump_buf_dif)
 			lpfc_printf_log(phba, KERN_ERR, LOG_BG,
 			"9047 BLKGRD: ERROR unable to allocate "
 			       "memory for hexdump\n");
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index ba996fb..719612d 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -92,7 +92,7 @@ struct scsi_dif_tuple {
 static void
 lpfc_debug_save_data(struct lpfc_hba *phba, struct scsi_cmnd *cmnd)
 {
-	void *src, *dst;
+	void *src, *dst, *end;
 	struct scatterlist *sgde = scsi_sglist(cmnd);
 
 	if (!_dump_buf_data) {
@@ -110,7 +110,12 @@ struct scsi_dif_tuple {
 	}
 
 	dst = (void *) _dump_buf_data;
+	end = ((char *) dst) + ((1 << PAGE_SHIFT) << _dump_buf_data_order);
 	while (sgde) {
+		if (dst + sgde->length >= end) {
+			printk(KERN_ERR "overflow buffer\n");
+			break;
+		}
 		src = sg_virt(sgde);
 		memcpy(dst, src, sgde->length);
 		dst += sgde->length;
@@ -121,7 +126,7 @@ struct scsi_dif_tuple {
 static void
 lpfc_debug_save_dif(struct lpfc_hba *phba, struct scsi_cmnd *cmnd)
 {
-	void *src, *dst;
+	void *src, *dst, *end;
 	struct scatterlist *sgde = scsi_prot_sglist(cmnd);
 
 	if (!_dump_buf_dif) {
@@ -138,7 +143,12 @@ struct scsi_dif_tuple {
 	}
 
 	dst = _dump_buf_dif;
+	end = ((char *) dst) + ((1 << PAGE_SHIFT) << _dump_buf_dif_order);
 	while (sgde) {
+		if (dst + sgde->length >= end) {
+			printk(KERN_ERR "overflow buffer\n");
+			break;
+		}
 		src = sg_virt(sgde);
 		memcpy(dst, src, sgde->length);
 		dst += sgde->length;
-- 
1.8.3.1

