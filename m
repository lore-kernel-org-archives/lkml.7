Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76133C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51E0421479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 09:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388423AbfDRJZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 05:25:32 -0400
Received: from goliath.siemens.de ([192.35.17.28]:53659 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfDRJZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 05:25:31 -0400
X-Greylist: delayed 625 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Apr 2019 05:25:29 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id x3I9EwJE015456
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Apr 2019 11:14:58 +0200
Received: from [139.25.68.37] (md1q0hnc.ad001.siemens.net [139.25.68.37] (may be forged))
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x3I9Ev1n009836;
        Thu, 18 Apr 2019 11:14:57 +0200
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        David Miller <davem@davemloft.net>
Cc:     Linux Netdev List <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Su Bao Cheng <baocheng.su@siemens.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] stmmac: pci: Adjust IOT2000 matching
Message-ID: <5a547510-2605-bae5-bd58-ab4aff28840d@siemens.com>
Date:   Thu, 18 Apr 2019 11:14:56 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); de; rv:1.8.1.12)
 Gecko/20080226 SUSE/2.0.0.12-1.1 Thunderbird/2.0.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Su Bao Cheng <baocheng.su@siemens.com>

Since there are more IOT2040 variants with identical hardware but
different asset tags, the asset tag matching should be adjusted to
support them.

For the board name "SIMATIC IOT2000", currently there are 2 types of
hardware, IOT2020 and IOT2040. The IOT2020 is identified by its unique
asset tag. Match on it first. If we then match on the board name only,
we will catch all IOT2040 variants. In the future there will be no other
devices with the "SIMATIC IOT2000" DMI board name but different
hardware.

Signed-off-by: Su Bao Cheng <baocheng.su@siemens.com>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
index d819e8eaba12..cc1e887e47b5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c
@@ -159,6 +159,12 @@ static const struct dmi_system_id quark_pci_dmi[] = {
 		},
 		.driver_data = (void *)&galileo_stmmac_dmi_data,
 	},
+	/*
+	 * There are 2 types of SIMATIC IOT2000: IOT20202 and IOT2040.
+	 * The asset tag "6ES7647-0AA00-0YA2" is only for IOT2020 which
+	 * has only one pci network device while other asset tags are
+	 * for IOT2040 which has two.
+	 */
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
@@ -170,8 +176,6 @@ static const struct dmi_system_id quark_pci_dmi[] = {
 	{
 		.matches = {
 			DMI_EXACT_MATCH(DMI_BOARD_NAME, "SIMATIC IOT2000"),
-			DMI_EXACT_MATCH(DMI_BOARD_ASSET_TAG,
-					"6ES7647-0AA00-1YA2"),
 		},
 		.driver_data = (void *)&iot2040_stmmac_dmi_data,
 	},
-- 
2.16.4
