Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FF8C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479EB214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 08:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JI4x7e7O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbfENI1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 04:27:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51984 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfENI1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 04:27:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id o189so1857277wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 01:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m6Un7OR1aiu9wrzrl8IRY5GNnopILO3r5dQ0m/pbT10=;
        b=JI4x7e7Oy3ry6mUfW5LiquXDPgzPcSd5zy3s2eWGX8WqMy4EoeoVL09PGiMTzW7OUy
         1zeXMdUAc5rN/k2ekwFxZQjgWsnxfzn+naKQC9NEexCAXDQsCNH5PPNziSSUXRDpJqs1
         OfiuS76sPDL4nxBByqQYJ8ceKziM9y6w6IehCyldMAoDofXEUxCn6pScPIkxOxhiNiUT
         siaJkO0/F1sbzN9mRsGPj0Y/nIBelz87TCjWLLrz3pynDQZ1UbNhYFiv1Zwtv+cuy+H5
         WGYV6ucH77gBg94yuAFVmhA++4wsANAXLf9KcVg6DK/Cz2foMz3t+tbLRKSQ3Y7xoA4w
         TEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m6Un7OR1aiu9wrzrl8IRY5GNnopILO3r5dQ0m/pbT10=;
        b=jTKAITmA4Gw5+JVmcRefS8wSxRQFnMsUP2ZLbxs4HVp0WQtNEhjGmEuC5aQ8qRk1Hl
         VxeyOnxL2IM+fjKHuewNSw59nbz6r7fTdA/1gYoMopqodht4WOe9QozJj3oW+RKBqmBK
         pBLYGJR5gI0SxcBNUirUhy6kipfkP5DCYDFb5VOs4hg1YorrKtdstU9YMA1fvVLaPk5z
         UiYcUnO095f/3AXxmZI9rnnwsGt3A9hSERuVu043X4OWt5k4QMS/dV9U0G3vt2reg4AS
         CzoF44YOHi83AUIybyVTWtTcf/ppHVugjKU92cF+zNkPOf+SJIm7gYydm4eG6T+KmhYX
         ZQUQ==
X-Gm-Message-State: APjAAAWtexXrsnCQtUaaP6gEDVLQBepUp5Dvk1HzEs359WhE6PhX+kvW
        quaTb624tmHaG+2LRNRTeGQy+w==
X-Google-Smtp-Source: APXvYqwiyL+F34V5oX5aorvsSvFWYQaBw0/Pj5Q1wGOXb7PjKpXDBCJptQeHKQK6h73Y6MwygEhtkw==
X-Received: by 2002:a1c:96c9:: with SMTP id y192mr7711843wmd.75.1557822418092;
        Tue, 14 May 2019 01:26:58 -0700 (PDT)
Received: from glaroque-ThinkPad-T480.home ([2a01:cb1d:379:8b00:1910:6694:7019:d3a])
        by smtp.gmail.com with ESMTPSA id j190sm2450772wmb.19.2019.05.14.01.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 01:26:57 -0700 (PDT)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     linus.walleij@linaro.org, khilman@baylibre.com
Cc:     jbrunet@baylibre.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] dt-bindings: pinctrl: meson: Add drive-strength-microamp property
Date:   Tue, 14 May 2019 10:26:49 +0200
Message-Id: <20190514082652.20686-4-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514082652.20686-1-glaroque@baylibre.com>
References: <20190514082652.20686-1-glaroque@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional drive-strength-microamp property

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
index a47dd990a8d3..a7618605bf1e 100644
--- a/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt
@@ -51,6 +51,10 @@ Configuration nodes support the generic properties "bias-disable",
 "bias-pull-up" and "bias-pull-down", described in file
 pinctrl-bindings.txt
 
+Optional properties :
+ - drive-strength-microamp: Drive strength for the specified pins in uA.
+			    This property is only valid for G12A and newer.
+
 === Example ===
 
 	pinctrl: pinctrl@c1109880 {
-- 
2.17.1

