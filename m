Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1A2C4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06579222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389583AbfIRUCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:02:15 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:59409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbfIRUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:02:14 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MbAtM-1hdXFq3c8O-00baXC; Wed, 18 Sep 2019 22:02:02 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] udc: lpc32xx: fix 64-bit compiler warning
Date:   Wed, 18 Sep 2019 22:01:41 +0200
Message-Id: <20190918200201.2292008-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bxmp9dxd7Rf7t+/OQ2JUHr1N8GlyL8/PIoJYASViwBPyicev7rU
 mGcazxroqrLSR8aEG3r61RC0FTDY3Z/BB70JjUmx5SaeGIjTkD02/Iao/Rd+7mm5OiPszrn
 FQaA/aOrpghPymORpTgqUWD9Fsq1MYqllZiZOYSGPBvrv7e9LDs+rXgyTcbv890NE8KPCCW
 0CDNbVvuz1asLg62dvs5w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jeVV6YZmc9o=:A6TaEpzkeGq91HCJvjF+ED
 zWi3nmSwgbTVAYHyP4cpemKiYgURYEPadrm4qGR0Hxps2xPeqTmPj7MykYvboXsiSse4UqKv6
 M4SjDGkK+ADlHNUp4C1rTabbS9vHC+MFR/Ia9cQYeoJjLpt58x04zVmQpu0okrJ0d1D+1lcpE
 M4wOQhrAuMUhFFoM0WilzCEbBBlY7QhxbxHG0sApr4SP/nWHg3ug4Qf0jofejTwyHLarKC2lp
 RoCsDU6p8rfAlY+Qn+tJ2Y+Zn7yTS3FdzXUTMZHBDfgHYq+2j7MpkoHlWFfO+jTPkl+/AWXm1
 YHF2GfwrSEUBUT1DL//5YEOX9E23S6BAbFwQzanf/GIrmE4/DGHkSB+YPSqzGPgtJymQSYn6k
 MzU6oqcn7muGo1FZiNkK19aPCVhT2vG/6cPsu4fxWis21E5xnUdQZOfQ48ScHg9u4D3ZYo7p9
 kMUsMr1Mb6+rMQBzgY1qV8XT3CzZgjwQofZqFxlAgTjzuLplChuuwxASCHpBYw+aw2MK9L8wW
 FAVbF/F4hzfSPz0m7s0k8/l83uiTgslG4000kDmXp7QuGu9neoUfrZaTWYAiA/aOCbFaxUfje
 5AxYpHmHI1eP3c6a5se+4UojEqGK375TcBibjXGD05YKlpJjelzjqtPn8Qb9MXP6FyUHnED2k
 c8sIXxnCpfAmgEPZdM2oJFIidrZDBnoMgMiYDQZZiKSkY4zsdf1D6dd1/d23AswfCdnE/DU31
 HpkxP0pIAnggserqBj80Ldmh2ZQU8dwNEKAWO5oNly+uOFvxXwDuBw1bBf9B8GIIdPyK7NKA4
 vPRHbH+jc5mHtrvyepL+QN9kc6MKA1l2s+nTy4BYWj2N6apHHZpA1p0uiFA8+hjp2B4leAvPl
 VXVEQIFGxozISn8jh88A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out a suspicious cast from a pointer to an 'int' when
compile-testing on 64-bit architectures.

drivers/usb/gadget/udc/lpc32xx_udc.c: In function ‘udc_pop_fifo’:
drivers/usb/gadget/udc/lpc32xx_udc.c:1156:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
drivers/usb/gadget/udc/lpc32xx_udc.c: In function ‘udc_stuff_fifo’:
drivers/usb/gadget/udc/lpc32xx_udc.c:1257:11: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

The code works find, but it's easy enough to change the cast to
a uintptr_t to shut up that warning.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/gadget/udc/Kconfig       | 2 +-
 drivers/usb/gadget/udc/lpc32xx_udc.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
index 868bdf7f42d0..ac0891a3dbf2 100644
--- a/drivers/usb/gadget/udc/Kconfig
+++ b/drivers/usb/gadget/udc/Kconfig
@@ -45,7 +45,7 @@ config USB_AT91
 
 config USB_LPC32XX
 	tristate "LPC32XX USB Peripheral Controller"
-	depends on ARCH_LPC32XX
+	depends on ARCH_LPC32XX || COMPILE_TEST
 	depends on I2C
 	select USB_ISP1301
 	help
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index b3e073fb88c6..2b1f3cc7819b 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -1151,7 +1151,7 @@ static void udc_pop_fifo(struct lpc32xx_udc *udc, u8 *data, u32 bytes)
 	u32 *p32, tmp, cbytes;
 
 	/* Use optimal data transfer method based on source address and size */
-	switch (((u32) data) & 0x3) {
+	switch (((uintptr_t) data) & 0x3) {
 	case 0: /* 32-bit aligned */
 		p32 = (u32 *) data;
 		cbytes = (bytes & ~0x3);
@@ -1252,7 +1252,7 @@ static void udc_stuff_fifo(struct lpc32xx_udc *udc, u8 *data, u32 bytes)
 	u32 *p32, tmp, cbytes;
 
 	/* Use optimal data transfer method based on source address and size */
-	switch (((u32) data) & 0x3) {
+	switch (((uintptr_t) data) & 0x3) {
 	case 0: /* 32-bit aligned */
 		p32 = (u32 *) data;
 		cbytes = (bytes & ~0x3);
-- 
2.20.0

