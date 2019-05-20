Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B737CC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C24020815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 08:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eh592mys"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbfETIbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 04:31:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39609 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbfETIbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 04:31:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id z26so6861507pfg.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 01:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDxVfW0Drk7B/WkdvCIQOYRuq9nRhmzNbEq0alSDlGc=;
        b=eh592mysWWaYmUlTdrJu5JmfPhAPRF044bjHqVn0RRF+Cc2Qvpf8BdsBT/qFoMgXr2
         5WYW6pVaaaLsonApbGcCNPZ64vDP375PnN9spMsi/O/4+77Pa5K5j+U0G1JW8Hdlyk26
         ZaQGBEK8AmtDo3XTJyJ/tr1m7f1jRs8XBBzfie8q34ToPxL2G5ZgqZta6ZbrlNa0QKBP
         9+5BtOhM+2XG1ULJyQ48cve2UX73EL2Pf0oCJiVjDqWl2NMnFFNFgylX31O0ATpjy7It
         F0a3ZSGbmOfL7Ps8dHG3idQuEu8vAl7OWF/agtQUTaHdNgLG8oZuNVZB47QJDzevNA+4
         Zztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDxVfW0Drk7B/WkdvCIQOYRuq9nRhmzNbEq0alSDlGc=;
        b=WVRaVn2ADdOOqP959y4tZywgXFXYEz9AeL3nOPzl5UYXQn/oKFLtZM6MSHVLSNn7BA
         fzQT0GYGsjxrivGJXT+3VXVsnUlMLXUUAt9egrFgzesa6WfUTreu99bvg+srYMa+DapX
         50BWXl0Qp9cLX9O/aiyqjGKVamhlUQzXra1FoSiRFdsHVqeWIjMkDrETPLENbq/y0sTr
         xBOSc3kQn4vXJxw59RcLpu/IUrYpnUhObL8GdKg0iw9E1VSYairyHcyFhTRhaNrzuMsl
         w10+Pz4Ade6Vr4rjvqAgCzQ2Lfo9cgd/mgoCBL7sLv9vAkT3VTDhd290rcraSuXfqGDM
         GONg==
X-Gm-Message-State: APjAAAWWUNOarAdwntppovULRvUuANb7KzFYwhQ1D8FLwDy4mpcR+LOF
        goOS571z4+PnvG+JDQadk9Id
X-Google-Smtp-Source: APXvYqwIB4PznKqCQ1cB5xDX9ohSxJ3Q8ajVmP/fHvwxtLD7sXxbiRog+BtNITGhoESjpgVTOlJXAA==
X-Received: by 2002:a63:7909:: with SMTP id u9mr67807558pgc.223.1558341081560;
        Mon, 20 May 2019 01:31:21 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7203:2717:7d22:7fdb:b76e:242c])
        by smtp.gmail.com with ESMTPSA id s72sm24068220pgc.65.2019.05.20.01.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 01:31:21 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linus.walleij@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        haitao.suo@bitmain.com, darren.tsao@bitmain.com,
        linux-gpio@vger.kernel.org, alec.lin@bitmain.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] dt-bindings: pinctrl: Modify pinctrl memory map
Date:   Mon, 20 May 2019 14:00:57 +0530
Message-Id: <20190520083101.10229-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org>
References: <20190520083101.10229-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier, the PWM registers were included as part of the pinctrl memory
map, but this turned to be useless as the muxing is being handled by the
SoC pin controller itself. So, lets modify the pinctrl memory map to
reflect the same.

Fixes: 07b734fbdea2 ("dt-bindings: pinctrl: Add BM1880 pinctrl binding")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt    | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
index ed34bb1ee81c..cc9a89aa4170 100644
--- a/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/bitmain,bm1880-pinctrl.txt
@@ -85,9 +85,9 @@ Required Properties:
                   spi0
 
 Example:
-        pinctrl: pinctrl@50 {
+        pinctrl: pinctrl@400 {
                 compatible = "bitmain,bm1880-pinctrl";
-                reg = <0x50 0x4B0>;
+                reg = <0x400 0x120>;
 
                 pinctrl_uart0_default: uart0-default {
                         pinmux {
-- 
2.17.1

