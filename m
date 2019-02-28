Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB12AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99B3218CD
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJsuZ7Li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388012AbfB1USg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:18:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42611 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfB1USW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:18:22 -0500
Received: by mail-io1-f68.google.com with SMTP id p196so17651108iod.9;
        Thu, 28 Feb 2019 12:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7etm47TnRnregHBE+j/uykWGKkqjJyGdYAKbcvnRIHQ=;
        b=cJsuZ7LiT9FNFK5H4B9VrW48ih2d8JR59pG29RS9XLg7smROgPYKSG9HDzVXbOvgFH
         vDk1VgZM5BZxryzU5ebx6JdgHHsG9KyqXaWQoFtT1NTzbqMV5lTQhML4NY2L6Qm47YBF
         Y1tZ1UxhLmAB35gfIY0wZ4Ai+ODwJtbcMXLU81hxxnMOiDzjB044CK8SPJdVimLvW1re
         otDzwkzGswS4dR5cInI3BHk684iKWlrmPi6qgBEaer/Mg/M+/XDg+KuxYVE+LST7Uf2h
         MA05inDew97jK4lozUMJGY+eVD3gnXObdQ0UY+ameZiNxaQmT8EHpFWSvHqLnhi/33q2
         cNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7etm47TnRnregHBE+j/uykWGKkqjJyGdYAKbcvnRIHQ=;
        b=LIinLjjuvggXN4gqagmKzHygXbYbHyZsUuq+QmEub8s+NaPu5hS7cO53DuH7MJZqQF
         EWLLekP67Ax92C8afyIj/dqdalS6Q/mE/ap9JGIVxo61mAUJTBHYZO+dNBUcYd+vf87/
         V78o1w1S44pabrAKx5TV6rfMOenQriDgNmMdUryOZsyi7RaEmhi+49DveH8CrRYuTKD9
         o9IQ566CvS3W4fylsmjKLiAfBRdoGU93SW2YpI6EWhfit66E401+ln1NfgAdFigbsuX6
         BvlF0iD3EpuYmduAZS6DWfScxxL96efqod7JUn4ndvGUhLcSvavlkosvcviPWXQSlIqZ
         ADZw==
X-Gm-Message-State: APjAAAWv/Bxw8e2ALl7gzPUnf0gF4aQF/rYIE7EUu/IL6uZ21jpfSPvR
        BRqQN3U0j+BNY/nhwV1Lkw==
X-Google-Smtp-Source: APXvYqz59PQX0kV3rme6WL6/BAW9nwr5K0/Wc+knAFME1D6gUdhJZs85a/IxGzNZGpIhGJYJTp/y3g==
X-Received: by 2002:a6b:4108:: with SMTP id n8mr761438ioa.168.1551385101285;
        Thu, 28 Feb 2019 12:18:21 -0800 (PST)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id l131sm3388808itc.17.2019.02.28.12.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 12:18:20 -0800 (PST)
From:   Robert Yang <decatf@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH 2/3] dt-bindings: iio: accel: kxcjk1013: Add device tree binding documentation
Date:   Thu, 28 Feb 2019 15:18:10 -0500
Message-Id: <20190228201811.7582-3-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228201811.7582-1-decatf@gmail.com>
References: <20190228201811.7582-1-decatf@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for Kionix KXCJK-1013 Accelerometer driver.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
 .../bindings/iio/accel/kionix,kxcjk1013.txt    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt

diff --git a/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
new file mode 100644
index 000000000000..521c53799bc5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/accel/kionix,kxcjk1013.txt
@@ -0,0 +1,18 @@
+Kionix KXCJK-1013 Accelerometer device tree bindings
+
+Required properties:
+
+- compatible: Must be one of:
+    "kionix,kxcjk1013"
+    "kionix,kxcj91008"
+    "kionix,kxtj21009"
+    "kionix,kxtf9"
+    "kionix,SMO8500"
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

