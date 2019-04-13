Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDA0C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646B920869
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 10:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XkxnmseL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfDMKd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 06:33:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55712 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfDMKd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 06:33:27 -0400
Received: by mail-wm1-f67.google.com with SMTP id o25so14187288wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2019 03:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T0J5b6frF9PSKnQwaC/CfZmJ3RaFOeM0eQnv9XoSRlM=;
        b=XkxnmseLFKacwYdswSjQ4qCQp+zeFnmWLEGrgn2/pSOTciUbLyAuIa8EGeErRB/fkZ
         so5dxln6kihjMX6pdIMYI+Czguc33R34IiYn3HlGKC8C/K+XhVg7v68+aNhrjWXYDNHF
         DHebpuiQTByHBvad12lDMitYSV0CABhlSEdpD92cCQCuKdriYMCFm4f43PQMQMyBypND
         Qf3SnXR2ucEveobqkk3hLHAEZ7F0D45OUf82aXcZdQIG8jF8r6Lg4X6zkGpT99pP1HSo
         7zk+iKkKYy+pBHDrMT8dyLlDpYuQQZwoiRYlFaZA+LRHIjtYtmFc/Eh3ZXWkDnGf0ACX
         LiBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T0J5b6frF9PSKnQwaC/CfZmJ3RaFOeM0eQnv9XoSRlM=;
        b=H2dAcjvcXUTmyWDPMR5cHJz9WRlO1rflavgF+ECn8TD+jpRG0RNhFGIscHUNVJJL4J
         7f/rqFqMooK/h6NGOzDAVCO/2LNAnPk0R25uLr0rtnMMiqZNJJeExEG6vS/mI7qGdbBk
         TnLoWo7ZZu/C4lxC2DmKOm2BYnkiFWM0nD2XfrGGra+MuD/8f7ai3ngpBYMKW5NONgfm
         BWSIlidhGIDi64oc3f5uXfheEASCAku7QgXxtPSbpeBE8s4dsKAw5b7fIbQL4itZBhpY
         TH+LoAuXYRqGHboVdNrEb5B8ud1Uf1sbRj/tLEfpYTeun9iMr06xebSh0SSXmivU5Sqt
         r3Ww==
X-Gm-Message-State: APjAAAW+Rdvaqe8aE7rkYbSXVr0Se5/+Dutqv105wN2K4EZI24uR65H1
        d4PnLi9lwq7bpIxdgxBnXZN+IPs5l/w=
X-Google-Smtp-Source: APXvYqzjSHi7r5CQ1fNw2xrnmf1sr62Kx1A4qn+k466kbkVi8HANsrvEr8cGKoC8L9DE4VqbjivwXQ==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr15636559wme.24.1555151605679;
        Sat, 13 Apr 2019 03:33:25 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u17sm19547303wmu.36.2019.04.13.03.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Apr 2019 03:33:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org
Subject: [RESEND PATCH 18/20] nvmem: sunxi-sid: add binding for H6's SID controller
Date:   Sat, 13 Apr 2019 11:33:03 +0100
Message-Id: <20190413103305.9576-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
References: <20190413103305.9576-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>

Add a binding for H6's SID controller.

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
index d37017e343b1..cfb18b4ef8f7 100644
--- a/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
+++ b/Documentation/devicetree/bindings/nvmem/allwinner,sunxi-sid.txt
@@ -8,6 +8,7 @@ Required properties:
   "allwinner,sun8i-h3-sid"
   "allwinner,sun50i-a64-sid"
   "allwinner,sun50i-h5-sid"
+  "allwinner,sun50i-h6-sid"
 
 - reg: Should contain registers location and length
 
-- 
2.21.0

