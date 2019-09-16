Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB6C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB741214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 21:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxIgfIi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391779AbfIPVPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 17:15:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38021 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387936AbfIPVPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 17:15:49 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so1100588lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 14:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=acgnm/6L0t0MmFqD1pjGrUf3zo1NA/kTNsVpmBt8uc4=;
        b=LxIgfIi7bK/uEMBeiVsIXBlO0na9Bduw3u7V/WpE65Yye3BzfEYQS0TDuJKK3GEmqX
         XsWPNjhwvniXabE2LuCiTksEUDBGalBMlg5KKXpBI01SMxu5xDWwmbnevy1IWpOG7PtA
         DENWV7LqZPjqoEf2Q7OssN+N2bugZ4wHKwWs6UxdCV7zJOk3EVrkAy+EdS4KPud98A6L
         GZhFuRwwa3M+0JC5QfMlBs4BcsLiDZB/L7aH7WC/kTGpSGzuH/6AA+wyACbSqNBSdJvT
         +NlB6yxZs7dn4K+Ay4teKDvgwqJCsVkngkIBbxWS40QManhiLWR5iiC35T2Exp372m2N
         14VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=acgnm/6L0t0MmFqD1pjGrUf3zo1NA/kTNsVpmBt8uc4=;
        b=tZx88by1ZFCXjvDOQQ8u9RjHJ9yep18Ry7iuqZ5Wna0N92uwE2OYq9eND5oZgXyvJB
         smdgK+/pQf+WrhQsK64CaXYMnrRhURvYy1B8AcRY9GTgJD4E3sT0Sb4BmG/ytC+9Mqko
         sYfMGi0IUIKBDzu193z9KmuU6XrYVUHEdFUQrvwdvNCLbTDESHvX6/bGt34Dmfatr3l8
         AxYvYUASxJ5QbEKRK/euGZIacViAWBp60IrwL7InNexcz37FytdrujTgPfN6Zm1oe/Id
         5BhlDlnlz4c5PI0QBc5cYccXwZ1Kh/z120DU/A8njHtv8TkkjkYke7sTVYnt54bygwwt
         kAOA==
X-Gm-Message-State: APjAAAWqzApx9TmZTzeZWYgw7miy0gtJTr3LmW/J3j0MLLJJZm/Dz+b6
        u6cp1KfsyHcN2S33HcJpW4hIP0BZ
X-Google-Smtp-Source: APXvYqy8bb4+4NTtd1zpYbWykLFnYctGZrIRNfUUUpgiHOGC2iZZ+HIu/GtrjsGUWHitVqWAFE5rlg==
X-Received: by 2002:ac2:5203:: with SMTP id a3mr98835lfl.151.1568668546817;
        Mon, 16 Sep 2019 14:15:46 -0700 (PDT)
Received: from localhost.localdomain ([46.216.138.44])
        by smtp.gmail.com with ESMTPSA id 207sm4240822lfn.0.2019.09.16.14.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 14:15:45 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92.1)
        (envelope-from <jekhor@gmail.com>)
        id 1i9yLZ-0007jq-Ju; Tue, 17 Sep 2019 00:15:45 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH v2] extcon-intel-cht-wc: Don't reset USB data connection at probe
Date:   Tue, 17 Sep 2019 00:15:36 +0300
Message-Id: <20190916211536.29646-2-jekhor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190916211536.29646-1-jekhor@gmail.com>
References: <20190916211536.29646-1-jekhor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Cherry Trail Whiskey Cove extcon driver connect USB data lines to
PMIC at driver probing for further charger detection. This causes reset of
USB data sessions and removing all devices from bus. If system was
booted from Live CD or USB dongle, this makes system unusable.

Check if USB ID pin is floating and re-route data lines in this case
only, don't touch otherwise.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/extcon/extcon-intel-cht-wc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
index 9d32150e68db..da1886a92f75 100644
--- a/drivers/extcon/extcon-intel-cht-wc.c
+++ b/drivers/extcon/extcon-intel-cht-wc.c
@@ -338,6 +338,7 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 	struct intel_soc_pmic *pmic = dev_get_drvdata(pdev->dev.parent);
 	struct cht_wc_extcon_data *ext;
 	unsigned long mask = ~(CHT_WC_PWRSRC_VBUS | CHT_WC_PWRSRC_USBID_MASK);
+	int pwrsrc_sts, id;
 	int irq, ret;
 
 	irq = platform_get_irq(pdev, 0);
@@ -387,8 +388,19 @@ static int cht_wc_extcon_probe(struct platform_device *pdev)
 		goto disable_sw_control;
 	}
 
-	/* Route D+ and D- to PMIC for initial charger detection */
-	cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
+	ret = regmap_read(ext->regmap, CHT_WC_PWRSRC_STS, &pwrsrc_sts);
+	if (ret) {
+		dev_err(ext->dev, "Error reading pwrsrc status: %d\n", ret);
+		goto disable_sw_control;
+	}
+
+	id = cht_wc_extcon_get_id(ext, pwrsrc_sts);
+
+	/* If no USB host or device connected, route D+ and D- to PMIC for
+	 * initial charger detection
+	 */
+	if (id != INTEL_USB_ID_GND)
+		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
 
 	/* Get initial state */
 	cht_wc_extcon_pwrsrc_event(ext);
-- 
2.23.0.rc1

