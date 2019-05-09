Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8058FC04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51091217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cH+VBwgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfEIVO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:14:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46844 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbfEIVOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:14:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id t187so1818733pgb.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 14:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0IPEAAZhLi1gys+2LirQge8UODqrAqbS/22Qm4bF1s=;
        b=cH+VBwgKsOunqPxtWlu1VRhFgLfNjKBoEnzFUBNyyHA8/Q8GAPqkdWGZXT5t4vH9V2
         G7V2bOhe0nuB+Dqyq7vpAWNVFoM6BhSlslYT1S/UqsnkcFDQjGsa+iOhjVOkVaVJsyBu
         POIUoG2DRasIPlM2Ukm0TaLG42f5fSOJ30za0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0IPEAAZhLi1gys+2LirQge8UODqrAqbS/22Qm4bF1s=;
        b=TQi4jaU8YXYp2Gv71n9M/ul8/gQh1tLdvN6Goo4ms4qLD3Ow7C+rm98vq/OOuL7/d2
         WCd7wcL8A9YPyH6zK5KSJbxt2KOGcqfHP8/Ben89zFpp+MwXoY/iKwHQLaMUYRdhi6mN
         azb5zH9AZ103CrCSk4VkbhnLeS6ERcf/IdpwgUVItINztAUrWfOd6TUBVw/HFM9H7unR
         846CdTuDh8txQ9PqdomvOEetieErB478qlMci4IxHxSVYvtKUTuAk5wS7rrk9XBslBPP
         CnRn9CdaG6odqJP3NfUVZKQSUUHBM1KKbmVpgoZTiHz4GHSJLJHhxN0WAFeI2J3Y/gzK
         lrWQ==
X-Gm-Message-State: APjAAAXN6BgWlc3r28AqmHwQqLOY9KfMxPZp2YbI6ZXC19v50W/+Q5xO
        /hUREMUZ6ZWGAkXoE3Z+9zEn8g==
X-Google-Smtp-Source: APXvYqyE6f1XisQgbEH3d5hrLdGWQVIy/zvCRIyERSNmqjO7MmtzNljBiI83zTxtJqG/PDRN7/ThIQ==
X-Received: by 2002:a62:4c5:: with SMTP id 188mr8667284pfe.29.1557436462597;
        Thu, 09 May 2019 14:14:22 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id g2sm4443402pfd.134.2019.05.09.14.14.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 14:14:22 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, bleung@chromium.org,
        groeck@chromium.org, lee.jones@linaro.org, jic23@kernel.org,
        broonie@kernel.org, cychiang@chromium.org, tiwai@suse.com
Cc:     linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 13/30] mfd: cros_ec: Expand hash API
Date:   Thu,  9 May 2019 14:13:36 -0700
Message-Id: <20190509211353.213194-14-gwendal@chromium.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509211353.213194-1-gwendal@chromium.org>
References: <20190509211353.213194-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve API to verify EC image signature.

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Benson Leung <bleung@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 0ff1941288cf..76943e64998a 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2018,8 +2018,15 @@ enum ec_vboot_hash_status {
  * If one of these is specified, the EC will automatically update offset and
  * size to the correct values for the specified image (RO or RW).
  */
-#define EC_VBOOT_HASH_OFFSET_RO 0xfffffffe
-#define EC_VBOOT_HASH_OFFSET_RW 0xfffffffd
+#define EC_VBOOT_HASH_OFFSET_RO		0xfffffffe
+#define EC_VBOOT_HASH_OFFSET_ACTIVE	0xfffffffd
+#define EC_VBOOT_HASH_OFFSET_UPDATE	0xfffffffc
+
+/*
+ * 'RW' is vague if there are multiple RW images; we mean the active one,
+ * so the old constant is deprecated.
+ */
+#define EC_VBOOT_HASH_OFFSET_RW EC_VBOOT_HASH_OFFSET_ACTIVE
 
 /*****************************************************************************/
 /*
-- 
2.21.0.1020.gf2820cf01a-goog

