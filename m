Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE48DC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B17A1206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfDPMd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:33:58 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:45461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfDPMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:33:58 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MfbwW-1geqb801Ae-00fzxb; Tue, 16 Apr 2019 14:33:26 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Phil Elwell <phil@raspberrypi.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Mao Wenan <maowenan@huawei.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] serial: sc16is7xx: fix unused label warning
Date:   Tue, 16 Apr 2019 14:33:14 +0200
Message-Id: <20190416123321.3577638-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Isv801bhuFl5TPOhgPhYg49CB4hUSHIfDyBdHkXyjrE6jHQsVRY
 0Hb9mHFX3KvqK44OPt04V48L08vIUpEOaO13zt4FnBahsxKsjzXHOr0GGXptEtpBnrpdbv1
 O5gRktt32NIaiea9SYUt+nnV3czISsTReOllGefyw6EXVK4wgNdNoum9tiCfKzG7aTLbyv/
 RGcM7gpQOPBygSArdaG2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NAuNrnS1aTg=:TFvsQhfn12DMfGoZMQB26S
 ZUmBJxIvA/NH/xESEJUYR+ObjDi5hHOZyrLvyNi6V6VlwqibFJZ1sBGQsxOAxHFNfKd2mAL2Q
 gi7d5oMSvSlYLiBIYUxnJZu7Az6NrE9ouhgoUlDIgoOZGxsc2rwVFOlD65VSdFAqvrsF+sqMB
 gtXDlHaT3aseLt34s0AjRC/wPjsAosHYgdNI2vwbU0zveiO0FV8IrswjzsGh9F2a0UhuHX7Kn
 eQwjn3eLKeGzS2Zj6diM6lijsGLM4/gqJlKu9NE3m1mZxNka3P7odRgobznwyD8RdfrUE5BTa
 xqXuiHNwIPuVUJDAeG6C6hqflxgAxbdQeEytCsS9bT602UmCuPz0sErRu4YCxJKMje22Dp+Fp
 gMsaWoJN0xoOW8PxFX6mqPEpui+SysrT3DIVu5cVa/yC3WSn9wImCQb94BDAl9igxmR8wWIMz
 tB07T1hX/pb7GqAOVk75jTv/HFGYgDCNIx/tDGpRE4u0BeVKHcc15lwpQjKqEJ7Nxjzbr/HMj
 YtDbD12R9cetwGHpPKvR8TyUaakYNedmx0lTUHWqRU5LDhrmxMSSBq1Q4PO9M0yRpdiDLOmAv
 guwKekvEc/GZcnnFJgRA3logNbujf7YrbrEgElCU6kLkLS2tN2T6PGxCZIcQNA/TILHG7z4ZC
 +Z1rk2ARP/5+MeIFqy+f3xcUg5dhFyyYlcSCoTa6UkE5KpMt1RtuqW8pZ8xy0Jj1bf6sLgu1N
 Wg7LDDslTPGHSTRelxMeI3AnS5hIVmEFTAokSQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bugfix introduced a harmless warning:

drivers/tty/serial/sc16is7xx.c:1523:1: error: unused label 'err_spi' [-Werror,-Wunused-label]

Move each label inside the correct #ifdef.

Fixes: ac0cdb3d9901 ("sc16is7xx: missing unregister/delete driver on error in sc16is7xx_init()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/sc16is7xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 09a183dfc526..a31db15cd7c0 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1520,11 +1520,13 @@ static int __init sc16is7xx_init(void)
 #endif
 	return ret;
 
+#ifdef CONFIG_SERIAL_SC16IS7XX_SPI
 err_spi:
+#endif
 #ifdef CONFIG_SERIAL_SC16IS7XX_I2C
 	i2c_del_driver(&sc16is7xx_i2c_uart_driver);
-#endif
 err_i2c:
+#endif
 	uart_unregister_driver(&sc16is7xx_uart);
 	return ret;
 }
-- 
2.20.0

