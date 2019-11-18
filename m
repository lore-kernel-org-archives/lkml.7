Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF46C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A606420727
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 10:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="aYCJUaOZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbfKRKTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 05:19:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35208 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfKRKTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 05:19:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so18746121wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2019 02:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YkuJY5bMzVOn8tEVv6frGRaoHpXdhLOu0WlHqY8B/bc=;
        b=aYCJUaOZbXJ117gLuwH8mAn50t71bZYKj79y1+U8/5XTaDq+2mRxPGPv48zl7pBna1
         KN3nSBfmToj5ZB2Omdcio1FnVvtFXDIIPRdhG80u4mcudFEjpZV945nZy05N06O7sL4Z
         /rY1huEjAbrkxBtrcGvvqEzwbo8YqzevXqxCr+IUhw6EADwT1Hi5hNJug07/L0VdRNmL
         ZegXpKqRWzEyge4ZBs5HTmvt7PMDntWsuQw0gQdYRLOhTUTUXa01V4R8znS3CHb8oGAU
         qPKZE5auRx2Ncbi8eigKIOncqnUDSMbSWb/yAoI1bnC5pNYZlR5hKC5eBRgmD1RsvZ/u
         ZkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YkuJY5bMzVOn8tEVv6frGRaoHpXdhLOu0WlHqY8B/bc=;
        b=TRFCdRGo9GX+pY4HaUOjH0HUOEEKzuCHm5pK7Gna3U98n4XhvQC3LwVzHE+OO31swa
         Y/ppzYbZgncSUk3Staurbf9f+Jgs201au4K5n8a+CWQtnjMPc//o7NgiZRpELzB87St1
         OjJQpmVcMZn0yeuuZVZkyIrj39SPF51HqOCjC+A491tftxhXzKlabPZelvdlIQpHeXw8
         99+QpjeZy93vYM9pXhNMS+nj85vv91IChG6/oivrpgRwL9hnXFVLGIh5HuSvLEzLTzGT
         PFj165efWUi6EmtZUKfGtchiPPGmmhlAB3ff+mMiG2/5YmijOUIOlNsBgfQ5S/FuMZ9c
         /hMA==
X-Gm-Message-State: APjAAAW6D8J/jZFDVfpPA9BsXVdD/91lvrRzl6m5dPBJPl+zsgzdoU8/
        Dr75dmbHsAbww/4hZDTq4Btwe827Jt7BW5OR
X-Google-Smtp-Source: APXvYqzPMRKFGXCFFx4efWbEG7cBWUAEurnHK1ekfR+aDwanu6vQ+1/R6iZicJ0Ba/POjQTLmCOvbA==
X-Received: by 2002:a5d:6a83:: with SMTP id s3mr28150834wru.159.1574072388195;
        Mon, 18 Nov 2019 02:19:48 -0800 (PST)
Received: from rudolphp.9e.network (b2b-78-94-0-50.unitymedia.biz. [78.94.0.50])
        by smtp.gmail.com with ESMTPSA id t134sm20766740wmt.24.2019.11.18.02.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 02:19:47 -0800 (PST)
From:   patrick.rudolph@9elements.com
To:     linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Arthur Heymans <arthur@aheymans.xyz>
Subject: [PATCH v3 1/3] firmware: google: Release devices before unregistering the bus
Date:   Mon, 18 Nov 2019 11:19:29 +0100
Message-Id: <20191118101934.22526-2-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191118101934.22526-1-patrick.rudolph@9elements.com>
References: <20191118101934.22526-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Fix a bug where the kernel module can't be loaded after it has been
unloaded as the devices are still present and conflicting with the
to be created coreboot devices.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 -v2:
	Add missing return statement.
 -v3:
	Add missing patch changelog.
---
 drivers/firmware/google/coreboot_table.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/google/coreboot_table.c
index 8d132e4f008a..0205987a4fd4 100644
--- a/drivers/firmware/google/coreboot_table.c
+++ b/drivers/firmware/google/coreboot_table.c
@@ -163,8 +163,15 @@ static int coreboot_table_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __cb_dev_unregister(struct device *dev, void *dummy)
+{
+	device_unregister(dev);
+	return 0;
+}
+
 static int coreboot_table_remove(struct platform_device *pdev)
 {
+	bus_for_each_dev(&coreboot_bus_type, NULL, NULL, __cb_dev_unregister);
 	bus_unregister(&coreboot_bus_type);
 	return 0;
 }
-- 
2.21.0

