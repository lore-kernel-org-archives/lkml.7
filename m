Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CF2C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41966208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 13:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCYbaaoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbfEVNQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 09:16:24 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:33688 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729171AbfEVNQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 09:16:23 -0400
Received: by mail-pl1-f175.google.com with SMTP id g21so1084705plq.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 06:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SOja6zqPN99/TlARSAlHzPeJdNcxfVK04/w1hxpH3MY=;
        b=lCYbaaocmA8VEskB3jrpVdSD5Ipzt8wpR49VsnAaXwjgmwZDoztzUTWCsCg+s6X2Kt
         AsiMmMp541wFD1sSxYOeb/r1ZyEqQpD98y3JHFZO4GjTcForJ2tN1s4QF+flYxY67KJ9
         AIO0QWpQXMOT7jyRZSV1bW8c9ipuZqV21a06ZYntxN+sx6GDfwtlVVeMNSj08nYquODO
         LddSX6WmcGJu8GXdsPD5BlOu6Vx1NkSHmnlyycpHc2ylfGo0ewlNZgLKyY6sHhQzZfQe
         G3Xz4p4G5dBclug699MLb3EVBcUfJm6r/qk+Hyv2S9lLMCdXv88ZG9LDg1XyZReHyyQm
         4p1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SOja6zqPN99/TlARSAlHzPeJdNcxfVK04/w1hxpH3MY=;
        b=DM5AXBx9LGNr9KM36x03ZZ3YVzaVI21aaoAfrg2C2UV2bItudyo/kS08NlXqv+i04j
         NC12zktCBhsDm6/rEjx6pg4zEfNqeRKRLyRyQTnovGJep41f5RB6LYCrUgeigJ8cni6O
         vnNx/mireFTbTPXgxPYHFqAKRkioZy7c9OoFzMwjj+if6YElSehgymnC5FvAk6Fcxd15
         r3CVU6tDQHTaReDoNI/sKce1pkP2+V4n55bX7ergwTFZ57zSMV3+gKVXS0crBBopz0QX
         xQzfXi+kcwKFKOWbYn0rb3Mmag1HzQjIuCUIEXPuP/PSGuroPInzpU5cam6Z35sFFZSo
         97jQ==
X-Gm-Message-State: APjAAAXucabqiEH9HMk75qunCAmhTF1x9mUaBkJpAwuo41GZ4n+QfQg+
        l8o2k85Yh87EX7PVKncc2NrG
X-Google-Smtp-Source: APXvYqwXHuqmUWgB39qseJ8piAj5qG/SLqw3JwF4ubtMTY0LOxy4i/1zTs0Eqn+oRbZURef/N9kqkw==
X-Received: by 2002:a17:902:bd46:: with SMTP id b6mr29151656plx.173.1558530983212;
        Wed, 22 May 2019 06:16:23 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c4:1ab0:ac45:9c21:7eb3:888a])
        by smtp.gmail.com with ESMTPSA id b7sm22273565pgq.71.2019.05.22.06.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 06:16:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, robh+dt@kernel.org,
        festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, pbrobinson@gmail.com,
        yossi@novtech.com, nazik@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] dt-bindings: arm: Document 96Boards Meerkat96 devicetree binding
Date:   Wed, 22 May 2019 18:45:49 +0530
Message-Id: <20190522131550.9034-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522131550.9034-1-manivannan.sadhasivam@linaro.org>
References: <20190522131550.9034-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document 96Boards Meerkat96 devicetree binding based on i.MX7D SoC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 7e2cd6ad26bd..dcd6c90b0cef 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -141,6 +141,7 @@ properties:
         items:
           - enum:
               - fsl,imx7d-sdb             # i.MX7 SabreSD Board
+              - novtech,imx7d-meerkat96   # i.MX7 Meerkat96 Board
           - const: fsl,imx7d
 
       - description:
-- 
2.17.1

