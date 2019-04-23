Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A39EC206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 09:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Xf0DC2Ny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfDWJP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 05:15:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43905 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfDWJPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 05:15:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so19179271wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 02:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Af+jmp4TxV/QvWrI8cMBNBX8b92F7d39H2RU/VUPuWE=;
        b=Xf0DC2Nyd4c7T3jzYzomlXi42Uw0hJDWS5xsYVLq1SYRxJKc0uaBrbdHILyCN7Uv24
         /Vbdn/VG/vFF/05d3ymbai8xGOdsZ1QXfVfM6JEJJtu3bpyXNDFIzIdQzFSVbi+n6Dr7
         txuRrFg+fuxmVCFGxKDC/lIPOEQUjEQFoahxn7WzZoOiciBoPwI14u/u0Wb4jeBq3M+U
         pR2wOSVyQFnHB3hWcoFvn+V/DsNwZ4/c2SwzcEGKrsJB5a163+L2xr08YG8V7+B62Rej
         bzUWECHdxrRLd2QE03pKztQ1U3CUa/my5icnDDISqLJWF49YetfRDwvKkapVE5krIS8w
         S2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Af+jmp4TxV/QvWrI8cMBNBX8b92F7d39H2RU/VUPuWE=;
        b=Qr+ICEpFKc/xYnliuwD7B+0RGZiLqe21ckAzMyi5rzMTAruyb2DcpiNMjw7jO+KrbQ
         CuvTt7BR67e3R/aNMAiJGPSWhD0xnl6RfC8nci9jo6gBOnioMIL6RIHK1kM0V7D3N6Lt
         D91T5mwYX/zJ1SG/leSiWJk5lqyUAvOVYR2vezROrXSgWhJaTW51ehiwcnOhq8dT9zqC
         qpNRMMc2dKZ/Bq1x72x+tVtF3lTWBBCmXQbxkySgy7kjkqJx1+OUjl/Z6wkJfkdveGq/
         05lzt4XPtbqkO4g5rgYtHyX4SF338JRzOnh1GuKwoAQZcgvuaAJwWyEhLwqyjxPtPJ4X
         FhlQ==
X-Gm-Message-State: APjAAAU6cKRs8EcSDZVQvryKfhw9pfjmgD127lCfyODM4KdTP1Kmyz65
        6nUT3vlG5C9mC0piCehpJHZ+4w==
X-Google-Smtp-Source: APXvYqxr3NuSkorOvc3NRetbaScHHrW/tcjCzGJC3wPfQVS3XV0ehPIG9WmxU9tUS8KVUot9JWuJjA==
X-Received: by 2002:adf:dbcc:: with SMTP id e12mr14411195wrj.134.1556010913995;
        Tue, 23 Apr 2019 02:15:13 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id t17sm12241272wrr.26.2019.04.23.02.15.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 23 Apr 2019 02:15:12 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org,
        jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 5/6] dt-bindings: arm: amlogic: add Odroid-N2 binding
Date:   Tue, 23 Apr 2019 11:15:02 +0200
Message-Id: <20190423091503.10847-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190423091503.10847-1-narmstrong@baylibre.com>
References: <20190423091503.10847-1-narmstrong@baylibre.com>
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

