Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1DCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569BD21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 08:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R2TjSGsF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408460AbfJYIqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 04:46:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41972 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733196AbfJYIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 04:46:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9P8kE7d045217;
        Fri, 25 Oct 2019 03:46:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571993174;
        bh=dbZbXXGm8jxdvBrYuzqBWnW2NMiJ85DT5sG+ajCyaSk=;
        h=From:To:CC:Subject:Date;
        b=R2TjSGsFL5tydwDobGjr4hLgjoDxVnT9M376/eIlJcDaMDnu2WpecWNPwmzj1JO82
         iX0Q5WEEJgk5Z24UPqp7dk9TyfTd5bmzp1XLaA5yuHb4mK+Fn+gFgx6Pq3rNRTGw5Q
         0vHTsNXBnZeP6akRGAgR6VvmqawCkzijxNrTBHrk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P8kENG057942;
        Fri, 25 Oct 2019 03:46:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 03:46:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 03:46:03 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P8kBYu105244;
        Fri, 25 Oct 2019 03:46:12 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: [PATCH] firmware: ti_sci: rm: Add support for tx_tdtype parameter for tx channel
Date:   Fri, 25 Oct 2019 11:47:15 +0300
Message-ID: <20191025084715.25098-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system controller's resource manager have support for configuring the
TDTYPE of TCHAN_CFG register on j721e.
With this parameter the teardown completion can be controlled:
TDTYPE == 0: Return without waiting for peer to complete the teardown
TDTYPE == 1: Wait for peer to complete the teardown

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

I know it is kind of getting late for 5.5, but can you consider this small
addition so I can add the support for it in the initial DMA driver?

Thanks and regards,
Peter

 drivers/firmware/ti_sci.c              | 1 +
 drivers/firmware/ti_sci.h              | 7 +++++++
 include/linux/soc/ti/ti_sci_protocol.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 4126be9e3216..f13e4a96f3b7 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2412,6 +2412,7 @@ static int ti_sci_cmd_rm_udmap_tx_ch_cfg(const struct ti_sci_handle *handle,
 	req->fdepth = params->fdepth;
 	req->tx_sched_priority = params->tx_sched_priority;
 	req->tx_burst_size = params->tx_burst_size;
+	req->tx_tdtype = params->tx_tdtype;
 
 	ret = ti_sci_do_xfer(info, xfer);
 	if (ret) {
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index f0d068c03944..255327171dae 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -910,6 +910,7 @@ struct rm_ti_sci_msg_udmap_rx_flow_opt_cfg {
  *   12 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_credit_count
  *   13 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::fdepth
  *   14 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_burst_size
+ *   15 - Valid bit for @ref ti_sci_msg_rm_udmap_tx_ch_cfg::tx_tdtype
  *
  * @nav_id: SoC device ID of Navigator Subsystem where tx channel is located
  *
@@ -973,6 +974,11 @@ struct rm_ti_sci_msg_udmap_rx_flow_opt_cfg {
  *
  * @tx_burst_size: UDMAP transmit channel burst size configuration to be
  * programmed into the tx_burst_size field of the TCHAN_TCFG register.
+ *
+ * @tx_tdtype: UDMAP transmit channel teardown type configuration to be
+ * programmed into the tdtype field of the TCHAN_TCFG register:
+ * 0 - Return immediately
+ * 1 - Wait for completion message from remote peer
  */
 struct ti_sci_msg_rm_udmap_tx_ch_cfg_req {
 	struct ti_sci_msg_hdr hdr;
@@ -994,6 +1000,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg_req {
 	u16 fdepth;
 	u8 tx_sched_priority;
 	u8 tx_burst_size;
+	u8 tx_tdtype;
 } __packed;
 
 /**
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 9531ec823298..f3aed0b91564 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -342,6 +342,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg {
 #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_SUPR_TDPKT_VALID        BIT(11)
 #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_CREDIT_COUNT_VALID      BIT(12)
 #define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_FDEPTH_VALID            BIT(13)
+#define TI_SCI_MSG_VALUE_RM_UDMAP_CH_TX_TDTYPE_VALID            BIT(15)
 	u16 nav_id;
 	u16 index;
 	u8 tx_pause_on_err;
@@ -359,6 +360,7 @@ struct ti_sci_msg_rm_udmap_tx_ch_cfg {
 	u16 fdepth;
 	u8 tx_sched_priority;
 	u8 tx_burst_size;
+	u8 tx_tdtype;
 };
 
 /**
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

