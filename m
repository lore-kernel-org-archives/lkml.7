Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF817C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81EE2064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 11:09:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbfCFLJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:09:14 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:36845 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbfCFLJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 06:09:13 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N14xe-1h7QSn0c5S-012Vhh; Wed, 06 Mar 2019 12:09:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] extcon-ptn5150: fix COMPILE_TEST dependencies
Date:   Wed,  6 Mar 2019 12:08:57 +0100
Message-Id: <20190306110906.2622957-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KC4iYkvGtYdhiUP3vD9B3Tevzaf0ckV5iiY6/4+X7YAF6iqCLkT
 jO4eSlcx40dobzhFrGGrNOpYIpu1DWPyvlIatlbHhzoao4Xjn8rTiodRQiNsVV+wPeDN4Pa
 ymaZwZkyhz69X/JI94frVY1narYa5T0BKFRg4iRNVeqBDXZF0BkcxNERrYB1+U9/I34lbVQ
 80I0+zzbC59lJEhLFzgLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DIcRHNM81FA=:vqTtp2fETiYjd9qjOBnzgj
 LnY6R2vq+dw0UsqGvmL+NfCKa174JhqSOw4lsQL2a8kq4GxCGP3L7Heba0iuUd2n9RFedEV/C
 CB03gtpJg1uuSJ0vaGrkIECaHEhiR8y95L7AXMs0kqnYFdJ7cvchJYY7WmozNh/zychoHQI1H
 FpTtmPZqggXKKr0yApmf3/oIbJ4Lgh5Oe8xGTbpbEaTClCz3WsYpm3wK8+xMidiWqq25fUoVC
 SlnxPDYXmVDorfd7MyWktgxvKrbR6m+ZAzwnYu7fFxyp3bNuL7qNKF/kRw8fNXcbHvWnQ86gR
 2gdzkM8ESo6AH78kiX/jrju+8Q6cSRLxdJbcXJ1mw6pJC/EPij3/8uB3HryG3RBx14LQkKQrA
 niNz2yVnr0Nia3459ABXkOsNIrhwl4gMhxElWgmnSVBFDx8V1SKB+Of5H0KO4kPGw2Z3B9B1d
 4hQ1nzgZ0tKr0UOqKKzVGIRanrxm16AXya86BoJnp71p7TXpZ6nETbww/nGLeFD1bt3RKXuOE
 MuEWND29o04b5jP2yROM/z4IBwyR1X98ytXrGm5k6/xxdLUYIPZTzrjanT8Z9m3KFwN3KQAH9
 qg8QQOhTWhi6pAanUJ6jqrfj584zhK3mCfztpNjkYVhALBxAFZdZxs8YYKkxu7ufgdNzFNTkB
 zGdIUc33KUTpEyUM2NV15QDG/Cz0Dk61TTL3wXVIbLGLJuMmoeyxP8E+FedMOx5ujMpfZXVX+
 L09QvvPbTWNy9uWy/I1bhwqNN8bVrHbq8h/SeA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PTN5150 dependencies look like they were meant to do the
right thing, but they actually should not allow building without
I2C for compile testing, as that results in a Kconfig warning
and subsequent build failure:

WARNING: unmet direct dependencies detected for REGMAP_I2C
  Depends on [m]: I2C [=m]
  Selected by [y]:
  - EXTCON_PTN5150 [=y] && EXTCON [=y] && (I2C [=m] && GPIOLIB [=y] || COMPILE_TEST [=y])
  Selected by [m]:
  - EEPROM_AT24 [=m] && I2C [=m] && SYSFS [=y]
  - KEYBOARD_CAP11XX [=m] && !UML && INPUT [=y] && INPUT_KEYBOARD [=y] && OF [=y] && I2C [=m]
  - INPUT_DRV260X_HAPTICS [=m] && !UML && INPUT_MISC [=y] && INPUT [=y] && I2C [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
  - ... [many others]

Add parentheses around the expression so we can compile-test
without GPIOLIB but not without I2C.

Fixes: 4ed754de2d66 ("extcon: Add support for ptn5150 extcon driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/extcon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/Kconfig b/drivers/extcon/Kconfig
index 8e17149655f0..540e8cd16ee6 100644
--- a/drivers/extcon/Kconfig
+++ b/drivers/extcon/Kconfig
@@ -116,7 +116,7 @@ config EXTCON_PALMAS
 
 config EXTCON_PTN5150
 	tristate "NXP PTN5150 CC LOGIC USB EXTCON support"
-	depends on I2C && GPIOLIB || COMPILE_TEST
+	depends on I2C && (GPIOLIB || COMPILE_TEST)
 	select REGMAP_I2C
 	help
 	  Say Y here to enable support for USB peripheral and USB host
-- 
2.20.0

