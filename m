Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC402C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9DE20C01
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfD0Mxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:53:33 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:58763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbfD0Mx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:29 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MrQN5-1gyFsf3szn-00oX3M; Sat, 27 Apr 2019 14:53:03 +0200
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
Subject: [PATCH 34/41] drivers: tty: serial: zs: fill mapsize and use it
Date:   Sat, 27 Apr 2019 14:52:15 +0200
Message-Id: <1556369542-13247-35-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:zrosD3Ctd1aN0WpNLZFdBQRFBUqXoIn/vK59RCWQKALAv5BYyI4
 9kJucz8qp+qIXGcy4ADN10n35GRjp3t1bSz4vEWOCzwTB2XXPf6KteeGAGjUQOXvDMkS0PQ
 658vUta/FNmxhHolnomtYwAm2hVQ/rOsExC3aVbcC7iO/2z6qctqb6KpFVlO6xFHXeNXPYX
 uBsZgE/3Ekcv4Nsi/qZwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KnnLQy5706A=:gIgNJYKZQ0XX/Ytqsc0i9l
 bO959YYz3tQkDcQX9QxnzOyjTiFB/3SnL7a7mJdfscylb4xtGHF8Ca2lF8toEGlTpepvNcD3u
 q/nsSq3YpagbmFV3RJP2FJ/a2wQNOTqtWrSn+Ufbk9PrY32lTsg4mgCiZO9RqXb+brgG0nr2n
 Unu5ZCbwOe1acSlJpHBna7JK0aBs8joJUkEL5bpTEBWeI48Dc8g1QcvV0uqUZe+jJPsvzn1Ce
 Rnsl20iqnyzitjrjZfcx6FuQcgrl90qwOG+9YwdtmHccYrKEwajsy3HckhHj7rku74x5Ywflx
 BR87rv5gnTMhhBsEQzFH5O3difC0EM84nSVZPBYoUuF89P6kZOPb/xIZQ0LsxmK1gsMErE4dQ
 gx+9MlNWwLAXqu3sprHSY4/2xEGB8DHEuwAaXAMrUtor6pjz2Re9KLfccujJOlMajeuIRjpvF
 qo6KNZtJYTmo92CsNrFbLhlfpwe4p9buJtiSD6VKuR7jpSnaSzvsH9ABS+KrwTEXS5bLdcxh+
 KA2vMAnfKXFDjsAYCtwLTRxipwutt02+Mg8cBfkEWgv+zNLGcwuo/nJ5L2sFStzZ/an6FlLZE
 Tzr7OlPZ1IudTpdEBKsseNSAzGMAYrmLd7VO4zG51pJXR1m0v9GkHScPVfPNH/U16MXifWOPE
 tdmwTQgV8IzEHnsE0FAGdgn+4ZTd5KO4C7SjNOnQIrB9ZALsDjCUkquoAbC+GFHLy+BKJngcs
 f9jIJFLQ2qoU1mBkm9+zlp5VRMtCHESx7VgPjQ==
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
 drivers/tty/serial/zs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index adbfe79..ab432ba 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -986,14 +986,14 @@ static void zs_release_port(struct uart_port *uport)
 {
 	iounmap(uport->membase);
 	uport->membase = 0;
-	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+	release_mem_region(uport->mapbase, uport->mapsize);
 }
 
 static int zs_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
 		uport->membase = ioremap_nocache(uport->mapbase,
-						 ZS_CHAN_IO_SIZE);
+						 uport->mapsize);
 	if (!uport->membase) {
 		dev_err(port->dev, "zs: Cannot map MMIO\n");
 		return -ENOMEM;
@@ -1005,13 +1005,13 @@ static int zs_request_port(struct uart_port *uport)
 {
 	int ret;
 
-	if (!request_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE, "scc")) {
+	if (!request_mem_region(uport->mapbase, uport->mapsize, "scc")) {
 		dev_err(uport->dev, "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
 	if (ret) {
-		release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+		release_mem_region(uport->mapbase, uport->mapsize);
 		return ret;
 	}
 	return 0;
@@ -1113,6 +1113,7 @@ static int __init zs_probe_sccs(void)
 			uport->flags	= UPF_BOOT_AUTOCONF;
 			uport->ops	= &zs_ops;
 			uport->line	= chip * ZS_NUM_CHAN + side;
+			uport->mapsize	= ZS_CHAN_IO_SIZE;
 			uport->mapbase	= dec_kn_slot_base +
 					  zs_parms.scc[chip] +
 					  (side ^ ZS_CHAN_B) * ZS_CHAN_IO_SIZE;
-- 
1.9.1

