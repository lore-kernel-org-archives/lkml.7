Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F84AC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D564221726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6sX+Dwu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388891AbfHBQDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:03:46 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37907 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbfHBQDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:03:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so36272241pfn.5;
        Fri, 02 Aug 2019 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=w74jXhv7cVptNBuubv+E0L15wrqg95AlmaYa2Bd6Vzc=;
        b=n6sX+Dwuq0vXWtL0awBliT2RTG9wIniMBTHmtZorHYR5prk9athV3qYQeyEo4TwZ4R
         yTVYfcBD4Jhu3lTugoAK/P2DrPYbP5qOuYMFk7s77PGw9aOLGX+SOSgYvHdhH+A/h6rB
         pF3h4RHQYGwR9LtLtP4u1Q30hDk0DCXKYortPB1vfTJbL04a5FmDPCtbBay9lMzLc/9p
         NYsacTb0gJNhmo4kp0MCQfKCVXb/VdvgfKc/gJpwJJ8nHPKf2vrS+HiGH8e9rGmTh4TV
         9ACrOtiahaXJNhaO9zBXmyOzVxzHVvzzdHeFgNXZk4YOeAnTT6L7e6YVsji3vNffdOMl
         tuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=w74jXhv7cVptNBuubv+E0L15wrqg95AlmaYa2Bd6Vzc=;
        b=lLiWmEH5ok9JbjEjM/rBl+hfpHcCD7/e6mc5duUlTGehUvXnL0I9V2UU4rWZG59+Sr
         T8uR+PFRQIyFkWgDAOpmpJRr9ItIk8Wtpzo1zxBzsXN/qWR8GaTm5HNXwIZxkd7h5NYi
         XagnAeRb4gCBBVBLL5Mxec+FDaYYvWk3Ss4OUpRZYhqLnM3MCLPRrWuX9ZzMKHAWy8gM
         hO2JD8Zm8AxT13sDkaS76HMUmbsgp0Cn2PTwHKhgalxfakZuMstOJ0Ap6zBmE6viboPX
         t1kDORMS6lKieUILv3BGEd4o+nbeoQWEk1xw6jWDX1a1sI6GvSKoxOZ2MGfxOatbMMnW
         WkxA==
X-Gm-Message-State: APjAAAW/QLT3QcCq/YUhnv7p6Ytp4FGqcdQppeGXV/RvLKSjEs98KxYh
        rXdxygHgkXty9/vj5S99G/8=
X-Google-Smtp-Source: APXvYqzHMzSF/bzj/LXPFoJEXQoat8183wYi1WUNr8Xnj+YQby+qnunSzeUFOt9m+gRVEtqxehm5JA==
X-Received: by 2002:a17:90b:949:: with SMTP id dw9mr5033485pjb.49.1564761825575;
        Fri, 02 Aug 2019 09:03:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 195sm120671389pfu.75.2019.08.02.09.03.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 09:03:44 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: [PATCH v2] usb: typec: tcpm: Ignore unsupported/unknown alternate mode requests
Date:   Fri,  2 Aug 2019 09:03:42 -0700
Message-Id: <1564761822-13984-1-git-send-email-linux@roeck-us.net>
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

Ignore PD messages if the associated alternate mode is not supported.

Fixes: e9576fe8e605c ("usb: typec: tcpm: Support for Alternate Modes")
Reported-by: Douglas Gilbert <dgilbert@interlog.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: No functional change
    Dropped RFC
    Added Tested/by: / Acked-by: tags

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

