Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B98C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10862087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfD0MxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:06 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfD0MxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:05 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MVNF1-1hBGZC1Cwp-00SLNE; Sat, 27 Apr 2019 14:52:41 +0200
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
Subject: [PATCH 09/41] drivers: tty: serial: sb1250-duart: fill mapsize and use it
Date:   Sat, 27 Apr 2019 14:51:50 +0200
Message-Id: <1556369542-13247-10-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:ZaCk4lb7tsU+VMSXb76laO+FYz7IB7DvruPd8DW8Z5VN86cLAXx
 XoTjgpy1D4cW0l6Dtk8ovOsbJ8N9Wa/Bbip0AWVSYaXLx73ljAgB+eT7NLTxRv9yXwxk0n6
 HH2/FDKHKTK7DJe3OrFZeO4xRkkEqT/D7RK5KNlvmu7PNcsk+uX5W9PhxlgNSIsAXElPf5S
 ey1fWSh+9w6GIdr1VGyZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bMjmK7y/pZk=:+AFfLGXZen+R/LjlG6zSk7
 L8sUEG8PAms3y8zIqVAQwMY6qAqR82Lr0rV3bmYkKN7tHlDRaITbqgcrePCA9GhxzAAamUqAf
 YwUlxTo4PLwjN1ylObX8wcBa9n6x6fJFhwBBYNjLMxo2rfYeunsf+B/mSAmul4qeuDFXvTiJR
 rLJjI4Q5l7VTPJ5zet72iWe0Hlp6PHbzAvsjIEeuOp0SraT4dJbsI7FZwjziDhZxH+ATmIsbb
 Kql4oUhkX+us1ZmJ42xUQasNo8zIArVrpR8vPsLM2jB/KzVDVkBjOTYmsByxB6ebMmMZFuPQd
 Q1ynq6X0xmA9TnjqSxTZikf1QA00We/n674kmX1LPWfbLz9t1njHTRpVxCALOyNjl22t9oqC0
 X5HvRIzJpn99vxUo1kTCGnHvD9Z8ouFu6TplGDfMsbVcUxgipevllxBYDC6h7bNmKhBjqnTMK
 06KakDCYlO0MY5EqGM2o5YxobEmB4gMoCiId14JTpNmX/F3DYudyaFLE0P+lWuFO7tUdgIZ/p
 hgGMynJm3bUU5Gt08dqMxN+WABde7p7fXqouDHErv3RZaOoAz6dcjciU+wuCblZWxT0OC28oP
 2u+KrAW0cbW4rM3u3mhzvA4/EA+YrH3HZHdGpWT3e9DlT2ljYYgQBAHO0cTMM/hSp1MuYkjdS
 41dTTuSXboMqixDvStEni4kBMKHteWCKINqCGhSJZBVy3lEq2Rb9jsrRZemdRp4Vhj4RMcfhE
 Fxrt899EKT3VTfQKp4V20bneFn76TA5cuj+Bcg==
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
 drivers/tty/serial/sb1250-duart.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 227af87..1184226 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -658,7 +658,7 @@ static void sbd_release_port(struct uart_port *uport)
 
 	if(refcount_dec_and_test(&duart->map_guard))
 		release_mem_region(duart->mapctrl, DUART_CHANREG_SPACING);
-	release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+	release_mem_region(uport->mapbase, uport->mapsize);
 }
 
 static int sbd_map_port(struct uart_port *uport)
@@ -668,7 +668,7 @@ static int sbd_map_port(struct uart_port *uport)
 
 	if (!uport->membase)
 		uport->membase = ioremap_nocache(uport->mapbase,
-						 DUART_CHANREG_SPACING);
+						 uport->mapsize);
 	if (!uport->membase) {
 		dev_err(uport->dev, "Cannot map MMIO (base)\n");
 		return -ENOMEM;
@@ -693,7 +693,7 @@ static int sbd_request_port(struct uart_port *uport)
 	struct sbd_duart *duart = to_sport(uport)->duart;
 	int ret = 0;
 
-	if (!request_mem_region(uport->mapbase, DUART_CHANREG_SPACING,
+	if (!request_mem_region(uport->mapbase, uport->mapsize,
 				"sb1250-duart")) {
 		pr_err(err);
 		return -EBUSY;
@@ -716,7 +716,7 @@ static int sbd_request_port(struct uart_port *uport)
 		}
 	}
 	if (ret) {
-		release_mem_region(uport->mapbase, DUART_CHANREG_SPACING);
+		release_mem_region(uport->mapbase, uport->mapsize);
 		return ret;
 	}
 	return 0;
@@ -812,6 +812,7 @@ static void __init sbd_probe_duarts(void)
 			uport->ops	= &sbd_ops;
 			uport->line	= line;
 			uport->mapbase	= SBD_CHANREGS(line);
+			uport->mapsize	= DUART_CHANREG_SPACING;
 		}
 	}
 }
-- 
1.9.1

