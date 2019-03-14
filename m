Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81058C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0882184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfCNWfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:35:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:56541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728112AbfCNWfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:05 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4aEC-1h56dS1INq-001j9O; Thu, 14 Mar 2019 23:34:48 +0100
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
Subject: [PATCH v2 17/45] drivers: tty: serial: timuart: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:47 +0100
Message-Id: <1552602855-26086-18-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:5r+Ptv5G3/1qWxI3DWCkkbtFxPTEnvSfhR5ukwO5ADoTqXU448U
 dtQMPth5bJpZ6f7Bscl0OBv3BL5nInhWPlG6uW76I9pJm3YfyWCWgkRwTyR5fQemqZGQEcW
 81RCi+VaElgdX2WTkloTzCI6WzzEdF+ZLkdYdHoDsuLPWXtSOleXnFSGakAbdc6hwe1rkHo
 fgRNgH1EdpTrK0eSklwNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O+os8DQ6rPM=:xPJygNrhvdGreJ8J1abZGo
 03XRikNHaMhwNSjS2mfFkudwef5NII6M/hEvHC9kdR/YNYHl7UDGfl+MwSd1tEAo/dwBXkt8Y
 6raWqdp714ENf0qaakCCHalCAKhNgdkTY0qG4+c+U5pRTCT2hUwDs7r2b6PX6l05nLwj1BiM2
 A4auArDgzMFT25JWG8jE1Jux9fWGEOKuvmu48i83Q8jr3cZ8fK+SbOcCnbRhUIHPwKKNshHFm
 VEPmMOE9O31356dtH5tgpm+NnnNxc/gVA4X5srmmwE+x5MlaKkb/TlGVnCjBSk+4WTE7nNZkX
 7dpJxc0gbdgqqRYO+NaUMq4Y2kfz8OKQ1VxyK13Zkz10GcafZD3u2R2C87Eh2TcsxB4/IlrEX
 NbubL4r2t91rp+tr5UHMUDTzvr9zSa/bGnEdVWgVaBuLhSFRFLosKLHJe5FmuZUl6cSyvAckF
 WxgSeMizUQ7B+n1xQj/mNbzPuZHNzNKIRh3rUWpybsbWjXyH5vHGg0J2XFgKlT2NLYyqBimkm
 mwVIcvgNmQGVxqAE2yRC/2zl2UBZQrHjMw74BjY5Czcd8Gao3y1znDW+UflD2Z3wrctVGUkfc
 t+1SxDHsKugQB4Syq9OfrHeZkM2QrQCxCunVrhHxoV0qvEi8TwoSea8/OhkIs9nxq4tdw62Zw
 /d/g5cm1eCPpws8n2BX/4w9WW3I1YmB6DEphKq/M/tcouC39sRCaxu+caYKCtcVAwYVw6NPQR
 xHBejTv3s3N08opJ2a2OSf2/wkjOe7Bh41sW5Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/timbuart.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 19d38b5..292354b 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -319,11 +319,11 @@ static void timbuart_release_port(struct uart_port *port)
 		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
 
 	if (port->flags & UPF_IOREMAP) {
-		iounmap(port->membase);
+		devm_iounmap(port->dev, port->membase);
 		port->membase = NULL;
 	}
 
-	release_mem_region(port->mapbase, size);
+	devm_release_mem_region(port->dev, port->mapbase, size);
 }
 
 static int timbuart_request_port(struct uart_port *port)
@@ -332,13 +332,18 @@ static int timbuart_request_port(struct uart_port *port)
 	int size =
 		resource_size(platform_get_resource(pdev, IORESOURCE_MEM, 0));
 
-	if (!request_mem_region(port->mapbase, size, "timb-uart"))
+	if (!devm_request_mem_region(port->dev,
+				     port->mapbase,
+				     size,
+				     "timb-uart"))
 		return -EBUSY;
 
 	if (port->flags & UPF_IOREMAP) {
 		port->membase = ioremap(port->mapbase, size);
 		if (port->membase == NULL) {
-			release_mem_region(port->mapbase, size);
+			devm-release_mem_region(port->dev,
+						port->mapbase,
+						size);
 			return -ENOMEM;
 		}
 	}
-- 
1.9.1

