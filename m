Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A487C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D492521873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfCNWil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:38:41 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:43405 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728032AbfCNWfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:02 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MOzjW-1hPNc02hqe-00PJk0; Thu, 14 Mar 2019 23:34:44 +0100
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
Subject: [PATCH v2 13/45] drivers: tty: serial: 21285: use devm_* functions
Date:   Thu, 14 Mar 2019 23:33:43 +0100
Message-Id: <1552602855-26086-14-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:h5fFTqI7FK0BepUa202XiTJexkjgZcrQ9yIhVKWn6VwEc9Y1x7K
 XzflPzTphuPzgv/x+KEpkxQVPJmOrk3uUbTHozIIlF3ygE7gP6AsVHjDboBUT4k+U1W7/o6
 NFBG5UbG6d6tFCYLVZJXdOYZMZg03tVoKP9mDOyctEYmmD8ymGng1G7rKbSspKFSCx1W02P
 IvwIngrQxpHi7HFnpyLEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aXmbC3/KU8E=:JlqCtlZexdHHcIXMiUsHfX
 zl6IdahqvXOyV3X/1h4a7tbpzvE7gdk3tbSKbB6WZYchfxqHVxYaapU1Y6z3iVcOqYXA2UfRY
 qPV1tO7tVP3QrddUINJ2d7MEbI6Wx0rYzkcFI2z6xDWs8fhUMJSInrmTHxAMrF2AASEoh6zl2
 5LpQ4C9J5JfFJs06sVt3NXA7qNUBrPc7P4ZkZgapp6UcRu6jmxWNXFV1tmcnlkgvmY//lpB/X
 x/Iqp9ZDyoix3QBsMuMynLIkjxLHOrhz0bv/pDAl+sLYTuh+NmiZbNsFmyIXTxP97g/ORlLeF
 lbctu/UYJznSlZZ2q5/0HQnHTcTRFOZEojfNCBghfBFsxEDTMTOWjCo+xA6rHqwqzYb4PfTgG
 Hu6XLNDxgRc5cXgT78IIRjBSmnhX0R/v5OhyC43dMaGx5ERtO2V1ay5ftIrY9XnfLrd3DpAsz
 YEOKZPS/X+HuOv0eWEwDIbkWvBZue/HavwnovDSbDTvhjUpxZxWqhvVp//j+CPRQ/TQVEIgL9
 E6SD47LwYDEtrwnAiOX3eY5rMR+2J8Q/Plzzy93vCVCuAIYdgcdEgzq0ORpT59knf91A4oTTl
 mVyJf/CoyD551iRgLwYLTUGf6TMD1hWcMpr0yN9/eX+Uz3ziI95qxT6SExDA6iN1HcO8E2Ejl
 hsXTH5ZBwMcaUsOLVawQDoW75tqYdIsBpzvSNDtyFEjS8m/owt20IHxVS8jU0GJ6wpMBaudnH
 JMt85xqpv5zpsMnCo13DZbg5d8MTdiyAe3sHOw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/21285.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 32b3acf..4ce2de2 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -305,12 +305,13 @@ static const char *serial21285_type(struct uart_port *port)
 
 static void serial21285_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, 32);
+	devm_release_mem_region(port->dev, port->mapbase, 32);
 }
 
 static int serial21285_request_port(struct uart_port *port)
 {
-	return request_mem_region(port->mapbase, 32, serial21285_name)
+	return devm_request_mem_region(port->dev, port->mapbase,
+				       32, serial21285_name)
 			 != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

