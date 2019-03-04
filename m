Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C87BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB7FB20830
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCDUE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:04:29 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:52925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDUE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:04:29 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MqJuP-1hN5bi2Y55-00nN5z; Mon, 04 Mar 2019 21:04:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Oded Gabbay <oded.gabbay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mike Rapoport <rppt@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] misc: habanalabs: avoid HWMON dependency
Date:   Mon,  4 Mar 2019 21:04:02 +0100
Message-Id: <20190304200412.1269035-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XyKcooFXQhX2uuTXTRZ2R3hAkAHkzbVMcnRmfEhsadCcZm60/V/
 KDd7EfSy4udHv4jJe9jazHsQ1DQdQ9PoPcUw0/TRZG7RDRae8tTXVzy2Qx11jBg29NdC4q2
 ROP1qp8TMvcLjBniy2Vlm/zlXCIr/kIfu5iz44f2EVO7+r+WEmBm/nKQkZyAOJbOMWjYc11
 C3+gIfefptZf9cLrGSHVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gTsI42fWA0M=:O+tbH+o0S3oDVqo1HqDwEY
 tIXhWdewERlcKU5ppFzk38XgA1p2rFX6ypYlFg1x1s8DFJTyQkWRCmolh2igwsOnSK/ErUBXj
 tIccNnq3CjYJ0/Z0LsVA2k1m+fLw1jYGE3yIfeo6orOGcbSXIMivWNjGzjNsmgng6d1WxC/ax
 qgdkdEXJEpkq80laZpadyIy8CZOxasm8uK7wnXgKy9ddSfiJuQWcEOD3pkGEy0viT1eUs9M4A
 GfzNmfBLpuhziAaap5e58xUj2+CvgxnI46kH8ajoomgGj/9Miy2+kKPUJDgckvGVuznA8aGK7
 Ne0VtTFrpXB38G5829XgPtvL3JaPoBTGWuCBzFEUPphkxv9Zv9TZJU72T7Bmkm8q8OEjnvrn6
 YLmGmPNexvZX3DdDbUxEgBMxa2m/X4XNTlp1nXDDYFu1JI/zypQE92iS4LtgOJm86V7wVOrdL
 AM1QqCxs8GwHCqSvhothu924LRlYlwp/VP9A9UoPLaIA46kHlM0n2EfUX3XK0lco4zoyLhcLw
 YHUZHR1dhiUvPwHt6RkVqjvxgPuHus9uSvVxKZ5kYzPwIshpuc5t1qbyHZF+C4bdQDDzxyAqf
 2VyguEu6nvTvXdI4yaqEllkv/XWCNJR6oZax7dUS0MON8xFFfGakTlYN3fXzYrjpsrhfE8h51
 2iSnHfbxodg15OMqfjI+5MJTZayPvJlQSRtNAktfsWb5xn63UMArK5gD/aeEQPAbbO2X5acUO
 WzhJhtBZtYv45qcYxP92tze3ghrV4Kz0lLcThw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_HWMON is disabled, we currently get a link error for this driver:

ERROR: "hwmon_device_unregister" [drivers/misc/habanalabs/habanalabs.ko] undefined!
ERROR: "hwmon_device_register_with_info" [drivers/misc/habanalabs/habanalabs.ko] undefined!

As the hardware monitoring is not a required part of the functionality,
make it possible to compile without HWMON by ignoring all that functionality
depending on the configuration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/habanalabs/hwmon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 77facd25c4a2..933746639831 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -423,7 +423,7 @@ int hl_hwmon_init(struct hl_device *hdev)
 	struct device *dev = hdev->pdev ? &hdev->pdev->dev : hdev->dev;
 	int rc;
 
-	if ((hdev->hwmon_initialized) || !(hdev->fw_loading))
+	if (!IS_ENABLED(CONFIG_HWMON) || (hdev->hwmon_initialized) || !(hdev->fw_loading))
 		return 0;
 
 	if (hdev->hl_chip_info->info) {
@@ -451,7 +451,7 @@ int hl_hwmon_init(struct hl_device *hdev)
 
 void hl_hwmon_fini(struct hl_device *hdev)
 {
-	if (!hdev->hwmon_initialized)
+	if (!IS_ENABLED(CONFIG_HWMON) || !hdev->hwmon_initialized)
 		return;
 
 	hwmon_device_unregister(hdev->hwmon_dev);
-- 
2.20.0

