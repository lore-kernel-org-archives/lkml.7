Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F130C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A2221872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vy7I7i7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbfHZUpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:19 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36491 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731535AbfHZUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:18 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so795213wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v0Q9LIYPLT9Xb7NvIePpDRDG5Nr2ZHct1pfdK6Hsxio=;
        b=vy7I7i7S9FlvZ0b7EumKVxLiBMBpKHKQiYAtIonVY+8p6F+86IuWJSe2EQrzseCoim
         /962hHWAX71X/Z9xnmVkOMSJuxnPT58lNz6Rq4aAue+g6DGGRGJysWNzUrHi9RBVKs9v
         WBTviGTDmb5qhKP3HgN6OKAQh8KXVDzTVZtse5ZLrgVnVz1BfbxOXgygmC0+nnshbDgE
         aOIRPI+1L5lQWRTMnTADfYj46ZkU+kuprPgsh/+7MOd/BL8OVtThD0o2/5Vm9h0S8DVa
         RZmlU2v4QlJ1JucV+7f8X9e+8LS8BnZQt8TamK4JIUiE/cLiiUu7tdYLv8VBj8h1v4+j
         g0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v0Q9LIYPLT9Xb7NvIePpDRDG5Nr2ZHct1pfdK6Hsxio=;
        b=ZkaRLMrDDqa0fKGfwhQ5bPXPPpVcJYTq1EZfu5Y3fOs9MtwQWy2bDKRKTEARxtgTwz
         dmVaRPHnEXvMS4CwvUMQPXte8G/EZsaY5k1dJ8/GTOruOirSjaBIzaXfvFmROMvDLlmh
         Teiu0+Oerw2x/UGC9NDzaEnOrM19JU3P2zfKGVSEc1NFG0zmjKbU3dOcyczI7KRbJE+I
         ndLhLzr/in8GtquyRmE5XZXL3eI8fbF7Q0SgbLR9Rf+mvJQRFnfPYYH7psnsKlpSfwPA
         oBraphKXOSfFOuYkrNfukQ9WPjdrpSQ/8iQBHCFdlR89Dq2503+BWLtZQLX4H7a0CbND
         tr7w==
X-Gm-Message-State: APjAAAVzhKl4+T/pOs/Tu8AIRFKs9nA3aORF/wIsSDEgVXzUw1Y5BKeK
        NQGrwM7/QYZfhkldjV5l+6z4eQ==
X-Google-Smtp-Source: APXvYqx58no0JlkS5nCZ70e7Qe3bjG/IHL/TSLf9TID1ZhNUfB9M6MjycO+zkc53qOEiUFTqpmyccw==
X-Received: by 2002:a05:600c:254a:: with SMTP id e10mr25254651wma.113.1566852315736;
        Mon, 26 Aug 2019 13:45:15 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:14 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Magnus Damm <damm+renesas@opensource.se>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH 16/20] dt-bindings: timer: renesas, cmt: Add CMT0 and CMT1 to r8a7792
Date:   Mon, 26 Aug 2019 22:44:03 +0200
Message-Id: <20190826204407.17759-16-daniel.lezcano@linaro.org>
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
the R-Car Gen2 V2H (r8a7792) SoC.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/renesas,cmt.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
index a297fca5b61e..5b7690ae8b9d 100644
--- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
@@ -35,6 +35,8 @@ Required Properties:
     - "renesas,r8a7790-cmt1" for the 48-bit CMT1 device included in r8a7790.
     - "renesas,r8a7791-cmt0" for the 32-bit CMT0 device included in r8a7791.
     - "renesas,r8a7791-cmt1" for the 48-bit CMT1 device included in r8a7791.
+    - "renesas,r8a7792-cmt0" for the 32-bit CMT0 device included in r8a7792.
+    - "renesas,r8a7792-cmt1" for the 48-bit CMT1 device included in r8a7792.
     - "renesas,r8a7793-cmt0" for the 32-bit CMT0 device included in r8a7793.
     - "renesas,r8a7793-cmt1" for the 48-bit CMT1 device included in r8a7793.
     - "renesas,r8a7794-cmt0" for the 32-bit CMT0 device included in r8a7794.
-- 
2.17.1

