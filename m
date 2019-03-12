Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCA8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808FB2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfCLO6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:58:20 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33725 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbfCLO6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:58:17 -0400
Received: from orion.localdomain ([77.4.190.91]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N2mS2-1gvqVA393c-0136zE; Tue, 12 Mar 2019 15:58:00 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] drivers: tty: serial: use memres
Date:   Tue, 12 Mar 2019 15:57:39 +0100
Message-Id: <1552402660-31730-8-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552402660-31730-1-git-send-email-info@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:Z2TEk28oacJ/FDoOqMwiAeOT5Rvnr9fTO4XQD/FmNKtfnkclMiU
 sN1PUnd3/icQjuK62d2h0q8mxeK0z2oPthUo1OIhfY+HcyAwZcMBRsliTbPFdCbKUEzjXuq
 oLiN9Jk4Zs8J4WU1HJVL6e4uJXgcsPGFPwxyEEwr61xslA3sRolFoYmEUaXhQqIvehy547J
 lTfppSm5vPCtXBLkPZ1Kw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8Ky0cuifLhY=:jhLcD+5Zj9kMz+2F3xLkeD
 fozRfkGpJZ9tKnZrEXF4qCKDrYFT1DWYT71DYzeVod8mhQfQWRqEMeV5iLaTKIlVSbKBd0D7M
 nuoArACyMxmFuquaoLPd/Ve4nek7nrySpFwBG6pT3748eJ+ryGzfsFKTV4vyaXIrLuYaArxse
 1k56Vo9YWXcvucPXc+MmfYQyH+WGLkCKyrFrRkp7lnJgrt6uxMexFr2GsSqprbnd6R2r2S8Ox
 G6EtHVNsEfrupltGYuzEo5/SQ4b/VrsDfLBjsBAJ0UFRCGDRfYyepzWi+tmrE0qxIXV8DnxJ1
 sVDpN30ld6DECCB3QUlGBlXDego1HY6cd0HBT86/5gxyGbQQLy+CuUhcpHybVIwcT8vrQONp1
 GOeVoPlCmlmgD6dy/+s4Mmx+heE3RCDODX0TT7QjW9/izARkQSO7e/WGu42qqiX3+u1EvebkJ
 AJJQZabCe+wN+6tPeReIuypibQ8y8IIMSBsA+jZC1ohCkJBOA8zzqtASinfS+izRXCPFbtsKl
 wfu6vrS0nzDxMJahDM8f1guyn98qoTcyTYYr2duPilpPAKerGAjc51oxoN9xahMEbgwOP8OSl
 3Cx5VzXLS8eDrFY8GuZvZDxrsx0VJObD7gCYOTHEsw6iMQcgSPegnKPwr2vEkLTapmY2nUHB4
 9UlqiGqtLSG7OayUJtirHOSo3lbmAylMYnnHCA8j4f2xPRdnDdO9PwRDnYD0Bc1eOHrqu+DSV
 olIYfeTTeJRdwgLtxz7G3VNbGaITHKnTTKZ7Hg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 drivers/tty/serial/zs.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index b03d3e4..2fd4821 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -986,14 +986,13 @@ static void zs_release_port(struct uart_port *uport)
 {
 	iounmap(uport->membase);
 	uport->membase = 0;
-	release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+	uart_memres_release(uport);
 }
 
 static int zs_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
-		uport->membase = ioremap_nocache(uport->mapbase,
-						 ZS_CHAN_IO_SIZE);
+		uport->membase = uart_memres_ioremap_nocache(uport);
 	if (!uport->membase) {
 		printk(KERN_ERR "zs: Cannot map MMIO\n");
 		return -ENOMEM;
@@ -1005,13 +1004,13 @@ static int zs_request_port(struct uart_port *uport)
 {
 	int ret;
 
-	if (!request_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE, "scc")) {
+	if (!uart_memres_request(uport, "scc")) {
 		printk(KERN_ERR "zs: Unable to reserve MMIO resource\n");
 		return -EBUSY;
 	}
 	ret = zs_map_port(uport);
 	if (ret) {
-		release_mem_region(uport->mapbase, ZS_CHAN_IO_SIZE);
+		uart_release_memres(uport);
 		return ret;
 	}
 	return 0;
@@ -1113,9 +1112,12 @@ static int __init zs_probe_sccs(void)
 			uport->flags	= UPF_BOOT_AUTOCONF;
 			uport->ops	= &zs_ops;
 			uport->line	= chip * ZS_NUM_CHAN + side;
-			uport->mapbase	= dec_kn_slot_base +
-					  zs_parms.scc[chip] +
-					  (side ^ ZS_CHAN_B) * ZS_CHAN_IO_SIZE;
+			uart_memres_set(
+				DEFINE_RES_MEM(
+					dec_kn_slot_base +
+					zs_parms.scc[chip] +
+					(side ^ ZS_CHAN_B) * ZS_CHAN_IO_SIZE,
+					ZS_CHAN_IO_SIZE));
 
 			for (i = 0; i < ZS_NUM_REGS; i++)
 				zport->regs[i] = zs_init_regs[i];
-- 
1.9.1

