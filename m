Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A671FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F28926DF3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 18:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YsPyRLSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfFCSeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 14:34:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40802 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfFCSeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 14:34:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id d30so8762538pgm.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 11:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNrf8Jnz97UuIym8j3dBQYRGR049MkRgE0BVyZwE5HM=;
        b=YsPyRLSkMm4zYPE51rbZbCHmfcIrNpbAXG1rR/QiOUreF79d1eERchC3FUKgTHziRO
         +lfs8fLTApFM4EabtSExv7Y+OgtT2Fc1hfNfkcdo2nvvth5H+mwseymOcmLsjK5Lkb0C
         C5vQMk3EDJU7oMVDG71D2fp/HhWIvgwfOuLRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNrf8Jnz97UuIym8j3dBQYRGR049MkRgE0BVyZwE5HM=;
        b=LRsxk/dtxXqhg1Z7zNUSktdVlFu8IfcYw2lAx1tXPFJ0ETDZHtbFMExCsEsZRwM3G1
         552JdRcERP5nmiLWynjv82aFgc4EvdDukiNJIAt/7PgBg5rDVmFwaG/9+PaSbl8fzsiv
         UHkux93aIrzR3JMHe8fs9dXRAW6AU3kl6X8b5RP1BJ//MHPHUxsmDnlItGD2k0zuhZTU
         hDrR+IASwiZisGbDKtogSQEkpHk/oYZiHJjIG3HlkwX+auFlBjQtVFCPrqU0DBA8amZ0
         986AdI4Mg9YfEa+cZlPWkPKRXyEMrlxZMiBFZ0A29yHMfCKCcKY/VQrI5nQV90Xsk4rX
         nwJw==
X-Gm-Message-State: APjAAAXUKkGB4ZYSocq9GewL07TVYqU4N2BkxLHc7kWiTR/sk5NzGpzd
        vMh6I7KAQCj0AwroNdsi6z61hA==
X-Google-Smtp-Source: APXvYqw6sXgo4NuVVy+bI0kBDsz/jNQ4q6SS66NHT9cYdkOFi8i45sJ9jIkrK4Pm4AbME7JEpHfjxw==
X-Received: by 2002:a63:c104:: with SMTP id w4mr10115534pgf.125.1559586848333;
        Mon, 03 Jun 2019 11:34:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id e6sm10590853pfi.42.2019.06.03.11.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 11:34:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com,
        fabien.lahoudere@collabora.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [RESEND PATCH v3 01/30] mfd: cros_ec: Update license term
Date:   Mon,  3 Jun 2019 11:33:32 -0700
Message-Id: <20190603183401.151408-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
In-Reply-To: <20190603183401.151408-1-gwendal@chromium.org>
References: <20190603183401.151408-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to SPDX-License-Identifier, GPL-2.0

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index dcec96f01879..48292d449921 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -1,25 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Host communication command constants for ChromeOS EC
  *
  * Copyright (C) 2012 Google, Inc
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * The ChromeOS EC multi function device is used to mux all the requests
- * to the EC device for its multiple features: keyboard controller,
- * battery charging and regulator control, firmware update.
- *
- * NOTE: This file is copied verbatim from the ChromeOS EC Open Source
- * project in an attempt to make future updates easy to make.
+ * NOTE: This file is auto-generated from ChromeOS EC Open Source code from
+ * https://chromium.googlesource.com/chromiumos/platform/ec/+/master/include/ec_commands.h
  */
 
+/* Host communication command constants for Chrome EC */
+
 #ifndef __CROS_EC_COMMANDS_H
 #define __CROS_EC_COMMANDS_H
 
-- 
2.21.0.1020.gf2820cf01a-goog

