Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0F9C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0260A20748
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 13:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P49bDYCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKRNGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 08:06:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37893 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfKRNGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 08:06:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id z19so18777310wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 05:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0t6BIfzNuRwt3DJsO04Qa7rSCpwHMZ7HhQW2jfstwDY=;
        b=P49bDYCWGr03vZ+a7KrjiIlnSMrd+Aj5xR0Hk1WbGo3oPX4Dy+BQka/bVkHQ+c7nkC
         C0y028voymLIugsxAQRMbqvwUFSvjhaiZEJ3as/MQTTCoKkMcLymcB9WJwQefCdK9pYg
         4LP7ZiO0oKd7GNnsKaCKzt0h8Q0ucoRyeBggNHqqXGwbpqIxKjvB2AR1Y5IhiiHrJb4V
         s5Cby1dsfqW560VCQsmdnAf3TioqXWtILiyX30WkOm77ZfV8zEzBLyMqAEH1ObjUN2Ai
         bmYBpiUILbxHECQQjMVVm6QdUQx2uF/Naz5839vCceIMP9GgFjSF4jGjYVsbJio5kvfd
         Xe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0t6BIfzNuRwt3DJsO04Qa7rSCpwHMZ7HhQW2jfstwDY=;
        b=BPMbYU5aKvjp9d9UI19DdoXbxvn7ct0dibvZ6k/CQo80RQrw6ibgjhJaSbpTZKHrN1
         HoVB/pOfTbOcZNMxLWW7cPCJrwVeKZo5LKvIhG3MOI5Ol/fSJ2U3o6ZrU4QJ96Hscj/t
         HRGR7XYlY1v2p0KAsLa01OPz6Ai7/+4dY0yQYnWWuuRCVgh+M0uG5QKkoWQl6FtSiPZC
         wlOi+I4VXgX78Qw8CYy7arnwOzOzwC3eDvCe2WNjD4N6nKdtKRbkeasRmD8X5ELqASs0
         Lj737P7pTW/iIEaYgJ4D+fWx8CzzUyTCGf+pbiGRP7Nc4dJy6wm2kuOqmhqp6AaiefEN
         vC8Q==
X-Gm-Message-State: APjAAAVGdu+d8EMq8JkjdqnCrWdrTadzglLeta6iAG/O4wXKtucoMoup
        G0+mXCtnNMRK/2xKgD2rOux+XJJnGf8=
X-Google-Smtp-Source: APXvYqx/aaSJCbsxTDRULbJpAt6SdtPlA64Xvin4WMDrksAhIu3v48QXIZiJge4nleDNyYx/cs5k4A==
X-Received: by 2002:a1c:4456:: with SMTP id r83mr27662299wma.2.1574082401326;
        Mon, 18 Nov 2019 05:06:41 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z8sm22472669wrp.49.2019.11.18.05.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 05:06:40 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: add more protection of device during reset
Date:   Mon, 18 Nov 2019 15:06:39 +0200
Message-Id: <20191118130639.22354-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent accesses to the device (register read/write) from debugfs entries
during reset as that can cause the device to get stuck.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 1cf75010a379..20413e350343 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -528,6 +528,12 @@ static int engines_show(struct seq_file *s, void *data)
 	struct hl_dbg_device_entry *dev_entry = entry->dev_entry;
 	struct hl_device *hdev = dev_entry->hdev;
 
+	if (atomic_read(&hdev->in_reset)) {
+		dev_warn_ratelimited(hdev->dev,
+				"Can't check device idle during reset\n");
+		return 0;
+	}
+
 	hdev->asic_funcs->is_device_idle(hdev, NULL, s);
 
 	return 0;
@@ -640,6 +646,11 @@ static ssize_t hl_data_read32(struct file *f, char __user *buf,
 	u32 val;
 	ssize_t rc;
 
+	if (atomic_read(&hdev->in_reset)) {
+		dev_warn_ratelimited(hdev->dev, "Can't read during reset\n");
+		return 0;
+	}
+
 	if (*ppos)
 		return 0;
 
@@ -669,6 +680,11 @@ static ssize_t hl_data_write32(struct file *f, const char __user *buf,
 	u32 value;
 	ssize_t rc;
 
+	if (atomic_read(&hdev->in_reset)) {
+		dev_warn_ratelimited(hdev->dev, "Can't write during reset\n");
+		return 0;
+	}
+
 	rc = kstrtouint_from_user(buf, count, 16, &value);
 	if (rc)
 		return rc;
-- 
2.17.1

