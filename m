Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B49C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BF22054F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="RpAM+Yk7";
	dkim=pass (1024-bit key) header.d=akkea.ca header.i=@akkea.ca header.b="ZopaZgRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfEFOIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:08:47 -0400
Received: from node.akkea.ca ([192.155.83.177]:37922 "EHLO node.akkea.ca"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfEFOIn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:08:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by node.akkea.ca (Postfix) with ESMTP id 370734E2051;
        Mon,  6 May 2019 14:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557151723; bh=BLB0iTG9i/WddnImNISlddzl33hPIw2AJtO7OrjPOZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=RpAM+Yk7PPWWDRTO0UILYgWgRQgRzmQP3fc3o8YKLk/t8T1vvTEi5+Vfz5cc0bT7S
         maAxEdgaAXEQ1/vrbl75lpjSlS/Kelg7Ks20mxvNM5PmrJUydHN3Dm0AhQl4jBiH2n
         xpj8fnsFwEkpVwjU9ez/FKCyPYe70e7zi9BgHHU4=
X-Virus-Scanned: Debian amavisd-new at mail.akkea.ca
Received: from node.akkea.ca ([127.0.0.1])
        by localhost (mail.akkea.ca [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FGdMrYgHdczt; Mon,  6 May 2019 14:08:42 +0000 (UTC)
Received: from localhost.localdomain (198-48-167-13.cpe.pppoe.ca [198.48.167.13])
        by node.akkea.ca (Postfix) with ESMTPSA id 729A04E204D;
        Mon,  6 May 2019 14:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akkea.ca; s=mail;
        t=1557151722; bh=BLB0iTG9i/WddnImNISlddzl33hPIw2AJtO7OrjPOZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZopaZgRKnkWRjE0ctpSl8fj8l4NjsLlTqz3eHqmtOEhX8/NcCsjR+hq74JbIdL+P0
         QNi8nEP/L//bSNVkwJDcaF+g1f2Ms76r+Q0fBnFXBH0wpOeKOoLGm9u+l86POnGt0R
         5CmQPAPvgBOUCdB0lv0zP5jp9ObcRWz3NlFk20N0=
From:   "Angus Ainslie (Purism)" <angus@akkea.ca>
To:     angus.ainslie@puri.sm
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Angus Ainslie (Purism)" <angus@akkea.ca>
Subject: [PATCH 1/3] usb: typec: tcpm: Export the logging function so it can be used by tcpci
Date:   Mon,  6 May 2019 08:08:28 -0600
Message-Id: <20190506140830.25376-2-angus@akkea.ca>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506140830.25376-1-angus@akkea.ca>
References: <20190506140830.25376-1-angus@akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give the rest of the tcpm stack access to the logging function.

Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 ++-
 include/linux/usb/tcpm.h      | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index fba32d84e578..7c35cc1accae 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -465,7 +465,7 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
 }
 
 __printf(2, 3)
-static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
+void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
 {
 	va_list args;
 
@@ -479,6 +479,7 @@ static void tcpm_log(struct tcpm_port *port, const char *fmt, ...)
 	_tcpm_log(port, fmt, args);
 	va_end(args);
 }
+EXPORT_SYMBOL_GPL(tcpm_log);
 
 __printf(2, 3)
 static void tcpm_log_force(struct tcpm_port *port, const char *fmt, ...)
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 36a15dcadc53..70bfffdf5760 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -169,4 +169,6 @@ void tcpm_pd_transmit_complete(struct tcpm_port *port,
 void tcpm_pd_hard_reset(struct tcpm_port *port);
 void tcpm_tcpc_reset(struct tcpm_port *port);
 
+void tcpm_log(struct tcpm_port *port, const char *fmt, ...);
+
 #endif /* __LINUX_USB_TCPM_H */
-- 
2.17.1

