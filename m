Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B76AC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB9B2178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 10:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PXCijcCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbfKHKNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 05:13:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45587 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfKHKNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 05:13:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so1038639wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2019 02:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=cU3L2BBWe8lA2LWE7gRXOVYyqfxgb1FEIKhotYOu9Xk=;
        b=PXCijcCcFDJnq59ddsvYjds27Zng22aFdWDWqJdpNGJIMHInEgrmbDnllDSDlpseVv
         ndv7yrifX9deROcU0bVxOwT22xYXQu9hh3qu6HtK1LKytptdkfMwhiOLlxuozEs7fDX7
         ekcbINwgFnIB1f3PYGXxtvrsVTGVqwc9fO4FE6rLLPlcMsXG0LdGB3K20jbqhsO8+Izr
         ZO9nT9X73Ks4swESUuATZx0VOTBixpPG8QnDSKKc6TEjkDIxbZpUc9BWOEOymq2lQzur
         n5SxVbKa15+zLCTN+BvD9PsOP91lfz5uW/edkJ5CODwQsSuAlsIX8dO85SkJcJC9o7z0
         WKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cU3L2BBWe8lA2LWE7gRXOVYyqfxgb1FEIKhotYOu9Xk=;
        b=X19vxlcq32oEPwUQZwFFlv/ufMIk+a8Vb8/gBjJpzQzmbuqLGEn/iXOE0Lf/iZ2v/b
         S+Jjvx4j9uyxp4Unf+a741naAqkVtRa5/4bZnWDIbAb6zmGjTW66uWDq0jJQ3FS37CrE
         1rjp9/JwCfl1A+ZvziQk/XGCr1vMOloWwy1x6l7MgNp9L3I61MVwFtzgpHPJ85aUv14X
         d9uTZMNIiu9/D55Z/NgM3a4+8l7I2Mpt16kpzyXmKlq+CgDzaAHwRVz/MvUFcVRDhUan
         vzhCHaiU3BGSJzPRRhoUgf8EZmC/6gUVG2VXZbBWNvJSg7AjViFs7GNRDiRACdACQ10k
         yWtg==
X-Gm-Message-State: APjAAAWtam+6DXomeVUrHthTWAyGUXNvFVIfc9mkKMlDYF7DstJ0YcDA
        H2YzDGqx3/cKOXKF5ge45yaZ80Ql834=
X-Google-Smtp-Source: APXvYqy54qoamMo6mHEiIaRis19DIgx8N4yy7Hc7RiXAPhgRu6JpxysgeEp8fI0vT1GFn/Qpj7mQfg==
X-Received: by 2002:adf:f4c9:: with SMTP id h9mr7041901wrp.354.1573207995337;
        Fri, 08 Nov 2019 02:13:15 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id a11sm5762163wmh.40.2019.11.08.02.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Nov 2019 02:13:14 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] MAINTAINERS: add linux-amlogic list for amlogic crypto
Date:   Fri,  8 Nov 2019 10:13:06 +0000
Message-Id: <1573207986-26787-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-amlogic mailing list need to be in copy of all patch for the amlogic crypto.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c4c532c70b86..ec1c71dba03d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1488,6 +1488,7 @@ N:	meson
 ARM/Amlogic Meson SoC Crypto Drivers
 M:	Corentin Labbe <clabbe@baylibre.com>
 L:	linux-crypto@vger.kernel.org
+L:	linux-amlogic@lists.infradead.org
 S:	Maintained
 F:	drivers/crypto/amlogic/
 F:	Documentation/devicetree/bindings/crypto/amlogic*
-- 
2.23.0

