Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10537C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17AE2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558553187;
	bh=+emL6wAQkP+GDqX7SW2N6KhPmXp11SOc6Q8U+zzJafQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o4YfcXcK+LiSOW/dspYpsRgDwCUUbN/Qa2GGuDMPrPyTffQsntwKMf8Ay9O8SkpY3
	 lcL5SaHMkhxonjzhOu1abee3JhtGQkV01E5/z07tck0BRJP4U00JphVNM/qhP0/Hnn
	 OsDb58Q8ROiNsulF1gY66vWtkOZ3zhCGNu6TWfjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfEVT01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731948AbfEVT0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:26:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7AF121881;
        Wed, 22 May 2019 19:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558553182;
        bh=+emL6wAQkP+GDqX7SW2N6KhPmXp11SOc6Q8U+zzJafQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0pvqCdrKgoupxfpft0YbPSUYvaGTmkBel2e30L0YE5oeuw6ztDHQ35nx1bbe5JHPy
         D6w+lzHETbJVXSWlUvAXh+Dpz3wOgZcMNHnCzI/PkKw3vWz4NVwKC38G0BWij1lRfe
         IxmVujlUTA1RK2UOTtl3s73pAObEiBQ65vAj2Pmc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ferry Toth <ftoth@exalondelft.nl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 098/317] Bluetooth: btbcm: Add default address for BCM43341B
Date:   Wed, 22 May 2019 15:19:59 -0400
Message-Id: <20190522192338.23715-98-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522192338.23715-1-sashal@kernel.org>
References: <20190522192338.23715-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ferry Toth <ftoth@exalondelft.nl>

[ Upstream commit 5035726128cd2e3813ee44deedb9898509edb232 ]

The BCM43341B has the default MAC address 43:34:1B:00:1F:AC if none
is given. This address was found when enabling Bluetooth on multiple
Intel Edison modules. It also contains the sequence 43341B, the name
the chip identifies itself as. Using the same BD_ADDR is problematic
when having multiple Intel Edison modules in each others range.
The default address also has the LAA (locally administered address)
bit set which prevents a BNEP device from being created, needed for
BT tethering.

Add this to the list of black listed default MAC addresses and let
the user configure a valid one using f.i.
`btmgmt -i hci0 public-addr xx:xx:xx:xx:xx:xx`

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btbcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d5d6e6e5da3bf..62d3aa2b26f60 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -37,6 +37,7 @@
 #define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xac, 0x1f, 0x12, 0xa0, 0x43, 0x43}})
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
+#define BDADDR_BCM43341B (&(bdaddr_t) {{0xac, 0x1f, 0x00, 0x1b, 0x34, 0x43}})
 
 int btbcm_check_bdaddr(struct hci_dev *hdev)
 {
@@ -82,7 +83,8 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM20702A1) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4324B3) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4330B1) ||
-	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0)) {
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
 		bt_dev_info(hdev, "BCM: Using default device address (%pMR)",
 			    &bda->bdaddr);
 		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-- 
2.20.1

