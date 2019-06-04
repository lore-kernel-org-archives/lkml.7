Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A8C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319B424A02
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA+l1Q+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbfFDMMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:12:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37619 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfFDMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:12:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id 22so6239290wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 05:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=l1HJmrQmWKCAnhFgY8RNTPFwWIICyDqiUtlEU3TzEm0=;
        b=OA+l1Q+vsX1G6ty+80aE1nRJRRtkrgqnM1NdZLlU16BKvJrEL4G1sIqnyWU/zvSB//
         giW55c7OEF9H+30xTo2LMCwceV3z+ExsFQkJ38as0IICNykUFb0pyAX3reVtH+7iIPhO
         yTFJXzoR6VMVSz+DiAR059TrQ8zFBfMUcKoDArjANWO0yA2eWgNrttYBpFQbvXYtywQY
         onwQq6mg0Ik6f0pkroqkUppB+4/9v13NX9C/N+DfarerDOK83Uy83MOuiiuWCswyI2Jv
         b4WbbSt8DGFRi1NbnNHxqlr24j/g/nQls6N6tTY1ZMckcIQoMYot7Ysw0ivUBv9lewaA
         jUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=l1HJmrQmWKCAnhFgY8RNTPFwWIICyDqiUtlEU3TzEm0=;
        b=EuoTHjChx6C1MFb4esFoLo9cijrMEenWJuqAQKSuryvmgKaeaEtWbmPZJ6rVjKUEWp
         /2F4eQalTQixZI75TJZ00QhfCi3OXI5zVoq5q/Kqqq/87eBqYC9//lM+DkwzfxQWm+WT
         Kayk+jNxKm/GfGOpy/kR4aaZMWR4Y2Ubm1GZuMWM2+8LQNGb6fAoOGsTO5wGJDJ3C0ZE
         0PsQ64rEkyjVzaqKsU0qWJzbCXUuFKx1ZYySNyYmx6MHOC236uIXnTCTF1EWExrwBbgS
         UzNkkNNwM7yfsBorX4GsHoOwleqIgKR0yDUdJAyVqs/tjP70tKQvZrKcUXB7ID2Uijim
         12Ew==
X-Gm-Message-State: APjAAAXaU9Jqds+28a5glhRN68mKp53p+POAkVniXvxvVuKgO/eUzUQB
        jXt1DRYocJHDF3wjeQHAEEqdB3nBRh4=
X-Google-Smtp-Source: APXvYqz0KHGqpaM4X55ahVDU+FzieilUsj2cYy0jzrHa8Ujk/PQg1NzZmi6JBn1bEMFBGdk64HpQ7A==
X-Received: by 2002:a1c:b706:: with SMTP id h6mr17441009wmf.119.1559650325250;
        Tue, 04 Jun 2019 05:12:05 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c24sm13775914wmb.21.2019.06.04.05.12.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 05:12:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: remove simulator dedicated code
Date:   Tue,  4 Jun 2019 15:12:02 +0300
Message-Id: <20190604121202.13588-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes two code sections in the common code that contain code
which is only relevant for simulator support (which is not upstreamed).

This removal saves the need to update this code upstream, which is not
needed anyway.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c | 7 -------
 drivers/misc/habanalabs/sysfs.c  | 4 ----
 2 files changed, 11 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index feedf4810430..843f0b6547b5 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -693,13 +693,6 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 
 		hdev->hard_reset_pending = true;
 
-		if (!hdev->pdev) {
-			dev_err(hdev->dev,
-				"Reset action is NOT supported in simulator\n");
-			rc = -EINVAL;
-			goto out_err;
-		}
-
 		device_reset_work = kzalloc(sizeof(*device_reset_work),
 						GFP_ATOMIC);
 		if (!device_reset_work) {
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index c900ab15cceb..25eb46d29d88 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -328,10 +328,6 @@ static ssize_t pci_addr_show(struct device *dev, struct device_attribute *attr,
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
 
-	/* Use dummy, fixed address for simulator */
-	if (!hdev->pdev)
-		return sprintf(buf, "0000:%02d:00.0\n", hdev->id);
-
 	return sprintf(buf, "%04x:%02x:%02x.%x\n",
 			pci_domain_nr(hdev->pdev->bus),
 			hdev->pdev->bus->number,
-- 
2.17.1

