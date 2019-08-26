Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F53C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C862184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEDRSS3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731717AbfHZUpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45870 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731462AbfHZUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:20 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so16556527wrj.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xx6zXzgb0vSpbhX3JZnxws+z9jl06fZin+m9UbiBa6U=;
        b=CEDRSS3J1v//1C8W0S/Dm2bDZoR3U7cM6SpNQPaC9aCNkRuGvkpUnVguzMnLDlfW9y
         Zdda6LAOMYaBAwO2eF0g/pl/luDQcohjoDKyATRtyX3XqDNHXZHA/oyF8ICWyCeTCqgY
         mdBron9n4N1xk805CkMnqK5lhWChg56DyLUwO0TmhqBmy/Flc4jh399CLyogsXoP2O1/
         N9gdTF0x6jCLgr4StWZI9S4Jx/xHewzOzzLJ4LsrGPeYkbyp3D1lMQ2+Aq9IrAgSNiH0
         Ir7KGWT9WSe6afAge8Ezu24kz49v+UAbzcTUns/Vjo/WZexcEJErxHmOj8rPeOqe0Mj9
         ae8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xx6zXzgb0vSpbhX3JZnxws+z9jl06fZin+m9UbiBa6U=;
        b=Jx/zBsDvqOjjD8PBYbq3UdhZ04ezBi6F+TYASv+tRZPOgIfDsGiBRg1M+5kL3prO3y
         oh2X6tTDDdcnwZJOeQcAHSWnPnj3BYlts7s4N6pYayh4bFtXC4F5th+e6sOQ4CdCuyCe
         /xUQg9lAh7M5VYsVDGX1xAgnBjoUnr/QlStysLvfIIzvFtH/V+dESr85SAvunH6iPDHf
         CWAcEHKR/JgV5vwuw6Xs6Z340yXLOAYxsl9D1LkSEkoQR6EclnDv0r2zVJmRIdQUh3d3
         2fA5nA67g8vTMIyWhbaSKxg6/tTc5MWEXMWwI/YuelTAUSTJEwlCE8lfcYMF53TpNMcn
         bZKQ==
X-Gm-Message-State: APjAAAXS+MOO+NQDDaT4MNZRlRfMAY79PZZUSPyKDRLEhagcCOi5jZ54
        TpgAWBgIWf/80pUSfIIheeIzPw==
X-Google-Smtp-Source: APXvYqyKb/Ydh+Yo49Z9t8rzx1TpEZs8J7o69uD7rzcHk8L7zl3KYr/n2nJWtOBEAFJUNY/k3TFrTA==
X-Received: by 2002:a5d:6a45:: with SMTP id t5mr23999753wrw.228.1566852317991;
        Mon, 26 Aug 2019 13:45:17 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:16 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Magnus Damm <damm+renesas@opensource.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 17/20] dt-bindings: timer: renesas, cmt: Add CMT0 and CMT1 to r8a77995
Date:   Mon, 26 Aug 2019 22:44:04 +0200
Message-Id: <20190826204407.17759-17-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This patch adds DT binding documentation for the CMT devices on
the R-Car Gen3 D3 (r8a77995) SoC.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index 5b7690ae8b9d..c7fdcb02e083 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -53,6 +53,8 @@ Required Properties:
     - "renesas,r8a77980-cmt1" for the 48-bit CMT1 device included in r8a77980.
     - "renesas,r8a77990-cmt0" for the 32-bit CMT0 device included in r8a77990.
     - "renesas,r8a77990-cmt1" for the 48-bit CMT1 device included in r8a77990.
+    - "renesas,r8a77995-cmt0" for the 32-bit CMT0 device included in r8a77995.
+    - "renesas,r8a77995-cmt1" for the 48-bit CMT1 device included in r8a77995.
     - "renesas,sh73a0-cmt0" for the 32-bit CMT0 device included in sh73a0.
     - "renesas,sh73a0-cmt1" for the 48-bit CMT1 device included in sh73a0.
     - "renesas,sh73a0-cmt2" for the 32-bit CMT2 device included in sh73a0.
-- 
2.17.1

