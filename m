Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1F1CA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 05:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8A52085B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 05:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EWImVPA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729872AbfKAFkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 01:40:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43698 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbfKAFkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 01:40:45 -0400
Received: by mail-pg1-f193.google.com with SMTP id l24so5753492pgh.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 22:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87LDioEh9QArbtKje2Ha+R3GcGCadSMWQHWuBYLzjuI=;
        b=EWImVPA87TD2kh6PA559dlNc+n4rQqoHwyEpsEAWLcv5GBJZG6m5C6ugqPSn+4jVS7
         wlgTmQIF2i5QkMRaxTYWAZ44so4xHKaU9s0gLO7c48BCOT9UFR5U9tC+F2+oEm0yqILh
         YvfTaygs0sSX6ocutJPJcbV5MbGqVkr9yS7+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=87LDioEh9QArbtKje2Ha+R3GcGCadSMWQHWuBYLzjuI=;
        b=p9ewhA2HcCUwVWTBucx8h/LBFc5uRbdxvnyoXFwBzGxcroS4lKejBdEugCcDT71L80
         xnjbvFdcxAXDjq+8xkYl7U0lSZJ17Pr4ZehTQdFgRsxuNtauxXbO9X8PsD7kRnl1DoXd
         f/Fqm7kvOVnEHpLeXWUd4iprUDCuHfEd/eqn3zQE19Y5wHXKrnBIu2KoSZXEJKiDuKcR
         XbURTQ5KfI6LuaK4aAD0+iVNk0TKJyyMBUavsQotYvcS6CLXPxdh/ayJkT1jW1f/ajKY
         m3vtcTE+vEalAcgsaE2abiZTrqyzG/gLIh+ry9uqfVwxEiE70NbI8+18dkTEsUx6l016
         cYSw==
X-Gm-Message-State: APjAAAWK4mg4KKb+6bYtaNqKMZg1txP2Gf75N9TU/X+oWZwZabOm14uC
        ByLF2FinLdJ4kJE4poBx0T6OTQ==
X-Google-Smtp-Source: APXvYqzmEFT6XObk/Pkzshp1rgxcYK0KGZjMpS1zkQ0VFL6rDsk3N+SH1c2LjWcJS3JUYdRAMO5HHA==
X-Received: by 2002:a63:2057:: with SMTP id r23mr11730719pgm.274.1572586843673;
        Thu, 31 Oct 2019 22:40:43 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:254e:2b40:ef8:ee17])
        by smtp.gmail.com with ESMTPSA id 16sm7460747pgd.0.2019.10.31.22.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 22:40:43 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     ath10k@lists.infradead.org
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ikjoon Jang <ikjn@chromium.org>
Subject: [PATCH] ath10k: disable cpuidle during downloading firmware.
Date:   Fri,  1 Nov 2019 13:40:35 +0800
Message-Id: <20191101054035.42101-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downloading ath10k firmware needs a large number of IOs and
cpuidle's miss predictions make it worse. In the worst case,
resume time can be three times longer than the average on sdio.

This patch disables cpuidle during firmware downloading by
applying PM_QOS_CPU_DMA_LATENCY in ath10k_download_fw().

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 36c62d66c19e..4f76ba5d78a9 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -11,6 +11,7 @@
 #include <linux/property.h>
 #include <linux/dmi.h>
 #include <linux/ctype.h>
+#include <linux/pm_qos.h>
 #include <asm/byteorder.h>
 
 #include "core.h"
@@ -1027,6 +1028,7 @@ static int ath10k_download_fw(struct ath10k *ar)
 	u32 address, data_len;
 	const void *data;
 	int ret;
+	struct pm_qos_request latency_qos;
 
 	address = ar->hw_params.patch_load_addr;
 
@@ -1060,8 +1062,14 @@ static int ath10k_download_fw(struct ath10k *ar)
 			    ret);
 	}
 
-	return ath10k_bmi_fast_download(ar, address,
-					data, data_len);
+	memset(&latency_qos, 0, sizeof(latency_qos));
+	pm_qos_add_request(&latency_qos, PM_QOS_CPU_DMA_LATENCY, 0);
+
+	ret = ath10k_bmi_fast_download(ar, address, data, data_len);
+
+	pm_qos_remove_request(&latency_qos);
+
+	return ret;
 }
 
 void ath10k_core_free_board_files(struct ath10k *ar)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

