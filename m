Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826F5C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1F82173C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 22:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7vVOeDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404528AbfHHWA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 18:00:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36509 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfHHWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 18:00:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so11046587ljj.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8FKs1Lf93PhHeNickgScG68jCCCMLn5xmM2hWU+zOc0=;
        b=N7vVOeDk0i8tnwx9FeM0bk2hzb1qQcG0jyudUYorCU2/vjX7WrpzoiXUdfAgBlwV/G
         HX8JXBL1UxIX4Zu566P7/BNQrodMwexwK3EDTayIOh7D27fiThpx4iWjhRlJ/UyIDTZp
         i4ftV8wMpo0OH12cyB11iavFzsVyoqJ2bDHH64WYzZ6KHBrXkeTLTqJFQVJwOgxGpgck
         55EoB1vyGjJdhV4KVvTqNDmnOyzZJhIW8T6CARg1I5SjHZNs9uwBOpsjIvkozv5eC8nG
         juUycyymABCTPmiSXbgshS9NIK9N/y0tPGBEGoJug8vdv5Bmms8RsofSZrtKBrR8tI76
         oL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8FKs1Lf93PhHeNickgScG68jCCCMLn5xmM2hWU+zOc0=;
        b=WH6qj2ZorhOR5KOThBst5VwJaJ3klvKVEpZ1IJasoA9B/xzXoVicf1rxCvCoIbnjXW
         mly92yddMCB5JiPBuNuaTu+qdWR0RXjxHG/qrxPOTsm/EgHSdahw7ofEARqDCRy1kDTv
         H9V1h3odNwkndMHA6mHJ86JoCLZfr1k9uR/BkC9QUk2jFUz/otwARgZPPuNB5cb5BIRt
         B7/w8Ok3F2bYLj5ALE7rkF+IN2FtQGz0ERQAZ/4cKRV7oz6FRXRXZTdjM09HoqQQqxCl
         C7Yss3WJI//lZaQYlBzxvMeuy9FsZbyw2LwTsAoQRs+QmiItfRidEYTwuJG19r2/pNTH
         i/Iw==
X-Gm-Message-State: APjAAAX+t7NpSPKmbC7JVeFt1/Gj4ZGaup8izclTtVdATxeD1lnjHBc9
        MZ9IshSJfT+lxaTVR4P1UEIoXxJK
X-Google-Smtp-Source: APXvYqwjZxd1Ihga4FE40fWoYBPdQTYfvm+tf5LuRvCEuMq+vckO1dXIYqIyeUTKIAKT5zlFhQbsvw==
X-Received: by 2002:a2e:8650:: with SMTP id i16mr9568178ljj.178.1565301625333;
        Thu, 08 Aug 2019 15:00:25 -0700 (PDT)
Received: from localhost.localdomain ([46.216.207.166])
        by smtp.gmail.com with ESMTPSA id h19sm3635422lfc.93.2019.08.08.15.00.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 15:00:24 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.92)
        (envelope-from <jekhor@gmail.com>)
        id 1hvqTZ-0000is-Re; Fri, 09 Aug 2019 01:01:37 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH] extcon-intel-cht-wc: Don't reset USB data connection at probe
Date:   Fri,  9 Aug 2019 01:01:29 +0300
Message-Id: <20190808220129.2737-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0
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
index 9d32150e68db..3ae573e93e6e 100644
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
+	if (id == INTEL_USB_ID_FLOAT)
+		cht_wc_extcon_set_phymux(ext, MUX_SEL_PMIC);
 
 	/* Get initial state */
 	cht_wc_extcon_pwrsrc_event(ext);
-- 
2.23.0.rc0

