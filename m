Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0C1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4552184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfCNWhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:37:54 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:46077 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfCNWfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:06 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MCsDe-1hDOdm1UB6-008uwe; Thu, 14 Mar 2019 23:34:50 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, eric@anholt.net,
        stefan.wahren@i2se.com, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andriy.shevchenko@linux.intel.com, vz@mleia.com,
        matthias.bgg@gmail.com, yamada.masahiro@socionext.com,
        tklauser@distanz.ch, richard.genoud@gmail.com,
        macro@linux-mips.org, u.kleine-koenig@pengutronix.de,
        kernel@pengutronix.de, slemieux.tyco@gmail.com,
        andy.gross@linaro.org, david.brown@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        baohua@kernel.org, jacmet@sunsite.dk, linux-serial@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 19/45] drivers: tty: serial: sh-sci: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:49 +0100
Message-Id: <1552602855-26086-20-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HBGeKvv+qEQbXti20pnx8D1tVmbz/ITGLOz+ix4DhYOtbK33vmW
 CqRzKVbI/QB4yWVcPfKCrF3m9cdKXwAZy+T/T/iH6WLxOYsrHpUCge07Ig3YQ4jBQwQfR5A
 BayTuIA0srciiGBNxM0Z9PHtR+w9JC/KSEY+REGx/xEWlNr7AHzMPRlkNx5UbMmMywR9HVK
 6Qei2aTMX/gvKEjJj66KA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+S3wpU6JtJ4=:GFMGEAn1Gx9dHsP0Vrwrx8
 ke5sI7qTIiiUC35E/EsF9BSIX0dE19OeZ0ealWnFbT8c3943BBlCM217Jtm7WLEJgjryfX4lT
 HVMJRwbNfiKXEcOanFjWhoAZyJ8yxb/C+7lMtfk5nKg+ekn/l45sXxfLO8hKOPHm2vMPbh8Hs
 B6Ak20q3etNlixlqmRGMbFZ+RMkwnGxSVaAlWmzwCI2fO9p2wwsynUEBpGTGETOKvPh0zFX/Z
 b2gyvV9Mn15F/a1rEh3CipnXS6fLp5n+TYG9q5D3/jKilJUpMvxVX0bxENbfGzP6YMInI2OrN
 FqtnjBbNuSetaZE9KUsFJ7eVjblPxqqChoD4CozNMt/gX+KWzyqs1WW8jxJtOK6J87t6dKXog
 bDvA18JwZtsxmXzfaUTQlemj0IqPGmBDpcMQN5jVV2W45Z4G92McfsFgJha2Ko7j9FpftABEK
 li2xCcp9WYF2a4AuJII903nUJiDrOJn3hTJQIdwhLYjfyJ7w44vWBAbaf+gK2zRbhkBWjjo3G
 dY/gEDIWdc2cfEbwXEIdt3XJyG5qLSEBDEa4/kTFHLlDOz5uMXOQ7WAqFcMwDFBf/18S5cUmo
 kHFmZH2efa0dUXGEMp+u0vj5Bbv1rDL0gyDPuAj4Ig8LX/g7eo9brg98BlZ4pg57K+COzHjhf
 n3W+9goDEMt6lEK4Cd509Kn6YaproKDo2qh50MiFWJUIWMjbZlCIKvFJtD1jOQU2aI7upPQh9
 LZxW5+2u4rnuD3Y4ZQ6+PLNTsI7jCrm+FP/c5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/sh-sci.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 060fcd4..e40b0d0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2667,7 +2667,9 @@ static int sci_remap_port(struct uart_port *port)
 		return 0;
 
 	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
-		port->membase = ioremap_nocache(port->mapbase, sport->reg_size);
+		port->membase = devm_ioremap_nocache(port->dev,
+						     port->mapbase,
+						     sport->reg_size);
 		if (unlikely(!port->membase)) {
 			dev_err(port->dev, "can't remap port#%d\n", port->line);
 			return -ENXIO;
@@ -2689,11 +2691,11 @@ static void sci_release_port(struct uart_port *port)
 	struct sci_port *sport = to_sci_port(port);
 
 	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, sport->reg_size);
+	devm_release_mem_region(port->dev, port->mapbase, sport->reg_size);
 }
 
 static int sci_request_port(struct uart_port *port)
@@ -2702,8 +2704,10 @@ static int sci_request_port(struct uart_port *port)
 	struct sci_port *sport = to_sci_port(port);
 	int ret;
 
-	res = request_mem_region(port->mapbase, sport->reg_size,
-				 dev_name(port->dev));
+	res = devm_request_mem_region(port->dev,
+				      port->mapbase,
+				      sport->reg_size,
+				      dev_name(port->dev));
 	if (unlikely(res == NULL)) {
 		dev_err(port->dev, "request_mem_region failed.");
 		return -EBUSY;
-- 
1.9.1

