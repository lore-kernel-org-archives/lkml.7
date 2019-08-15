Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1E3C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790AD208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 04:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeHAmCVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfHOETr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 00:19:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33042 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfHOETr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 00:19:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so739425pfq.0;
        Wed, 14 Aug 2019 21:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uOgVUn/DRFSOh5W5qyOtEQclzchLjIrxz1tzU/4/1oQ=;
        b=oeHAmCVhAMM4BfdFg6inmhL91K0Xh/B6WX/iSl7bN7lI0lA9tXKhOM2m/RwO1LnK+F
         T5GNe7lcDKrKHUmzE1fEqnDz9KaDaIje37NiIMjkPcE3SvmAZXWoNOuQDtdnNMp/ijlJ
         ekJmyWHhfhofjtLEb8H09n9mnQBASh3EMv2O6FIuA7FqrtJVGXfkD9hZASiloJQ6RYCK
         yP+ejv/LmlmAk/wgOqOwshunIdq7h3w95wWh4w076nPA0CL0Yg2ZlXlOjGGROrfUjG6U
         znVBO0CGYb9+bSS222drzjRyOjhYy4nvZTvsy/ogIL4DX9BpA8IABdUSmVpVGI33AjdA
         Zirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uOgVUn/DRFSOh5W5qyOtEQclzchLjIrxz1tzU/4/1oQ=;
        b=C3S1bo6t6c1iedJz5nWdQkTuBYIQBVGTd4jKVGmefeIb0g7AiM0tXIWbKPwjPpTy7/
         Be7bEPM12RseSorpVa79wdw/jb+1U1W4N+gye+3MKJP95WoBcINbMWulXDgHhLk06fxM
         6bRW7roWvp7QJHy4IZFZmr6OAeCvsuffSnOHJKBV5T2jTqsh4DuYIuOzupYiMT0w2Kew
         a4RxPAAzeZIq0gqPb13KiWOlq3ivo2C4vIX4gu2wbcNztCl7l19Vy/0/mI1hhwzr8MUH
         JlkOFKI7a57bsAomOIHsF+nGiPyOAqE7M4rox50LUKPdDPKaHpaB4Oa8rnxhlrgAiOn8
         IkIQ==
X-Gm-Message-State: APjAAAWAvFoyUzWJB3FYAWRT1LwShJIvMUvv8KgCWFl0NL9rLg9V9oOE
        Xze2eMCETmmbxuPWBqzEBs78H7XsFQHENA==
X-Google-Smtp-Source: APXvYqwdZObWETKuYB2zMbBui/p7/+RZufZOeNa9IaTSwnElv9QOWUK+kE/mfenGh2aR3cJEwxc4Xw==
X-Received: by 2002:a62:b411:: with SMTP id h17mr3327430pfn.99.1565842786426;
        Wed, 14 Aug 2019 21:19:46 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:55d:33e8:b108:8ed7:92b9:4a86])
        by smtp.gmail.com with ESMTPSA id p8sm1633946pfq.129.2019.08.14.21.19.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Aug 2019 21:19:45 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     cy_huang <cy_huang@richtek.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com
Subject: [PATCH] From: cy_huang <cy_huang@richtek.com> Subject: usb: add more vendor defined ops in tcpci
Date:   Thu, 15 Aug 2019 12:19:13 +0800
Message-Id: <1565842753-14245-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: cy_huang <cy_huang@richtek.com>

In real case, not all TCPCs support the tcpc PP control command.
Sometimes, charger/OTG/CurrentLimit functions will need to externally
control via power_supply/regulator/BC1.2(extcon). This patch add the ops
set_vbus/get_current_limit/set_current_limit for vendors.

Signed-off-by: cy_huang <cy_huang@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/usb/typec/tcpm/tcpci.h |  5 +++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index c1f7073..22dfcd8 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -279,6 +279,13 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
 	int ret;
 
+	/* Handle vendor set vbus */
+	if (tcpci->data->set_vbus) {
+		ret = tcpci->data->set_vbus(tcpci, tcpci->data, source, sink);
+		if (ret < 0)
+			return ret;
+	}
+
 	/* Disable both source and sink first before enabling anything */
 
 	if (!source) {
@@ -346,6 +353,30 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
 	return 0;
 }
 
+static int tcpci_get_current_limit(struct tcpc_dev *tcpc)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	/* Handle vendor get current limit */
+	if (tcpci->data->get_current_limit)
+		return tcpci->data->get_current_limit(tcpci, tcpci->data);
+
+	return 0;
+}
+
+static int tcpci_set_current_limit(struct tcpc_dev *tcpc, u32 max_ma, u32 mv)
+{
+	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
+
+	/* Handle vendor set current limit */
+	if (tcpci->data->set_current_limit) {
+		return tcpci->data->set_current_limit(tcpci,
+						      tcpci->data, max_ma, mv);
+	}
+
+	return 0;
+}
+
 static int tcpci_init(struct tcpc_dev *tcpc)
 {
 	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
@@ -521,6 +552,9 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
 	tcpci->tcpc.set_roles = tcpci_set_roles;
 	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
 
+	tcpci->tcpc.get_current_limit = tcpci_get_current_limit;
+	tcpci->tcpc.set_current_limit = tcpci_set_current_limit;
+
 	err = tcpci_parse_config(tcpci);
 	if (err < 0)
 		return ERR_PTR(err);
diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
index 303ebde..a6754fb 100644
--- a/drivers/usb/typec/tcpm/tcpci.h
+++ b/drivers/usb/typec/tcpm/tcpci.h
@@ -130,6 +130,11 @@ struct tcpci_data {
 			 bool enable);
 	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
 				  enum typec_cc_status cc);
+	int (*set_vbus)(struct tcpci *tcpci,
+			struct tcpci_data *data, bool source, bool sink);
+	int (*get_current_limit)(struct tcpci *tcpci, struct tcpci_data *data);
+	int (*set_current_limit)(struct tcpci *tcpci,
+				 struct tcpci_data *data, u32 max_ma, u32 mv);
 };
 
 struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
-- 
2.7.4

