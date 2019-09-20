Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE082C49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB64221929
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 03:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpJEPenr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406785AbfITDZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 23:25:34 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:52550 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390917AbfITDZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 23:25:33 -0400
Received: by mail-vk1-f202.google.com with SMTP id 70so2154522vki.19
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 20:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tx8vtK5bTkWKGgQeG8002cHxlevjtY1VIp0qcrlwyDA=;
        b=FpJEPenrCiJFddqH8B7LWDR78NmhNNZJo9ikjFfQgKyH2Y8FkJXhUI+r11OYB/fg7X
         iS/5u+5RiH1roCVMI89Y9ywy2JwU+I0CyxBN1afaQMsqlKp0RWwSmEljq1Rw4Uf3mHvn
         e0EFcAMO1CEJOkjNciq22hHO3OGidPIQqzUNeS04btYpVWYe/nNtClHvkcy7MzzyDlI6
         wbxiBpfacp2GKl9jNc70jkZHAARzc/za3FtjTUPpKzfF/aNcNHCv8lYrZNqIalRqc95U
         p19Aj7xgSOUPUdBWFlTrrFlb2TGJQbFEnQaAKbTc9tD7gpctNNszr+2bjasDIZY8ZC3W
         iLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tx8vtK5bTkWKGgQeG8002cHxlevjtY1VIp0qcrlwyDA=;
        b=A/Tr8hmL1GaNBm1g53HIXnWGoR7BaWUIHFaSBQ9xs5HyGUnSePDfiI9+u1p7o2dCeh
         M0BivSBash1mKgSbtZflrkBLRGZjQuv3noZvQi02xZH3x/cd/vDR0g5BYN2K9az7o8sx
         bRN7jSJtNfRyriH47MQSj/6Dv4p1BunXUnreMl1cLaweXnab5jwRXDnCN4omLSSORT5m
         VKKL+ILHIl0W4ZGKiQUXDZBDpxSkaiAozNZeZEsPNH3XdtQU12HgLJp8vd3I83btsm7U
         vF1a2mutZXdmkI8nTmDYQlhnlcHT9H8dH6jOgrUPzg7/6CDqnrbvCaxq/nDvvJ852ZVD
         bldw==
X-Gm-Message-State: APjAAAVEAZc0KIMBiuv6d2gAmcN1G5zbKXUwEHwSUn6O4lQGyqlseBig
        yeJilhpLJ6lCkOivrHo1W6ZqkDpl59eV
X-Google-Smtp-Source: APXvYqwD8YmjCo5BgO3Mk4/5Ap7YCPlyo6Ktbx5mssFEDMf9axpg8xCScSw/4P5R8p6O+3YliYwBCD9aCiQ8
X-Received: by 2002:a1f:a6cd:: with SMTP id p196mr6870673vke.25.1568949931402;
 Thu, 19 Sep 2019 20:25:31 -0700 (PDT)
Date:   Fri, 20 Sep 2019 11:24:37 +0800
In-Reply-To: <20190920032437.242187-1-kyletso@google.com>
Message-Id: <20190920032437.242187-3-kyletso@google.com>
Mime-Version: 1.0
References: <20190920032437.242187-1-kyletso@google.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: [PATCH v3 2/2] usb: typec: tcpm: AMS for PD2.0
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

AMS is defined in PD2.0 as well. Remove the filter in tcpm_ams_start
and change the CC for Collision Avoidance only if the negotiated
revision is higher than PD2.0.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changelog since v2:
- N/A; This is the first version.

 drivers/usb/typec/tcpm/tcpm.c | 129 +++++++++++++++-------------------
 1 file changed, 57 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 7d1c30c33097..aca1c5bbe870 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -391,6 +391,12 @@ struct pd_rx_event {
 	struct pd_message msg;
 };
 
+static const char * const pd_rev[] = {
+	[PD_REV10]		= "rev1",
+	[PD_REV20]		= "rev2",
+	[PD_REV30]		= "rev3",
+};
+
 #define tcpm_cc_is_sink(cc) \
 	((cc) == TYPEC_CC_RP_DEF || (cc) == TYPEC_CC_RP_1_5 || \
 	 (cc) == TYPEC_CC_RP_3_0)
@@ -431,8 +437,6 @@ struct pd_rx_event {
 	(tcpm_port_is_sink(port) && \
 	((port)->cc1 == TYPEC_CC_RP_3_0 || (port)->cc2 == TYPEC_CC_RP_3_0))
 
-#define support_ams(port)       ((port)->negotiated_rev >= PD_REV30)
-
 static enum tcpm_state tcpm_default_state(struct tcpm_port *port)
 {
 	if (port->port_type == TYPEC_PORT_DRP) {
@@ -679,14 +683,9 @@ static int tcpm_ams_finish(struct tcpm_port *port)
 {
 	int ret = 0;
 
-	if (!support_ams(port)) {
-		port->upcoming_state = INVALID_STATE;
-		return -EOPNOTSUPP;
-	}
-
 	tcpm_log(port, "AMS %s finished", tcpm_ams_str[port->ams]);
 
-	if (port->pwr_role == TYPEC_SOURCE)
+	if (port->negotiated_rev >= PD_REV30 && port->pwr_role == TYPEC_SOURCE)
 		tcpm_set_cc(port, SINK_TX_OK);
 
 	port->in_ams = false;
@@ -723,12 +722,13 @@ static int tcpm_pd_transmit(struct tcpm_port *port,
 	case TCPC_TX_SUCCESS:
 		port->message_id = (port->message_id + 1) & PD_HEADER_ID_MASK;
 		/*
+		 * USB PD rev 2.0, 8.3.2.2.1:
 		 * USB PD rev 3.0, 8.3.2.1.3:
 		 * "... Note that every AMS is Interruptible until the first
 		 * Message in the sequence has been successfully sent (GoodCRC
 		 * Message received)."
 		 */
-		if (support_ams(port) && port->ams != NONE_AMS)
+		if (port->ams != NONE_AMS)
 			port->in_ams = true;
 		break;
 	case TCPC_TX_DISCARDED:
@@ -994,20 +994,18 @@ static void tcpm_set_state(struct tcpm_port *port, enum tcpm_state state,
 			   unsigned int delay_ms)
 {
 	if (delay_ms) {
-		tcpm_log(port, "pending state change %s -> %s @ %u ms%s%s",
+		tcpm_log(port, "pending state change %s -> %s @ %u ms [%s %s]",
 			 tcpm_states[port->state], tcpm_states[state], delay_ms,
-			 support_ams(port) ? " in AMS " : "",
-			 support_ams(port) ? tcpm_ams_str[port->ams] : "");
+			 pd_rev[port->negotiated_rev], tcpm_ams_str[port->ams]);
 		port->delayed_state = state;
 		mod_delayed_work(port->wq, &port->state_machine,
 				 msecs_to_jiffies(delay_ms));
 		port->delayed_runtime = jiffies + msecs_to_jiffies(delay_ms);
 		port->delay_ms = delay_ms;
 	} else {
-		tcpm_log(port, "state change %s -> %s%s%s",
+		tcpm_log(port, "state change %s -> %s [%s %s]",
 			 tcpm_states[port->state], tcpm_states[state],
-			 support_ams(port) ? " in AMS " : "",
-			 support_ams(port) ? tcpm_ams_str[port->ams] : "");
+			 pd_rev[port->negotiated_rev], tcpm_ams_str[port->ams]);
 		port->delayed_state = INVALID_STATE;
 		port->prev_state = port->state;
 		port->state = state;
@@ -1029,12 +1027,11 @@ static void tcpm_set_state_cond(struct tcpm_port *port, enum tcpm_state state,
 		tcpm_set_state(port, state, delay_ms);
 	else
 		tcpm_log(port,
-			 "skipped %sstate change %s -> %s [%u ms], context state %s%s%s",
+			 "skipped %sstate change %s -> %s [%u ms], context state %s [%s %s]",
 			 delay_ms ? "delayed " : "",
 			 tcpm_states[port->state], tcpm_states[state],
 			 delay_ms, tcpm_states[port->enter_state],
-			 support_ams(port) ? " in AMS " : "",
-			 support_ams(port) ? tcpm_ams_str[port->ams] : "");
+			 pd_rev[port->negotiated_rev], tcpm_ams_str[port->ams]);
 }
 
 static void tcpm_queue_message(struct tcpm_port *port,
@@ -1100,11 +1097,6 @@ static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams)
 {
 	int ret = 0;
 
-	if (!support_ams(port)) {
-		port->upcoming_state = INVALID_STATE;
-		return -EOPNOTSUPP;
-	}
-
 	tcpm_log(port, "AMS %s start", tcpm_ams_str[ams]);
 
 	if (!tcpm_ams_interruptible(port) && ams != HARD_RESET) {
@@ -1132,24 +1124,41 @@ static int tcpm_ams_start(struct tcpm_port *port, enum tcpm_ams ams)
 			}
 		} else if (tcpm_vdm_ams(port)) {
 			/* tSinkTx is enforced in vdm_run_state_machine */
-			tcpm_set_cc(port, SINK_TX_NG);
+			if (port->negotiated_rev >= PD_REV30)
+				tcpm_set_cc(port, SINK_TX_NG);
 			return ret;
 		}
 
-		cc_req = port->cc_req;
-		tcpm_set_cc(port, SINK_TX_NG);
-		if (port->state == SRC_READY ||
-		    port->state == SRC_STARTUP ||
-		    port->state == SRC_SOFT_RESET_WAIT_SNK_TX ||
-		    port->state == SOFT_RESET ||
-		    port->state == SOFT_RESET_SEND)
-			tcpm_set_state(port, AMS_START, cc_req == SINK_TX_OK ?
-				       PD_T_SINK_TX : 0);
-		else
-			tcpm_set_state(port, SRC_READY, cc_req == SINK_TX_OK ?
-				       PD_T_SINK_TX : 0);
+		if (port->negotiated_rev >= PD_REV30) {
+			cc_req = port->cc_req;
+			tcpm_set_cc(port, SINK_TX_NG);
+		}
+
+		switch (port->state) {
+		case SRC_READY:
+		case SRC_STARTUP:
+		case SRC_SOFT_RESET_WAIT_SNK_TX:
+		case SOFT_RESET:
+		case SOFT_RESET_SEND:
+			if (port->negotiated_rev >= PD_REV30)
+				tcpm_set_state(port, AMS_START,
+					       cc_req == SINK_TX_OK ?
+					       PD_T_SINK_TX : 0);
+			else
+				tcpm_set_state(port, AMS_START, 0);
+			break;
+		default:
+			if (port->negotiated_rev >= PD_REV30)
+				tcpm_set_state(port, SRC_READY,
+					       cc_req == SINK_TX_OK ?
+					       PD_T_SINK_TX : 0);
+			else
+				tcpm_set_state(port, SRC_READY, 0);
+			break;
+		}
 	} else {
-		if (!tcpm_sink_tx_ok(port) &&
+		if (port->negotiated_rev >= PD_REV30 &&
+		    !tcpm_sink_tx_ok(port) &&
 		    ams != SOFT_RESET_AMS &&
 		    ams != HARD_RESET) {
 			port->upcoming_state = INVALID_STATE;
@@ -1565,13 +1574,13 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 				break;
 			}
 
-			if (res == -EAGAIN)
+			if (res < 0)
 				return;
 		}
 
 		port->vdm_state = VDM_STATE_SEND_MESSAGE;
 		mod_delayed_work(port->wq, &port->vdm_state_machine,
-				 (res != -EOPNOTSUPP) &&
+				 (port->negotiated_rev >= PD_REV30) &&
 				 (port->pwr_role == TYPEC_SOURCE) &&
 				 (PD_VDO_CMDT(port->vdo_data[0]) == CMDT_INIT) ?
 				 PD_T_SINK_TX : 0);
@@ -1975,7 +1984,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 {
 	enum pd_ctrl_msg_type type = pd_header_type_le(msg->header);
 	enum tcpm_state next_state;
-	int ret = 0;
 
 	switch (type) {
 	case PD_CTRL_GOOD_CRC:
@@ -2094,11 +2102,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 				tcpm_ams_finish(port);
 			if (port->pwr_role == TYPEC_SOURCE) {
 				port->upcoming_state = SRC_SEND_CAPABILITIES;
-				ret = tcpm_ams_start(port, POWER_NEGOTIATION);
-				if (ret == -EOPNOTSUPP)
-					tcpm_set_state(port,
-						       SRC_SEND_CAPABILITIES,
-						       0);
+				tcpm_ams_start(port, POWER_NEGOTIATION);
 			} else {
 				tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 			}
@@ -3254,9 +3258,7 @@ static void run_state_machine(struct tcpm_port *port)
 		    port->ams == FAST_ROLE_SWAP)
 			tcpm_ams_finish(port);
 		port->upcoming_state = SRC_SEND_CAPABILITIES;
-		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
-		if (ret == -EOPNOTSUPP)
-			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+		tcpm_ams_start(port, POWER_NEGOTIATION);
 		break;
 	case SRC_SEND_CAPABILITIES:
 		port->caps_count++;
@@ -3620,11 +3622,7 @@ static void run_state_machine(struct tcpm_port *port)
 		 * thus set upcoming_state to INVALID_STATE.
 		 */
 		port->upcoming_state = INVALID_STATE;
-		ret = tcpm_ams_start(port, HARD_RESET);
-		if (ret == -EOPNOTSUPP) {
-			tcpm_pd_transmit(port, TCPC_TX_HARD_RESET, NULL);
-			tcpm_set_state(port, HARD_RESET_START, 0);
-		}
+		tcpm_ams_start(port, HARD_RESET);
 		break;
 	case HARD_RESET_START:
 		port->hard_reset_count++;
@@ -3709,9 +3707,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
 		if (port->pwr_role == TYPEC_SOURCE) {
 			port->upcoming_state = SRC_SEND_CAPABILITIES;
-			ret = tcpm_ams_start(port, POWER_NEGOTIATION);
-			if (ret == -EOPNOTSUPP)
-				tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+			tcpm_ams_start(port, POWER_NEGOTIATION);
 		} else {
 			tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
 		}
@@ -3721,9 +3717,7 @@ static void run_state_machine(struct tcpm_port *port)
 		if (port->ams != NONE_AMS)
 			tcpm_ams_finish(port);
 		port->upcoming_state = SOFT_RESET_SEND;
-		ret = tcpm_ams_start(port, SOFT_RESET_AMS);
-		if (ret == -EOPNOTSUPP)
-			tcpm_set_state(port, SOFT_RESET_SEND, 0);
+		tcpm_ams_start(port, SOFT_RESET_AMS);
 		break;
 	case SOFT_RESET_SEND:
 		port->message_id = 0;
@@ -3930,7 +3924,7 @@ static void run_state_machine(struct tcpm_port *port)
 			       port->vbus_present ? PD_T_PS_SOURCE_OFF : 0);
 		break;
 
-	/* Collision Avoidance state */
+	/* AMS intermediate state */
 	case AMS_START:
 		if (port->upcoming_state == INVALID_STATE) {
 			tcpm_set_state(port, port->pwr_role == TYPEC_SOURCE ?
@@ -4392,9 +4386,6 @@ static int tcpm_dr_set(const struct typec_capability *cap,
 		if (ret == -EAGAIN) {
 			port->upcoming_state = INVALID_STATE;
 			goto port_unlock;
-		} else if (ret == -EOPNOTSUPP) {
-			port->upcoming_state = INVALID_STATE;
-			tcpm_set_state(port, DR_SWAP_SEND, 0);
 		}
 	}
 
@@ -4447,9 +4438,6 @@ static int tcpm_pr_set(const struct typec_capability *cap,
 	if (ret == -EAGAIN) {
 		port->upcoming_state = INVALID_STATE;
 		goto port_unlock;
-	} else if (ret == -EOPNOTSUPP) {
-		port->upcoming_state = INVALID_STATE;
-		tcpm_set_state(port, PR_SWAP_SEND, 0);
 	}
 
 	port->swap_status = 0;
@@ -4496,9 +4484,6 @@ static int tcpm_vconn_set(const struct typec_capability *cap,
 	if (ret == -EAGAIN) {
 		port->upcoming_state = INVALID_STATE;
 		goto port_unlock;
-	} else if (ret == -EOPNOTSUPP) {
-		port->upcoming_state = INVALID_STATE;
-		tcpm_set_state(port, VCONN_SWAP_SEND, 0);
 	}
 
 	port->swap_status = 0;
@@ -4570,7 +4555,7 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
 
 	port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
 	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
-	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+	if (ret == -EAGAIN) {
 		port->upcoming_state = INVALID_STATE;
 		goto port_unlock;
 	}
@@ -4632,7 +4617,7 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
 
 	port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
 	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
-	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+	if (ret == -EAGAIN) {
 		port->upcoming_state = INVALID_STATE;
 		goto port_unlock;
 	}
@@ -4688,7 +4673,7 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 	else
 		port->upcoming_state = SNK_NEGOTIATE_CAPABILITIES;
 	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
-	if (ret == -EAGAIN || ret == -EOPNOTSUPP) {
+	if (ret == -EAGAIN) {
 		port->upcoming_state = INVALID_STATE;
 		goto port_unlock;
 	}
-- 
2.23.0.351.gc4317032e6-goog

