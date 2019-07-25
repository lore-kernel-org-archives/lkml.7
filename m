Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E01CC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2407421850
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 04:30:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzHCkuX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389220AbfGYEal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 00:30:41 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38707 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfGYEal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 00:30:41 -0400
Received: by mail-pg1-f193.google.com with SMTP id f5so13499631pgu.5;
        Wed, 24 Jul 2019 21:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=2OOipR6ExT2jNJi4jbCkya5oL8OY5qKBVN4HVC3rk40=;
        b=FzHCkuX/yPdx2rB65HPx3xPsnFpinwzY8xUPsFsNkqk20Pd9KYCc5MaZH8/4FR6wFc
         kY09+WnE+PA3hkaSW+6kt+6bFZje6pzjOciyxjiU+lglVJQStTJBJ3sV61VRB12o/p3C
         vogzuNi4N2XHLc5CPnNK/DfXwEbV7aUUF2Oae75AtiRF1SavbX9uV3x45t2CP+XneUWp
         HLaEj/3kH5bKi0h7uonSPVeEeGs+DBI/smg/WZ/OJOvMHAI/hB2Whwfidn2GQA2pmy9h
         x8ITDWxZEmw9mpEqKBezniQDW7OkNvxkeCOjEZ2EDWim8qeaUsl417pwYiildxpDArjw
         HI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=2OOipR6ExT2jNJi4jbCkya5oL8OY5qKBVN4HVC3rk40=;
        b=md9B0ChXfNkBdrL5/D9KNdNryY5+VG61Ko43DI4STp42VUrc4HvmdhxLXcASEX2gTY
         gXw0dzP5hrlukribNsyPsY+tvDx/6+dvZCmLrBj2XBVvLD68AW933yf+bp5synhZOv5E
         aQlJvqpWhi8REONZQ9VNX6oDQTwp4dyNaNTIUvq9MQaxi9ISkVPwESOLtwjy3V7kXwD/
         V27RL6/kV3vLi7t/oDXnvHreXmB1Dtm37gRtqkrOGM0+r28gr8TLpi3xQOn4XC9NyCom
         acFne6LurcFOFRwKR8DafGJ9E+kUTNWZ2h364Rstn8PrDS56VYDRqsKDtC+3DjWK+4wt
         33ig==
X-Gm-Message-State: APjAAAWm7eZYSnxxtPjGqZODjzv9IrZCbNu2B+J+kwoWaItMCnPHI/ef
        VNATtemQpN7z0SeY4ryi+txwADVC
X-Google-Smtp-Source: APXvYqxZPyLC+zW4PLVN9gRsznLhYfP5lFVWO1Mywd6VzjZseDLRdCth8ccSI0PNWuDWNK7ePiBjxA==
X-Received: by 2002:a17:90a:cb18:: with SMTP id z24mr39609687pjt.108.1564029040397;
        Wed, 24 Jul 2019 21:30:40 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9sm48380995pji.18.2019.07.24.21.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 21:30:39 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: [RFC PATCH] usb: typec: tcpm: Ignore unsupported/unknown alternate mode requests
Date:   Wed, 24 Jul 2019 21:30:37 -0700
Message-Id: <1564029037-22929-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCPM may receive PD messages associated with unknown or unsupported
alternate modes. If that happens, calls to typec_match_altmode()
will return NULL. The tcpm code does not currently take this into
account. This results in crashes.

Unable to handle kernel NULL pointer dereference at virtual address 000001f0
pgd = 41dad9a1
[000001f0] *pgd=00000000
Internal error: Oops: 5 [#1] THUMB2
Modules linked in: tcpci tcpm
CPU: 0 PID: 2338 Comm: kworker/u2:0 Not tainted 5.1.18-sama5-armv7-r2 #6
Hardware name: Atmel SAMA5
Workqueue: 2-0050 tcpm_pd_rx_handler [tcpm]
PC is at typec_altmode_attention+0x0/0x14
LR is at tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm]
...
[<c03fbee8>] (typec_altmode_attention) from [<bf8030fb>]
				(tcpm_pd_rx_handler+0xa3b/0xda0 [tcpm])
[<bf8030fb>] (tcpm_pd_rx_handler [tcpm]) from [<c012082b>]
				(process_one_work+0x123/0x2a8)
[<c012082b>] (process_one_work) from [<c0120a6d>]
				(worker_thread+0xbd/0x3b0)
[<c0120a6d>] (worker_thread) from [<c012431f>] (kthread+0xcf/0xf4)
[<c012431f>] (kthread) from [<c01010f9>] (ret_from_fork+0x11/0x38)

Ignore PD messages if the asociated alternate mode is not supported.

Reported-by: Douglas Gilbert <dgilbert@interlog.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Fixes: e9576fe8e605c ("usb: typec: tcpm: Support for Alternate Modes")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Taking a stab at the problem. I don't really know if this is the correct
fix, or even if my understanding of the problem is correct, thus marking
the patch as RFC.

 drivers/usb/typec/tcpm/tcpm.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 77f71f602f73..1df2844469aa 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1096,7 +1096,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 			break;
 		case CMD_ATTENTION:
 			/* Attention command does not have response */
-			typec_altmode_attention(adev, p[1]);
+			if (adev)
+				typec_altmode_attention(adev, p[1]);
 			return 0;
 		default:
 			break;
@@ -1148,20 +1149,26 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 			}
 			break;
 		case CMD_ENTER_MODE:
-			typec_altmode_update_active(pdev, true);
-
-			if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
-				response[0] = VDO(adev->svid, 1, CMD_EXIT_MODE);
-				response[0] |= VDO_OPOS(adev->mode);
-				return 1;
+			if (adev && pdev) {
+				typec_altmode_update_active(pdev, true);
+
+				if (typec_altmode_vdm(adev, p[0], &p[1], cnt)) {
+					response[0] = VDO(adev->svid, 1,
+							  CMD_EXIT_MODE);
+					response[0] |= VDO_OPOS(adev->mode);
+					return 1;
+				}
 			}
 			return 0;
 		case CMD_EXIT_MODE:
-			typec_altmode_update_active(pdev, false);
+			if (adev && pdev) {
+				typec_altmode_update_active(pdev, false);
 
-			/* Back to USB Operation */
-			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB,
-						     NULL));
+				/* Back to USB Operation */
+				WARN_ON(typec_altmode_notify(adev,
+							     TYPEC_STATE_USB,
+							     NULL));
+			}
 			break;
 		default:
 			break;
@@ -1171,8 +1178,10 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 		switch (cmd) {
 		case CMD_ENTER_MODE:
 			/* Back to USB Operation */
-			WARN_ON(typec_altmode_notify(adev, TYPEC_STATE_USB,
-						     NULL));
+			if (adev)
+				WARN_ON(typec_altmode_notify(adev,
+							     TYPEC_STATE_USB,
+							     NULL));
 			break;
 		default:
 			break;
@@ -1183,7 +1192,8 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
 	}
 
 	/* Informing the alternate mode drivers about everything */
-	typec_altmode_vdm(adev, p[0], &p[1], cnt);
+	if (adev)
+		typec_altmode_vdm(adev, p[0], &p[1], cnt);
 
 	return rlen;
 }
-- 
2.7.4

