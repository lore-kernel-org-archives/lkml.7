Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EA3C352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:21:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AE882246B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 07:21:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XU5TSTRz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJBHU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 03:20:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53730 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfJBHU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 03:20:57 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so5915366wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 00:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8FodZSxtce/9VbKtIxl8y+chzA0F3ci9cGAB2QwiVA=;
        b=XU5TSTRzztZCfDtqzfe7LtjkiX2LxGtZy0/TpyNMpWmwxkl+yCZZMGHT1r+8L19cWp
         Qmxgw/1gpclM/V1M0uJlsVr6BOoBiWe8cva5Pb3wnlPKKTpwrrrdRp2J+U5AtQMWeb9G
         wAGdAuJif6QYDLIUd3q2zaq1L4lFPCRbrRzYlFc8TvMeCpG+4OJFaJvYL4tXp/OvsWBZ
         qinBB0p/YP0ya6k/46fyOUQyKiPuPKNEqBet4e3oCtljlbyXAvZATFdl2jGDnKA2/QcN
         XSQxHJOJIBs067Ac6vJqq8rYgBZmlX3f9yGCO7vuna6h6yDOhF3yWqCwrQ9gi93deCBc
         Ii/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8FodZSxtce/9VbKtIxl8y+chzA0F3ci9cGAB2QwiVA=;
        b=JMMDtywWAVnIPRjCjvu7yyjdLbDHiq6/SQcjylwMxQEjVS1gpPBK/u2RHcAjTpOSfk
         VsbY0oEnCx3QqU72SQpRKCzSx3bXfZ6Cl1SSq36jKPswntx4DiUjpaPUeUtOcGpEPlx1
         zKK1joZZdTPemznZ+EDPeLYJshZVL7SOLFDD5ClDxlpavdkgQ+8G3OjqazFgKQ3170/h
         0XShwLgfJF8Zll5ZcgE+BK90Lr8uA/Ba0qbHJ9IDLUDYsip69oxUPQ/RB/HLQbAmTXDU
         uaqbLGqL5qBRytm4vXCJ/x5qU8iclCc2LURBvN+jTKx4+9IETQH0hz7YxMMdcyx5N8fd
         MC6w==
X-Gm-Message-State: APjAAAWoHxoV4IERqcZ8nR0rdWH/bo0jx5HoS74AZmVJyslhi/Lfz/t0
        G2IemkJVIFq1kvvzQ+tP9ld2QA==
X-Google-Smtp-Source: APXvYqwpmmYPeIWFm5Mj5G5MRqI9fjHcBbdi1XfHC6f/7VKAtRbHeKSKd+0gQv+rgNHvnNitkiKcrw==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr1607834wmj.121.1570000854142;
        Wed, 02 Oct 2019 00:20:54 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id n18sm3850640wmi.20.2019.10.02.00.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 00:20:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Rosin <peda@axentia.se>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/2] dt-bindings: at24: add new compatible
Date:   Wed,  2 Oct 2019 09:20:47 +0200
Message-Id: <20191002072047.20895-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191002072047.20895-1-brgl@bgdev.pl>
References: <20191002072047.20895-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

arch/arm/boot/dts/at91-dvk_som60.dt.yaml uses the compatible string
'giantec,gt24c32a' for an at24 EEPROM with a fallback to 'atmel,24c32'.

Add this model as a special case to the binding document.

Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 Documentation/devicetree/bindings/eeprom/at24.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/eeprom/at24.yaml b/Documentation/devicetree/bindings/eeprom/at24.yaml
index c56f27fde3b3..e8778560d966 100644
--- a/Documentation/devicetree/bindings/eeprom/at24.yaml
+++ b/Documentation/devicetree/bindings/eeprom/at24.yaml
@@ -107,6 +107,9 @@ properties:
       - items:
           - const: renesas,r1ex24016
           - const: atmel,24c16
+      - items:
+          - const: giantec,gt24c32a
+          - const: atmel,24c32
       - items:
           - const: renesas,r1ex24128
           - const: atmel,24c128
-- 
2.23.0

