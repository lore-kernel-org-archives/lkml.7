Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64055C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A78320717
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yCtt0wGZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfE0OCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:02:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51789 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE0OCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:02:14 -0400
Received: by mail-wm1-f65.google.com with SMTP id f10so8850957wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rO31uLodqtR0UANwODTPyvdISTtsAPEuGeRxrgglRH8=;
        b=yCtt0wGZdVi1k/2V5asoBDK6Yzs1fm4vO9CA5a2/sfxJNiiymxdYyE3uFDC0zkOrvc
         ydMz9pzk79I3IOes2wxEYa0BstMJIdAcguZkAvWLbXN+t6KXYyksuB0xoFjtVYNQrFxv
         EIPmB9PCO8wEv8tY8xwd4BzgFPk+bGfOwemmo9jjbZWv/KqNNcG3Eix6CMQUXeOyU1YY
         hE5nsT4FVw9deb/lH7/WicXP+XVxnE2fdytGMhoynk5+b9qVPtwI5hJznaof1GEs4hYN
         UBkTW59bZNupnMzY6HWq7KSAXsQNYZukZrvDDPcX9UQXpNx54Ms/BJjK7kxGd45W+rrL
         zlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rO31uLodqtR0UANwODTPyvdISTtsAPEuGeRxrgglRH8=;
        b=WkKDJ1cobg8MT8SYTmCudSux+xfdrrtcR4Mr8JBOI8GSJYk7GBpn7dXdmchPOODh7v
         IA1kIDPSA3vlv4w4YektGekA4H/AF8JF7xF4Q8PcJeHQhP5xpkmuwChy6/F1duIU84bR
         0d0Ks/+8Z+4Fe8lS6UMcUDNTet/+ECGXK3ViTSHJLcApdLV6QFUjP9fi3JNMmKxjTYb+
         LjhWrEH4a4ljRufk6w3wAtDsxctaZ90soz7Vsftr1tagQdVyxgK1oyfNnahoaeuelIs2
         NUQVspZ+aWwedH61n3qGUQv9+/xH+in18rpMowwEdW+yI1h4R9DB0z4bHIt24syPm5+9
         SBYw==
X-Gm-Message-State: APjAAAWOw7HD970wJYz5Vx+G8R0BYx4nLSy6LSqrx3skURLytNVV0VFU
        YInGpuaxx/F+Xczcs3aJIpM+Yw==
X-Google-Smtp-Source: APXvYqz6fMBKbektBh6mgh4wb189td6wyNv3zG8A3t1I2yYon0EbBaq+sRg2X7rkbiVCNCbhyZzQig==
X-Received: by 2002:a1c:1b4a:: with SMTP id b71mr10259602wmb.177.1558965732652;
        Mon, 27 May 2019 07:02:12 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id s17sm8231628wmj.15.2019.05.27.07.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 07:02:11 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 2/3] dt-bindings: arm: amlogic: add Odroid-N2 binding
Date:   Mon, 27 May 2019 16:02:05 +0200
Message-Id: <20190527140206.30392-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190527140206.30392-1-narmstrong@baylibre.com>
References: <20190527140206.30392-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Amlogic G12B (S922X) SoC based Odroid-N2 SBC
from HardKernel.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 28115dd49f96..f75df4471c0a 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -139,6 +139,8 @@ properties:
 
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
+          - enum:
+              - hardkernel,odroid-n2
           - const: amlogic,g12b
 
 ...
-- 
2.21.0

