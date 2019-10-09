Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CE0C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E9621721
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfJINEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:04:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:5507 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbfJINEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:04:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 06:04:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="223580511"
Received: from skassina-mobl.ccr.corp.intel.com (HELO caravaggio.ger.corp.intel.com) ([10.251.93.62])
  by fmsmga002.fm.intel.com with ESMTP; 09 Oct 2019 06:04:37 -0700
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH 1/2] acpi: Fail GED probe when not on hardware-reduced
Date:   Wed,  9 Oct 2019 15:04:32 +0200
Message-Id: <20191009130433.29134-2-sameo@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191009130433.29134-1-sameo@linux.intel.com>
References: <20191009130433.29134-1-sameo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Generic Event Device (GED) is a hardware-reduced platform device.
Probing this driver on fixed platforms should fail.

Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/acpi/evged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
index aba0d0027586..55de4b2d2fee 100644
--- a/drivers/acpi/evged.c
+++ b/drivers/acpi/evged.c
@@ -127,6 +127,9 @@ static int ged_probe(struct platform_device *pdev)
 	struct acpi_ged_device *geddev;
 	acpi_status acpi_ret;
 
+	if (!acpi_gbl_reduced_hardware)
+		return -ENODEV;
+
 	geddev = devm_kzalloc(&pdev->dev, sizeof(*geddev), GFP_KERNEL);
 	if (!geddev)
 		return -ENOMEM;
-- 
2.21.0

