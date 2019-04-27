Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36436C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1094920C01
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfD0Mxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:37 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56653 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfD0Mxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:36 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MBltM-1hUJVl230m-00CCVD; Sat, 27 Apr 2019 14:53:05 +0200
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, andrew@aj.id.au,
        andriy.shevchenko@linux.intel.com, macro@linux-mips.org,
        vz@mleia.com, slemieux.tyco@gmail.com, khilman@baylibre.com,
        liviu.dudau@arm.com, sudeep.holla@arm.com,
        lorenzo.pieralisi@arm.com, davem@davemloft.net, jacmet@sunsite.dk,
        linux@prisktech.co.nz, matthias.bgg@gmail.com,
        linux-mips@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH 37/41] drivers: tty: serial: 8250: simplify io resource size computation
Date:   Sat, 27 Apr 2019 14:52:18 +0200
Message-Id: <1556369542-13247-38-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ZXB7mz06Ly6MRfvhguoHM1IMTFUXYkIayQ68G7Km7tO2KigZSMd
 WUDQTyk7nJWuJWfpUC2J3DXsXOHpTBXAQKmw4PEK4HGNm8oGTafIAx2Xk8Zj7ZVo8wGvu2C
 WGMoTc/hfdwrsTKqgRSAMJYHomV0Lqh7b2/oYaNbGzZfASAsdwQhPLui2wYuEQ8VqWoKKUa
 A6yCc5QHRSyk0dMUcyEUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:93wra+Qsj5Y=:XHwmY3IHMhOTtTwYleFaYp
 PCXSvCkNG306ssxvH2mmJYSPBHuXbTCJnleHmnh9t9Be+YdN0wLScPfILH4TKc90KfNN8Pxib
 UrKW6/PxCpLn/Koj4G/g1lu6rJvrRaAw7qAJokpPoKm7tlOoEYEbry5kL7NN9DF8UEmOW6V1R
 NfGRJ+lr4UX9x5IZAdAWGleM5Uj71lJWViQNgheekR8JDIdAUsTjLCAFS3uORFtDHMEELA5th
 aIBXftbPsKFzzQwqtp6hKM9Xb+5YtjfYEH+Zcvd/evd24tVRKwoCXUpE6XIXjgWlSg8vRqP5i
 +FSM27/iGFEOLhfrShGN8Sy9NxN/kONh9wFaa1yjGjTdb6l9VRsBP0TyRCF4/442yovIW/wYl
 /ctIs4g7N2mOowGIllfQjlzB6Lo319VBhyz7wRm1D7F+/SoLc5fDUClXplUe0JrQcwNsF6pMp
 mku/zHhL6iDvJtIn1LZ8HdIXWbn0uD4xY8kuBTQhenLreJezjR0STxZ3x1MCjMrYIDyuhL+qe
 Z5+kqWq4G3SSFzy9KUuq21LUmqFvPKDnZfxekvgX18cU5HyvmnMFbzmG/YLO4bXRj873Hz0ee
 7EKcIgxKKL8Hex71R96Nvh25ouN3UuDsS5ISPRwUzfK+FEvkJYmFSnG9zoV90STqGCnyfMdSJ
 +V+gWcjaqsBs30A/7RLXLbikyKWf01R/0aJ1X6QSSQa+03P0MI4nl4mFPHjcUGTfWZyezKlJ2
 JXAC4DHk4/cwvJNWcmd8RV2n2dC+RgUhIxkunA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simpily io resource size computation by setting mapsize field.

Some of the special cases handled by serial8250_port_size() can be
simplified by putting this data to corresponding platform data
or probe function.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 arch/mips/alchemy/common/platform.c | 1 +
 drivers/tty/serial/8250/8250.h      | 1 +
 drivers/tty/serial/8250/8250_of.c   | 1 +
 drivers/tty/serial/8250/8250_port.c | 6 +-----
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 1454d9f..226096d 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -51,6 +51,7 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 #define PORT(_base, _irq)					\
 	{							\
 		.mapbase	= _base,			\
+		.mapsize	= 0x1000,			\
 		.irq		= _irq,				\
 		.regshift	= 2,				\
 		.iotype		= UPIO_AU,			\
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 89e3f09..7984aad 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -105,6 +105,7 @@ struct serial8250_config {
 
 #define SERIAL8250_PORT(_base, _irq) SERIAL8250_PORT_FLAGS(_base, _irq, 0)
 
+#define SERIAL_RT2880_IOSIZE	0x100
 
 static inline int serial_in(struct uart_8250_port *up, int offset)
 {
diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 0277479c..08157a1 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -185,6 +185,7 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	case PORT_RT2880:
 		port->iotype = UPIO_AU;
+		port->mapsize = SERIAL_RT2880_IOSIZE;
 		break;
 	}
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d09af4c..51d6076 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2833,11 +2833,7 @@ unsigned int serial8250_port_size(struct uart_8250_port *pt)
 {
 	if (pt->port.mapsize)
 		return pt->port.mapsize;
-	if (pt->port.iotype == UPIO_AU) {
-		if (pt->port.type == PORT_RT2880)
-			return 0x100;
-		return 0x1000;
-	}
+
 	if (is_omap1_8250(pt))
 		return 0x16 << pt->port.regshift;
 
-- 
1.9.1

