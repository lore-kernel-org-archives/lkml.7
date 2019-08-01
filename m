Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E673FC41514
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F9C206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 10:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfHAKUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 06:20:32 -0400
Received: from foss.arm.com ([217.140.110.172]:33576 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbfHAKUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 06:20:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A3311570;
        Thu,  1 Aug 2019 03:20:32 -0700 (PDT)
Received: from dawn-kernel.cambridge.arm.com (unknown [10.1.197.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3ACB3F575;
        Thu,  1 Aug 2019 03:20:30 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, lkp@intel.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 1/3] i2c: Revert incorrect conversion to use generic helper
Date:   Thu,  1 Aug 2019 11:20:24 +0100
Message-Id: <20190801102026.27312-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190801061042.GA1132@kroah.com>
References: <20190801061042.GA1132@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch "drivers: Introduce device lookup variants by ACPI_COMPANION device"
converted an incorrect instance in i2c driver to a new helper. Revert this
change.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/i2c/i2c-core-acpi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index bc80aafb521f..f60f7a95d48e 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -357,7 +357,10 @@ static int i2c_acpi_find_match_adapter(struct device *dev, const void *data)
 
 struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
 {
-	struct device *dev = bus_find_device_by_acpi_dev(&i2c_bus_type, handle);
+	struct device *dev;
+
+	dev = bus_find_device(&i2c_bus_type, NULL, handle,
+			      i2c_acpi_find_match_adapter);
 
 	return dev ? i2c_verify_adapter(dev) : NULL;
 }
-- 
2.21.0

