Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3695C04AB1
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D42E217D7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mwaQeNmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbfELBZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:25:34 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56129 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726529AbfELBZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:31 -0400
Received: by mail-it1-f194.google.com with SMTP id q132so15165932itc.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVycjHRBln996eRpk6k47CxqNjyaNSdSdKwD7DF2v4g=;
        b=mwaQeNmWR9ZKIdVhlyKXSsaF91NBkAVwoudjrhGFawDHq1RUlZftn53OjELSg6B3QA
         /8DUCt68ZXbY/0p/MwswJcClkwJfH3PDwHtvacduSPl9bnSB9JTh+DM6zTpZ3TEGY9nc
         vg+mZ+Tm3YGxXyoJLRAJAczsp7BKK82rC00IEwRbyJuwJ+03mWpyQMBEPjUA5aNWZpIY
         C1NgIxBDY1cSB31zt+kvwMCQJCCD0UHShTEeP7FEF9HufTuhH6wpdIY6Nbk+/pncxl6Y
         L2HM+eIP5SO/Dm+ONM1iS3RIiKVmBenu1mYuTJZ6Ha5PLpc48mIjBIvo/B/yIEOhmmcp
         eu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVycjHRBln996eRpk6k47CxqNjyaNSdSdKwD7DF2v4g=;
        b=pRT7R4fo3nDWfswx8sfNiaTlb0jw4vDJyKw4WAe+MPPjxfLI9rNb+2VObWM8sHQ1/D
         e/IbOQeiHYAvoxH1yXLijzfrd3W9IVuuPvR4MvO6lHR1ky2HXB1RzDFZLDmAGvHMlCBp
         D0Zfu5migHOnTD/g37GlUuQy7NFnk1slGPVQ1j2RQ4/n34aYgAoXOH4GfFreQkRQeP5K
         j9sefxBLRFVMRXVqLvSaq5whlnlANVdWJQWLg5zMFQucLBBWE7Co6NJWH0BmOpW9KYAU
         FVpDJH/OkwXLY1Fy6/4gQKpQzDVlmr6UpJCQVV1k4yPDKDs2ftaPgCf02tONWQ9srJBE
         KWiw==
X-Gm-Message-State: APjAAAX47Db9RacHrXvgdBauVlQR6eX4tHb5jIntrj4Ddn4qpCT5eZuP
        vPwBzYu2IM3LJM1HyLqn+Xz2ag==
X-Google-Smtp-Source: APXvYqz0TKjYgBNtbCwWsQibvllsattvenxrEvd6vZRVHZatuGPQMqrMjGmfRu9K0Esns77RNsqZqA==
X-Received: by 2002:a24:7f84:: with SMTP id r126mr11927200itc.99.1557624330598;
        Sat, 11 May 2019 18:25:30 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:29 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org, subashab@codeaurora.org,
        stranche@codeaurora.org, yuehaibing@huawei.com, joe@perches.com
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
Date:   Sat, 11 May 2019 20:24:52 -0500
Message-Id: <20190512012508.10608-3-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IPA driver requires some (but not all) symbols defined in
"drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h".  Create a new
public header file "include/soc/qcom/rmnet.h" and move the needed
definitions there.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .../ethernet/qualcomm/rmnet/rmnet_handlers.c  |  1 +
 .../net/ethernet/qualcomm/rmnet/rmnet_map.h   | 24 ------------
 .../qualcomm/rmnet/rmnet_map_command.c        |  1 +
 .../ethernet/qualcomm/rmnet/rmnet_map_data.c  |  1 +
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |  1 +
 include/soc/qcom/rmnet.h                      | 38 +++++++++++++++++++
 6 files changed, 42 insertions(+), 24 deletions(-)
 create mode 100644 include/soc/qcom/rmnet.h

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
index 11167abe5934..3aa79b7ed539 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c
@@ -17,6 +17,7 @@
 #include <linux/netdev_features.h>
 #include <linux/if_arp.h>
 #include <net/sock.h>
+#include <soc/qcom/rmnet.h>
 #include "rmnet_private.h"
 #include "rmnet_config.h"
 #include "rmnet_vnd.h"
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
index 884f1f52dcc2..39d0be99a771 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map.h
@@ -39,30 +39,6 @@ enum rmnet_map_commands {
 	RMNET_MAP_COMMAND_ENUM_LENGTH
 };
 
-struct rmnet_map_header {
-	u8  pad_len:6;
-	u8  reserved_bit:1;
-	u8  cd_bit:1;
-	u8  mux_id;
-	__be16 pkt_len;
-}  __aligned(1);
-
-struct rmnet_map_dl_csum_trailer {
-	u8  reserved1;
-	u8  valid:1;
-	u8  reserved2:7;
-	u16 csum_start_offset;
-	u16 csum_length;
-	__be16 csum_value;
-} __aligned(1);
-
-struct rmnet_map_ul_csum_header {
-	__be16 csum_start_offset;
-	u16 csum_insert_offset:14;
-	u16 udp_ip4_ind:1;
-	u16 csum_enabled:1;
-} __aligned(1);
-
 #define RMNET_MAP_GET_MUX_ID(Y) (((struct rmnet_map_header *) \
 				 (Y)->data)->mux_id)
 #define RMNET_MAP_GET_CD_BIT(Y) (((struct rmnet_map_header *) \
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
index f6cf59aee212..54b86a8be570 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/netdevice.h>
+#include <soc/qcom/rmnet.h>
 #include "rmnet_config.h"
 #include "rmnet_map.h"
 #include "rmnet_private.h"
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
index 57a9c314a665..e3fb4035820c 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_data.c
@@ -17,6 +17,7 @@
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <net/ip6_checksum.h>
+#include <soc/qcom/rmnet.h>
 #include "rmnet_config.h"
 #include "rmnet_map.h"
 #include "rmnet_private.h"
diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
index d11c16aeb19a..b8df36e827d4 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_vnd.c
@@ -17,6 +17,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if_arp.h>
 #include <net/pkt_sched.h>
+#include <soc/qcom/rmnet.h>
 #include "rmnet_config.h"
 #include "rmnet_handlers.h"
 #include "rmnet_private.h"
diff --git a/include/soc/qcom/rmnet.h b/include/soc/qcom/rmnet.h
new file mode 100644
index 000000000000..80dcd6e68c3d
--- /dev/null
+++ b/include/soc/qcom/rmnet.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Copyright (c) 2013-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2018-2019 Linaro Ltd.
+ */
+#ifndef _SOC_QCOM_RMNET_H_
+#define _SOC_QCOM_RMNET_H_
+
+#include <linux/types.h>
+
+/* Header structure that precedes packets in ETH_P_MAP protocol */
+struct rmnet_map_header {
+	u8  pad_len		: 6;
+	u8  reserved_bit	: 1;
+	u8  cd_bit		: 1;
+	u8  mux_id;
+	__be16 pkt_len;
+}  __aligned(1);
+
+/* Checksum offload metadata header for outbound packets*/
+struct rmnet_map_ul_csum_header {
+	__be16 csum_start_offset;
+	u16 csum_insert_offset	: 14;
+	u16 udp_ip4_ind		: 1;
+	u16 csum_enabled	: 1;
+} __aligned(1);
+
+/* Checksum offload metadata trailer for inbound packets */
+struct rmnet_map_dl_csum_trailer {
+	u8  reserved1;
+	u8  valid		: 1;
+	u8  reserved2		: 7;
+	u16 csum_start_offset;
+	u16 csum_length;
+	__be16 csum_value;
+} __aligned(1);
+
+#endif /* _SOC_QCOM_RMNET_H_ */
-- 
2.20.1

