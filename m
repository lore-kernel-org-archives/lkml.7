Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B8AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFACF20823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbfCDTz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:55:59 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:52615 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfCDTz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:55:59 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N95qT-1h4SQ513KR-016A9E; Mon, 04 Mar 2019 20:55:50 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     NOGUCHI Hiroshi <drvlabo@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] HID: hid-asus: select CONFIG_POWER_SUPPLY
Date:   Mon,  4 Mar 2019 20:54:43 +0100
Message-Id: <20190304195536.1019650-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f+i+OrDzGO5H4U2g4SqZUp9c0UQmPl0RW7oYspPkrcB5i49uSJn
 NzL/ZrRU2mKFqYAHpn3s5zcgYzdivprMCE1lopi5HT0NHuRdsTxpZevB006Ps4xo1sF0QMR
 +9ULLpfK28inUcSySNcgfwjFYG5WfsH3aZrsHoELYXrZ0NqetQzrQBzsCgPGiLX8NvOVsLI
 BKdHO6VFVGzUh97iaC+Mg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8USgwDmB/OY=:gy//9rVrQEESBN2+gLPbj+
 nuDyqOROJII3exPtGEnI/QNEbcPICR4qqqbgFbpNn9EGoiG12B5EbjqyQwLqbxXKuq9jzsuPk
 DVB4sMigqjh+TKkkBI44wE9IwSWY1QJi1+c9ygNC16Kel1epATeUWaLyfkNkD0DYAOZCUiNJi
 cQfOqcN4hnmFzb3gJbVhgllgaa2d7TCUnVIcWUPMmsqug6TQyRZkAbOQZitbu/Z/FXk6bG7/x
 MbJbtPuLvaRIfoSBIFB7IOL8qbNpHQe/zseqTe/P6VLP9it4teMEHa69FVX+APT0Sjej1MdXh
 EeK1fnxBuSgGKvot1V2Zg2xsSegOOx4S/JmwDMrtYNYbkaB3WyZxYnElY3FudKtZqxwEISVmh
 sir4mp0bB2Lz4FaUiK+bz51Ign8tA241GT49VkRMbDo13DZv3bVx2+KYGcUDbjpkcMCVCTxNW
 en53xbV6dJzqa7HvjbklsOpexaVQsW/QrhWsLcKnF38x8Mj+cTxCp1BpE1cR876PSdQris/iq
 Sk7ZhnwKL6fbce6ZI305wQd4E5DMK7xmypYNMmBOv/vQuJkAWWlfSFY9TjzJGQxPYuT0YuMe/
 BqoRatQjoICDb4BWbXc8HmlLc/f5zO0JFcFom06xZtXEBczaTGW7ggNtrdEP5vIq8gZ8JUYL/
 /JHcsbvfqzGTtZ67zdHjEV/2Wgt+oQD0lkc6h33fqp+69yRrooZ/a4NkNM6h+EephxctKYjCv
 fTJkdVN6L5jEVX7vKTVAXfAbSBJ1/fWQJfKS/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newly added power supply code fails to link when the power supply core
code is disabled:

drivers/hid/hid-asus.o: In function `asus_battery_get_property':
hid-asus.c:(.text+0x11de): undefined reference to `power_supply_get_drvdata'
drivers/hid/hid-asus.o: In function `asus_probe':
hid-asus.c:(.text+0x170c): undefined reference to `devm_power_supply_register'
hid-asus.c:(.text+0x1734): undefined reference to `power_supply_powers'
drivers/hid/hid-asus.o: In function `asus_raw_event':
hid-asus.c:(.text+0x1914): undefined reference to `power_supply_changed'

Select the subsystem from Kconfig as we do for other hid drivers already.

Fixes: 6311d329e12a ("HID: hid-asus: Add BT keyboard dock battery monitoring support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hid/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 6ca8d322b487..4ca0cdfa6b33 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -150,6 +150,7 @@ config HID_ASUS
 	tristate "Asus"
 	depends on LEDS_CLASS
 	depends on ASUS_WMI || ASUS_WMI=n
+	select POWER_SUPPLY
 	---help---
 	Support for Asus notebook built-in keyboard and touchpad via i2c, and
 	the Asus Republic of Gamers laptop keyboard special keys.
-- 
2.20.0

