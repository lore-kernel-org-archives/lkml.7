Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A553C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7169F206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 12:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfDPMZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 08:25:47 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:55245 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbfDPMZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 08:25:46 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBUuP-1h8ymA11DD-00Cvb6; Tue, 16 Apr 2019 14:25:41 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Dmitry Osipenko <digetx@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: fsl: fix link error against usb-gadget module
Date:   Tue, 16 Apr 2019 14:25:32 +0200
Message-Id: <20190416122540.3222314-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Z4JFO1al4yfSeyJC5wJvaU8oqEG+h5zWrHcjZ9c6Ssu2yjAVBAr
 ThIugfScLvblwnGiSRGC035AhzKBggc7kSlIl78J21iJCaBy6yH9+qib4NRuoHL0ohjaln9
 Yt3IMODEbPE+NjYoHZYf+0EGGUeUIHcVAc6adrvMaw1nceaLXtftb42l2uEpuwtmiarHTgm
 0j4inZ97tjJhfgqn1CXUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7jqD/e/gBYQ=:7qJWDYZ662F5UrEt1A33CS
 6R37CMcqiVU4ykjOj0GXK4oq4taWNstVQxoS7qwZ68/X8w0+XMfsthgwNWXn+5oOu5r7t/t33
 aobcyYCn9n911nDzjEpQ5rh+NRsJNWjz9UtrwXuYJOqxZ+yBkn5uafgHU7zaQe47vsT8DeY3N
 Tuac9tsfiGklUHDvIn+y1Ccti2W3H8kqSPe6MKXh/4lVuXZLjdrioHmCfqQ6hMdWdaKExsa/V
 SOQ0VOLPjhXTkGqfy0CP569HW/mYFG6hB82CkPf5QAPl/iewQ7M5oo6/kyM8Fk2JqSq2R8J+u
 pjd3nIzWRzj8paS1PDxdc3j0m9HYExFpb5tECmmpVYN2OkC5a6nB0mGQjxbu0Nw+tQov3xxk0
 JjwDIhpI0I8lHWPANrA9btZksNuJozgZMeuO+yXho5p1rDuQPZ28Vm62YAAjmDMO10OcVmBIV
 k2j41w3+UsfQZxbJVtqZmzg2ZV1jH5PFW44Js79fUzhFgpggvpfBqyiF+7np8cIGEFYEcYsBo
 WS9RqHTHBDv0Z5MSk9yzT5nGZefv6wdr2ce0PqlKCfMW8VJrQQeCnQTgzM6AFXQp/9A4y1KFz
 d6ub3sN5PCC5vDm8lXVlS3odkDuMRn2sdpYf10Y0Sn0cV7aqmNua8HuuJdSAKLzVCFS1FOh05
 NAzy6dsDOzwZuv9MXod2yoPuUH+SKWLNqoGXgyVkq5Ac+ws07Svy563v5uUzzWm4Jj+JJQBrB
 OV1YOw5Btxlkn9+ze5BKRiP88lt9i+oTVbu3ow==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependency to ensure this driver links correctly fails since
it can not be a loadable module:

drivers/usb/phy/phy-fsl-usb.o: In function `fsl_otg_set_peripheral':
phy-fsl-usb.c:(.text+0x2224): undefined reference to `usb_gadget_vbus_disconnect'

Make the option 'tristate' so it can work correctly.

Fixes: 5a8d651a2bde ("usb: gadget: move gadget API functions to udc-core")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/phy/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 8c509b060c09..24b4f091acb8 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -21,7 +21,7 @@ config AB8500_USB
 	  in host mode, low speed.
 
 config FSL_USB2_OTG
-	bool "Freescale USB OTG Transceiver Driver"
+	tristate "Freescale USB OTG Transceiver Driver"
 	depends on USB_EHCI_FSL && USB_FSL_USB2 && USB_OTG_FSM=y && PM
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	select USB_PHY
-- 
2.20.0

