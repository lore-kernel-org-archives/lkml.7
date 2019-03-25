Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645A3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240B62075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553538873;
	bh=UxWONWsL6txs55J0zpd5iY+QGPBw4hGVBRcu9t6czFA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=djCCGFh4VMmy0iplY8K3NqiXqJhj+B/Pz+Y2Gm7OYvMywaTH1/fise001jMN9er4H
	 opk+xipQeQnlT71cUpaoc4nmlYwveAJAf+L11/9YGryW9IhEKiYjt0PVAlXz6MjqjL
	 2ncFoN00u9GT3XMrzfJOUKzJD8hTNGtvsQ7xpQYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730265AbfCYSec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:38764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730169AbfCYSeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:34:21 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35B922087C;
        Mon, 25 Mar 2019 18:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553538860;
        bh=UxWONWsL6txs55J0zpd5iY+QGPBw4hGVBRcu9t6czFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEVfosBLSVh15xNaj2UJ2yRgL5i33Wi+tmSZ7T8GG4TrGDQWyX9C8jni1iFO3U4pG
         GALAKpBwdiEhwbmOY7S2LnOR3XbrjPZpcgZf0tSuhwR4alU7hYwLOFmJhf3oK4/swv
         tjBkUZ/zpsyux/VC9HwLn9VUrZSwCg4eXTvLmPxs=
From:   helgaas@kernel.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/4] ACPI / scan: Add labels for PNP button devices
Date:   Mon, 25 Mar 2019 13:34:03 -0500
Message-Id: <20190325183403.251473-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325183403.251473-1-helgaas@kernel.org>
References: <20190325183403.251473-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Subsequent code treats button_device_ids[] entries differently, and it's
hard to follow without a hint as to which is which.  Add comments to
identify the power button, lid, and sleep button devices.

The "PNP" prefix is owned by Microsoft, so they distribute the canonical
list of "PNP" IDs.

Link: https://uefi.org/PNP_ACPI_Registry
Link: https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/devids.txt
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f3b40299a641..814a02568d68 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -846,9 +846,9 @@ static int acpi_bus_extract_wakeup_device_power_package(struct acpi_device *dev)
 static bool acpi_wakeup_gpe_init(struct acpi_device *device)
 {
 	static const struct acpi_device_id button_device_ids[] = {
-		{"PNP0C0C", 0},
-		{"PNP0C0D", 0},
-		{"PNP0C0E", 0},
+		{"PNP0C0C", 0},		/* Power button */
+		{"PNP0C0D", 0},		/* Lid */
+		{"PNP0C0E", 0},		/* Sleep button */
 		{"", 0},
 	};
 	struct acpi_device_wakeup *wakeup = &device->wakeup;
-- 
2.21.0.392.gf8f6787159e-goog

