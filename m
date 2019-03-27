Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EF5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BFC2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CxgFoKZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbfC0KWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:22:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46717 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfC0KWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:22:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id t17so1194436wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWWk57s1TgVpgIwAlC7p82w8/KGV2Il7XfuLTWHllUA=;
        b=CxgFoKZBE4pi+gLZkGqwq3lguVI2ErX/hnoj3kMUWsDyco6oobgvbBe59CbQEWKmfb
         P4yvskYlZk0frUUFrp5XaPFs1cLK0izzhlRB8tEQItgR5TK9WGpq/i+J/+YXN1cWr9Ss
         HDmNszddeKWDY4Y//N3JuEMR7rRE0dITa4nGgDyBVAcuAyER0t8/WEH5/Z6gNsRiXmFe
         7u7JAZ6qBjNdxLScdXCe9VP5lvs7TYu/kOkQSYVk2rioKczh2YgwgjTB+uUIMcCaNXdq
         YQWPKgiJO48j6FOiu3hzFvzgCj8tMGuTtJkOMYdrGF+HmNW5aZvsTiBrGSOtw3q31pQw
         jO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWWk57s1TgVpgIwAlC7p82w8/KGV2Il7XfuLTWHllUA=;
        b=QdQvZxY4+2EMCAo/2C9/KYhlgHASQepUSsyO0Il9YL7elLWYNFWwCSdRkgMjJcylDD
         6v98nAZgMJsFEpYowvkxWOAxDOUy860djAfFKsDpKP9l0laUa/XH0koDgjZpS8RJbUL3
         9jpZwqzLG9mhxE29IZ/d9rRUl3pVtk9D7GKtJSIDlrhppw5pW8s4ybB4E9wT0mnoaYPi
         NfPlU84jlkRXg+W36FsKl4V/g6gmKGaf8/ZxB5HWLSrQEuxOBVA8zb/6T8U/dDJAxGn5
         U+FvrWt+vii9gvFSQtlI7/Q41HHt1YqDzzZ+dOuE/O44O3hgvIod7KtoDVjPeXB2o59j
         7jpA==
X-Gm-Message-State: APjAAAUWPOufZ1hkIb/HbFzB6Vv+EMIw/QWciVM+iBsm/wTVDFnRaWAS
        DrKzrOKmglDFrgeP0qBLG+2+AQ==
X-Google-Smtp-Source: APXvYqyuXXold9/U3/Pdda9L8ailm5qb0kHNoc9al6XjuI1s2MGFUOjm1qp0Ig+DIA2bWWbPX7QrqQ==
X-Received: by 2002:adf:f64d:: with SMTP id x13mr23839547wrp.298.1553682119705;
        Wed, 27 Mar 2019 03:21:59 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm19811444wrw.88.2019.03.27.03.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 03:21:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: meson-g12a: Add CMA reserved memory
Date:   Wed, 27 Mar 2019 11:21:57 +0100
Message-Id: <20190327102157.15908-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to handle Video Output and later on Video decoding,
add a reserved CMA pool with a similar 256MiB size as other SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 8f6f72e9825c..58176b525004 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -82,6 +82,14 @@
 			reg = <0x0 0x05000000 0x0 0x300000>;
 			no-map;
 		};
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x10000000>;
+			alignment = <0x0 0x400000>;
+			linux,cma-default;
+		};
 	};
 
 	sm: secure-monitor {
-- 
2.21.0

