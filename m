Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A00BC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B810217BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 11:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="g+PBel5C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbfK1LAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 06:00:41 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39126 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727239AbfK1LAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 06:00:37 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xASAq4aw023223;
        Thu, 28 Nov 2019 12:00:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=YlvngK0gfmo41ZPgYNmQ5FeUoDq2NlVbgxbpkAXqaNo=;
 b=g+PBel5CcX28hOwSErBElntV7lIrjG+ImRaFZ/DcosdQWmLQa1wYF8wMdMTXXLxh8XK+
 LkW4iImv5f/JCPZQrARr5/V8I4k5ARI+P6RRaIlbLO7uDMBE2p4eASawAx6sxf6KZgd9
 lGgiaNJbL6CxItNeuSbAYVw/zEFE/WS0x3wtehG6OV7eSmN407na6kiKZja7TisHYQci
 vUGP69CrjA4to8oPnWPb+srmmZOiXEvl1aD9HiKCUF5m1gDKP0cYhrw2D3ISH5A1LH24
 BByv03/I1nrsxRea6jCBwt/kkD0oUMN3eSSx1XTLWH7H0FXUisgoRon83q5xGuxHopvB Yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2whcxks8mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Nov 2019 12:00:20 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6753C10002A;
        Thu, 28 Nov 2019 12:00:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 31E532B11E2;
        Thu, 28 Nov 2019 12:00:16 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 28 Nov 2019 12:00:15
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH v2] drm/dp_mst: Fix W=1 warnings
Date:   Thu, 28 Nov 2019 12:00:12 +0100
Message-ID: <20191128110012.23898-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-28_01:2019-11-28,2019-11-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warnings that show up with W=1.
They are all about unused but set variables.
If functions returns are not used anymore make them void.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
CC: Jani Nikula <jani.nikula@linux.intel.com>
---
changes in version 2:
- fix indentations
- when possible change functions prototype to void

Note: this patch may conflict with c485e2c97dae ("drm/dp_mst: Refactor pdt
setup/teardown, add more locking") when it will hit drm-misc-next

 drivers/gpu/drm/drm_dp_mst_topology.c | 83 +++++++++++++----------------------
 1 file changed, 31 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index b854a422a523..ff2d81db0778 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -672,7 +672,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_sideband_msg_rx *msg,
 				      u8 *replybuf, u8 replybuflen, bool hdr)
 {
 	int ret;
-	u8 crc4;
 
 	if (hdr) {
 		u8 hdrlen;
@@ -714,8 +713,6 @@ static bool drm_dp_sideband_msg_build(struct drm_dp_sideband_msg_rx *msg,
 	}
 
 	if (msg->curchunk_idx >= msg->curchunk_len) {
-		/* do CRC */
-		crc4 = drm_dp_msg_data_crc4(msg->chunk, msg->curchunk_len - 1);
 		/* copy chunk into bigger msg */
 		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
 		msg->curlen += msg->curchunk_len - 1;
@@ -1012,7 +1009,7 @@ static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
 	}
 }
 
-static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes, u8 *bytes)
+static void build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes, u8 *bytes)
 {
 	struct drm_dp_sideband_msg_req_body req;
 
@@ -1022,17 +1019,14 @@ static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32
 	req.u.dpcd_write.num_bytes = num_bytes;
 	req.u.dpcd_write.bytes = bytes;
 	drm_dp_encode_sideband_req(&req, msg);
-
-	return 0;
 }
 
-static int build_link_address(struct drm_dp_sideband_msg_tx *msg)
+static void build_link_address(struct drm_dp_sideband_msg_tx *msg)
 {
 	struct drm_dp_sideband_msg_req_body req;
 
 	req.req_type = DP_LINK_ADDRESS;
 	drm_dp_encode_sideband_req(&req, msg);
-	return 0;
 }
 
 static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg, int port_num)
@@ -1046,7 +1040,7 @@ static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg, int por
 	return 0;
 }
 
-static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_num,
+static void build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_num,
 				  u8 vcpi, uint16_t pbn,
 				  u8 number_sdp_streams,
 				  u8 *sdp_stream_sink)
@@ -1062,10 +1056,9 @@ static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int port_n
 		   number_sdp_streams);
 	drm_dp_encode_sideband_req(&req, msg);
 	msg->path_msg = true;
-	return 0;
 }
 
-static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
+static void build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
 				  int port_num, bool power_up)
 {
 	struct drm_dp_sideband_msg_req_body req;
@@ -1078,7 +1071,6 @@ static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
 	req.u.port_num.port_number = port_num;
 	drm_dp_encode_sideband_req(&req, msg);
 	msg->path_msg = true;
-	return 0;
 }
 
 static int drm_dp_mst_assign_payload_id(struct drm_dp_mst_topology_mgr *mgr,
@@ -1744,14 +1736,13 @@ static u8 drm_dp_calculate_rad(struct drm_dp_mst_port *port,
  */
 static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
 {
-	int ret;
 	u8 rad[6], lct;
 	bool send_link = false;
 	switch (port->pdt) {
 	case DP_PEER_DEVICE_DP_LEGACY_CONV:
 	case DP_PEER_DEVICE_SST_SINK:
 		/* add i2c over sideband */
-		ret = drm_dp_mst_register_i2c_bus(&port->aux);
+		drm_dp_mst_register_i2c_bus(&port->aux);
 		break;
 	case DP_PEER_DEVICE_MST_BRANCHING:
 		lct = drm_dp_calculate_rad(port, rad);
@@ -1821,25 +1812,20 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux *aux,
 
 static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 *guid)
 {
-	int ret;
-
 	memcpy(mstb->guid, guid, 16);
 
 	if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
 		if (mstb->port_parent) {
-			ret = drm_dp_send_dpcd_write(
-					mstb->mgr,
-					mstb->port_parent,
-					DP_GUID,
-					16,
-					mstb->guid);
+			drm_dp_send_dpcd_write(mstb->mgr,
+					       mstb->port_parent,
+					       DP_GUID,
+					       16,
+					       mstb->guid);
 		} else {
-
-			ret = drm_dp_dpcd_write(
-					mstb->mgr->aux,
-					DP_GUID,
-					mstb->guid,
-					16);
+			drm_dp_dpcd_write(mstb->mgr->aux,
+					  DP_GUID,
+					  mstb->guid,
+					  16);
 		}
 	}
 }
@@ -2195,7 +2181,7 @@ static bool drm_dp_validate_guid(struct drm_dp_mst_topology_mgr *mgr,
 	return false;
 }
 
-static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes)
+static void build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32 offset, u8 num_bytes)
 {
 	struct drm_dp_sideband_msg_req_body req;
 
@@ -2204,8 +2190,6 @@ static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num, u32
 	req.u.dpcd_read.dpcd_address = offset;
 	req.u.dpcd_read.num_bytes = num_bytes;
 	drm_dp_encode_sideband_req(&req, msg);
-
-	return 0;
 }
 
 static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology_mgr *mgr,
@@ -2427,14 +2411,14 @@ static void drm_dp_send_link_address(struct drm_dp_mst_topology_mgr *mgr,
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
 	struct drm_dp_link_address_ack_reply *reply;
-	int i, len, ret;
+	int i, ret;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
 	if (!txmsg)
 		return;
 
 	txmsg->dst = mstb;
-	len = build_link_address(txmsg);
+	build_link_address(txmsg);
 
 	mstb->link_address_sent = true;
 	drm_dp_queue_down_tx(mgr, txmsg);
@@ -2476,7 +2460,6 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
 {
 	struct drm_dp_enum_path_resources_ack_reply *path_res;
 	struct drm_dp_sideband_msg_tx *txmsg;
-	int len;
 	int ret;
 
 	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
@@ -2484,7 +2467,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_topology_mgr *mgr,
 		return -ENOMEM;
 
 	txmsg->dst = mstb;
-	len = build_enum_path_resources(txmsg, port->port_num);
+	build_enum_path_resources(txmsg, port->port_num);
 
 	drm_dp_queue_down_tx(mgr, txmsg);
 
@@ -2567,7 +2550,7 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
 	struct drm_dp_mst_branch *mstb;
-	int len, ret, port_num;
+	int ret, port_num;
 	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
 	int i;
 
@@ -2592,9 +2575,9 @@ static int drm_dp_payload_send_msg(struct drm_dp_mst_topology_mgr *mgr,
 		sinks[i] = i;
 
 	txmsg->dst = mstb;
-	len = build_allocate_payload(txmsg, port_num,
-				     id,
-				     pbn, port->num_sdp_streams, sinks);
+	build_allocate_payload(txmsg, port_num,
+			       id,
+			       pbn, port->num_sdp_streams, sinks);
 
 	drm_dp_queue_down_tx(mgr, txmsg);
 
@@ -2623,7 +2606,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_port *port, bool power_up)
 {
 	struct drm_dp_sideband_msg_tx *txmsg;
-	int len, ret;
+	int ret;
 
 	port = drm_dp_mst_topology_get_port_validated(mgr, port);
 	if (!port)
@@ -2636,7 +2619,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_topology_mgr *mgr,
 	}
 
 	txmsg->dst = port->parent;
-	len = build_power_updown_phy(txmsg, port->port_num, power_up);
+	build_power_updown_phy(txmsg, port->port_num, power_up);
 	drm_dp_queue_down_tx(mgr, txmsg);
 
 	ret = drm_dp_mst_wait_tx_reply(port->parent, txmsg);
@@ -2856,7 +2839,6 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_topology_mgr *mgr,
 				 struct drm_dp_mst_port *port,
 				 int offset, int size, u8 *bytes)
 {
-	int len;
 	int ret = 0;
 	struct drm_dp_sideband_msg_tx *txmsg;
 	struct drm_dp_mst_branch *mstb;
@@ -2871,7 +2853,7 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_topology_mgr *mgr,
 		goto fail_put;
 	}
 
-	len = build_dpcd_read(txmsg, port->port_num, offset, size);
+	build_dpcd_read(txmsg, port->port_num, offset, size);
 	txmsg->dst = port->parent;
 
 	drm_dp_queue_down_tx(mgr, txmsg);
@@ -2909,7 +2891,6 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
 				  struct drm_dp_mst_port *port,
 				  int offset, int size, u8 *bytes)
 {
-	int len;
 	int ret;
 	struct drm_dp_sideband_msg_tx *txmsg;
 	struct drm_dp_mst_branch *mstb;
@@ -2924,7 +2905,7 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst_topology_mgr *mgr,
 		goto fail_put;
 	}
 
-	len = build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
+	build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
 	txmsg->dst = mstb;
 
 	drm_dp_queue_down_tx(mgr, txmsg);
@@ -3147,7 +3128,7 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
 {
 	int len;
 	u8 replyblock[32];
-	int replylen, origlen, curreply;
+	int replylen, curreply;
 	int ret;
 	struct drm_dp_sideband_msg_rx *msg;
 	int basereg = up ? DP_SIDEBAND_MSG_UP_REQ_BASE : DP_SIDEBAND_MSG_DOWN_REP_BASE;
@@ -3167,7 +3148,6 @@ static bool drm_dp_get_one_sb_msg(struct drm_dp_mst_topology_mgr *mgr, bool up)
 	}
 	replylen = msg->curchunk_len + msg->curchunk_hdrlen;
 
-	origlen = replylen;
 	replylen -= len;
 	curreply = len;
 	while (replylen > 0) {
@@ -3959,17 +3939,16 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
 	mutex_lock(&mgr->lock);
 	if (mgr->mst_primary) {
 		u8 buf[DP_PAYLOAD_TABLE_SIZE];
-		int ret;
 
-		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
+		drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_RECEIVER_CAP_SIZE);
 		seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
-		ret = drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
+		drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
 		seq_printf(m, "faux/mst: %*ph\n", 2, buf);
-		ret = drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
+		drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
 		seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
 
 		/* dump the standard OUI branch header */
-		ret = drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
+		drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP_BRANCH_OUI_HEADER_SIZE);
 		seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
 		for (i = 0x3; i < 0x8 && buf[i]; i++)
 			seq_printf(m, "%c", buf[i]);
-- 
2.15.0

