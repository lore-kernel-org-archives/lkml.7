Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747AFC28CC6
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6D620684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 02:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6aPPAjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfFFCyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 22:54:44 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34914 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfFFCym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 22:54:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id s27so461661pgl.2;
        Wed, 05 Jun 2019 19:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HMdqjqPKlxZQSHzx3Vn6pFK3iI06XFWAA0ObiWucrNs=;
        b=n6aPPAjV2esjw71uUNRUWQ0y5OX5FNS/1B5WVGujyXMaNz97deNQ1jbfjOy8x+AaKg
         KUYokjGoWKFvwItK4mQ2GEdiOy8E65DAIcSvLTvxVujz0SzPP/wHyfvY+LaRDbAKuKqk
         LEtmrtXQyaBc65NSFS5r1pwx8d+nWra9kXI0faD8bfH2wf+SGmVGvL1S6L1o2OgUJIFN
         6qewCDT/qFgAFY0ftyKetmucBFHQ2tze2sRe0so2OaTGUKXqgT9mK4W20A1wRGgNSkna
         srJ7IR0ndDnOYTEJKQdUURueIVmb3VdMNgIdjtdkDk59y7hstFkUnC1SoHxRjo0QL6pF
         0DqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HMdqjqPKlxZQSHzx3Vn6pFK3iI06XFWAA0ObiWucrNs=;
        b=Xo4YdhcKkt7HmKIGWYid3Rj+b2iMhF3Rll5rusBdAYC8rJzfE/R1XjG80SFG/QO4e0
         H/swV+9WHQ2VC1Pw/1CxhsjdOcSZWuZ69B6/ajKhu8zLJtGi0Wz05Iw+q0rIE/JoL4lz
         7IR3FDvKQOjGUVN6dABo+okG7cfRrsn9I7LFKb/0osYHo6sQkbnjHbmkVa5In6mXZ48U
         uDkBhBlAZaL7PVDYa43U7XFqm0VdEReJQ31QlG8105bqDhmrlH0Mq4cQAQ5zS5u/kPbM
         lMuMuO9vf2rj4HNh+3dwxSTYTk2NtS6mv4iN9Crr617V2i7V5PYnjEVocvJdVxWV2y6k
         9BJA==
X-Gm-Message-State: APjAAAX46+ITsHTF/kOhoP9g+7N7AX7T4c08fMAZ1aq6Qhwb5oGeVQ7y
        /7q1E1tu+v6/hu/Pv3IsIwg=
X-Google-Smtp-Source: APXvYqxdk0Pgojj1778F7NNQY+CQC6CofKEglMnXj8YYwzXJ5uWMkqFDfSJsRKJeiXTLy5G0Et8hrw==
X-Received: by 2002:aa7:910e:: with SMTP id 14mr50636742pfh.153.1559789681892;
        Wed, 05 Jun 2019 19:54:41 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id e20sm304083pfi.35.2019.06.05.19.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 19:54:41 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 2/6] USB: serial: f81232: Force F81534A with RS232 mode
Date:   Thu,  6 Jun 2019 10:54:12 +0800
Message-Id: <1559789656-15847-3-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1559789656-15847-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force F81534A series UARTs with RS232 mode in port_probe().

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/usb/serial/f81232.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 84efcc66aa56..75dfc0b9ef30 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -83,12 +83,22 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define F81232_F81232_TYPE		1
 #define F81232_F81534A_TYPE		2
 
+/* Serial port self GPIO control, 2bytes [control&output data][input data] */
+#define F81534A_GPIO_REG		0x10e
+#define F81534A_GPIO_MODE2_DIR		BIT(6) /* 1: input, 0: output */
+#define F81534A_GPIO_MODE1_DIR		BIT(5)
+#define F81534A_GPIO_MODE0_DIR		BIT(4)
+#define F81534A_GPIO_MODE2_OUTPUT	BIT(2)
+#define F81534A_GPIO_MODE1_OUTPUT	BIT(1)
+#define F81534A_GPIO_MODE0_OUTPUT	BIT(0)
+
 struct f81232_private {
 	struct mutex lock;
 	u8 modem_control;
 	u8 modem_status;
 	u8 shadow_lcr;
 	u8 device_type;
+	u8 gpio_mode;
 	speed_t baud_base;
 	struct work_struct lsr_work;
 	struct work_struct interrupt_work;
@@ -871,6 +881,11 @@ static int f81232_port_probe(struct usb_serial_port *port)
 	switch (priv->device_type) {
 	case F81232_F81534A_TYPE:
 		priv->process_read_urb = f81534a_process_read_urb;
+		priv->gpio_mode = F81534A_GPIO_MODE2_DIR;
+
+		/* tri-state with pull-high, default RS232 Mode */
+		status = f81232_set_register(port, F81534A_GPIO_REG,
+					priv->gpio_mode);
 		break;
 
 	case F81232_F81232_TYPE:
-- 
2.7.4

