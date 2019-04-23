Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6159C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D77D20693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbE0ovKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfDWQGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:06:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43746 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfDWQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:06:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so7824699pgu.10;
        Tue, 23 Apr 2019 09:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/08y2m3gGBdkdTWiOB0hDrv+GCpmViZ3xqDkyKBOonQ=;
        b=rbE0ovKOEPUtZiXT8GKfWp68IRxrFBVu65y+r2ufpuXIWvjTzrze+EDGFNV3DY2eB2
         KB6TOfoh85x3n5Dv4dTj/1PRR3KYbHevdc0MnjhXOhB/1rgFGGhKVCZZAVorq6XVZIWS
         mdGFn96aVkkyeiqJLZRi6WoAqNLqckIVLIy0FuhMR4SxRtaRfTgOSRH5jOZKx9apkYi6
         opuzIhYcgQhOrKKgUsiG9C7WZZZOcg/4KWX8R1J96u9rAoo3lV0UzgOlGseSTcjchju5
         YQ+yJKztGj3uQJwleWj+4SdXxNS8ANqJKtqLgknAQeMh9WXKbf7WtwmCCquVfI5lM1GT
         HqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/08y2m3gGBdkdTWiOB0hDrv+GCpmViZ3xqDkyKBOonQ=;
        b=B8/Qy2SkOujc88jbt1VcPYhfhaOEhAzJR1e5btOyM8pBs22OIIpp1a6Dy9HkqEU3d0
         d+GnNjhwQKjvpnHUHpGoL3Sm/qKcr2Lhs1OQw6BkVAYY9+Q/o+gb0e3C+GlSLFwj+weh
         IVy+2SMWAdBZZPDSv9mhOpFR/Of/e7LixWw1TYyQbW+dMRFZKS9ZyaUEBCnuQN6IZHgh
         Q8NDtJUOdt3fVpo0taTOlVydmx0+3+bKQ9mtSCEyIt4W0Oywk5gPB4LsMFRuN/e8ZAG3
         CYIPMJx1QGRgvOfVczBNGSN48QDsEBoieS8KbgjXx0NuIMRYK/4BSvAJ3r/6mSgrl057
         4cEg==
X-Gm-Message-State: APjAAAV/W4FfHsfABfcp1bc6RIXCTfqmSEK8B4kgWE879KpeZQ/7BFQR
        VLGtcZ0IhRg3ngPCBoi+HYQ=
X-Google-Smtp-Source: APXvYqwvCGErpG52qlMI1HiREj+WXP6/uK+sGhaj66OQ1C0xFHt+NaZMg3ehEw8lAab5pmI1HtO1ZA==
X-Received: by 2002:a62:e412:: with SMTP id r18mr27779355pfh.207.1556035573253;
        Tue, 23 Apr 2019 09:06:13 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id e193sm28258557pgc.53.2019.04.23.09.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:06:12 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     lee.jones@linaro.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, agross@kernel.org,
        david.brown@linaro.org, hdegoede@redhat.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v4 1/2] HID: quirks: Refactor ELAN 400 and 401 handling
Date:   Tue, 23 Apr 2019 09:06:05 -0700
Message-Id: <20190423160605.9970-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423160543.9922-1-jeffrey.l.hugo@gmail.com>
References: <20190423160543.9922-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There needs to be coordination between hid-quirks and the elan_i2c driver
about which devices are handled by what drivers.  Currently, both use
whitelists, which results in valid devices being unhandled by default,
when they should not be rejected by hid-quirks.  This is quickly becoming
an issue.

Since elan_i2c has a maintained whitelist of what devices it will handle,
use that to implement a blacklist in hid-quirks so that only the devices
that need to be handled by elan_i2c get rejected by hid-quirks, and
everything else is handled by default.  The downside is the whitelist and
blacklist need to be kept in sync.

Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/hid/hid-quirks.c            | 64 ++++++++++++++++++++++++-----
 drivers/input/mouse/elan_i2c_core.c |  4 ++
 2 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 77ffba48cc73..656485e08eb7 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -987,17 +987,61 @@ bool hid_ignore(struct hid_device *hdev)
 		break;
 	case USB_VENDOR_ID_ELAN:
 		/*
-		 * Many Elan devices have a product id of 0x0401 and are handled
-		 * by the elan_i2c input driver. But the ACPI HID ELAN0800 dev
-		 * is not (and cannot be) handled by that driver ->
-		 * Ignore all 0x0401 devs except for the ELAN0800 dev.
+		 * Blacklist of everything that gets handled by the elan_i2c
+		 * input driver.  This should be kept in sync with the whitelist
+		 * that exists in that driver.  This avoids disabling valid
+		 * touchpads and other ELAN devices.
 		 */
-		if (hdev->product == 0x0401 &&
-		    strncmp(hdev->name, "ELAN0800", 8) != 0)
-			return true;
-		/* Same with product id 0x0400 */
-		if (hdev->product == 0x0400 &&
-		    strncmp(hdev->name, "QTEC0001", 8) != 0)
+		if ((hdev->product == 0x0401 || hdev->product == 0x0400) &&
+		   (strncmp(hdev->name, "ELAN0000", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0100", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0600", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0601", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0602", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0603", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0604", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0605", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0606", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0607", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0608", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0609", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN060B", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN060C", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN060F", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0610", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0611", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0612", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0613", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0614", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0615", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0616", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0617", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0618", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0619", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN061A", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN061B", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN061C", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN061D", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN061E", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN061F", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0620", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0621", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0622", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0623", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0624", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0625", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0626", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0627", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0628", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0629", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN062A", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN062B", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN062C", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN062D", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0631", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN0632", 8) == 0 ||
+		    strncmp(hdev->name, "ELAN1000", 8) == 0 ||
+		    strncmp(hdev->name, "elan,ekth3000", 13) == 0))
 			return true;
 		break;
 	}
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index f9525d6f0bfe..3ded19528cd4 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1332,6 +1332,10 @@ static const struct i2c_device_id elan_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, elan_id);
 
+/*
+ * when these whtielists get updated, the corresponding blacklist in hid-quirks
+ * needs to be updated to match.
+ */
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id elan_acpi_id[] = {
 	{ "ELAN0000", 0 },
-- 
2.17.1

