Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B3AC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F0E20879
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640045;
	bh=ZNvB4MTqhULf+8cWMI+y4RjcPucrTChmDOREjgeOcBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W7giwmrxq+BllceToRkDO9pxPUAr3kiYB5YpsuW9kcY9a+6ArPEBB8qWcCX5OUqX4
	 rhRHbxfWM2wWJMpYDa5ogxMVhFzEdPasT8K0R7iHOW7g+/BEq+XUfiVkRq0hqbSsPY
	 xHbEmwmS2B/Y5O38V82pHzlGPmmDdfXxVE/TedJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391766AbfEWT2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:28:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391389AbfEWT2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:28:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C28C206BA;
        Thu, 23 May 2019 19:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558639696;
        bh=ZNvB4MTqhULf+8cWMI+y4RjcPucrTChmDOREjgeOcBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yDQV214/2zThetsqooP02IitFCLGPLzDTWy4H3vobuO5vMjyPF1+QOsKSdkRY3jIP
         keRgt6nhhtcd2qj8rAMsyioPE3MP3Sgb176nj4g6D83V5xZwzCngfEQM0BAV+bYwZS
         okkkEtOxESpif6j5rISDj3sgsqUxwFSuL3NFdoY0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.1 045/122] brcmfmac: Add DMI nvram filename quirk for ACEPC T8 and T11 mini PCs
Date:   Thu, 23 May 2019 21:06:07 +0200
Message-Id: <20190523181710.637629318@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181705.091418060@linuxfoundation.org>
References: <20190523181705.091418060@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit b1a0ba8f772d7a6dcb5aa3e856f5bd8274989ebe upstream.

The ACEPC T8 and T11 mini PCs contain quite generic names in the sys_vendor
and product_name DMI strings, without this patch brcmfmac will try to load:
"brcmfmac43455-sdio.Default string-Default string.txt" as nvram file which
is way too generic.

The DMI strings on which we are matching are somewhat generic too, but
"To be filled by O.E.M." is less common then "Default string" and the
system-sku and bios-version strings are pretty unique. Beside the DMI
strings we also check the wifi-module chip-id and revision. I'm confident
that the combination of all this is unique.

Both the T8 and T11 use the same wifi-module, this commit adds DMI
quirks for both mini PCs pointing to brcmfmac43455-sdio.acepc-t8.txt .

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1690852
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c |   26 +++++++++++++++++
 1 file changed, 26 insertions(+)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
@@ -31,6 +31,10 @@ struct brcmf_dmi_data {
 
 /* NOTE: Please keep all entries sorted alphabetically */
 
+static const struct brcmf_dmi_data acepc_t8_data = {
+	BRCM_CC_4345_CHIP_ID, 6, "acepc-t8"
+};
+
 static const struct brcmf_dmi_data gpd_win_pocket_data = {
 	BRCM_CC_4356_CHIP_ID, 2, "gpd-win-pocket"
 };
@@ -49,6 +53,28 @@ static const struct brcmf_dmi_data pov_t
 
 static const struct dmi_system_id dmi_platform_data[] = {
 	{
+		/* ACEPC T8 Cherry Trail Z8350 mini PC */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "T8"),
+			/* also match on somewhat unique bios-version */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
+		},
+		.driver_data = (void *)&acepc_t8_data,
+	},
+	{
+		/* ACEPC T11 Cherry Trail Z8350 mini PC, same wifi as the T8 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "T11"),
+			/* also match on somewhat unique bios-version */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
+		},
+		.driver_data = (void *)&acepc_t8_data,
+	},
+	{
 		/* Match for the GPDwin which unfortunately uses somewhat
 		 * generic dmi strings, which is why we test for 4 strings.
 		 * Comparing against 23 other byt/cht boards, board_vendor


