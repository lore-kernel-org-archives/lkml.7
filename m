Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AC9C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093BC2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZHdDStIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfEPV4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:56:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39894 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfEPV4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:56:32 -0400
Received: by mail-io1-f68.google.com with SMTP id m7so3864731ioa.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30hVVs4KstAY1Cm8mS0N7KHumN5n7CONcXPWGn5Ws6A=;
        b=ZHdDStIn8Nh3/v0i1rIiUZbPlnHF/ZpK2u9nHuYkVHpfRygwqsqhfIeoWGjrGE6l81
         e9RuOg5/DSBpaph108jInUozc+UCRLLZcpYq9Sddfxq/7nludItMO8M1kutE5gC7iNgo
         3zGU6EgQvx17q0RPaG5GT7Y5RZnF3dxGDdbq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=30hVVs4KstAY1Cm8mS0N7KHumN5n7CONcXPWGn5Ws6A=;
        b=gO2+hokwha56z4D7nN9Zdrd2kRrf+meuFy3lwx+TMA+8CGuABG4w8qK+9Efwse0zvG
         CQDM127Ox+8TTPK69X9srVvtUXLF6+6FebZsXmTY+CaNCSngifLA5lg95EK5GTsGwf92
         38oKsp+rb8HPTWx1sZJGLFZ+Ei3QuFIj8L5Fi2T8i0CUoM/nWtOMTnJ2xMtmNIX7YdCy
         JkqTAipJCoOwUrX9iiPYTqupmo7ogDIFDnUaw5L2yAhfvOwyUZXh16+ShP588S1cm17H
         jhEdc0Ev8GxPx6iCITWZQDt4aWxOkfohEfPUqvkqb+zN2hai8q5a8euZvVV9bW5YxC2R
         m1aQ==
X-Gm-Message-State: APjAAAUuvyBZECtNlMl9Z1Vi1MRosTaUpk5HDizYGhRHh95ZBvgG0xJb
        LhwqORlr9Bo6xXWThFBIMCbQowtuMqj4LA==
X-Google-Smtp-Source: APXvYqy8uV4H/brx/EiboH8ZkZo8jxjBVfHbXkfySYBjdVZOOGXPooNYLRP97OO7C07dawOoLsTl2Q==
X-Received: by 2002:a5d:8153:: with SMTP id f19mr7148987ioo.167.1558043791537;
        Thu, 16 May 2019 14:56:31 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:2e1:1bad:9c62:dd74])
        by smtp.gmail.com with ESMTPSA id h16sm2079282ioh.35.2019.05.16.14.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 14:56:30 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        AceLan Kao <acelan.kao@canonical.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH] platform/x86: intel-vbtn: Report switch events when event wakes device
Date:   Thu, 16 May 2019 15:56:15 -0600
Message-Id: <20190516215615.261258-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a switch event, such as tablet mode/laptop mode or docked/undocked,
wakes a device make sure that the value of the swich is reported.
Without when a device is put in tablet mode from laptop mode when it is
suspended or vice versa the device will wake up but mode will be
incorrect.

Tested by suspending a device in laptop mode and putting it in tablet
mode, the device resumes and is in tablet mode. When suspending the
device in tablet mode and putting it in laptop mode the device resumes
and is in laptop mode.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/platform/x86/intel-vbtn.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
index 06cd7e818ed5..990cc8c20872 100644
--- a/drivers/platform/x86/intel-vbtn.c
+++ b/drivers/platform/x86/intel-vbtn.c
@@ -76,12 +76,15 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
 	struct platform_device *device = context;
 	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
 	unsigned int val = !(event & 1); /* Even=press, Odd=release */
-	const struct key_entry *ke_rel;
+	const struct key_entry *ke, *ke_rel;
 	bool autorelease;
 
 	if (priv->wakeup_mode) {
-		if (sparse_keymap_entry_from_scancode(priv->input_dev, event)) {
+		ke = sparse_keymap_entry_from_scancode(priv->input_dev, event);
+		if (ke) {
 			pm_wakeup_hard_event(&device->dev);
+			if (ke->type == KE_SW)
+				sparse_keymap_report_event(priv->input_dev, event, val, 0);
 			return;
 		}
 		goto out_unknown;
-- 
2.21.0.1020.gf2820cf01a-goog

