Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D79C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543E120679
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 19:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rnt3TaLC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfJMTKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 15:10:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37183 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729335AbfJMTKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 15:10:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id p1so8774853pgi.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Oct 2019 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b80mjczMKdynxDiqihftIRC/nvOfe2fufAmH1zUWecg=;
        b=Rnt3TaLC3t5HfsHxd7aOpUWt1ltyyk0x1kQ4RXg7fRL316JzXDZRbp2fDirHoNbT+p
         TkG0KrYAXKYZNnszzkD7/wFIkEvaGtbd6sfhQ9e1SXbZgrRjSeI1ZAOdRbbwp9vIhfgU
         iCEGzzxe/taIIbL0bD56GdvxKmVDDlcE1Vnjet4RvBSzT7GlQ3a+GswEBA7O057MD433
         sZzmLWGxZq9bfq5CEi4K3+GMVHY/tdb7BA11kXrydINEflM9jUm+rQRyrwdTux7LKIgh
         h/gqD6dw+6LHAe+ajJrvsqNJBYbke0Zs0T56BFwmnZGs7Hz0ldSo7y/uJhwQpGC8aFmR
         0o5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b80mjczMKdynxDiqihftIRC/nvOfe2fufAmH1zUWecg=;
        b=aW+ecXTaqKkXaNO9aEKiA6sKO/slag7A1Y6G1zk7XC3ezoYLnzvhHdO3fvq0yGG33m
         mXkGpq7w6TI0u48TNt9m5PKFWrHY/APb/Oj/cOITkKRXoCoDg3XZVjvZ9b3CJjpoRCJo
         Jmhxot7/1mEUHsTRoa3saY8pYVvs2umEGLSbNSV4+t+WVkN1tb1nR372v+LThQWzfRCm
         F9F1uqSnH1TpWXWglxh/02iVtlMaOlZuoWvVI7Tv9ChiaRHHxR+dloaQL07Hm0AQGlPl
         lT55whKmsvxrdRer1ujYK8z7mXfXPysn0ECneS8u7qEpqPSQ3PHB+r3MEKghcepbP0dT
         VCKw==
X-Gm-Message-State: APjAAAXEGHok63nQVwgdjeA4psnr1ifdG9q5Wd6Bbd2OpFKxTtokUN6/
        h4G8m3SJsLCEETz9vOqrnbU=
X-Google-Smtp-Source: APXvYqxQzbjm7g/LJpdZWfeo4Uaggr8/CzxmLN7hdm1fYG9ceaKdu+4kP3AREI2KrAAK0x40piPAqg==
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr31936123pjv.67.1570993846203;
        Sun, 13 Oct 2019 12:10:46 -0700 (PDT)
Received: from wambui.zuku.co.ke ([197.237.61.225])
        by smtp.googlemail.com with ESMTPSA id m5sm15261216pgt.15.2019.10.13.12.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2019 12:10:45 -0700 (PDT)
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, eric@anholt.net, wahrenst@gmx.net,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2] staging: rtl8723bs: use DIV_ROUND_UP helper macro
Date:   Sun, 13 Oct 2019 22:10:27 +0300
Message-Id: <20191013191027.6470-1-wambui.karugax@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the DIV_ROUND_UP macro to replace open-coded divisor calculation
to improve readability.
Issue found using coccinelle:
@@
expression n,d;
@@
(
- ((n + d - 1) / d)
+ DIV_ROUND_UP(n,d)
|
- ((n + (d - 1)) / d)
+ DIV_ROUND_UP(n,d)
)

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
Changes in v2:
  - Remove comment that explained previously used calculation.
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 87535a4c2e14..22931ab3a5fc 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -4156,9 +4156,8 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 				break;
 			}
 
-			/*  The value of ((usNavUpper + HAL_NAV_UPPER_UNIT_8723B - 1) / HAL_NAV_UPPER_UNIT_8723B) */
-			/*  is getting the upper integer. */
-			usNavUpper = (usNavUpper + HAL_NAV_UPPER_UNIT_8723B - 1) / HAL_NAV_UPPER_UNIT_8723B;
+			usNavUpper = DIV_ROUND_UP(usNavUpper,
+						  HAL_NAV_UPPER_UNIT_8723B);
 			rtw_write8(padapter, REG_NAV_UPPER, (u8)usNavUpper);
 		}
 		break;
-- 
2.23.0

