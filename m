Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B96C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3715421934
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138645;
	bh=RjexhMKHY/sxgM6EwuxeBUkbArXgXBXdRE0CvJXpUDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P4su0Rf1foLZ2z9/q27PfWdunNbNuKNqXADrVoGYOqMrSwQ778iNp++5+FItb/kD1
	 VqVkEVu3I09MhEmIVRA234gRUKwb1mV971wcvJt1AsxARgsiNYNWqM7ogf2ENhoG4U
	 sW+P6LICpWIvyYIXorsmApLuJA41UkbEVsCdlJDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfDARKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbfDARKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:10:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D37206B8;
        Mon,  1 Apr 2019 17:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138639;
        bh=RjexhMKHY/sxgM6EwuxeBUkbArXgXBXdRE0CvJXpUDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaueCgdgsvCK5sqAGlU9HpUXJb9Jwi1TbnTDRHG9CMbiyNOjPK7Y8+Pw5cPO6tucO
         j/Ie705MCUmMZbEZpNMN9iUMulOkMmRuk05cQJgj9KfWEC6fYlP05ii6PJ6rxFm5af
         ZcFibeLZLGHpGuHtpFcZQ0ERmpqIiqNi9PG34wfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.0 123/146] usb: typec: tcpm: Try PD-2.0 if sink does not respond to 3.0 source-caps
Date:   Mon,  1 Apr 2019 19:02:15 +0200
Message-Id: <20190401170058.723014657@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit 976daf9d1199932df80e7b04546d1a1bd4ed5ece upstream.

PD 2.0 sinks are supposed to accept src-capabilities with a 3.0 header and
simply ignore any src PDOs which the sink does not understand such as PPS
but some 2.0 sinks instead ignore the entire PD_DATA_SOURCE_CAP message,
causing contract negotiation to fail.

This commit fixes such sinks not working by re-trying the contract
negotiation with PD-2.0 source-caps messages if we don't have a contract
after PD_N_HARD_RESET_COUNT hard-reset attempts.

The problem fixed by this commit was noticed with a Type-C to VGA dongle.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/typec/tcpm/tcpm.c |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -37,6 +37,7 @@
 	S(SRC_ATTACHED),			\
 	S(SRC_STARTUP),				\
 	S(SRC_SEND_CAPABILITIES),		\
+	S(SRC_SEND_CAPABILITIES_TIMEOUT),	\
 	S(SRC_NEGOTIATE_CAPABILITIES),		\
 	S(SRC_TRANSITION_SUPPLY),		\
 	S(SRC_READY),				\
@@ -2966,10 +2967,34 @@ static void run_state_machine(struct tcp
 			/* port->hard_reset_count = 0; */
 			port->caps_count = 0;
 			port->pd_capable = true;
-			tcpm_set_state_cond(port, hard_reset_state(port),
+			tcpm_set_state_cond(port, SRC_SEND_CAPABILITIES_TIMEOUT,
 					    PD_T_SEND_SOURCE_CAP);
 		}
 		break;
+	case SRC_SEND_CAPABILITIES_TIMEOUT:
+		/*
+		 * Error recovery for a PD_DATA_SOURCE_CAP reply timeout.
+		 *
+		 * PD 2.0 sinks are supposed to accept src-capabilities with a
+		 * 3.0 header and simply ignore any src PDOs which the sink does
+		 * not understand such as PPS but some 2.0 sinks instead ignore
+		 * the entire PD_DATA_SOURCE_CAP message, causing contract
+		 * negotiation to fail.
+		 *
+		 * After PD_N_HARD_RESET_COUNT hard-reset attempts, we try
+		 * sending src-capabilities with a lower PD revision to
+		 * make these broken sinks work.
+		 */
+		if (port->hard_reset_count < PD_N_HARD_RESET_COUNT) {
+			tcpm_set_state(port, HARD_RESET_SEND, 0);
+		} else if (port->negotiated_rev > PD_REV20) {
+			port->negotiated_rev--;
+			port->hard_reset_count = 0;
+			tcpm_set_state(port, SRC_SEND_CAPABILITIES, 0);
+		} else {
+			tcpm_set_state(port, hard_reset_state(port), 0);
+		}
+		break;
 	case SRC_NEGOTIATE_CAPABILITIES:
 		ret = tcpm_pd_check_request(port);
 		if (ret < 0) {


