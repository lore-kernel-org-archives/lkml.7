Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532BAC28CC2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272A926348
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:54:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W3TwW4Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfEaDyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:54:11 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34895 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfEaDyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:54:08 -0400
Received: by mail-io1-f68.google.com with SMTP id p2so7031166iol.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qcjrhVYsZg52RJ5XXriOknCyqMNzK66d33ZzlwDcMVo=;
        b=W3TwW4DqsezXBlUJHicJWKqM/j0qAEnP6ywmwbFYab/eJVNGGidy9owsITmfaNAdf6
         Fz5fuAuBri9mUH60zR3nugFjCv3odkZK6b4QYl4vGiQCDYsAc+9+SB1gAXM8GLdw+1eR
         q/MWSwM0Q45OYgflLad5PZ2BGq5fTi6Zh5TtBnmnOq2f31aSzXW0kPNfq+dFmxNe3bLW
         xDC2BU3ZbGf9oaByMK8aQe0qmfaNHtkNnyuES5HZvwzjktrsL/wwUV3DtJss56WiImYG
         588YsvLCDWIkiEHFIAb0j8CR+dgreVIM0l064j6cYll80b80qiv2Bf4TCK3groaINQrC
         k+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qcjrhVYsZg52RJ5XXriOknCyqMNzK66d33ZzlwDcMVo=;
        b=P0W4nHm6vRf+e++XwFx9bgBK3QWEh5Kae+XZ9hrOIyI3dUKBQYuSyvTJD9joK3LsJY
         yzDHLCDqo9U5WK5JU2zTl8cB+aedgOFJZz65ZniAV9Y7b7kerkgmRH4sI2AcqDeRxoQU
         c22K+MvRekViSqfyzXZnNHuY5LXc/5oYoFTU7KNwyIJcC+JBeb7QXlDIrZomyyK4ZTlV
         aLcNZSbOXfaqte0aViAEEYgleTsnvEji3moclhjOme/irFRzYY+PG8E3fNhM41ZRa0vz
         MiEOiI+o8J9g1JYz5TQFm9jxCReGngIrP+zQgB6s3u8cCzCm/gKyu+BdEFKW+Fh2grmM
         vAlA==
X-Gm-Message-State: APjAAAVik+oY0iRqAPrbNoub1xBcb9DmCiHEK8udsvnLUteTlEg++YU0
        PqU04vdd3dacaojE8jhjYI+gaw==
X-Google-Smtp-Source: APXvYqyoSK33VrVMXXIhBImgNXPM19PElBRuQNwVsxLaDvN7FuwTs/xkVcRJ5E34mPw9RNG7aVFRmg==
X-Received: by 2002:a5d:9518:: with SMTP id d24mr5008878iom.21.1559274847945;
        Thu, 30 May 2019 20:54:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id q15sm1626947ioi.15.2019.05.30.20.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 20:54:07 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        cpratapa@codeaurora.org, syadagir@codeaurora.org,
        subashab@codeaurora.org, abhishek.esse@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 09/17] soc: qcom: ipa: IPA interface to GSI
Date:   Thu, 30 May 2019 22:53:40 -0500
Message-Id: <20190531035348.7194-10-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190531035348.7194-1-elder@linaro.org>
References: <20190531035348.7194-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides interface functions supplied by the IPA layer
that are called from the GSI layer.  One function is called when a
GSI transaction has completed.  The others allow the GSI layer to
inform the IPA layer when the hardware has been told it has new TREs
to execute, and when the hardware has indicated transactions have
completed.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_gsi.c | 48 ++++++++++++++++++++++++++++++++++++++
 drivers/net/ipa/ipa_gsi.h | 49 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 drivers/net/ipa/ipa_gsi.c
 create mode 100644 drivers/net/ipa/ipa_gsi.h

diff --git a/drivers/net/ipa/ipa_gsi.c b/drivers/net/ipa/ipa_gsi.c
new file mode 100644
index 000000000000..7f8d74688c1e
--- /dev/null
+++ b/drivers/net/ipa/ipa_gsi.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+
+#include <linux/types.h>
+
+#include "gsi_trans.h"
+#include "ipa.h"
+#include "ipa_endpoint.h"
+
+void ipa_gsi_trans_complete(struct gsi_trans *trans)
+{
+	struct ipa *ipa = container_of(trans->gsi, struct ipa, gsi);
+	struct ipa_endpoint *endpoint;
+
+	endpoint = ipa->endpoint_map[trans->channel_id];
+	if (endpoint == ipa->command_endpoint)
+		return;		/* Nothing to do for commands */
+
+	if (endpoint->toward_ipa)
+		ipa_endpoint_skb_tx_complete(trans);
+	else
+		ipa_endpoint_rx_complete(trans);
+}
+
+void ipa_gsi_channel_tx_queued(struct gsi *gsi, u32 channel_id, u32 count,
+			       u32 byte_count)
+{
+	struct ipa *ipa = container_of(gsi, struct ipa, gsi);
+	struct ipa_endpoint *endpoint;
+
+	endpoint = ipa->endpoint_map[channel_id];
+	if (endpoint->netdev)
+		netdev_sent_queue(endpoint->netdev, byte_count);
+}
+
+void ipa_gsi_channel_tx_completed(struct gsi *gsi, u32 channel_id, u32 count,
+				  u32 byte_count)
+{
+	struct ipa *ipa = container_of(gsi, struct ipa, gsi);
+	struct ipa_endpoint *endpoint;
+
+	endpoint = ipa->endpoint_map[channel_id];
+	if (endpoint->netdev)
+		netdev_completed_queue(endpoint->netdev, count, byte_count);
+}
diff --git a/drivers/net/ipa/ipa_gsi.h b/drivers/net/ipa/ipa_gsi.h
new file mode 100644
index 000000000000..72adb520da40
--- /dev/null
+++ b/drivers/net/ipa/ipa_gsi.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/* Copyright (c) 2012-2018, The Linux Foundation. All rights reserved.
+ * Copyright (C) 2019 Linaro Ltd.
+ */
+#ifndef _IPA_GSI_TRANS_H_
+#define _IPA_GSI_TRANS_H_
+
+#include <linux/types.h>
+
+struct gsi_trans;
+
+/**
+ * ipa_gsi_trans_complete() - GSI transaction completion callback
+ * @gsi:	GSI pointer
+ * @trans:	Transaction that has completed
+ *
+ * This called from the GSI layer to notify the IPA layer that a
+ * transaction has completed.
+ */
+void ipa_gsi_trans_complete(struct gsi_trans *trans);
+
+/**
+ * ipa_gsi_channel_tx_queued() - GSI queued to hardware notification
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel number
+ * @count:	Number of transactions queued
+ * @byte_count:	Number of bytes to transfer represented by transactions
+ *
+ * This called from the GSI layer to notify the IPA layer that some
+ * number of transactions have been queued to hardware for execution.
+ */
+void ipa_gsi_channel_tx_queued(struct gsi *gsi, u32 channel_id, u32 count,
+			       u32 byte_count);
+/**
+ * ipa_gsi_trans_complete() - GSI transaction completion callback
+ipa_gsi_channel_tx_completed()
+ * @gsi:	GSI pointer
+ * @channel_id:	Channel number
+ * @count:	Number of transactions completed since last report
+ * @byte_count:	Number of bytes transferred represented by transactions
+ *
+ * This called from the GSI layer to notify the IPA layer that the hardware
+ * has reported the completion of some number of transactions.
+ */
+void ipa_gsi_channel_tx_completed(struct gsi *gsi, u32 channel_id, u32 count,
+				  u32 byte_count);
+
+#endif /* _IPA_GSI_TRANS_H_ */
-- 
2.20.1

