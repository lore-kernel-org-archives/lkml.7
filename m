Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CEFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C96E20872
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvMDnDEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfCSGlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:41:04 -0400
Received: from mail-vs1-f74.google.com ([209.85.217.74]:47179 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfCSGlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:41:03 -0400
Received: by mail-vs1-f74.google.com with SMTP id m16so4451504vsp.14
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+k6OZ3DLwWWLcyqVVOMyxiV6o4ihkG7WcaE8OYTG2qM=;
        b=mvMDnDEdJ85V1hpQELk6qMP0DpGWQXQRyrmJCcp5lhGYcqZCzSAJTS4QUkRZUyFtBv
         vC1vkH0KFMtyK4NF73QnTDFhgoKxhQltKFcYszEr2nTf3x2sNUwLiRcDZiXC3md7z3Jr
         DeSVw58kIku+U9GTpyYZ7wy2VQBcNbyUnUwHkqCygwHxVe2TSS2xCnLjkDsxAm+QuvSp
         vM0qsi8RKFLM47xeauSTg27GfpoYEKbicSQCSOLdX1x1cCHzhlxL1kbAFZU8jrfFdvF7
         5Do7GAhsypJEaBvAw9xz1MkisSrNLS0my1P4iIwoQPP/ZbIpBjdMl/XiR7BFSiqAslan
         7TBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+k6OZ3DLwWWLcyqVVOMyxiV6o4ihkG7WcaE8OYTG2qM=;
        b=EHtvQmxpMrpJpZGGi19iSNiaWs4oXxq2NkCOJquoNhyc+pmw0yjvPYKCzUUJaQHj2G
         uYGrSRKgQqoVmICLRSHrvA9wsDrnV8SsjevRMQeTUgRqQ8SIKodN3/ntkkNLg7qU5XyL
         wJJntLBdwwdys0P7r/OPMCnv0Q/zLqs3YIG31478w5nMBx8JiPiFu3CJCsNrrfpDA6aQ
         dLqsrSkX4ZcZPm7RpUWe6rU7R0maVm34dEuZHsxFoJ2dcLR4yQtr2+JkmVgT79/ZkrBd
         uL4v+7vkRPady3/z2UNtcpjKeK0GV4zOlcQvrVF/z7E1jF1nilIeG6zz1E+8dWjB/WWY
         mrCw==
X-Gm-Message-State: APjAAAUe3t+RUv//sshKYCVHul2tdLZKb0yL2xeJq8WKopJqLTm0W4lS
        2vIGbih/cLhw3t4WDFTpLO7l9wxVvb0u
X-Google-Smtp-Source: APXvYqzcHUqIDZ5q/GCtW9t0zr8cayy6KWBqHVn6Dc+27o7sTDReJsLfd87f25yxKg5fjLtKG5D0GFiSANN4
X-Received: by 2002:a1f:be47:: with SMTP id o68mr6298481vkf.19.1552977661353;
 Mon, 18 Mar 2019 23:41:01 -0700 (PDT)
Date:   Tue, 19 Mar 2019 14:40:50 +0800
Message-Id: <20190319064050.149212-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
Subject: [PATCH] usb: typec: tcpm: collision avoidance
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the implementation of Collision Avoidance introduced
in PD3.0. The start of each Atomic Message Sequence (AMS) initiated by
the port will be denied if the current AMS is not interruptible. The
Source port will set the CC to SinkTxNG if it is going to initiate an
AMS, and SinkTxOk otherwise. Meanwhile, any AMS initiated by a Sink port
will be denied in TCPM if the port partner (Source) sets SinkTxNG except
for HARD_RESET and SOFT_RESET.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 539 ++++++++++++++++++++++++++++++----
 include/linux/usb/pd.h        |   1 +
 include/linux/usb/tcpm.h      |   4 +
 3 files changed, 484 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0f62db091d8d..312008cdc7d3 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -71,6 +71,8 @@
 	S(SNK_HARD_RESET_SINK_ON),		\
 						\
 	S(SOFT_RESET),				\
+	S(SRC_SOFT_RESET_WAIT_SNK_TX),		\
+	S(SNK_SOFT_RESET),			\
 	S(SOFT_RESET_SEND),			\
 						\
 	S(DR_SWAP_ACCEPT),			\
@@ -124,7 +126,45 @@
 						\
 	S(ERROR_RECOVERY),			\
 	S(PORT_RESET),				\
-	S(PORT_RESET_WAIT_OFF)
+	S(PORT_RESET_WAIT_OFF),			\
+						\
+	S(AMS_START)
+
+#define FOREACH_AMS(S)				\
+	S(NONE_AMS),				\
+	S(POWER_NEGOTIATION),			\
+	S(GOTOMIN),				\
+	S(SOFT_RESET_AMS),			\
+	S(HARD_RESET),				\
+	S(CABLE_RESET),				\
+	S(GET_SOURCE_CAPABILITIES),		\
+	S(GET_SINK_CAPABILITIES),		\
+	S(POWER_ROLE_SWAP),			\
+	S(FAST_ROLE_SWAP),			\
+	S(DATA_ROLE_SWAP),			\
+	S(VCONN_SWAP),				\
+	S(SOURCE_ALERT),			\
+	S(GETTING_SOURCE_EXTENDED_CAPABILITIES),\
+	S(GETTING_SOURCE_SINK_STATUS),		\
+	S(GETTING_BATTERY_CAPABILITIES),	\
+	S(GETTING_BATTERY_STATUS),		\
+	S(GETTING_MANUFACTURER_INFORMATION),	\
+	S(SECURITY),				\
+	S(FIRMWARE_UPDATE),			\
+	S(DISCOVER_IDENTITY),			\
+	S(SOURCE_STARTUP_CABLE_PLUG_DISCOVER_IDENTITY),	\
+	S(DISCOVER_SVIDS),			\
+	S(DISCOVER_MODES),			\
+	S(DFP_TO_UFP_ENTER_MODE),		\
+	S(DFP_TO_UFP_EXIT_MODE),		\
+	S(DFP_TO_CABLE_PLUG_ENTER_MODE),	\
+	S(DFP_TO_CABLE_PLUG_EXIT_MODE),		\
+	S(ATTENTION),				\
+	S(BIST),				\
+	S(UNSTRUCTURED_VDMS),			\
+	S(STRUCTURED_VDMS),			\
+	S(COUNTRY_INFO),			\
+	S(COUNTRY_CODES)
 
 #define GENERATE_ENUM(e)	e
 #define GENERATE_STRING(s)	#s
@@ -137,6 +177,14 @@ static const char * const tcpm_states[] = {
 	FOREACH_STATE(GENERATE_STRING)
 };
 
+enum tcpm_ams {
+	FOREACH_AMS(GENERATE_ENUM)
+};
+
+static const char * const tcpm_ams_str[] = {
+	FOREACH_AMS(GENERATE_STRING)
+};
+
 enum vdm_states {
 	VDM_STATE_ERR_BUSY = -3,
 	VDM_STATE_ERR_SEND = -2,
@@ -146,6 +194,7 @@ enum vdm_states {
 	VDM_STATE_READY = 1,
 	VDM_STATE_BUSY = 2,
 	VDM_STATE_WAIT_RSP_BUSY = 3,
+	VDM_STATE_SEND_MESSAGE = 4,
 };
 
 enum pd_msg_request {
@@ -320,6 +369,11 @@ struct tcpm_port {
 	/* port belongs to a self powered device */
 	bool self_powered;
 
+	/* Collision Avoidance and Atomic Message Sequence */
+	enum tcpm_state upcoming_state;
+	enum tcpm_ams ams;
+	bool in_ams;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *dentry;
 	struct mutex logbuffer_lock;	/* log buffer access lock */
@@ -371,6 +425,16 @@ struct pd_rx_event {
 	((port)->try_src_count == 0 && (port)->try_role == TYPEC_SOURCE && \
 	(port)->port_type == TYPEC_PORT_DRP)
 
+#define tcpm_sink_tx_ok(port) \
+	(tcpm_port_is_sink(port) && \
+	((port)->cc1 == TYPEC_CC_RP_3_0 || (port)->cc2 == TYPEC_CC_RP_3_0))
+
+#define tcpm_switch_state(port, state, delay) \
+	do { \
+		(port)->upcoming_state = INVALID_STATE; \
+		tcpm_set_state(port, state, delay); \
+	} while (0)
+
 static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
 {
 	if (port->port_type == TYPEC_PORT_DRP) {
@@ -600,6 +664,9 @@ static void tcpm_debugfs_exit(const struct tcpm_port *port) { }
 
 #endif
 
+static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams,
+			  bool start);
+
 static int tcpm_pd_transmit(struct tcpm_port *port,
 			    enum tcpm_transmit_type type,
 			    const struct pd_message *msg)
@@ -627,13 +694,30 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
 	switch (port->tx_status) {
 	case TCPC_TX_SUCCESS:
 		port->message_id = (port->message_id + 1) & PD_HEADER_ID_MASK;
-		return 0;
+		/*
+		 * USB PD rev 3.0, 8.3.2.1.3:
+		 * "... Note that every AMS is Interruptible until the first
+		 * Message in the sequence has been successfully sent (GoodCRC
+		 * Message received)."
+		 */
+		if ((port->negotiated_rev >= PD_REV30) &&
+		    (port->ams != NONE_AMS))
+			port->in_ams = true;
+		break;
 	case TCPC_TX_DISCARDED:
-		return -EAGAIN;
+		ret = -EAGAIN;
+		break;
 	case TCPC_TX_FAILED:
 	default:
-		return -EIO;
+		ret = -EIO;
+		break;
 	}
+
+	/* Some AMS don't expect responses. Finish them here. */
+	if (port->ams == ATTENTION || port->ams == SOURCE_ALERT)
+		tcpm_ams_start(port, port->ams, false);
+
+	return ret;
 }
 
 void tcpm_pd_transmit_complete(struct tcpm_port *port,
@@ -883,17 +967,20 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
 			   unsigned int delay_ms)
 {
 	if (delay_ms) {
-		tcpm_log(port, "pending state change %s -> %s @ %u ms",
-			 tcpm_states[port->state], tcpm_states[state],
-			 delay_ms);
+		tcpm_log(port, "pending state change %s -> %s @ %u ms [%s]",
+			 tcpm_states[port->state], tcpm_states[state], delay_ms,
+			 port->negotiated_rev >= PD_REV30 ?
+			 tcpm_ams_str[port->ams] : "");
 		port->delayed_state = state;
 		mod_delayed_work(port->wq, &port->state_machine,
 				 msecs_to_jiffies(delay_ms));
 		port->delayed_runtime = jiffies + msecs_to_jiffies(delay_ms);
 		port->delay_ms = delay_ms;
 	} else {
-		tcpm_log(port, "state change %s -> %s",
-			 tcpm_states[port->state], tcpm_states[state]);
+		tcpm_log(port, "state change %s -> %s [%s]",
+			 tcpm_states[port->state], tcpm_states[state],
+			 port->negotiated_rev >= PD_REV30 ?
+			 tcpm_ams_str[port->ams] : "");
 		port->delayed_state = INVALID_STATE;
 		port->prev_state = port->state;
 		port->state = state;
@@ -915,10 +1002,12 @@ static void tcpm_set_state_cond(struct tcpm_port *port, enum tcpm_state state,
 		tcpm_set_state(port, state, delay_ms);
 	else
 		tcpm_log(port,
-			 "skipped %sstate change %s -> %s [%u ms], context state %s",
+			 "skipped %sstate change %s -> %s [%u ms], context state %s [%s]",
 			 delay_ms ? "delayed " : "",
 			 tcpm_states[port->state], tcpm_states[state],
-			 delay_ms, tcpm_states[port->enter_state]);
+			 delay_ms, tcpm_states[port->enter_state],
+			 port->negotiated_rev >= PD_REV30 ?
+			 tcpm_ams_str[port->ams] : "");
 }
 
 static void tcpm_queue_message(struct tcpm_port *port,
@@ -928,6 +1017,160 @@ static void tcpm_queue_message(struct tcpm_port *port,
 	mod_delayed_work(port->wq, &port->state_machine, 0);
 }
 
+static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
+{
+	tcpm_log(port, "cc:=%d", cc);
+	port->cc_req = cc;
+	port->tcpc->set_cc(port->tcpc, cc);
+}
+
+static bool tcpm_vdm_ams(struct tcpm_port *port)
+{
+	switch (port->ams) {
+	case DISCOVER_IDENTITY:
+	case SOURCE_STARTUP_CABLE_PLUG_DISCOVER_IDENTITY:
+	case DISCOVER_SVIDS:
+	case DISCOVER_MODES:
+	case DFP_TO_UFP_ENTER_MODE:
+	case DFP_TO_UFP_EXIT_MODE:
+	case DFP_TO_CABLE_PLUG_ENTER_MODE:
+	case DFP_TO_CABLE_PLUG_EXIT_MODE:
+	case ATTENTION:
+	case UNSTRUCTURED_VDMS:
+	case STRUCTURED_VDMS:
+		break;
+	default:
+		return false;
+	}
+
+	return true;
+}
+
+static bool tcpm_ams_interruptible(struct tcpm_port *port)
+{
+	switch (port->ams) {
+	/* Interruptible AMS */
+	case NONE_AMS:
+	case SECURITY:
+	case FIRMWARE_UPDATE:
+	case DISCOVER_IDENTITY:
+	case SOURCE_STARTUP_CABLE_PLUG_DISCOVER_IDENTITY:
+	case DISCOVER_SVIDS:
+	case DISCOVER_MODES:
+	case DFP_TO_UFP_ENTER_MODE:
+	case DFP_TO_UFP_EXIT_MODE:
+	case DFP_TO_CABLE_PLUG_ENTER_MODE:
+	case DFP_TO_CABLE_PLUG_EXIT_MODE:
+	case UNSTRUCTURED_VDMS:
+	case STRUCTURED_VDMS:
+	case COUNTRY_INFO:
+	case COUNTRY_CODES:
+		break;
+	/* Non-Interruptible AMS */
+	default:
+		if (port->in_ams)
+			return false;
+		break;
+	}
+
+	return true;
+}
+
+static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams, bool start)
+{
+	int ret = 0;
+
+	if (port->negotiated_rev < PD_REV30) {
+		port->upcoming_state = INVALID_STATE;
+		return -EOPNOTSUPP;
+	}
+
+	if (!start)
+		goto ams_finish;
+
+	tcpm_log(port, "AMS: %s start", tcpm_ams_str[ams]);
+
+	if (!tcpm_ams_interruptible(port) && ams != HARD_RESET) {
+		port->upcoming_state = INVALID_STATE;
+		tcpm_log(port, "AMS: %s not interruptible, aborting",
+			 tcpm_ams_str[port->ams]);
+		return -EAGAIN;
+	}
+
+	if (port->pwr_role == TYPEC_SOURCE) {
+		enum typec_cc_status cc_req;
+
+		port->ams = ams;
+
+		if (ams == HARD_RESET) {
+			tcpm_set_cc(port, tcpm_rp_cc(port));
+			tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
+			tcpm_set_state(port, HARD_RESET_START, 0);
+			return 0;
+		} else if (ams == SOFT_RESET_AMS) {
+			if (!port->explicit_contract) {
+				port->upcoming_state = INVALID_STATE;
+				tcpm_set_cc(port, tcpm_rp_cc(port));
+				return 0;
+			}
+		} else if (tcpm_vdm_ams(port)) {
+			/* tSinkTx is enforced in vdm_run_state_machine */
+			tcpm_set_cc(port, SINK_TX_NG);
+			return 0;
+		}
+
+		cc_req = port->cc_req;
+		tcpm_set_cc(port, SINK_TX_NG);
+		if (port->state == SRC_READY ||
+		    port->state == SRC_STARTUP ||
+		    port->state == SRC_SOFT_RESET_WAIT_SNK_TX ||
+		    port->state == SOFT_RESET ||
+		    port->state == SOFT_RESET_SEND)
+			tcpm_set_state(port, AMS_START, cc_req == SINK_TX_OK ?
+				       PD_T_SINK_TX : 0);
+		else
+			tcpm_set_state(port, SRC_READY, cc_req == SINK_TX_OK ?
+				       PD_T_SINK_TX : 0);
+	} else {
+		if (!tcpm_sink_tx_ok(port) &&
+		    ams != SOFT_RESET_AMS &&
+		    ams != HARD_RESET) {
+			port->upcoming_state = INVALID_STATE;
+			tcpm_log(port, "Sink TX No Go");
+			return -EAGAIN;
+		}
+
+		port->ams = ams;
+
+		if (ams == HARD_RESET) {
+			tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
+			tcpm_set_state(port, HARD_RESET_START, 0);
+			return 0;
+		} else if (tcpm_vdm_ams(port)) {
+			return 0;
+		}
+
+		if (port->state == SNK_READY ||
+		    port->state == SNK_SOFT_RESET)
+			tcpm_set_state(port, AMS_START, 0);
+		else
+			tcpm_set_state(port, SNK_READY, 0);
+	}
+
+	return ret;
+
+ams_finish:
+	tcpm_log(port, "AMS: %s finished", tcpm_ams_str[ams]);
+
+	if (port->pwr_role == TYPEC_SOURCE)
+		tcpm_set_cc(port, SINK_TX_OK);
+
+	port->in_ams = false;
+	port->ams = NONE_AMS;
+
+	return ret;
+}
+
 /*
  * VDM/VDO handling functions
  */
@@ -1164,6 +1407,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		default:
 			break;
 		}
+		tcpm_ams_start(port, port->ams, false);
 		break;
 	case CMDT_RSP_NAK:
 		switch (cmd) {
@@ -1175,6 +1419,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		default:
 			break;
 		}
+		tcpm_ams_start(port, port->ams, false);
 		break;
 	default:
 		break;
@@ -1260,7 +1505,7 @@ static unsigned int vdm_ready_timeout(u32 vdm_hdr)
 static void vdm_run_state_machine(struct tcpm_port *port)
 {
 	struct pd_message msg;
-	int i, res;
+	int i, res = 0;
 
 	switch (port->vdm_state) {
 	case VDM_STATE_READY:
@@ -1277,27 +1522,47 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		if (port->state != SRC_READY && port->state != SNK_READY)
 			break;
 
-		/* Prepare and send VDM */
-		memset(&msg, 0, sizeof(msg));
-		msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
-					  port->pwr_role,
-					  port->data_role,
-					  port->negotiated_rev,
-					  port->message_id, port->vdo_count);
-		for (i = 0; i < port->vdo_count; i++)
-			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
-		res = tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
-		if (res < 0) {
-			port->vdm_state = VDM_STATE_ERR_SEND;
-		} else {
-			unsigned long timeout;
+		if (PD_VDO_CMDT(port->vdo_data[0]) == CMDT_INIT) {
+			switch (PD_VDO_CMD(port->vdo_data[0])) {
+			case CMD_DISCOVER_IDENT:
+				res = tcpm_ams_start(port, DISCOVER_IDENTITY,
+						     true);
+				break;
+			case CMD_DISCOVER_SVID:
+				res = tcpm_ams_start(port, DISCOVER_SVIDS,
+						     true);
+				break;
+			case CMD_DISCOVER_MODES:
+				res = tcpm_ams_start(port, DISCOVER_MODES,
+						     true);
+				break;
+			case CMD_ENTER_MODE:
+				res = tcpm_ams_start(port,
+						     DFP_TO_UFP_ENTER_MODE,
+						     true);
+				break;
+			case CMD_EXIT_MODE:
+				res = tcpm_ams_start(port, DFP_TO_UFP_EXIT_MODE,
+						     true);
+				break;
+			case CMD_ATTENTION:
+				res = tcpm_ams_start(port, ATTENTION, true);
+				break;
+			default:
+				res = -EOPNOTSUPP;
+				break;
+			}
 
-			port->vdm_retries = 0;
-			port->vdm_state = VDM_STATE_BUSY;
-			timeout = vdm_ready_timeout(port->vdo_data[0]);
-			mod_delayed_work(port->wq, &port->vdm_state_machine,
-					 timeout);
+			if (res == -EAGAIN)
+				return;
 		}
+
+		port->vdm_state = VDM_STATE_SEND_MESSAGE;
+		mod_delayed_work(port->wq, &port->vdm_state_machine,
+				 (res != -EOPNOTSUPP) &&
+				 (port->pwr_role == TYPEC_SOURCE) &&
+				 (PD_VDO_CMDT(port->vdo_data[0]) == CMDT_INIT) ?
+				 PD_T_SINK_TX : 0);
 		break;
 	case VDM_STATE_WAIT_RSP_BUSY:
 		port->vdo_data[0] = port->vdo_retry;
@@ -1306,6 +1571,8 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		break;
 	case VDM_STATE_BUSY:
 		port->vdm_state = VDM_STATE_ERR_TMOUT;
+		if (port->ams != NONE_AMS)
+			tcpm_ams_start(port, port->ams, false);
 		break;
 	case VDM_STATE_ERR_SEND:
 		/*
@@ -1318,6 +1585,30 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 			tcpm_log(port, "VDM Tx error, retry");
 			port->vdm_retries++;
 			port->vdm_state = VDM_STATE_READY;
+			tcpm_ams_start(port, port->ams, false);
+		}
+		break;
+	case VDM_STATE_SEND_MESSAGE:
+		/* Prepare and send VDM */
+		memset(&msg, 0, sizeof(msg));
+		msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
+					  port->pwr_role,
+					  port->data_role,
+					  port->negotiated_rev,
+					  port->message_id, port->vdo_count);
+		for (i = 0; i < port->vdo_count; i++)
+			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
+		res = tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
+		if (res < 0) {
+			port->vdm_state = VDM_STATE_ERR_SEND;
+		} else {
+			unsigned long timeout;
+
+			port->vdm_retries = 0;
+			port->vdm_state = VDM_STATE_BUSY;
+			timeout = vdm_ready_timeout(port->vdo_data[0]);
+			mod_delayed_work(port->wq, &port->vdm_state_machine,
+					 timeout);
 		}
 		break;
 	default:
@@ -1341,7 +1632,8 @@ static void vdm_state_machine_work(struct work_struct *work)
 		prev_state = port->vdm_state;
 		vdm_run_state_machine(port);
 	} while (port->vdm_state != prev_state &&
-		 port->vdm_state != VDM_STATE_BUSY);
+		 port->vdm_state != VDM_STATE_BUSY &&
+		 port->vdm_state != VDM_STATE_SEND_MESSAGE);
 
 	mutex_unlock(&port->lock);
 }
@@ -1671,6 +1963,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 {
 	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
 	enum tcpm_state next_state;
+	int ret = 0;
 
 	switch (type) {
 	case PD_CTRL_GOOD_CRC:
@@ -1785,11 +2078,19 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		case SOFT_RESET_SEND:
 			port->message_id = 0;
 			port->rx_msgid = -1;
-			if (port->pwr_role == TYPEC_SOURCE)
-				next_state = SRC_SEND_CAPABILITIES;
-			else
-				next_state = SNK_WAIT_CAPABILITIES;
-			tcpm_set_state(port, next_state, 0);
+			if (port->ams == SOFT_RESET_AMS)
+				tcpm_ams_start(port, port->ams, false);
+			if (port->pwr_role == TYPEC_SOURCE) {
+				port->upcoming_state = SRC_SEND_CAPABILITIES;
+				ret = tcpm_ams_start(port, POWER_NEGOTIATION,
+						     true);
+				if (ret == -EOPNOTSUPP)
+					tcpm_set_state(port,
+						       SRC_SEND_CAPABILITIES,
+						       0);
+			} else {
+				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
+			}
 			break;
 		case DR_SWAP_SEND:
 			tcpm_set_state(port, DR_SWAP_CHANGE_DR, 0);
@@ -2555,13 +2856,6 @@ static bool tcpm_start_drp_toggling(struct tcpm_port *port,
 	return false;
 }
 
-static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
-{
-	tcpm_log(port, "cc:=%d", cc);
-	port->cc_req = cc;
-	port->tcpc->set_cc(port->tcpc, cc);
-}
-
 static int tcpm_init_vbus(struct tcpm_port *port)
 {
 	int ret;
@@ -2680,6 +2974,8 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 
 static void tcpm_reset_port(struct tcpm_port *port)
 {
+	port->in_ams = false;
+	port->ams = NONE_AMS;
 	tcpm_unregister_altmodes(port);
 	tcpm_typec_disconnect(port);
 	port->attached = false;
@@ -2843,6 +3139,7 @@ static void run_state_machine(struct tcpm_port *port)
 	int ret;
 	enum typec_pwr_opmode opmode;
 	unsigned int msecs;
+	enum tcpm_state upcoming_state;
 
 	port->enter_state = port->state;
 	switch (port->state) {
@@ -2945,7 +3242,14 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
-		tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+		/* SNK -> SRC POWER/FAST_ROLE_SWAP finished */
+		if (port->ams == POWER_ROLE_SWAP ||
+		    port->ams == FAST_ROLE_SWAP)
+			tcpm_ams_start(port, port->ams, false);
+		port->upcoming_state = SRC_SEND_CAPABILITIES;
+		ret = tcpm_ams_start(port, POWER_NEGOTIATION, true);
+		if (ret == -EOPNOTSUPP)
+			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
 		break;
 	case SRC_SEND_CAPABILITIES:
 		port->caps_count++;
@@ -3003,6 +3307,18 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
 
+		if (port->ams != NONE_AMS)
+			tcpm_ams_start(port, port->ams, false);
+		/*
+		 * If previous AMS is interrupted, switch to the upcoming
+		 * state.
+		 */
+		upcoming_state = port->upcoming_state;
+		if (port->upcoming_state != INVALID_STATE) {
+			tcpm_switch_state(port, upcoming_state, 0);
+			break;
+		}
+
 		tcpm_check_send_discover(port);
 		/*
 		 * 6.3.5
@@ -3120,6 +3436,12 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
+
+		if (port->ams == POWER_ROLE_SWAP ||
+		    port->ams == FAST_ROLE_SWAP)
+			/* SRC -> SNK POWER/FAST_ROLE_SWAP finished */
+			tcpm_ams_start(port, port->ams, false);
+
 		tcpm_set_state(port, SNK_DISCOVERY, 0);
 		break;
 	case SNK_DISCOVERY:
@@ -3169,7 +3491,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		if (port->vbus_never_low) {
 			port->vbus_never_low = false;
-			tcpm_set_state(port, SOFT_RESET_SEND,
+			tcpm_set_state(port, SNK_SOFT_RESET,
 				       PD_T_SINK_WAIT_CAP);
 		} else {
 			tcpm_set_state(port, hard_reset_state(port),
@@ -3222,9 +3544,21 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
-		tcpm_check_send_discover(port);
 		tcpm_pps_complete(port, port->pps_status);
 
+		if (port->ams != NONE_AMS)
+			tcpm_ams_start(port, port->ams, false);
+		/*
+		 * If previous AMS is interrupted, switch to the upcoming
+		 * state.
+		 */
+		upcoming_state = port->upcoming_state;
+		if (port->upcoming_state != INVALID_STATE) {
+			tcpm_switch_state(port, upcoming_state, 0);
+			break;
+		}
+
+		tcpm_check_send_discover(port);
 		power_supply_changed(port->psy);
 
 		break;
@@ -3246,8 +3580,18 @@ static void run_state_machine(struct tcpm_port *port)
 
 	/* Hard_Reset states */
 	case HARD_RESET_SEND:
-		tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
-		tcpm_set_state(port, HARD_RESET_START, 0);
+		if (port->ams != NONE_AMS)
+			tcpm_ams_start(port, port->ams, false);
+		/*
+		 * State machine will be directed to HARD_RESET_START,
+		 * thus set upcoming_state to INVALID_STATE.
+		 */
+		port->upcoming_state = INVALID_STATE;
+		ret = tcpm_ams_start(port, HARD_RESET, true);
+		if (ret == -EOPNOTSUPP) {
+			tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
+			tcpm_set_state(port, HARD_RESET_START, 0);
+		}
 		break;
 	case HARD_RESET_START:
 		port->hard_reset_count++;
@@ -3269,6 +3613,8 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SRC_HARD_RESET_VBUS_ON:
 		tcpm_set_vbus(port, true);
+		if (port->ams == HARD_RESET)
+			tcpm_ams_start(port, port->ams, false);
 		port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
@@ -3288,6 +3634,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, SNK_HARD_RESET_SINK_ON, PD_T_SAFE_0V);
 		break;
 	case SNK_HARD_RESET_WAIT_VBUS:
+		if (port->ams == HARD_RESET)
+			tcpm_ams_start(port, port->ams, false);
 		/* Assume we're disconnected if VBUS doesn't come back. */
 		tcpm_set_state(port, SNK_UNATTACHED,
 			       PD_T_SRC_RECOVER_MAX + PD_T_SRC_TURN_ON);
@@ -3315,6 +3663,8 @@ static void run_state_machine(struct tcpm_port *port)
 					       5000);
 			tcpm_set_charge(port, true);
 		}
+		if (port->ams == HARD_RESET)
+			tcpm_ams_start(port, port->ams, false);
 		tcpm_set_attached_state(port, true);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
@@ -3324,10 +3674,23 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
-		if (port->pwr_role == TYPEC_SOURCE)
-			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
-		else
+		if (port->pwr_role == TYPEC_SOURCE) {
+			port->upcoming_state = SRC_SEND_CAPABILITIES;
+			ret = tcpm_ams_start(port, POWER_NEGOTIATION, true);
+			if (ret == -EOPNOTSUPP)
+				tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+		} else {
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
+		}
+		break;
+	case SRC_SOFT_RESET_WAIT_SNK_TX:
+	case SNK_SOFT_RESET:
+		if (port->ams != NONE_AMS)
+			tcpm_ams_start(port, port->ams, false);
+		port->upcoming_state = SOFT_RESET_SEND;
+		ret = tcpm_ams_start(port, SOFT_RESET_AMS, true);
+		if (ret == -EOPNOTSUPP)
+			tcpm_set_state(port, SOFT_RESET_SEND, 0);
 		break;
 	case SOFT_RESET_SEND:
 		port->message_id = 0;
@@ -3533,6 +3896,18 @@ static void run_state_machine(struct tcpm_port *port)
 			       tcpm_default_state(port),
 			       port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
 		break;
+
+	/* Collision Avoidance state */
+	case AMS_START:
+		if (port->upcoming_state == INVALID_STATE) {
+			tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ?
+				       SRC_READY : SNK_READY, 0);
+			break;
+		}
+
+		upcoming_state = port->upcoming_state;
+		tcpm_switch_state(port, upcoming_state, 0);
+		break;
 	default:
 		WARN(1, "Unexpected port state %d\n", port->state);
 		break;
@@ -3859,6 +4234,8 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 {
 	tcpm_log_force(port, "Received hard reset");
+	if (port->ams != NONE_AMS)
+		port->ams = NONE_AMS;
 	/*
 	 * If we keep receiving hard reset requests, executing the hard reset
 	 * must have failed. Revert to error recovery if that happens.
@@ -3976,7 +4353,14 @@ static int tcpm_dr_set(const struct typec_capability *cap,
 		port->non_pd_role_swap = true;
 		tcpm_set_state(port, PORT_RESET, 0);
 	} else {
-		tcpm_set_state(port, DR_SWAP_SEND, 0);
+		port->upcoming_state = DR_SWAP_SEND;
+		ret = tcpm_ams_start(port, DATA_ROLE_SWAP, true);
+		if (ret == -EAGAIN) {
+			port->upcoming_state = INVALID_STATE;
+			goto port_unlock;
+		} else if (ret == -EOPNOTSUPP) {
+			tcpm_switch_state(port, DR_SWAP_SEND, 0);
+		}
 	}
 
 	port->swap_status = 0;
@@ -4023,10 +4407,18 @@ static int tcpm_pr_set(const struct typec_capability *cap,
 		goto port_unlock;
 	}
 
+	port->upcoming_state = PR_SWAP_SEND;
+	ret = tcpm_ams_start(port, POWER_ROLE_SWAP, true);
+	if (ret == -EAGAIN) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	} else if (ret == -EOPNOTSUPP) {
+		tcpm_switch_state(port, PR_SWAP_SEND, 0);
+	}
+
 	port->swap_status = 0;
 	port->swap_pending = true;
 	reinit_completion(&port->swap_complete);
-	tcpm_set_state(port, PR_SWAP_SEND, 0);
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
@@ -4063,10 +4455,18 @@ static int tcpm_vconn_set(const struct typec_capability *cap,
 		goto port_unlock;
 	}
 
+	port->upcoming_state = VCONN_SWAP_SEND;
+	ret = tcpm_ams_start(port, VCONN_SWAP, true);
+	if (ret == -EAGAIN) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	} else if (ret == -EOPNOTSUPP) {
+		tcpm_switch_state(port, VCONN_SWAP_SEND, 0);
+	}
+
 	port->swap_status = 0;
 	port->swap_pending = true;
 	reinit_completion(&port->swap_complete);
-	tcpm_set_state(port, VCONN_SWAP_SEND, 0);
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
@@ -4131,6 +4531,13 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 		goto port_unlock;
 	}
 
+	port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+	ret = tcpm_ams_start(port, POWER_NEGOTIATION, true);
+	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	}
+
 	/* Round down operating current to align with PPS valid steps */
 	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
 
@@ -4138,7 +4545,6 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 	port->pps_data.op_curr = op_curr;
 	port->pps_status = 0;
 	port->pps_pending = true;
-	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->pps_complete,
@@ -4187,6 +4593,13 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 		goto port_unlock;
 	}
 
+	port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+	ret = tcpm_ams_start(port, POWER_NEGOTIATION, true);
+	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	}
+
 	/* Round down output voltage to align with PPS valid steps */
 	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
 
@@ -4194,7 +4607,6 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 	port->pps_data.out_volt = out_volt;
 	port->pps_status = 0;
 	port->pps_pending = true;
-	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->pps_complete,
@@ -4234,6 +4646,16 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 		goto port_unlock;
 	}
 
+	if (activate)
+		port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+	else
+		port->upcoming_state = SNK_NEGOTIATE_CAPABILITIES;
+	ret = tcpm_ams_start(port, POWER_NEGOTIATION, true);
+	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	}
+
 	reinit_completion(&port->pps_complete);
 	port->pps_status = 0;
 	port->pps_pending = true;
@@ -4242,9 +4664,6 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 	if (activate) {
 		port->pps_data.out_volt = port->supply_voltage;
 		port->pps_data.op_curr = port->current_limit;
-		tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
-	} else {
-		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
 	}
 	mutex_unlock(&port->lock);
 
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index f2162e0fe531..6296ef65dab6 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -451,6 +451,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
 #define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
 #define PD_T_NEWSRC            250     /* Maximum of 275ms */
+#define PD_T_SINK_TX		16	/* 16 - 20 ms */
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 0c532ca3f079..419929a10549 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -28,6 +28,10 @@ enum typec_cc_status {
 	TYPEC_CC_RP_3_0,
 };
 
+/* Collision Avoidance */
+#define SINK_TX_NG	TYPEC_CC_RP_1_5
+#define SINK_TX_OK	TYPEC_CC_RP_3_0
+
 enum typec_cc_polarity {
 	TYPEC_POLARITY_CC1,
 	TYPEC_POLARITY_CC2,
-- 
2.21.0.225.g810b269d1ac-goog

