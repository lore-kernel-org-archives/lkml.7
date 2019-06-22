Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149E1C48BE7
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C73206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 08:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDAd1wO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfFVIvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 04:51:21 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35205 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfFVIvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 04:51:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id m3so8757912wrv.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 01:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OT8SPNHWk4z4I8Pp+icjCJXudD3ZuOCKF+jmfrUNbnE=;
        b=XDAd1wO7ZXP/gkz9tP6VaxixOwMxJNdn94LT+0YFDWEbbHwXz3J0qni/pdrkNShwW+
         iX6TbIyyRSWGcNxHBi7Rf30Oi2htKV3CxWTHG72+lG2m+eYRMeqoOF3yWEetK3cRtcH/
         JILOcF6hfHOM0geAh1PJ7P1jeMzDra6B9baC6Wn3+5/YQ77gSqHUr4+vXObVUxZUyt6t
         SzwC0XKnD5ycOhRK1hduOSRi/XLrQ8QQBgFiF19fp4ANigZM3AkbsCsgdGdgtIARiL8x
         k3ANoZz06BRD3MCxcjYdLQNoLmcwGFx8k23M/J+lCMqCN/+F0K8+1gGkz8PCFLa3va0K
         Mz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OT8SPNHWk4z4I8Pp+icjCJXudD3ZuOCKF+jmfrUNbnE=;
        b=d2HO7RK9uwK9OO+FHF6dwlbDIXr5oR+kMn1TXoADLu2d47PSKbvgf6WHd6WxkV7s0r
         tXpyrbS40CS+rbfBXyYH3gfYeHyTV3CHiVrilf8UXAINiXWdYHbMC2C0yBYiahTLhiVk
         WN1O4pYAg7rcjC9oz5Adcp+IvU6/R8IihukxrNKdNwdRUpqiWkcjb890nB9APWkFEfVy
         uyCzRA2P89P8jeR7k390DBJnMZ0mOXjxuIdlQ3JCRLwK7oHcAbh+zRZyBo6UezQPWHHr
         Z9rBc5cHxvksMGwPOYvm9yXOpRsUb1aBbleM0LPmFO2L1eiHPWC+QuQt2ZYnF9HS/UFX
         yaGg==
X-Gm-Message-State: APjAAAWBgXOzdgD3+FH6glQxz+sELQUvw32ayJaawylXcip6zjyyjO1S
        ZZy9Z2WoN4Ks6wAv7x5hV+pUHA==
X-Google-Smtp-Source: APXvYqxuk4LvffOaJ8GkE3qYxtS7zZb3EEA/mB/jdVnyU1h0V18ENYI/mpS0guMTT8+y06baPY/I/g==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr95195242wrp.149.1561193474094;
        Sat, 22 Jun 2019 01:51:14 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:4bd:3f91:4ef8:ae7e])
        by smtp.gmail.com with ESMTPSA id v15sm4863589wrt.25.2019.06.22.01.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 01:51:13 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Jonathan Richardson <jonathan.richardson@broadcom.com>,
        Luo XinanX <xinanx.luo@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Qian Cai <cai@lca.pw>, Tian Baofeng <baofeng.tian@intel.com>
Subject: [PATCH 2/4] efi/bgrt: Drop BGRT status field reserved bits check
Date:   Sat, 22 Jun 2019 10:51:04 +0200
Message-Id: <20190622085106.24859-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
References: <20190622085106.24859-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

Starting with ACPI 6.2 bits 1 and 2 of the BGRT status field are no longer
reserved. These bits are now used to indicate if the image needs to be
rotated before being displayed.

The first device using these bits has now shown up (the GPD MicroPC) and
the reserved bits check causes us to reject the valid BGRT table on this
device.

Rather then changing the reserved bits check, allowing only the 2 new bits,
instead just completely remove it so that we do not end up with a similar
problem when more bits are added in the future.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/efi-bgrt.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index a2384184a7de..b07c17643210 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -47,11 +47,6 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 		       bgrt->version);
 		goto out;
 	}
-	if (bgrt->status & 0xfe) {
-		pr_notice("Ignoring BGRT: reserved status bits are non-zero %u\n",
-		       bgrt->status);
-		goto out;
-	}
 	if (bgrt->image_type != 0) {
 		pr_notice("Ignoring BGRT: invalid image type %u (expected 0)\n",
 		       bgrt->image_type);
-- 
2.20.1

