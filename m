Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A40CC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD154218D0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o1rxf+p6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfDOQLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:11:13 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46339 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbfDOQLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:11:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so8778809pll.13;
        Mon, 15 Apr 2019 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZb0G+Ixk05sPWFLkG4KLNrtvUAjvxl/N0UbSKoYsGA=;
        b=o1rxf+p6yrXr83RO7GSPmI34elIz+dcIq2aH+q1Z3qWW61lDb+BWTvAp/TZQTpSqpS
         SCoELej5EsuqYHi+0WG3Qi/NcsF91qCIa0PDANVVkRY7kNENIdXi2TeiJp5wd4XyIvTH
         MSQFz0divmh0gMtnuZHJgAg9BttUEJV1ZaugsSca10KPFDQi9Fd0V/vfSIkvKR8uRIs9
         sG+e1KE/rTWrjik2Pz89KB0XVi9w3J17tDm+LsXWVaiIxrCswmt4Y63kUBmOlMv8Zsq0
         ahJ5PC47bRd/W3i3Z2s/e57noLpnyR1+CkM4yR1r90PMH1+jd9N7oQXHqyEzupOf/Rqt
         BgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tZb0G+Ixk05sPWFLkG4KLNrtvUAjvxl/N0UbSKoYsGA=;
        b=FJ47PIFLVXK+E1uQ5M7qoGJYwZe/pWRrMF+HX8b9v4aLctVrtaK88PAEnSzSOlrZow
         ENTwTjiddTt62mTdpl4z24M7e3M7+cnf8VzwpgIlBp+bD4x/8+JgwmwZKvhmOqq2v/qT
         oqlOCoZeY1DdFXJ/3hWqEC+pk1NwF2egnmSyf5Kygt9430objjVHqMnVVfnSN/EMDKfw
         3LEIlE31L7a82hwixfPV96rWsio2kMv3sMHJ5rhK1LnZJAzfJf0o0QjhAjAMlOq8B1Tw
         yjYOh/hT/B2S7lz6N6HPlc8Z5mAtSIiPrPq0lTjPep787/KMZS4WG0KSsF7Kttf95H6R
         PDAw==
X-Gm-Message-State: APjAAAVP4JMSqI9NPfjbLpNnC47SqnSSZ9xDGlwze/GTw/scGpUlpfX3
        E1C3q1IirPjxicKKfOpmZoM=
X-Google-Smtp-Source: APXvYqzctdkN23u9O7ytCx/3VZFsxswOcLlHD97OHr6g+V7u1F26SYyneIte8ailWmWDG73D96N7XQ==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12mr27140656plb.192.1555344672098;
        Mon, 15 Apr 2019 09:11:12 -0700 (PDT)
Received: from aw-bldr-10.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 75sm98591590pfr.55.2019.04.15.09.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 09:11:11 -0700 (PDT)
From:   Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     lee.jones@linaro.org, bjorn.andersson@linaro.org,
        dmitry.torokhov@gmail.com, agross@kernel.org,
        david.brown@linaro.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: [PATCH v3 2/3] HID: quirks: Fix keyboard + touchpad on Lenovo Miix 630 for DT
Date:   Mon, 15 Apr 2019 09:11:08 -0700
Message-Id: <20190415161108.16419-1-jeffrey.l.hugo@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following up on commit 2bafa1e96254 ("HID: quirks: Fix keyboard + touchpad
on Lenovo Miix 630"), the devicetree (DT) identifier for the combo keyboard
+ touchpad device is "elan,combo400-i2c", which differs from the ACPI ID,
thus if we want the quirk to work properly when booting via DT instead of
ACPI, we need to key off the DT id as well.

Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
---
 drivers/hid/hid-quirks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 77ffba48cc73..00c08f8318b8 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -997,7 +997,8 @@ bool hid_ignore(struct hid_device *hdev)
 			return true;
 		/* Same with product id 0x0400 */
 		if (hdev->product == 0x0400 &&
-		    strncmp(hdev->name, "QTEC0001", 8) != 0)
+		    (strncmp(hdev->name, "QTEC0001", 8) != 0 ||
+		     strncmp(hdev->name, "elan,combo400-i2c", 17) != 0))
 			return true;
 		break;
 	}
-- 
2.17.1

