Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101B2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC1D220850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 14:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfCSOmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 10:42:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfCSOmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 10:42:02 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C2CB83024564;
        Tue, 19 Mar 2019 14:42:01 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 323625C641;
        Tue, 19 Mar 2019 14:41:57 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     linux-nvme@lists.infradead.org
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "David S . Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "Paul E . McKenney " <paulmck@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Liang Cunming <cunming.liang@intel.com>,
        Liu Changpeng <changpeng.liu@intel.com>,
        Fam Zheng <fam@euphon.net>, Amnon Ilan <ailan@redhat.com>,
        John Ferlan <jferlan@redhat.com>
Subject: [PATCH 2/9] nvme/core: add some more values from the spec
Date:   Tue, 19 Mar 2019 16:41:09 +0200
Message-Id: <20190319144116.400-3-mlevitsk@redhat.com>
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 19 Mar 2019 14:42:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds few defines from the spec,
that will be used in the nvme-mdev driver

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 include/linux/nvme.h | 88 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 20 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bbcc83886899..029162db31bb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -152,32 +152,42 @@ enum {
 #define NVME_NVM_IOCQES		4
 
 enum {
-	NVME_CC_ENABLE		= 1 << 0,
-	NVME_CC_CSS_NVM		= 0 << 4,
 	NVME_CC_EN_SHIFT	= 0,
+	NVME_CC_ENABLE		= 1 << NVME_CC_EN_SHIFT,
+
 	NVME_CC_CSS_SHIFT	= 4,
+	NVME_CC_CSS_NVM		= 0 << NVME_CC_CSS_SHIFT,
+
 	NVME_CC_MPS_SHIFT	= 7,
+	NVME_CC_MPS_MASK	= 0xF << NVME_CC_MPS_SHIFT,
+
 	NVME_CC_AMS_SHIFT	= 11,
-	NVME_CC_SHN_SHIFT	= 14,
-	NVME_CC_IOSQES_SHIFT	= 16,
-	NVME_CC_IOCQES_SHIFT	= 20,
 	NVME_CC_AMS_RR		= 0 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_WRRU	= 1 << NVME_CC_AMS_SHIFT,
 	NVME_CC_AMS_VS		= 7 << NVME_CC_AMS_SHIFT,
+	NVME_CC_AMS_MASK	= 0x7 << NVME_CC_AMS_SHIFT,
+
+	NVME_CC_SHN_SHIFT	= 14,
 	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
 	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
+
+	NVME_CC_IOSQES_SHIFT	= 16,
+	NVME_CC_IOCQES_SHIFT	= 20,
 	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
 	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
+
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
 	NVME_CSTS_PP		= 1 << 5,
-	NVME_CSTS_SHST_NORMAL	= 0 << 2,
-	NVME_CSTS_SHST_OCCUR	= 1 << 2,
-	NVME_CSTS_SHST_CMPLT	= 2 << 2,
-	NVME_CSTS_SHST_MASK	= 3 << 2,
+
+	NVME_CSTS_SHST_SHIFT	= 2,
+	NVME_CSTS_SHST_NORMAL	= 0 << NVME_CSTS_SHST_SHIFT,
+	NVME_CSTS_SHST_OCCUR	= 1 << NVME_CSTS_SHST_SHIFT,
+	NVME_CSTS_SHST_CMPLT	= 2 << NVME_CSTS_SHST_SHIFT,
+	NVME_CSTS_SHST_MASK	= 3 << NVME_CSTS_SHST_SHIFT,
 };
 
 struct nvme_id_power_state {
@@ -404,6 +414,20 @@ enum {
 	NVME_NIDT_UUID		= 0x03,
 };
 
+struct nvme_err_log_entry {
+	__u8			err_count[8];
+	__le16			sqid;
+	__le16			cid;
+	__le16			status;
+	__le16			location;
+	__u8			lba[8];
+	__le32			ns;
+	__u8			vnd;
+	__u8			rsvd1[3];
+	__u8			cmd_specific[8];
+	__u8			rsvd2[24];
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
@@ -491,13 +515,30 @@ enum {
 	NVME_AER_VS			= 7,
 };
 
-enum {
-	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
-	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
-	NVME_AER_NOTICE_ANA		= 0x03,
-	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
+enum nvme_async_event_type {
+	NVME_AER_TYPE_ERROR	= 0,
+	NVME_AER_TYPE_SMART	= 1,
+	NVME_AER_TYPE_NOTICE	= 2,
+	NVME_AER_TYPE_MAX	= 7,
 };
 
+enum nvme_async_event {
+	NVME_AER_ERROR_INVALID_DB_REG = 0,
+	NVME_AER_ERROR_INVALID_DB_VALUE = 1,
+	NVME_AER_ERROR_DIAG_FAILURE = 2,
+	NVME_AER_ERROR_PERSISTENT_INT_ERR = 3,
+	NVME_AER_ERROR_TRANSIENT_INT_ERR = 4,
+	NVME_AER_ERROR_FW_IMAGE_LOAD_ERR = 5,
+
+	NVME_AER_SMART_SUBSYS_RELIABILITY = 0,
+	NVME_AER_SMART_TEMP_THRESH = 1,
+	NVME_AER_SMART_SPARE_BELOW_THRESH = 2,
+
+	NVME_AER_NOTICE_NS_CHANGED	= 0,
+	NVME_AER_NOTICE_FW_ACT_STARTING = 1,
+	NVME_AER_NOTICE_ANA		= 3,
+	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
+};
 enum {
 	NVME_AEN_BIT_NS_ATTR		= 8,
 	NVME_AEN_BIT_FW_ACT		= 9,
@@ -548,12 +589,6 @@ struct nvme_reservation_status {
 	} regctl_ds[];
 };
 
-enum nvme_async_event_type {
-	NVME_AER_TYPE_ERROR	= 0,
-	NVME_AER_TYPE_SMART	= 1,
-	NVME_AER_TYPE_NOTICE	= 2,
-};
-
 /* I/O commands */
 
 enum nvme_opcode {
@@ -705,10 +740,19 @@ enum {
 	NVME_RW_DSM_LATENCY_LOW		= 3 << 4,
 	NVME_RW_DSM_SEQ_REQ		= 1 << 6,
 	NVME_RW_DSM_COMPRESSED		= 1 << 7,
+
+	NVME_WZ_DEAC			= 1 << 9,
 	NVME_RW_PRINFO_PRCHK_REF	= 1 << 10,
 	NVME_RW_PRINFO_PRCHK_APP	= 1 << 11,
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
+
+	NVME_RW_PRINFO			=
+			NVME_RW_PRINFO_PRCHK_REF |
+			NVME_RW_PRINFO_PRCHK_APP |
+			NVME_RW_PRINFO_PRCHK_GUARD |
+			NVME_RW_PRINFO_PRACT,
+
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
 };
 
@@ -809,6 +853,7 @@ enum {
 	NVME_SQ_PRIO_HIGH	= (1 << 1),
 	NVME_SQ_PRIO_MEDIUM	= (2 << 1),
 	NVME_SQ_PRIO_LOW	= (3 << 1),
+	NVME_SQ_PRIO_MASK	= (3 << 1),
 	NVME_FEAT_ARBITRATION	= 0x01,
 	NVME_FEAT_POWER_MGMT	= 0x02,
 	NVME_FEAT_LBA_RANGE	= 0x03,
@@ -1146,6 +1191,7 @@ struct streams_directive_params {
 
 struct nvme_command {
 	union {
+		__le32 dwords[16];
 		struct nvme_common_command common;
 		struct nvme_rw_command rw;
 		struct nvme_identify identify;
@@ -1217,6 +1263,8 @@ enum {
 	NVME_SC_SGL_INVALID_METADATA	= 0x10,
 	NVME_SC_SGL_INVALID_TYPE	= 0x11,
 
+	NVME_SC_PRP_OFFSET_INVALID	= 0x13,
+
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
-- 
2.17.2

