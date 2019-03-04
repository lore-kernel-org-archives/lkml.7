Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DBDC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660E320652
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjMp/l2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbfCDPTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:19:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40368 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCDPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:19:35 -0500
Received: by mail-io1-f68.google.com with SMTP id p17so4207948iol.7;
        Mon, 04 Mar 2019 07:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dkcNqktpR8yNEegl0ynANTKXSHlu6lgX/Bw/77RWtQM=;
        b=ZjMp/l2eoG6Z99R1rB3QPaja9RhIl651Wy1VooAJtYTD7R8sfvCboAqJpon9XeNJJQ
         x195ywgdzNtkuid85a7qyiHI6iJUXppSOrRvQyy2gCuI6TirCuTQUP6nZ3bDx0h3zEJ9
         f4ha28pcgZgL4xOCzr1vNU9ADX/FxRcdcSQJ8EoE0bNHvZGOSP/ibaAIsx91ZUXTdWev
         lOLQ3nJfIJMXm99GbzCRnwE3NtgmOioNxTDUjPwpymYpfIcBrxGBNYSmB2/337Eg2ccO
         DuMlfSreeVvWhZoob6Mq656uIOwthTpsnkWOpyLOTFhKiMaMmZ8QLodffO/wlpveh3rg
         HlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dkcNqktpR8yNEegl0ynANTKXSHlu6lgX/Bw/77RWtQM=;
        b=sd7Lya2FkjcH4znDU0naQlirrjF4Hy6ESVSEL6JtJje5Ncqbpg3o/pIO3Cxwp4ryw/
         Y0jAiN/q3e6qPHLQ9shlxzKB7BTWQmImyQWPEA98ypfsmQ1ojVbdk+xURRo0gX1acbKX
         t6QlPA8igTRhvFgh/fJho7VADwBFOTn9kC7dmMbDC8RClLIvgeMxBQrHVCCAeIuuIuHV
         9eUdohQ5e7gI+tCHh/5wuPg/xOVftA9guy8f9L7GbfbvKNSs11mrUoNXvS4NMEtB4Xdx
         hGJoDR5FpIGQuMZneTWAcTKEC5mlK7e/OYxVBv+KPSWGWx2xyePKjs934KuwyjbZ4Hca
         KHfg==
X-Gm-Message-State: APjAAAUgRJ3wmk/HhpyDem58nj409KA0M+SXS1veke0Yp2AyIN5ylnM8
        zdkm0F3fSfQOXBBN56RqR9MM4t0=
X-Google-Smtp-Source: APXvYqx4nFxkgQA4Qvp5kh38vS+O+LVho5YsfFIUSGPZLlYaMZjJCQSqntgmKoKS29gaICqjWNbHzg==
X-Received: by 2002:a5d:91d3:: with SMTP id k19mr10030875ior.258.1551712774783;
        Mon, 04 Mar 2019 07:19:34 -0800 (PST)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id 5sm3240615ity.40.2019.03.04.07.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 07:19:34 -0800 (PST)
From:   Robert Yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: iio: accel: kxcjk1013: Add device tree binding documentation
Date:   Mon,  4 Mar 2019 10:19:11 -0500
Message-Id: <20190304151912.11485-3-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190304151912.11485-1-decatf@gmail.com>
References: <20190304151912.11485-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for Kionix KXCJK-1013 Accelerometer driver.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
 .../bindings/iio/accel/kionix,kxcjk1013.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
new file mode 100644
index 000000000000..eb76a02e2a82
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
@@ -0,0 +1,17 @@
+Kionix KXCJK-1013 Accelerometer device tree bindings
+
+Required properties:
+
+- compatible: Must be one of:
+    "kionix,kxcjk1013"
+    "kionix,kxcj91008"
+    "kionix,kxtj21009"
+    "kionix,kxtf9"
+ - reg: i2c slave address
+
+Example:
+
+kxtf9@f {
+	compatible = "kionix,kxtf9";
+	reg = <0x0F>;
+};
-- 
2.17.1

