Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCCF2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553538866;
	bh=8dNQrxbDFMLReAt4an3K/41lo4f7y3htlrB90N5BTME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SnY3AnzSj2O4bPtFqd6Ajdmy2+qOxFyTGFBmqr7SsHp97HxnQsOwvLhWpSPIqzi98
	 33bczZ8AQQNWdRvezLZWgpTnFPoIKjVxtoPMj8rPSMzCPSERCVfdxkr1lpVdFyMWJf
	 yTm2P2FuBm0Br6wTvbPUsREZQ0GinVDJrPsCtpsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730239AbfCYSeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:34:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbfCYSeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:34:19 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C3E52075D;
        Mon, 25 Mar 2019 18:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553538858;
        bh=8dNQrxbDFMLReAt4an3K/41lo4f7y3htlrB90N5BTME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hx9TIwBtnjevmiDEn2eUfZDsxyE/TfYEu6MpIgP4SDer7Vicv4AkfZZ5/koiTgJ2h
         Oc13oA4awHZwFtuJvnbN+97tiZtKsK4XksB7fHBrHvZjWJfJyuoG4A3vySlrxkhZWb
         +aGgjxtKrPLXUmQttBQYlSy1MxkeSdgINQCjNYsg=
From:   helgaas@kernel.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 3/4] ACPI / scan: Simplify acpi_bus_extract_wakeup_device_power_package()
Date:   Mon, 25 Mar 2019 13:34:02 -0500
Message-Id: <20190325183403.251473-4-helgaas@kernel.org>
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

acpi_bus_extract_wakeup_device_power_package() is a static function with a
single caller that supplies (device->handle, &device->wakeup).  Simplify
the interface so the caller need only supply "device".

This makes it obvious that "wakeup", i.e., &device->wakeup, can never be
NULL, so remove the unnecessary check for that.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/scan.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 1b66fc835e39..f3b40299a641 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -763,18 +763,16 @@ acpi_bus_get_ejd(acpi_handle handle, acpi_handle *ejd)
 }
 EXPORT_SYMBOL_GPL(acpi_bus_get_ejd);
 
-static int acpi_bus_extract_wakeup_device_power_package(acpi_handle handle,
-					struct acpi_device_wakeup *wakeup)
+static int acpi_bus_extract_wakeup_device_power_package(struct acpi_device *dev)
 {
+	acpi_handle handle = dev->handle;
+	struct acpi_device_wakeup *wakeup = &dev->wakeup;
 	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
 	union acpi_object *package = NULL;
 	union acpi_object *element = NULL;
 	acpi_status status;
 	int err = -ENODATA;
 
-	if (!wakeup)
-		return -EINVAL;
-
 	INIT_LIST_HEAD(&wakeup->resources);
 
 	/* _PRW */
@@ -883,8 +881,7 @@ static void acpi_bus_get_wakeup_device_flags(struct acpi_device *device)
 	if (!acpi_has_method(device->handle, "_PRW"))
 		return;
 
-	err = acpi_bus_extract_wakeup_device_power_package(device->handle,
-							   &device->wakeup);
+	err = acpi_bus_extract_wakeup_device_power_package(device);
 	if (err) {
 		dev_err(&device->dev, "_PRW evaluation error: %d\n", err);
 		return;
-- 
2.21.0.392.gf8f6787159e-goog

