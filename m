Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E20C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B10B42075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 10:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KhrBnRBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbfC0Kd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 06:33:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35474 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733217AbfC0KdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 06:33:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id w1so17936870wrp.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 03:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKLO1xq8GhoCKIta95r/uYSgTA9Z6FYbrp7bg0UxXxk=;
        b=KhrBnRBgmJd76U2vV4Eff5pU94SEB34MwayBQhqEk66ntaYGIWkLBQU3BrvUcE0aki
         wO5y7jyg7ssSkSa9JSslRUgpAnOb1b7YdMBzIOa1fxjDXhCjitWqyLQraZFaLxGJLRSl
         nGWR8b1H7SdiT4j4pBnBhlfEZKKjKWeZSW4oC9WqBHV6Fra/sI6iTt9pYmXmDkSVfSjf
         ruyTMsWrUhsAQc88fWZA2bA8AEopRWqP7Twh43Wof7ceE92VAp4VZhPmLFUMTdgJjxnt
         gYUkJKnXxwAgsAAImT1KaX9lUo+0hfRVMVmpiYaJsVR6geP9BVHzLf6lQ1Go/OjATeN6
         p6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKLO1xq8GhoCKIta95r/uYSgTA9Z6FYbrp7bg0UxXxk=;
        b=eYHE8IceF1qqRtmWJ0imPaqJvhIN6DEa5KN0oUwmujhXCRJc73TYbzEKsZpJzJxOKV
         odITVAWj7xZQOMgjPokdNLCw4ZA5XG0ESzhcNyEPszqdoeWGVfFm7ABBRiN8DI4mDsFI
         NhCNjEyGUXkBxKU+2VItG5TZ6Q8MTrn0wOb2raEi9LWQJpjzw4B+oAUmceO/6I2e2dAB
         /0/KKa8OeuV3JVckHX8Nx0g0O34W83wu7YI/RoIvw4gmdB0V3tp91Z3SflKx+LGRuMVq
         Rs/ujpXWxKj8EZJo7b1lWZWp6HEfbhJS6jfwJ3s4uuO+gyVz82pJUKYypH6zYellGJCN
         cS2A==
X-Gm-Message-State: APjAAAXru0W1/2SaGsaNG18BHpsUTTqK26Ut0pOCmEZnaKFjxE+gyD80
        VW3vz80o313Qp56Kh0zglr0cpw==
X-Google-Smtp-Source: APXvYqz6DfHxlTZonMpH8LVbU+iwOS6IKXyO8Sgapw96CLMkctoR80hr0zVTngzcA8rF3N4zp7wpqg==
X-Received: by 2002:adf:e692:: with SMTP id r18mr24460580wrm.231.1553682796331;
        Wed, 27 Mar 2019 03:33:16 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a20sm27017513wmb.17.2019.03.27.03.33.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Mar 2019 03:33:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 5/6] dt-bindings: arm: amlogic: add Odroid-N2 binding
Date:   Wed, 27 Mar 2019 11:33:07 +0100
Message-Id: <20190327103308.25058-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190327103308.25058-1-narmstrong@baylibre.com>
References: <20190327103308.25058-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
from HardKernel.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/arm/amlogic.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.txt b/Documentation/devicetree/bindings/arm/amlogic.txt
index 94bbcc646e10..eff41128268e 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.txt
+++ b/Documentation/devicetree/bindings/arm/amlogic.txt
@@ -116,6 +116,8 @@ Board compatible values (alphabetically, grouped by SoC):
   - "amediatech,x96-max" (Meson g12a s905x2)
   - "seirobotics,sei510" (Meson g12a s905x2)
 
+  - "hardkernel,odroid-n2" (Meson g12b s922x)
+
 Amlogic Meson Firmware registers Interface
 ------------------------------------------
 
-- 
2.21.0

