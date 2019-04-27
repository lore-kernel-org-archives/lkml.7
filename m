Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A03C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F572087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfD0M4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:56:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:56161 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbfD0MxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:10 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MHoZS-1hX2X90am6-00EvFl; Sat, 27 Apr 2019 14:52:49 +0200
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
Subject: [PATCH 18/41] drivers: tty: serial: apbuart: use dev_info() instead of printk()
Date:   Sat, 27 Apr 2019 14:51:59 +0200
Message-Id: <1556369542-13247-19-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:OVKGRVf0aXMWmtc1PHtqfEjiYENJhZU3hpSHmEA0npVSmInw18W
 peVVZAyjlFJAio3YAZ7zsEC8Fe2VQ89wyDlbJaIzUmZGMMp3iII6gzrN822v79B5j0vvLsh
 71zzSbmGgmkHHfJu8peOu878gwp/4AQZkem15Rl7F+pbbfe+1IRXXc3iTGk/vbwXXy8feJ1
 A4wTh5WhUYxm3/nJIj4hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kJPYxrqUW4Q=:IX4zfaBz7w6xvHD6+zvUEx
 9lgTvdeuV59hcukEVZymu+p6tcoSHdR0K1YyNeMpb8uyuppx99cFXsn6a/2c3QwCqdTtaOI7b
 NM555G1mdTA4tx9beSLOpohIzVc1IAh0aF9aqOMLarv10YlFJVBypKsS7eozOr8YjLPwNCA7y
 xLNnSL9nvqoyuR6pmZ9cvRyyyP6/eYw4Fc/aHOZVjluv6XaHH1kDZqcwruoEvA55uYtvnSHac
 9MjLs8ftcbsYmjTSWf1ukKC9wrnPzPU62l5wd6argIoQ2M9shIoE9+TB45W0N7bfJyq0mDbaX
 TJHKhxyRPW+/7p9yUNV10hZ7DQE+aMsD5fm2A2ANmTrYm1EOuOJrwHBgNOvOC8EJ4+jTkk6/W
 BwDYOySXQ80cH6wqZIg+DXq1/w/mFQHSkmwtbd0oqKoJWF1i+ZJF+Ic9yETZqxb/VKtT1JjId
 aY7KauvC1h+u+2i6Ia65kuNV1gsqfMmGLLZjy0AiXOjEvc13FOU1AbsdYNOJA5WSEPHUqWLHT
 SoAIo9fOAKbG2KsIwCu7Zo2mryl45CvXBMMMbNQ9jt5fV9nD8v7BkFwLkMucoFwqTowZs8u5T
 g8EDSIiimu5RjbwcGKHM6HD5X5/g/5FrZKGvHbfpY29hrmOad8MLWYtKwnASbuVRUr6XWpvrq
 WJJr4n5/Cu72gbTk0oEBe4AhzNbI9tMroHYK2nYqhfZrYtIznaI/92IoE9ZcqFvyCxwmiSEKp
 6Y0UpIDYj+h2G2Yvy0Vj7nMLmkVAnbhBJyzm0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/apbuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index d2b86f7..89e19b6 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -568,7 +568,7 @@ static int apbuart_probe(struct platform_device *op)
 
 	apbuart_flush_fifo((struct uart_port *) port);
 
-	printk(KERN_INFO "grlib-apbuart at 0x%llx, irq %d\n",
+	dev_info(&pdev->pdev, "grlib-apbuart at 0x%llx, irq %d\n",
 	       (unsigned long long) port->mapbase, port->irq);
 	return 0;
 }
-- 
1.9.1

