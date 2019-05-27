Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18710C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FE820717
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="C3tyRMtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfE0OCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:02:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42044 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfE0OCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:02:13 -0400
Received: by mail-wr1-f65.google.com with SMTP id l2so17055791wrb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=flCBkYYx+PdHsv3XsjTv06FvsWqxIYgVPOMABFKuON0=;
        b=C3tyRMtkKESDLxtFYlgpiQcewolwEMTiUIVBDr7x3PEKYiuhwu9mydcq7rXOn2Zpj+
         OsuMTPvCWBndgt6LyHD0GA9FYGZQeIC47jc5XYgtkPzOviz/fiWEo0zQt2lrwinFXRw7
         AOQywD7O3Vz97NW2v2vgrY16D0cQXyYbwglSDfrHpxFOcRWboS0TlNGFqJTFo22D8jYV
         wbyfqlGLlr9AaDpY+9idLlBePOMCpeDmzG9oyYN3hWqijW5KY8HYkIsk+VnI/TjhtkxB
         uhWxJU59bNUzA8PmH5dgVa+CBC3ElbIPx/+MJT47AzpEUlGHGncZEGtkj+UEBoF5OS5n
         rlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=flCBkYYx+PdHsv3XsjTv06FvsWqxIYgVPOMABFKuON0=;
        b=Q+hdS5SGyFSpOroVPnbht2EHgBpK4If1WZZqZiy9C//o7+f8qc8NVy4m83ZRQUfVIt
         ybmnNl5n+QVoPNUut6fzp9/eUe9kccgMyxT5gNqOKUsCTL6sKuLLuNsw8VDebtylEQ88
         XkiIIjYL1sUMPS0iZwqbpXjGxoAxil6D+muEgjJqiKn7sKMl7xU3Cel6mM2zf5EixzZc
         Kts1gwwiJ3WNkORGsvkHJUN7CYU41htxMIJTbbjM5fjhpmR1OzjqnmQ0sqaosVyqE4xh
         +zxPOlO9ZyuVr6ClWaUZ2msvfn2LYi9IkaLdGym2flmoQpZFb3cDGtmdQ0jRFFPrUbms
         iHTw==
X-Gm-Message-State: APjAAAXKj0ENr8EW4bmNh3TO1r+1JBw6eCGSbsiAdD3LZMK+cYFbhcs2
        hzMpWQujK3abVHR7w15M00Z+Fw==
X-Google-Smtp-Source: APXvYqzB79oAEKLqaqNxNAfhu1XtKKfKofuiCpo+cHunEcCqE0tpQhb0Z0CVOVDbv88FoAnNyf/Ytw==
X-Received: by 2002:adf:fc92:: with SMTP id g18mr11215057wrr.174.1558965731559;
        Mon, 27 May 2019 07:02:11 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s17sm8231628wmj.15.2019.05.27.07.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 07:02:10 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 1/3] dt-bindings: arm: amlogic: add G12B bindings
Date:   Mon, 27 May 2019 16:02:04 +0200
Message-Id: <20190527140206.30392-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527140206.30392-1-narmstrong@baylibre.com>
References: <20190527140206.30392-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B SoC, sharing most of the
features and architecture with the G12A SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 6d5bb493db03..28115dd49f96 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -137,4 +137,8 @@ properties:
               - amlogic,u200
           - const: amlogic,g12a
 
+      - description: Boards with the Amlogic Meson G12B S922X SoC
+        items:
+          - const: amlogic,g12b
+
 ...
-- 
2.21.0

