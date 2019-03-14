Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BDBC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BE6B21873
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfCNWgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:36:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:55555 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728276AbfCNWfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:35:25 -0400
Received: from orion.localdomain ([95.117.89.18]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mnqfc-1gfhVq0cXa-00pPMk; Thu, 14 Mar 2019 23:35:12 +0100
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
Subject: [PATCH v2 42/45] drivers: tty: serial: sa1100: use devm_* functions
Date:   Thu, 14 Mar 2019 23:34:12 +0100
Message-Id: <1552602855-26086-43-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552602855-26086-1-git-send-email-info@metux.net>
References: <1552602855-26086-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:RVGNTqK71uxCFzYiMccKjuCKa9laF5X8HCcGcmlmO1usX3YVlzQ
 2l0E32dh0GukR5EdVh1DhZcBWg83jqWN/ogke08s8INXpCOetgNpLOEYrY4HjVW1zWMcNn7
 ZAGjvmK1JQukDRJBUS+PeG45zVtJkXpp8YR5j+irWM4N0MykiP3+jBroEQKX36PN9uq6ZJR
 O4t/cOcbKDvRBRmsjuuxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9eK6LDs34VM=:oAkZK4RcLFbn0YB72xpPgd
 PUpVRJzzsZsyyADxwqdbDiE1xNQ3aX7TtXLOzmT5+kX+ulnfG2eVdVR+SNmx3IiSF0aumaBHx
 +bUSgOvqmYtJlpbXtJ+lnVA1YKEs3HZSGUtETtyriWahIHBct4+hStxilF+Cw0dO6nQ+gHhkW
 p7h8WD+HLLwldAHMY9YJHlvGVgj0FyaweK/D6crfTOJAjcmKALoU1kxgTViUXbrMX8exg79xj
 xxx5AsvSkiQ1de1QzhR2JKLrCIeHL+K2lRrNyc0xw0+s0vKWu5ZvhZQMtGTmzDW7G4tujyFAC
 oGBYGyi8RrmKwz0Y0p2RoKIBxutEzu9ShdIWFLMilKSuoV4L79C5LHvBcnpn6VOc5dnZMaHKL
 3J3aC8F/7YNJzEB8Dmm+12tt6MOkLkYtxswm/PWRwXJO/izSvBazj63tYVZxdbh21Bjy38FWU
 bAKpukglONH9XWQVnOOFJ9BcuXjQXsjJIu6H+8LHzI95cgsZLNUNJNrBMZ2QmkZuGvzpkej9R
 KOhOGFU6DeFtQE53HIGizdIQ1rH9aNUN910nsbH9bXTYJoUyVx+j6e6BilSWwTq9P1aLYeOS9
 qEvYEVNoLOrXDduIHdnwTPGliEvKAhvlkG+DkrSe0wmR52L0iprcJu2ynHLYcpz9LVSKa4pfi
 yeH6q0l2W5wiy3dEfUVOvqB7fnYtODJSjd4VQG/onh0Vw5GD4Hm1EZcdKnPRqf450bjxBERlD
 ETDaSJybMySEjDj2vrH/rnloHnSUDALInx72kw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the safer devm versions of memory mapping functions.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/tty/serial/sa1100.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index a399772b..3aa20a2 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -522,7 +522,7 @@ static void sa1100_release_port(struct uart_port *port)
 	struct sa1100_port *sport =
 		container_of(port, struct sa1100_port, port);
 
-	release_mem_region(sport->port.mapbase, UART_PORT_SIZE);
+	devm_release_mem_region(port->dev, sport->port.mapbase, UART_PORT_SIZE);
 }
 
 /*
@@ -533,7 +533,7 @@ static int sa1100_request_port(struct uart_port *port)
 	struct sa1100_port *sport =
 		container_of(port, struct sa1100_port, port);
 
-	return request_mem_region(sport->port.mapbase, UART_PORT_SIZE,
+	return devm_request_mem_region(port->dev, port->mapbase, UART_PORT_SIZE,
 			"sa11x0-uart") != NULL ? 0 : -EBUSY;
 }
 
-- 
1.9.1

