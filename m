Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEE1C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2952C208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfD0Mze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:55:34 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33287 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfD0MxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:15 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhUDj-1gqW7b2XwJ-00efAG; Sat, 27 Apr 2019 14:52:52 +0200
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
Subject: [PATCH 22/41] drivers: tty: serial: cpm_uart: fix logging calls
Date:   Sat, 27 Apr 2019 14:52:03 +0200
Message-Id: <1556369542-13247-23-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:6aniEe4uJcRcav5vVBfcQ4eLLFWMnqJpVC4vZyHJ9k0A6q/tn4j
 b9DaJRxToUGOhrA8XctR1mPhJ0cf7Ttk2f4rAFWNa3fQjR7YkDeiN3gu2Jkvl9J2LTCqub4
 NvWiLxdxAxFk1k9fhSMKs/EVAw4rvAGYukqY9dkQaz94+MijAkIVPXhEPMgivLXBUM8RACd
 PwxeoNLw6M7rcZKmGYaIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N1DUCAE49ps=:6Bg3z0yKDfbQlfXN15vFTK
 CTXF7meBLhT1JFynkQvUub9OX3IH9Bn32MIrPU8KLGYu6xRSeeA/dv91WkdRSMB7jw5SdnYVU
 fBjG6PFdpn1ZcQEzJLT3TEeYtiWNSTLLl+4olsmK1UCkntdxplgAH0cDkdqmRgBilTze2f7jr
 yBoEZG/TEYQR7XOcNbzuiDrCWD/QGrMzOWGTHHxN6hQnmtCwz+JPrD3eLuSj6f48WAbwJlu1K
 pi/aO1K/KDfh6fTnuKZ0wM3Rb509RDLGyiAS7Cq+EOzAfOuLQxlXxNmBU5uwfoZgNkZxLYXpG
 LPA/VLSRM/do906EdV+T1SaqdwZoEwTB6TVOR/PMF8++fRGUXP3sVtBYfhqAlLOACU03kvhhT
 e/wSlyyyIN8laaJjGbbkdmkScfnBHzxwxJJodWsT5x5MW2YdlWf5dVUI7B1fkpyAn6/3PpqHZ
 ozeZgeiwzfUj7KdmcDro0QCipy3GpQh1Tv0Iq+NqFHBGaR3f3+cWDo3rDMych8CTVLTU1AVkl
 2XBtChbNXe7808yH+6vrzkl8qad8i15gpT2NYBjcGcbsv3Jx9SO4lLao075F0ckBuGvZ+84La
 SuMyHOhs9Ph85GauTE8NUiSCnd851q5KRXd3jTIJoWrjlcnFeyNg6Od4d+LNqplzy1QwNfHER
 tVlWKkonlZQPDNV6mjAqvrxGHz/Dn/JPo8WteDheS37jlKM3nioX2QkQZjoaYGONVb+tRUXJw
 jl1OMAdapLwDVC/umjMb4TaNPso7exnunktkrQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warnings by using pr_err():

    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
    #109: FILE: drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c:109:
    +		printk(KERN_ERR

    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
    #128: FILE: drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c:128:
    +		printk(KERN_ERR

    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
    +           printk(KERN_ERR

    WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
    +           printk(KERN_ERR

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c | 6 ++----
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c | 6 ++----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
index 56fc527..aed61e9 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
@@ -71,8 +71,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
 	dp_offset = cpm_dpalloc(dpmemsz, 8);
 	if (IS_ERR_VALUE(dp_offset)) {
-		printk(KERN_ERR
-		       "cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
+		pr_err("cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
 		return -ENOMEM;
 	}
 	dp_mem = cpm_dpram_addr(dp_offset);
@@ -90,8 +89,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 
 	if (mem_addr == NULL) {
 		cpm_dpfree(dp_offset);
-		printk(KERN_ERR
-		       "cpm_uart_cpm1.c: could not allocate coherent memory\n");
+		pr_err("cpm_uart_cpm1.c: could not allocate coherent memory\n");
 		return -ENOMEM;
 	}
 
diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
index 40cfcf4..a0fccda 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
@@ -106,8 +106,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
 	dp_offset = cpm_dpalloc(dpmemsz, 8);
 	if (IS_ERR_VALUE(dp_offset)) {
-		printk(KERN_ERR
-		       "cpm_uart_cpm.c: could not allocate buffer descriptors\n");
+		pr_err("cpm_uart_cpm.c: could not allocate buffer descriptors\n");
 		return -ENOMEM;
 	}
 
@@ -125,8 +124,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 
 	if (mem_addr == NULL) {
 		cpm_dpfree(dp_offset);
-		printk(KERN_ERR
-		       "cpm_uart_cpm.c: could not allocate coherent memory\n");
+		pr_err("cpm_uart_cpm.c: could not allocate coherent memory\n");
 		return -ENOMEM;
 	}
 
-- 
1.9.1

