Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85105C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54ACE20693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="V9q4JOR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfCRKFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53676 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbfCRKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id e74so12284053wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d1m2cZ4Hsds4Mlix4L4I7dVD1tQWYPx7jZATENXCdR0=;
        b=V9q4JOR/b6VgtxPAtDphRKRoCMPKmUrMmGNXmfYimJeJX1X1Y3Z+jIbjMRn59t9T4M
         cRkEg1vfHvXpsFzNQ3Wc9VWr+tVxpiEcgfUWgrvQquo2b9aPBGuy6Cb2H2g8eOEYbkfs
         VZPEkMGa5q5bR1BjBV6YOZB//BBO2vXwimr4en9WnssSUXzROoZmtRBgu0LrvJQ2xXqs
         OzRGZXzUT/nHnXB15BTBT4xO5VBlV6GNq0y6oEWtzg1m6PMsXGeNaFOdUZ6h56aUc1IC
         22Qj3W/YQTa6QKYXLv0W9QOtnt7GsOFdwY0bpU4qsYUVrphrPYGqdwH9RcU7ZW3x2pjS
         5tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d1m2cZ4Hsds4Mlix4L4I7dVD1tQWYPx7jZATENXCdR0=;
        b=jV9HrlMt13Qxn8ITWnXbwkhLDg7BXeac0y/5NZuQoy21ULhvBXcfQRBerN2XVaLHEg
         6bqk9JtZl/zV6ZOy0rym+CIYgeyRlwcGbifl/rlUXsIMBpQOsriMtFoMowqTyGzp4MEo
         i7mT++SsWAoJ7EXU2vyANKx0sH/qOeISs391FR4US9ouNqN0K+H+5lbXjFhCO5YIZVRW
         0R5jexVo+IeilZtExjfGtKxjybk3NgT7Xa3PGGzzERbw86UK/lup0LrNExzUBDsLOoqF
         3Q4GsqYpAB2NxwZek7PY0hm4ibiEtmIzq0EcRt4EYR+rJF/Vjj+9KCrISOihpEzbm7qw
         J7CQ==
X-Gm-Message-State: APjAAAX28/e/jKhpVSz/OM+F8U/rYR8Txu4MZDtaWJJolMRW7OBc0THw
        z/ag1lLrgXLLU9MJPBNIR5Q8Ng==
X-Google-Smtp-Source: APXvYqy6mAWZbbu3AkNr+/6AEaAM6DGSfu7zYfBU0VUjbVtjtWASTJfE6YJsIxzhhQszgSvy5Of6ZQ==
X-Received: by 2002:a1c:e910:: with SMTP id q16mr11086345wmc.30.1552903509019;
        Mon, 18 Mar 2019 03:05:09 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:05:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] arm64: dts: meson-g12a-sei510: Enable USB
Date:   Mon, 18 Mar 2019 11:04:56 +0100
Message-Id: <20190318100458.5619-10-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190318100458.5619-1-narmstrong@baylibre.com>
References: <20190318100458.5619-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the USB2 and USB3 Host ports on the SEI520 Set-Top-Box.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index ebdad5a192f1..c350a0165d44 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -125,3 +125,8 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
+&usb {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.20.1

