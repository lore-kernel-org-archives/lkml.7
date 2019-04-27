Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6BDC4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D3C2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbfD0Mxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:55 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:54021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbfD0Mxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:35 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M4bA6-1hJp7z0BBm-001m7B; Sat, 27 Apr 2019 14:53:09 +0200
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
Subject: [PATCH 41/41] drivers: tty: serial: lpc32xx_hs: fill mapsize and use it
Date:   Sat, 27 Apr 2019 14:52:22 +0200
Message-Id: <1556369542-13247-42-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:NfvV5UR6Ok9kQv6ROMSW720NbVRt8zJA2j6SiVCta9zO0Jw5F68
 oDYmpeAiqIZsk1sS86lqn4+pdFZWevIEnEZ69zvk7cMJbxGvaG9S0AMXx6E3vAMZVzd7pPE
 dnjPcyK+WGDDc90Ms7ezLEUDc+ruGvc0EkFIZ+8daJJAv3bsvnnSUMXjXwFBnPEgLp6qoWu
 RKq97jOfEVGzQSAvfA3Lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kstkQConv8Y=:FRqaAKBl04WQWWJ/xhmytR
 ow68932EyMejNE2ydtWTf0Nk48WsWDBX+U00qXQiCeX9RLfuAjZhJilURAne8iEvlgV02R+n0
 A2GYXlH6RAocA+3/XNEogage/GN6dO4HAMa6C/jwf7JzbK5UWacs4I86YK6BjId9I8QaBDRgB
 kf36Yrz9heQ6rpkUEPNwg7vs0J835p/+DW0ua1TLJJlSFnCt+nM1Z7WstcwbivmVU+gVR/Qqx
 LJN2HlNYlbXhHrWMmA6exILj0ML6d2lYydBx/ivglWsiafz+dSezxWkhz08L8VIqiIK6dShE3
 srcNtj9cCMeeXy/WuKz1SoACQyyWLzFX5vJ7HF9AD7gMD8mGgq8+HhaWZ4LUAaR/dSriR/R3e
 B3lrMjPoO3yEqTwjmVNFPEHpLcxgHp3k0K3Z94bAYryqu/D8Q3Kol+4OglHPh7K6XXE7/78xA
 oUHoCvvSmoukL8/pOHIkrZr9VoXnBeU4ZV3EjcqSp85aW5Q6jRGfhhvHsog/vo9c0GQByGKDm
 IhDlqb2OO2SeLSFm9kDdRiPNxLsJCsxNdbJujreUgg5JbBJjQnJ034mhihaiaT1Aiki1mOiMB
 OI/mo7wAX4gLt7UHYKkjXmMizG1VASLtLoiFffgH9E2VkMfVV4CHN+LQBdpOkpoUf5rl7srXx
 Kiaqeii/5ydXPnHLqiI2CQtzy/PupKJZ0jWzWsaeQ4xVmH8rQepFc6frR/i5b/8B5xfPqj2Q5
 /wVryOKfpTVqR4EsCEJA4sFCJJjcxbeUyiEL7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fill the struct uart_port->mapsize field and use it, insteaf of
hardcoded values in many places. This makes the code layout a bit
more consistent and easily allows using generic helpers for the
io memory handling.

Candidates for such helpers could be eg. the request+ioremap and
iounmap+release combinations.

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/lpc32xx_hs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index f4e27d0..d1f09aa 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -579,7 +579,7 @@ static void serial_lpc32xx_release_port(struct uart_port *port)
 			port->membase = NULL;
 		}
 
-		release_mem_region(port->mapbase, SZ_4K);
+		release_mem_region(port->mapbase, port->mapsize);
 	}
 }
 
@@ -590,12 +590,15 @@ static int serial_lpc32xx_request_port(struct uart_port *port)
 	if ((port->iotype == UPIO_MEM32) && (port->mapbase)) {
 		ret = 0;
 
-		if (!request_mem_region(port->mapbase, SZ_4K, MODNAME))
+		if (!request_mem_region(port->mapbase,
+					port->mapsize, MODNAME))
 			ret = -EBUSY;
 		else if (port->flags & UPF_IOREMAP) {
-			port->membase = ioremap(port->mapbase, SZ_4K);
+			port->membase = ioremap(port->mapbase,
+						port->mapsize);
 			if (!port->membase) {
-				release_mem_region(port->mapbase, SZ_4K);
+				release_mem_region(port->mapbase,
+						   port->mapsize);
 				ret = -ENOMEM;
 			}
 		}
@@ -684,6 +687,7 @@ static int serial_hs_lpc32xx_probe(struct platform_device *pdev)
 		return -ENXIO;
 	}
 	p->port.mapbase = res->start;
+	p->port.mapsize = SZ_4K;
 	p->port.membase = NULL;
 
 	ret = platform_get_irq(pdev, 0);
-- 
1.9.1

