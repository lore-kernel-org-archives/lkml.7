Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740292087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553539026;
	bh=IN9vz6UZKdIt8wxBM33pyslmgsVbca2t352mBFP4rHI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=DPChKquBv+hAkBZoL+ny7Ev0j2oCUAa4Hd842MgPOLtU/VsXwpyKjoLGGgtEUTR9x
	 Y0W1azRthK6PRlOXR3jX0xtBboD8XWlD3vExzuDhmTb/sP/7a8hd611ZUolN8p0L69
	 d5i5w0wcO2SHbv+pc5pLN9wFbOm3dQjbLCo+Dpiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbfCYShF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbfCYShE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:37:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9F120879;
        Mon, 25 Mar 2019 18:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553539024;
        bh=IN9vz6UZKdIt8wxBM33pyslmgsVbca2t352mBFP4rHI=;
        h=From:To:Cc:Subject:Date:From;
        b=s0hbvh1JmVtb5fGk5Vfl+5rP69FUzs92BJr58CQMMmO5htk7jUH+81kPnyhcKM3UD
         08aobHtN5R3LYoNNi68z0CJTI+W7tphO4DTssW8pNO+rXMffzNIMzae+cIMUy0TZMe
         805ohZWeSydKYfz4NJckTjPcMLlvnaAZNB7I4MqM=
From:   helgaas@kernel.org
To:     Jean Delvare <jdelvare@suse.com>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] i2c: isch: Remove unnecessary acpi.h include
Date:   Mon, 25 Mar 2019 13:36:52 -0500
Message-Id: <20190325183652.252175-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

54fb4a05af0a ("i2c: Check for ACPI resource conflicts") included
<linux/acpi.h> so we could use acpi_check_region().  fd46a0064af1 ("i2c:
convert i2c-isch to platform_device") removed the use of
acpi_check_region() but not the include.

Remove the now-unnecessary include of <linux/acpi.h>.  No functional change
intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/i2c/busses/i2c-isch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-isch.c b/drivers/i2c/busses/i2c-isch.c
index 5c754bf659e2..f64c1d72f73f 100644
--- a/drivers/i2c/busses/i2c-isch.c
+++ b/drivers/i2c/busses/i2c-isch.c
@@ -30,7 +30,6 @@
 #include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/io.h>
-#include <linux/acpi.h>
 
 /* SCH SMBus address offsets */
 #define SMBHSTCNT	(0 + sch_smba)
-- 
2.21.0.392.gf8f6787159e-goog

