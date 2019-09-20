Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC20C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965EA21929
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fv8MZdhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406634AbfITDZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:25:26 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:53724 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392102AbfITDZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:25:26 -0400
Received: by mail-vk1-f201.google.com with SMTP id q5so2156194vkg.20
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 20:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nh+2Uzk+Eex4HuEP9mzBatOey6MEgAFCtVbtILkYwoE=;
        b=fv8MZdhe94p468v0Pu275GO5Y8MhgZbs4BEiGPWQhcdogvl/YqVT38DDXGjVFuDPf7
         FPdqqPUvincleMWPZWBEKc2dK6YNr5o/RYVS3xjJwOoK98iBHAQK1+tAOOX5Ci5AiWO2
         O1x9QfNwuuk17MKChxYEwoekvutEzzIrJvNBXlZ0KjkoASyaa3vWFUjuxV6bFmKJXKrq
         ndyDGoqGCsSbOraAESY3hKmhqiBTFbM4kh2FiOpxZlp0sooVGpzQTd/TJ8O5PjRSoHUY
         /1b9lbRgf+8xVeR8L/gqgTrd5QEkWlnE4XuHPM9U+XTBY2bjxLgRbqqExUhmMyTQbgg7
         b+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nh+2Uzk+Eex4HuEP9mzBatOey6MEgAFCtVbtILkYwoE=;
        b=ZJ8SFkAr6lcIPrKtkBZ16zZawSNtYiBsfMlrE+M1hh6XmVKA8ZDsDXK+tRAvFo3kAo
         p+kO47+OLlfP9w1bHMDTLSMJQKd0vCUweh/ZPQdhVzr0QA9QRi+OvEptZ5IQlex+o0b3
         dEw3iJLZP+7xBCjV+MXy3E4vaLPZWedak8jPvv3tPcT4P9fkps/Uz+Gtn8mBZfi4YKjX
         XSP0BqFaiCL3kOBybWbP5IvTU4uprq+wS/DizN3V+DnVrbccg485r8Fy4HIO9DiNznZ2
         pXfmDtcFlSfUJhQjoOh5qOHnd6I0+8gZO0nt9DAmHlE/8izxVpX+LqM7/RhOa9qjr8Hp
         2aeg==
X-Gm-Message-State: APjAAAW7ZDPhlgPhTz4dREgZxcBk8lNWSiAm6ohmGZiTIY41Xtr3SU0i
        yOnJMvpQtrzGczlfTOV6tZsE8ua2EvPy
X-Google-Smtp-Source: APXvYqyf0eDZsQLb9o0Mu+E1zU3TMysfoggx8HvWxwMAs0Vnj8K1O7KfILHysh13gjMgtoBZ/BxuT8gaHtm/
X-Received: by 2002:a1f:8c50:: with SMTP id o77mr6750847vkd.52.1568949924026;
 Thu, 19 Sep 2019 20:25:24 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:24:36 +0800
In-Reply-To: <20190920032437.242187-1-kyletso@google.com>
Message-Id: <20190920032437.242187-2-kyletso@google.com>
Mime-Version: 1.0
References: <20190920032437.242187-1-kyletso@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v3 1/2] usb: typec: tcpm: AMS and Collision Avoidance
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, hdegoede@redhat.com,
        Adam.Thomson.Opensource@diasemi.com, linux-usb@vger.kernel.org,
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
Changelog since v2:
- (nit) changed some return values from constant 0 to variable "ret" in
  function tcpm_ams_start

 drivers/usb/typec/tcpm/tcpm.c | 538 ++++++++++++++++++++++++++++++----
 include/linux/usb/pd.h        |   1 +
 include/linux/usb/tcpm.h      |   4 +
 3 files changed, 483 insertions(+), 60 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 96562744101c..7d1c30c33097 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -73,6 +73,8 @@
 	S(SNK_HARD_RESET_SINK_ON),		\
 						\
 	S(SOFT_RESET),				\
+	S(SRC_SOFT_RESET_WAIT_SNK_TX),		\
+	S(SNK_SOFT_RESET),			\
 	S(SOFT_RESET_SEND),			\
 						\
 	S(DR_SWAP_ACCEPT),			\
@@ -126,7 +128,45 @@
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
@@ -139,6 +179,14 @@ static const char * const tcpm_states[] = {
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
@@ -148,6 +196,7 @@ enum vdm_states {
 	VDM_STATE_READY = 1,
 	VDM_STATE_BUSY = 2,
 	VDM_STATE_WAIT_RSP_BUSY = 3,
+	VDM_STATE_SEND_MESSAGE = 4,
 };
 
 enum pd_msg_request {
@@ -322,6 +371,11 @@ struct tcpm_port {
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
@@ -373,6 +427,12 @@ struct pd_rx_event {
 	((port)->try_src_count == 0 && (port)->try_role == TYPEC_SOURCE && \
 	(port)->port_type == TYPEC_PORT_DRP)
 
+#define tcpm_sink_tx_ok(port) \
+	(tcpm_port_is_sink(port) && \
+	((port)->cc1 == TYPEC_CC_RP_3_0 || (port)->cc2 == TYPEC_CC_RP_3_0))
+
+#define support_ams(port)       ((port)->negotiated_rev >= PD_REV30)
+
 static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
 {
 	if (port->port_type == TYPEC_PORT_DRP) {
@@ -608,6 +668,33 @@ static void tcpm_debugfs_exit(const struct tcpm_port *port) { }
 
 #endif
 
+static void tcpm_set_cc(struct tcpm_port *port, enum typec_cc_status cc)
+{
+	tcpm_log(port, "cc:=%d", cc);
+	port->cc_req = cc;
+	port->tcpc->set_cc(port->tcpc, cc);
+}
+
+static int tcpm_ams_finish(struct tcpm_port *port)
+{
+	int ret = 0;
+
+	if (!support_ams(port)) {
+		port->upcoming_state = INVALID_STATE;
+		return -EOPNOTSUPP;
+	}
+
+	tcpm_log(port, "AMS %s finished", tcpm_ams_str[port->ams]);
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
 static int tcpm_pd_transmit(struct tcpm_port *port,
 			    enum tcpm_transmit_type type,
 			    const struct pd_message *msg)
@@ -635,13 +722,29 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
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
+		if (support_ams(port) && port->ams != NONE_AMS)
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
+		tcpm_ams_finish(port);
+
+	return ret;
 }
 
 void tcpm_pd_transmit_complete(struct tcpm_port *port,
@@ -891,17 +994,20 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
 			   unsigned int delay_ms)
 {
 	if (delay_ms) {
-		tcpm_log(port, "pending state change %s -> %s @ %u ms",
-			 tcpm_states[port->state], tcpm_states[state],
-			 delay_ms);
+		tcpm_log(port, "pending state change %s -> %s @ %u ms%s%s",
+			 tcpm_states[port->state], tcpm_states[state], delay_ms,
+			 support_ams(port) ? " in AMS " : "",
+			 support_ams(port) ? tcpm_ams_str[port->ams] : "");
 		port->delayed_state = state;
 		mod_delayed_work(port->wq, &port->state_machine,
 				 msecs_to_jiffies(delay_ms));
 		port->delayed_runtime = jiffies + msecs_to_jiffies(delay_ms);
 		port->delay_ms = delay_ms;
 	} else {
-		tcpm_log(port, "state change %s -> %s",
-			 tcpm_states[port->state], tcpm_states[state]);
+		tcpm_log(port, "state change %s -> %s%s%s",
+			 tcpm_states[port->state], tcpm_states[state],
+			 support_ams(port) ? " in AMS " : "",
+			 support_ams(port) ? tcpm_ams_str[port->ams] : "");
 		port->delayed_state = INVALID_STATE;
 		port->prev_state = port->state;
 		port->state = state;
@@ -923,10 +1029,12 @@ static void tcpm_set_state_cond(struct tcpm_port *port, enum tcpm_state state,
 		tcpm_set_state(port, state, delay_ms);
 	else
 		tcpm_log(port,
-			 "skipped %sstate change %s -> %s [%u ms], context state %s",
+			 "skipped %sstate change %s -> %s [%u ms], context state %s%s%s",
 			 delay_ms ? "delayed " : "",
 			 tcpm_states[port->state], tcpm_states[state],
-			 delay_ms, tcpm_states[port->enter_state]);
+			 delay_ms, tcpm_states[port->enter_state],
+			 support_ams(port) ? " in AMS " : "",
+			 support_ams(port) ? tcpm_ams_str[port->ams] : "");
 }
 
 static void tcpm_queue_message(struct tcpm_port *port,
@@ -936,6 +1044,139 @@ static void tcpm_queue_message(struct tcpm_port *port,
 	mod_delayed_work(port->wq, &port->state_machine, 0);
 }
 
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
+static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams)
+{
+	int ret = 0;
+
+	if (!support_ams(port)) {
+		port->upcoming_state = INVALID_STATE;
+		return -EOPNOTSUPP;
+	}
+
+	tcpm_log(port, "AMS %s start", tcpm_ams_str[ams]);
+
+	if (!tcpm_ams_interruptible(port) && ams != HARD_RESET) {
+		port->upcoming_state = INVALID_STATE;
+		tcpm_log(port, "AMS %s not interruptible, aborting",
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
+			return ret;
+		} else if (ams == SOFT_RESET_AMS) {
+			if (!port->explicit_contract) {
+				port->upcoming_state = INVALID_STATE;
+				tcpm_set_cc(port, tcpm_rp_cc(port));
+				return ret;
+			}
+		} else if (tcpm_vdm_ams(port)) {
+			/* tSinkTx is enforced in vdm_run_state_machine */
+			tcpm_set_cc(port, SINK_TX_NG);
+			return ret;
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
+			return ret;
+		} else if (tcpm_vdm_ams(port)) {
+			return ret;
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
+}
+
 /*
  * VDM/VDO handling functions
  */
@@ -1179,6 +1420,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		default:
 			break;
 		}
+		tcpm_ams_finish(port);
 		break;
 	case CMDT_RSP_NAK:
 		switch (cmd) {
@@ -1192,6 +1434,7 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		default:
 			break;
 		}
+		tcpm_ams_finish(port);
 		break;
 	default:
 		break;
@@ -1278,7 +1521,7 @@ static unsigned int vdm_ready_timeout(u32 vdm_hdr)
 static void vdm_run_state_machine(struct tcpm_port *port)
 {
 	struct pd_message msg;
-	int i, res;
+	int i, res = 0;
 
 	switch (port->vdm_state) {
 	case VDM_STATE_READY:
@@ -1295,27 +1538,43 @@ static void vdm_run_state_machine(struct tcpm_port *port)
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
+				res = tcpm_ams_start(port, DISCOVER_IDENTITY);
+				break;
+			case CMD_DISCOVER_SVID:
+				res = tcpm_ams_start(port, DISCOVER_SVIDS);
+				break;
+			case CMD_DISCOVER_MODES:
+				res = tcpm_ams_start(port, DISCOVER_MODES);
+				break;
+			case CMD_ENTER_MODE:
+				res = tcpm_ams_start(port,
+						     DFP_TO_UFP_ENTER_MODE);
+				break;
+			case CMD_EXIT_MODE:
+				res = tcpm_ams_start(port,
+						     DFP_TO_UFP_EXIT_MODE);
+				break;
+			case CMD_ATTENTION:
+				res = tcpm_ams_start(port, ATTENTION);
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
@@ -1324,6 +1583,8 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		break;
 	case VDM_STATE_BUSY:
 		port->vdm_state = VDM_STATE_ERR_TMOUT;
+		if (port->ams != NONE_AMS)
+			tcpm_ams_finish(port);
 		break;
 	case VDM_STATE_ERR_SEND:
 		/*
@@ -1336,6 +1597,30 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 			tcpm_log(port, "VDM Tx error, retry");
 			port->vdm_retries++;
 			port->vdm_state = VDM_STATE_READY;
+			tcpm_ams_finish(port);
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
@@ -1359,7 +1644,8 @@ static void vdm_state_machine_work(struct work_struct *work)
 		prev_state = port->vdm_state;
 		vdm_run_state_machine(port);
 	} while (port->vdm_state != prev_state &&
-		 port->vdm_state != VDM_STATE_BUSY);
+		 port->vdm_state != VDM_STATE_BUSY &&
+		 port->vdm_state != VDM_STATE_SEND_MESSAGE);
 
 	mutex_unlock(&port->lock);
 }
@@ -1689,6 +1975,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 {
 	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
 	enum tcpm_state next_state;
+	int ret = 0;
 
 	switch (type) {
 	case PD_CTRL_GOOD_CRC:
@@ -1803,11 +2090,18 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		case SOFT_RESET_SEND:
 			port->message_id = 0;
 			port->rx_msgid = -1;
-			if (port->pwr_role == TYPEC_SOURCE)
-				next_state = SRC_SEND_CAPABILITIES;
-			else
-				next_state = SNK_WAIT_CAPABILITIES;
-			tcpm_set_state(port, next_state, 0);
+			if (port->ams == SOFT_RESET_AMS)
+				tcpm_ams_finish(port);
+			if (port->pwr_role == TYPEC_SOURCE) {
+				port->upcoming_state = SRC_SEND_CAPABILITIES;
+				ret = tcpm_ams_start(port, POWER_NEGOTIATION);
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
@@ -2569,13 +2863,6 @@ static bool tcpm_start_toggling(struct tcpm_port *port, enum typec_cc_status cc)
 	return ret == 0;
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
@@ -2694,6 +2981,8 @@ static void tcpm_unregister_altmodes(struct tcpm_port *port)
 
 static void tcpm_reset_port(struct tcpm_port *port)
 {
+	port->in_ams = false;
+	port->ams = NONE_AMS;
 	tcpm_unregister_altmodes(port);
 	tcpm_typec_disconnect(port);
 	port->attached = false;
@@ -2857,6 +3146,7 @@ static void run_state_machine(struct tcpm_port *port)
 	int ret;
 	enum typec_pwr_opmode opmode;
 	unsigned int msecs;
+	enum tcpm_state upcoming_state;
 
 	port->enter_state = port->state;
 	switch (port->state) {
@@ -2959,7 +3249,14 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
-		tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+		/* SNK -> SRC POWER/FAST_ROLE_SWAP finished */
+		if (port->ams == POWER_ROLE_SWAP ||
+		    port->ams == FAST_ROLE_SWAP)
+			tcpm_ams_finish(port);
+		port->upcoming_state = SRC_SEND_CAPABILITIES;
+		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+		if (ret == -EOPNOTSUPP)
+			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
 		break;
 	case SRC_SEND_CAPABILITIES:
 		port->caps_count++;
@@ -3041,6 +3338,19 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
 
+		if (port->ams != NONE_AMS)
+			tcpm_ams_finish(port);
+		/*
+		 * If previous AMS is interrupted, switch to the upcoming
+		 * state.
+		 */
+		upcoming_state = port->upcoming_state;
+		if (port->upcoming_state != INVALID_STATE) {
+			port->upcoming_state = INVALID_STATE;
+			tcpm_set_state(port, upcoming_state, 0);
+			break;
+		}
+
 		tcpm_check_send_discover(port);
 		/*
 		 * 6.3.5
@@ -3158,6 +3468,12 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
+
+		if (port->ams == POWER_ROLE_SWAP ||
+		    port->ams == FAST_ROLE_SWAP)
+			/* SRC -> SNK POWER/FAST_ROLE_SWAP finished */
+			tcpm_ams_finish(port);
+
 		tcpm_set_state(port, SNK_DISCOVERY, 0);
 		break;
 	case SNK_DISCOVERY:
@@ -3207,7 +3523,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 */
 		if (port->vbus_never_low) {
 			port->vbus_never_low = false;
-			tcpm_set_state(port, SOFT_RESET_SEND,
+			tcpm_set_state(port, SNK_SOFT_RESET,
 				       PD_T_SINK_WAIT_CAP);
 		} else {
 			tcpm_set_state(port, hard_reset_state(port),
@@ -3260,9 +3576,22 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
-		tcpm_check_send_discover(port);
 		tcpm_pps_complete(port, port->pps_status);
 
+		if (port->ams != NONE_AMS)
+			tcpm_ams_finish(port);
+		/*
+		 * If previous AMS is interrupted, switch to the upcoming
+		 * state.
+		 */
+		upcoming_state = port->upcoming_state;
+		if (port->upcoming_state != INVALID_STATE) {
+			port->upcoming_state = INVALID_STATE;
+			tcpm_set_state(port, upcoming_state, 0);
+			break;
+		}
+
+		tcpm_check_send_discover(port);
 		power_supply_changed(port->psy);
 
 		break;
@@ -3284,8 +3613,18 @@ static void run_state_machine(struct tcpm_port *port)
 
 	/* Hard_Reset states */
 	case HARD_RESET_SEND:
-		tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
-		tcpm_set_state(port, HARD_RESET_START, 0);
+		if (port->ams != NONE_AMS)
+			tcpm_ams_finish(port);
+		/*
+		 * State machine will be directed to HARD_RESET_START,
+		 * thus set upcoming_state to INVALID_STATE.
+		 */
+		port->upcoming_state = INVALID_STATE;
+		ret = tcpm_ams_start(port, HARD_RESET);
+		if (ret == -EOPNOTSUPP) {
+			tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
+			tcpm_set_state(port, HARD_RESET_START, 0);
+		}
 		break;
 	case HARD_RESET_START:
 		port->hard_reset_count++;
@@ -3307,6 +3646,8 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SRC_HARD_RESET_VBUS_ON:
 		tcpm_set_vbus(port, true);
+		if (port->ams == HARD_RESET)
+			tcpm_ams_finish(port);
 		port->tcpc->set_pd_rx(port->tcpc, true);
 		tcpm_set_attached_state(port, true);
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
@@ -3326,6 +3667,8 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, SNK_HARD_RESET_SINK_ON, PD_T_SAFE_0V);
 		break;
 	case SNK_HARD_RESET_WAIT_VBUS:
+		if (port->ams == HARD_RESET)
+			tcpm_ams_finish(port);
 		/* Assume we're disconnected if VBUS doesn't come back. */
 		tcpm_set_state(port, SNK_UNATTACHED,
 			       PD_T_SRC_RECOVER_MAX + PD_T_SRC_TURN_ON);
@@ -3353,6 +3696,8 @@ static void run_state_machine(struct tcpm_port *port)
 					       5000);
 			tcpm_set_charge(port, true);
 		}
+		if (port->ams == HARD_RESET)
+			tcpm_ams_finish(port);
 		tcpm_set_attached_state(port, true);
 		tcpm_set_state(port, SNK_STARTUP, 0);
 		break;
@@ -3362,10 +3707,23 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
-		if (port->pwr_role == TYPEC_SOURCE)
-			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
-		else
+		if (port->pwr_role == TYPEC_SOURCE) {
+			port->upcoming_state = SRC_SEND_CAPABILITIES;
+			ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+			if (ret == -EOPNOTSUPP)
+				tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+		} else {
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
+		}
+		break;
+	case SRC_SOFT_RESET_WAIT_SNK_TX:
+	case SNK_SOFT_RESET:
+		if (port->ams != NONE_AMS)
+			tcpm_ams_finish(port);
+		port->upcoming_state = SOFT_RESET_SEND;
+		ret = tcpm_ams_start(port, SOFT_RESET_AMS);
+		if (ret == -EOPNOTSUPP)
+			tcpm_set_state(port, SOFT_RESET_SEND, 0);
 		break;
 	case SOFT_RESET_SEND:
 		port->message_id = 0;
@@ -3571,6 +3929,19 @@ static void run_state_machine(struct tcpm_port *port)
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
+		port->upcoming_state = INVALID_STATE;
+		tcpm_set_state(port, upcoming_state, 0);
+		break;
 	default:
 		WARN(1, "Unexpected port state %d\n", port->state);
 		break;
@@ -3897,6 +4268,8 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 static void _tcpm_pd_hard_reset(struct tcpm_port *port)
 {
 	tcpm_log_force(port, "Received hard reset");
+	if (port->ams != NONE_AMS)
+		port->ams = NONE_AMS;
 	/*
 	 * If we keep receiving hard reset requests, executing the hard reset
 	 * must have failed. Revert to error recovery if that happens.
@@ -4014,7 +4387,15 @@ static int tcpm_dr_set(const struct typec_capability *cap,
 		port->non_pd_role_swap = true;
 		tcpm_set_state(port, PORT_RESET, 0);
 	} else {
-		tcpm_set_state(port, DR_SWAP_SEND, 0);
+		port->upcoming_state = DR_SWAP_SEND;
+		ret = tcpm_ams_start(port, DATA_ROLE_SWAP);
+		if (ret == -EAGAIN) {
+			port->upcoming_state = INVALID_STATE;
+			goto port_unlock;
+		} else if (ret == -EOPNOTSUPP) {
+			port->upcoming_state = INVALID_STATE;
+			tcpm_set_state(port, DR_SWAP_SEND, 0);
+		}
 	}
 
 	port->swap_status = 0;
@@ -4061,10 +4442,19 @@ static int tcpm_pr_set(const struct typec_capability *cap,
 		goto port_unlock;
 	}
 
+	port->upcoming_state = PR_SWAP_SEND;
+	ret = tcpm_ams_start(port, POWER_ROLE_SWAP);
+	if (ret == -EAGAIN) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	} else if (ret == -EOPNOTSUPP) {
+		port->upcoming_state = INVALID_STATE;
+		tcpm_set_state(port, PR_SWAP_SEND, 0);
+	}
+
 	port->swap_status = 0;
 	port->swap_pending = true;
 	reinit_completion(&port->swap_complete);
-	tcpm_set_state(port, PR_SWAP_SEND, 0);
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
@@ -4101,10 +4491,19 @@ static int tcpm_vconn_set(const struct typec_capability *cap,
 		goto port_unlock;
 	}
 
+	port->upcoming_state = VCONN_SWAP_SEND;
+	ret = tcpm_ams_start(port, VCONN_SWAP);
+	if (ret == -EAGAIN) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	} else if (ret == -EOPNOTSUPP) {
+		port->upcoming_state = INVALID_STATE;
+		tcpm_set_state(port, VCONN_SWAP_SEND, 0);
+	}
+
 	port->swap_status = 0;
 	port->swap_pending = true;
 	reinit_completion(&port->swap_complete);
-	tcpm_set_state(port, VCONN_SWAP_SEND, 0);
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
@@ -4169,6 +4568,13 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 		goto port_unlock;
 	}
 
+	port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	}
+
 	/* Round down operating current to align with PPS valid steps */
 	op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
 
@@ -4176,7 +4582,6 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 	port->pps_data.op_curr = op_curr;
 	port->pps_status = 0;
 	port->pps_pending = true;
-	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->pps_complete,
@@ -4225,6 +4630,13 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 		goto port_unlock;
 	}
 
+	port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	}
+
 	/* Round down output voltage to align with PPS valid steps */
 	out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
 
@@ -4232,7 +4644,6 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 	port->pps_data.out_volt = out_volt;
 	port->pps_status = 0;
 	port->pps_pending = true;
-	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->pps_complete,
@@ -4272,6 +4683,16 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 		goto port_unlock;
 	}
 
+	if (activate)
+		port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+	else
+		port->upcoming_state = SNK_NEGOTIATE_CAPABILITIES;
+	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	}
+
 	reinit_completion(&port->pps_complete);
 	port->pps_status = 0;
 	port->pps_pending = true;
@@ -4280,9 +4701,6 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 	if (activate) {
 		port->pps_data.out_volt = port->supply_voltage;
 		port->pps_data.op_curr = port->current_limit;
-		tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
-	} else {
-		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
 	}
 	mutex_unlock(&port->lock);
 
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 145c38e351c2..e4343e656470 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -442,6 +442,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
 #define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
 #define PD_T_NEWSRC            250     /* Maximum of 275ms */
+#define PD_T_SINK_TX		16	/* 16 - 20 ms */
 
 #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
 #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index f516955a0cf4..53afd61fe003 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -19,6 +19,10 @@ enum typec_cc_status {
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
2.23.0.351.gc4317032e6-goog

