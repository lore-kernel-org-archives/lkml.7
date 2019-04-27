Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFC2C4321A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88F6D208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfD0My0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:54:26 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:58021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbfD0Mxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:53:33 -0400
Received: from orion.localdomain ([77.2.90.210]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N9MlI-1gfl9m1ece-015ExT; Sat, 27 Apr 2019 14:52:54 +0200
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
Subject: [PATCH 24/41] drivers: tty: serial: timbuart: use dev_err() instead of printk()
Date:   Sat, 27 Apr 2019 14:52:05 +0200
Message-Id: <1556369542-13247-25-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
References: <1556369542-13247-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:BieBEBBsy2gfEajzWoDGWMcE2Mvq0o7NJ63l6aX+FxhP7ufm2yW
 8dXTC3JQUAFY/WCMJ1/1FJOwC4nH5OFd4rdRacx9W0Ygab84QWKSXEPsRUsyINwb9XiMSPm
 RCcNrFz9CApcr0oX4NbMqQ9F8s3kYV2PWgfs7u2aOEsWDpqGeA0wVWyWwLSbOC/ddaW82Li
 OjOZ6NUleeV5JtDUVLwHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JS7vPazR9sY=:wh6dRw4oaWtG3y+0FQ4wKZ
 8vb7ymeX2tvwfAYmr9+mJF4S6k4k9U5V2HEyPrbXJ6/0S9GBgBjJsnwpIZ5c9QgEmjdbWNwxg
 Vu9sf1Y1H5gIZWUsI+qv9PJ9ijIsfYONXKtG98bdpDehmBa5qXmyawHJxhqJs7cRiKkqUAqhY
 FblvZEXvdgz9TOlb8kRby4CbfcCKnvCbFz4yjEjCjnokt4kucvMTBS3a3i0hZDUtXgg/fUvko
 g8UHmEKQyTFXGke0jVcSVmWHajcG1LwVu3u1NfrKQSPqjTGOM+lz0jhtq+zv4PDQ2jPV08Idb
 o/e8xk3mnYBnfPx/mcfQq2eWNyWyx8LzuhwoN/61aCuaXzqf+p2hVM8yePsmjyKQQurXL2qtm
 hLSGJdkrKlIlIvxUAWWF8pRewTNM7KxRH+HAh51wyAc2pc6Kbz3eMc9VAhgttLdykwXdo4XO/
 MHT/R993D1mIhehh6zsGIWqNcm9geCIzmq6h/mVEXRtEqiWomnfCx/WZzeP78227zdQka6OWH
 AVPG353dCHdmxxwOxXw1IJi3Bd0v4+932OPM18Pb/iC+CGjIyy+yZ1L+8PBnIdRjQf8+mDMzD
 SreZjfTcmkCfajv+bJY8mQ+JYH8Rxiri6wgGAWTDynnZSmostnIMj5M0gAxG+J412mhB3vQFu
 lH8SZfCFJ/Q0gFM/aZO2GpwOFmRdwx0qX9iN++Gnue88aT6r05Z83YCxEEVqOSlZgOagQcbFz
 usYqNiOrhd8kKTnSF8uvixL3c8RNqm8PDX/OFg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using dev_err() instead of printk() for more consistent output.
(prints device name, etc).

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/timbuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 19d38b5..dcce936 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -470,8 +470,7 @@ static int timbuart_probe(struct platform_device *dev)
 err_register:
 	kfree(uart);
 err_mem:
-	printk(KERN_ERR "timberdale: Failed to register Timberdale UART: %d\n",
-		err);
+	dev_err(&dev->dev, "Failed to register Timberdale UART: %d\n", err);
 
 	return err;
 }
-- 
1.9.1

