Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0417AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72F1217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmI8O8VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbfDXVNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:13:42 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46090 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfDXVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:13:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id k18so15781117lfj.13;
        Wed, 24 Apr 2019 14:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GjKyhYhNibj/Dd5BoaRj7nvklTeCLpfBWZvTQSPTpeA=;
        b=PmI8O8VN+zj2aIXDBML98fem50ho0MZwWSeTzo4lz1PzB+eywd5mm0BPgHGzaHXUn4
         QCSj0TqX6alT3I18dTeRZUvmQa7UZEfE1JPyyjhQbhw38Loz3tuGB8Ja1nY+TevaRDJo
         s1QsYUFJC8cjaiKg1rEohrod14HjDY/s10cuQ/jBVM0qfKIA0i/UyI3JB4tJrhkG9+ds
         He4Dc2AjsulpAFXQrCEj5KQPbD0iDPhjaGsTWkaJvQGpKvg4vC3BNdyWjB1EiT3yMa6r
         PvdHBtin1OlVlEKNL3DZuOteaLTrqwy1SOiHduhUEo4w/bil5/NWZ1mUCnd/BCzghXMw
         eywA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GjKyhYhNibj/Dd5BoaRj7nvklTeCLpfBWZvTQSPTpeA=;
        b=EGeOJGCMZhMMe1pmavw+NvnQjiDhetbC2Mce3qm35wLiQ8y1EpVm/Mm6dQ1ajBgaCf
         TJK4I8TvRSzuoxq8um0izcT8n3Sa5hxyzYoOJerk6L+Hzw1Y1FwdojwD+/tsx3tV0s2j
         N5Ua38gECbNs4/U8KXJgWj3IBvDEve6FCf6sg4lLZShHHHIvu/2Xmi/FRVOg6Ms3+79g
         71FskkutyiUif4sRa9Tjaufv8H5caWXVINp8+jEbGsTxC7B7CMCeUfuYyWF/qLH6Q/1h
         tUPoMps1S66RYMw03z59FFgYAacPIEfj5BDYcRAyit30kARjVfSuwt3NFFx/lezsb+on
         lxIg==
X-Gm-Message-State: APjAAAV8nSfctRg7yyUNIM2kmUMhcZxQFZ4cU9v9PlLRc9vtBKUGyWkg
        vnMHoh8twjUM4Z2v3H5mLSY=
X-Google-Smtp-Source: APXvYqzH8hgPfmnPoksy7y4d7KScZ7S4cAAb7U0FcZgnSE4YGpXtyOxoHCQzvTBRlOE/u1yKAcyj7A==
X-Received: by 2002:ac2:5181:: with SMTP id u1mr3728311lfi.59.1556140416763;
        Wed, 24 Apr 2019 14:13:36 -0700 (PDT)
Received: from localhost.localdomain ([5.164.240.123])
        by smtp.gmail.com with ESMTPSA id m3sm4540248lfh.94.2019.04.24.14.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 14:13:36 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Richard Leitner <richard.leitner@skidata.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Serge Semin <Sergey.Semin@t-platforms.ru>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: usb251xb: Create a ports field collector method
Date:   Thu, 25 Apr 2019 00:12:06 +0300
Message-Id: <20190424211208.17499-3-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424211208.17499-1-fancer.lancer@gmail.com>
References: <20190424211208.17499-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seeing the ports field collection functionality is used four times per
just one function, it's better to have a dedicated method performing
the task. Note that this fix filters the port 0 out from the lanes
swapping property the same way as it has been programmed for the rest
multi-ports properties. But unlike the rest of ports config registers
the BIT(0) of the Port Lanes Swap register refers to the Upstream Port
lanes inversion. This fact hasn't been documented in the driver bindings
nor there were any mentioning about port 0 being treated as upstream
port. Lets then leave this fix as is for the properties unification
and create an additional "swap-us-lanes" in the next patch.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/usb/misc/usb251xb.c | 71 ++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/misc/usb251xb.c b/drivers/usb/misc/usb251xb.c
index 04684849d683..4ef34df948ad 100644
--- a/drivers/usb/misc/usb251xb.c
+++ b/drivers/usb/misc/usb251xb.c
@@ -331,18 +331,31 @@ static int usb251xb_connect(struct usb251xb *hub)
 }
 
 #ifdef CONFIG_OF
+static void usb251xb_get_ports_field(struct usb251xb *hub,
+				    const char *prop_name, u8 port_cnt, u8 *fld)
+{
+	struct device *dev = hub->dev;
+	struct property *prop;
+	const __be32 *p;
+	u32 port;
+
+	of_property_for_each_u32(dev->of_node, prop_name, prop, p, port) {
+		if ((port >= 1) && (port <= port_cnt))
+			*fld |= BIT(port);
+		else
+			dev_warn(dev, "port %u doesn't exist\n", port);
+	}
+}
+
 static int usb251xb_get_ofdata(struct usb251xb *hub,
 			       struct usb251xb_data *data)
 {
 	struct device *dev = hub->dev;
 	struct device_node *np = dev->of_node;
-	int len, err, i;
-	u32 port, property_u32 = 0;
-	const u32 *cproperty_u32;
+	int len, err;
+	u32 property_u32 = 0;
 	const char *cproperty_char;
 	char str[USB251XB_STRING_BUFSIZE / 2];
-	struct property *prop;
-	const __be32 *p;
 
 	if (!np) {
 		dev_err(dev, "failed to get ofdata\n");
@@ -444,46 +457,16 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 		hub->conf_data3 |= BIT(0);
 
 	hub->non_rem_dev = USB251XB_DEF_NON_REMOVABLE_DEVICES;
-	cproperty_u32 = of_get_property(np, "non-removable-ports", &len);
-	if (cproperty_u32 && (len / sizeof(u32)) > 0) {
-		for (i = 0; i < len / sizeof(u32); i++) {
-			u32 port = be32_to_cpu(cproperty_u32[i]);
-
-			if ((port >= 1) && (port <= data->port_cnt))
-				hub->non_rem_dev |= BIT(port);
-			else
-				dev_warn(dev, "NRD port %u doesn't exist\n",
-					port);
-		}
-	}
+	usb251xb_get_ports_field(hub, "non-removable-ports", data->port_cnt,
+				 &hub->non_rem_dev);
 
 	hub->port_disable_sp = USB251XB_DEF_PORT_DISABLE_SELF;
-	cproperty_u32 = of_get_property(np, "sp-disabled-ports", &len);
-	if (cproperty_u32 && (len / sizeof(u32)) > 0) {
-		for (i = 0; i < len / sizeof(u32); i++) {
-			u32 port = be32_to_cpu(cproperty_u32[i]);
-
-			if ((port >= 1) && (port <= data->port_cnt))
-				hub->port_disable_sp |= BIT(port);
-			else
-				dev_warn(dev, "PDS port %u doesn't exist\n",
-					port);
-		}
-	}
+	usb251xb_get_ports_field(hub, "sp-disabled-ports", data->port_cnt,
+				 &hub->port_disable_sp);
 
 	hub->port_disable_bp = USB251XB_DEF_PORT_DISABLE_BUS;
-	cproperty_u32 = of_get_property(np, "bp-disabled-ports", &len);
-	if (cproperty_u32 && (len / sizeof(u32)) > 0) {
-		for (i = 0; i < len / sizeof(u32); i++) {
-			u32 port = be32_to_cpu(cproperty_u32[i]);
-
-			if ((port >= 1) && (port <= data->port_cnt))
-				hub->port_disable_bp |= BIT(port);
-			else
-				dev_warn(dev, "PDB port %u doesn't exist\n",
-					port);
-		}
-	}
+	usb251xb_get_ports_field(hub, "bp-disabled-ports", data->port_cnt,
+				 &hub->port_disable_bp);
 
 	hub->max_power_sp = USB251XB_DEF_MAX_POWER_SELF;
 	if (!of_property_read_u32(np, "sp-max-total-current-microamp",
@@ -546,10 +529,8 @@ static int usb251xb_get_ofdata(struct usb251xb *hub,
 	 * register controls the USB DP/DM signal swapping for each port.
 	 */
 	hub->port_swap = USB251XB_DEF_PORT_SWAP;
-	of_property_for_each_u32(np, "swap-dx-lanes", prop, p, port) {
-		if (port <= data->port_cnt)
-			hub->port_swap |= BIT(port);
-	}
+	usb251xb_get_ports_field(hub, "swap-dx-lanes", data->port_cnt,
+				 &hub->port_swap);
 
 	/* The following parameters are currently not exposed to devicetree, but
 	 * may be as soon as needed.
-- 
2.21.0

