Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3B8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B500214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142710;
	bh=63nU4fdCgX2p8UUb5OJm+yB5Xgb0CqU3zNEb9oVmn4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WWATxHWQl5f2aUJ5lEjDk7JZwwSJIu+fl2nkLGKh6GY8CfSlmUwqeGICcCVJFqNZE
	 6FwjUcsON1Z+YFpBgGuw2iIHtokSblg7TuMsVpSv6PBDmkwVIRs5UKxLByWCqKGF7x
	 dUQ8L7oHazofJMazB8CZTh85LS/ZKZQHobo4YMWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731844AbfKSFvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:51:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731839AbfKSFvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:51:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11F8D21783;
        Tue, 19 Nov 2019 05:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142705;
        bh=63nU4fdCgX2p8UUb5OJm+yB5Xgb0CqU3zNEb9oVmn4Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/BnRmczu+NpPpYmd4lv1IKQelcKPZJUvdkeTVZ1YUpFmUsjX/fCkWNTv2+5xNZfL
         YUwZbJqaLAeHpY/7r17mf5DuZenPRJedE3nc2YS+TfyVnzEW2Y+mSX8F3oC2oZRLOk
         x5eykw1+Ib+Xwm1aP4diX9RzxsFroJyLnLjn8XcA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Kelley <mikelley@microsoft.com>,
        Sinan Kaya <okaya@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 131/239] PCI/ACPI: Correct error message for ASPM disabling
Date:   Tue, 19 Nov 2019 06:18:51 +0100
Message-Id: <20191119051330.707132807@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sinan Kaya <okaya@kernel.org>

[ Upstream commit 1ad61b612b95980a4d970c52022aa01dfc0f6068 ]

If _OSC execution fails today for platforms without an _OSC entry, code is
printing a misleading message saying disabling ASPM as follows:

  acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM

We need to ensure that platform supports ASPM to begin with.

Reported-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/pci_root.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index eb857d6ea1fef..96911360a28e7 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -454,8 +454,9 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
 	if (ACPI_FAILURE(status)) {
-		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
-			 acpi_format_exception(status));
+		dev_info(&device->dev, "_OSC failed (%s)%s\n",
+			 acpi_format_exception(status),
+			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
 		*no_aspm = 1;
 		return;
 	}
-- 
2.20.1



