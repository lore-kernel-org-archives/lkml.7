Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AC7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD092064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FqIyQ9au"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbfDDPFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:05:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36311 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729224AbfDDPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:05:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so3820459wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bInNvpdWwB8SzqqGmXY3uxa+isS0spqIYrGtdkeVxUk=;
        b=FqIyQ9auGcvuYUZPgN5keoYhi1UJHIuVbbfmsOIOimv6RzZ7QUWf3Mn5SlLZuzAgK4
         sw5tCWLo1AnJKFlFjryms9sApDxElcSkF7XofC5hQouUy3JUJIG1txRjZjQ+TNGR/r1f
         W1RK0L2NLlr8exOY3kNmbOL3LSH/Yp6UqpWPGSTU9mRZYiM69SswkXgbiIfZb7qKggWv
         NmQnndra6cgqbyCAYDHZqluQ7N1fclNddoAoAIqHLYLQtjUAocyXh6fpebc08DHNiZOj
         3y/CTqS/2Z0trErPnrWNh/fh238xu/2o0z/BBlhh+Rrn/bVd2GQ+76nky8kohE9KiYme
         4b2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bInNvpdWwB8SzqqGmXY3uxa+isS0spqIYrGtdkeVxUk=;
        b=kJogUmkILfVYvqmtyJPZYVwq6VwImoJi6kbS6TOmewCVwWJiI2SxHy2TEOalVxturE
         ajsEa82G7wbJPULpW2zBjGqHjwARO1zf1SRrbgHwalPNY4dM+aBg5xefSmCQKjZyBSP9
         WdOk5x38q1pn6OU+q/UG3K6aE2V9UU9nT8r0BYnEWfFOVMbXWE230IR2Neu8ZSs2XYrJ
         AwhwJxFRVyX/yX2ocNTYoLn2UinPcHr/jB6O2LZ5g8srIVQ+1dkDf9SqWde0vW7OAOu2
         gX5onL0vYqs6CRwv1nLYfE0d6elaWHT4GsOveYj8sP/8nhn5VXy2i/rlEplDz1wc3cAm
         WaKg==
X-Gm-Message-State: APjAAAXOZWfJWnpL4AdC2uJBkrwWiLhOmUX65vlOWp2SJHi1NFyQHFf7
        +FLFGyBUpr271YNrF+Wb0svArg==
X-Google-Smtp-Source: APXvYqwUgrIXls8oZpziEumTbZJlMjDOQ4B/kV+4Cm0w8jrUgo/b3K4Ok+aPFGh+/VMiONvtVvEQZQ==
X-Received: by 2002:a1c:f702:: with SMTP id v2mr4748620wmh.0.1554390333574;
        Thu, 04 Apr 2019 08:05:33 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id z23sm9880981wma.0.2019.04.04.08.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 08:05:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org,
        jbrunet@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 1/6] dt-bindings: clk: meson: add g12b periph clock controller bindings
Date:   Thu,  4 Apr 2019 17:05:13 +0200
Message-Id: <20190404150518.30337-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404150518.30337-1-narmstrong@baylibre.com>
References: <20190404150518.30337-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the specific Amlogic G12B clock driver compatible.

G12B clock driver is very close, the main differences are :
- the clock tree is duplicated for the both clusters, and the
  SYS_PLL are swapped between the clusters
- G12A has additional clocks like for CSI an other components

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
index 5c8b105be4d6..6eaa52092313 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-clkc.txt
@@ -10,6 +10,7 @@ Required Properties:
 		"amlogic,gxl-clkc" for GXL and GXM SoC,
 		"amlogic,axg-clkc" for AXG SoC.
 		"amlogic,g12a-clkc" for G12A SoC.
+		"amlogic,g12b-clkc" for G12B SoC.
 - clocks : list of clock phandle, one for each entry clock-names.
 - clock-names : should contain the following:
   * "xtal": the platform xtal
-- 
2.21.0

