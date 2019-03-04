Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83320206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfCDUYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:24:43 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:43425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDUYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:24:42 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mgw7n-1hS0A20zVd-00hOO7; Mon, 04 Mar 2019 21:24:35 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] phy: mapphone-mdm6600: add gpiolib dependency
Date:   Mon,  4 Mar 2019 21:23:58 +0100
Message-Id: <20190304202406.1716350-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304202406.1716350-1-arnd@arndb.de>
References: <20190304202406.1716350-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dSwZJHcC1C9MpQ1yOPIGgBeO4Z6CAh/IO3/w2kOYJZGxsrQKV67
 6Y9krjnXvOMr/0HEWg+0upmkgonXmbakzHRlP0vGGbPKoM0tuAcYlsYbnrbJC3LnDD98Wfw
 zHCv2GXmucNFhu91BPZrK28QaeSUyxw6JZBiRkQiJNiyqu86G2IBgRuTucX6dPOGVEqlAxn
 GSshz6dW5X54fHSQryy0w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GlHpxjsHNeY=:f3W5jd0yaxbKyUmLvaf/HW
 s2TDzhrLSp9uL7paKbb7TA5Nqz/zVsQfBBkP6l4Ya5AfFdExBe0sIgLK/QrGXZaeQj+b7fOWp
 pTJocnjto6qAmAhQqJtcUGLDjyjnPDL5NtAPK3nEnFMiu/H12n1SFNgZbD5LlSHsmJJ9hjOI4
 H5mgyVXMG/JxHXGqNtG62Ddv3gNP7UfhyFHKdpcXlBanMK8D/5XmeyPhGzPcexULFqqfYCAec
 umRuoslU/pYjc3uEUKcbEqYkfOSfCvfccz8c/Ru5yLlz3CO2uf5RkWX4e95GsGw5ezO7hIYBC
 GNKriWxDzCppIbL3HqmHYagn3MdGbIaNRLxIm8z/ElO6mEQg6XyjFNon8K9v22r/3esDvjczM
 3xESmedw7KQ6BSon/Tk7WnlpOwAGRjvZbFkD4s6To0g9cbYBiywVlXOEkVRBmZT+tm+H/IUBm
 2iaMnr8B5fegexlwPg9ySkcTUAt7VjUX8RC7Si7gP2VKDdXyt7bUKS6qHHzDA4qz/WrJOelvS
 qiEazxkRrzPzUL9jOzPtu//5w2cypVQFwI9m7fxTogVycfuDDdFzCld5FXnZ+r64caKWMfW7H
 a2oqWcG6QnDnc/LmeSAiUlaKhy1Zo37hsuptKUIAkSdy7ALZV4blIg+hFfK3FwxXHvavU8Ozr
 LNKhl9Lhmm3kKyc3EikMHrQnBKqSc/gF7iBxCYJ0pwSMECAyUDaY+h0p+YMJ6Tf2z9s8dP9kJ
 dFr+j/TE1j74y1rDRrjX+bMZEHsfPbQpVYJY0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc points out that when CONFIG_GPIOLIB is disabled,
gpiod_get_array_value_cansleep() returns 0 but fails to set its output:

drivers/phy/motorola/phy-mapphone-mdm6600.c: In function 'phy_mdm6600_status':
drivers/phy/motorola/phy-mapphone-mdm6600.c:220:24: error: 'values[0]' is used uninitialized in this function [-Werror=uninitialized]

This could be fixed more generally in gpiolib by returning a failure
code, but for this specific case, the easier workaround is to add a
gpiolib dependency.

Fixes: 5d1ebbda0318 ("phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on Droid 4")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/phy/motorola/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/Kconfig b/drivers/phy/motorola/Kconfig
index 82651524ffb9..718f8729701d 100644
--- a/drivers/phy/motorola/Kconfig
+++ b/drivers/phy/motorola/Kconfig
@@ -13,7 +13,7 @@ config PHY_CPCAP_USB
 
 config PHY_MAPPHONE_MDM6600
 	tristate "Motorola Mapphone MDM6600 modem USB PHY driver"
-	depends on OF && USB_SUPPORT
+	depends on OF && USB_SUPPORT && GPIOLIB
 	select GENERIC_PHY
 	help
 	  Enable this for MDM6600 USB modem to work on Motorola phones
-- 
2.20.0

