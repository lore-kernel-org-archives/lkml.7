Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57749C04AB3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D31B2184D
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 01:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZtOjMZmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfELBZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 21:25:49 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35172 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbfELBZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 21:25:43 -0400
Received: by mail-it1-f194.google.com with SMTP id u186so15155163ith.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2019 18:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jRmWMCr9C4dJ0Jxfhe2zjagSxgsETvqOgSRpXe72yco=;
        b=ZtOjMZmCTR/mrrnpw9PTvwmk/K3sCZTUUTDUVRIIqp9Mtmr86wlCJSG4Xetmehw55H
         WUELhrR76P6FtqznqwuyJs47HbORH3XjXBTO4d0PksfiX41gxlxHpJdAqsaYVRm1+ZIv
         1qRrH0eYcsqcMSVP1Tf5Qjh3ZJWwNlu/+s5aBchXDq19Z6w9ylMyXTNVJAY9hqxB6pwK
         pkUyMvtgHx+7bHSLVbAMyMkDuLaIdZic+Z7EIkhPN+Fr0hwyQ95WBNUhCdof/rVmotZ7
         PKwaHIUAX6k4o5Gx4eQgy6heYu1mQx1/9wlVy2BW5YKyIySIcOCvYimQLRChjxlGSHUM
         TU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jRmWMCr9C4dJ0Jxfhe2zjagSxgsETvqOgSRpXe72yco=;
        b=TEuraM3W7o1UuSptlLVqVoC02ytHFC3tm1rrBo4eUAqGkH577udABCrUbUYQhx86to
         zYZNvQ8hf2zibgqcxBbxq7K+VOmKHmZo6yTkq+j1fOArfa9WVnNdD3afiIshm1hanj1W
         iFODFf059sRyqLpfAjBgxGD9poviMldGCIwidXcnbIGR8NmzjaNunS0TgsTW4bTZYz+a
         rh+1KolwNyq+zvfBzYujFfhLodTQH/R569qmv1sFxoEstWZfY91AgReQBHFVcHeP6ONJ
         OSigqjzICdILsM/dE6j8a1P7KOfcTIhIuH2qTXTos558PGATkKUCYwqTupWaANb04EIg
         c7uw==
X-Gm-Message-State: APjAAAX+QJde5+PU+OwN+EYppCyc09r5oThHEmvBYBYgVqTZ92zTsQ0J
        KJy4rkoff+pmSmP+Ib598SViQw==
X-Google-Smtp-Source: APXvYqwNFp05LkowrFMViqhFPT/xRC2yNKzgkZFEhxu9XezGlR/mQmqMqS8ySmuQlsg7qGtAqUBVBQ==
X-Received: by 2002:a02:1cc6:: with SMTP id c189mr13576396jac.119.1557624342247;
        Sat, 11 May 2019 18:25:42 -0700 (PDT)
Received: from shibby.hil-lafwehx.chi.wayport.net (hampton-inn.wintek.com. [72.12.199.50])
        by smtp.gmail.com with ESMTPSA id u134sm1579013itb.32.2019.05.11.18.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 18:25:41 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, arnd@arndb.de, bjorn.andersson@linaro.org,
        ilias.apalodimas@linaro.org
Cc:     syadagir@codeaurora.org, mjavid@codeaurora.org,
        evgreen@chromium.org, benchan@google.com, ejcaruso@google.com,
        abhishek.esse@gmail.com, linux-kernel@vger.kernel.org,
        Alex Elder <elder@linaro.org>
Subject: [PATCH 10/18] soc: qcom: ipa: IPA interface to GSI
Date:   Sat, 11 May 2019 20:25:00 -0500
Message-Id: <20190512012508.10608-11-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190512012508.10608-1-elder@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides interface functions supplied by the IPA layer
that are called from the GSI layer.  One function is called when a
GSI transaction has completed.  The others allow the GSI layer to
inform the IPA layer when transactions have been supplied to
hardware, and when the hardware has indicated transactions have
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
index 000000000000..c4e6c96d1676
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
+		ipa_endpoint_skb_tx_callback(trans);
+	else
+		ipa_endpoint_rx_callback(trans);
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

