Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB0C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6576221743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ZdzRHhNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfEUPUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:20:08 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42332 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728726AbfEUPT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:19:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id l2so19079646wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vhkCArdSYp19WRy9pHtDkpRiGu4ocnCtsFxZgKHOrQQ=;
        b=ZdzRHhNgFLRHQR2KIcm6dzqe1zFhhkXiYls6dlf6D0mkFq02TpZrZ2l+l4r75FvB0v
         m4JTBZwT8qCdcC88C+fXX6a8njfGpjqV9qvC0JKB2cddv12E4/a8/lAgFsVFSPzQ1rBR
         ZXL+sA089J4vbDi/TfRsJXTWmnzY2bOxPWFxnTaaF5fLuf+ZICJ7f5x0LsKUyOL545JK
         XgbN8tMu7pvfgSSACiloqxRp+TQy2HQq2cGYLE11rSl8SWGkOqxqKfdex0fPdwgW7ihJ
         2RG/iudUEiUaVpyAU0wOUCv/tL1kzCqe1EilyLOC3uMtPMPXyteLlUMS4TSRPWihE6ie
         Iosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vhkCArdSYp19WRy9pHtDkpRiGu4ocnCtsFxZgKHOrQQ=;
        b=ObRq17MynM0+e+JsZ9XG2/ori7ZyfjlLv7MyVXPRr2Eu0E99VCB45PH5G3cQSAblUP
         WvZIwk/krPvkefc6qMFXXYheALb5dJcnLXyxLqs/n2rjvLGXKPtLxQ6bJg0rmBe4xUfy
         gshaK8CG7GypmwxdQY7gJMOxd2Yy/RJCrvsDRLaFOFpiJxM1dcf9d39fXy9DfIUu//7Y
         FEINcx8wl4TPQH7vrmnU3VjzBQ26K4C48zLwDYIk0sVgaD38t+FvS4ImLTTTZmlv54wY
         olp2pTxMf68lek4ys+tZUoFqvPY8ZA4zOcV/dZx+iKzp/niRSd8I654IwLRM6pZ1RGoy
         LvAw==
X-Gm-Message-State: APjAAAXjw5sTwAAm5beNCKxK5dvi02UumDFFaFLaRPbfKlp9zv4Tp7H4
        /lB1MJMqbTmsxXnaQVOhEReVgA==
X-Google-Smtp-Source: APXvYqyRX+GLakjFp0Eh9cc4c2GsZ6BB2KNHfqbeBehOMfsXhgM9oc/3OwNRrSmb43o1etqmgBN0Nw==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr14666829wrj.230.1558451995591;
        Tue, 21 May 2019 08:19:55 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p17sm3945677wrq.95.2019.05.21.08.19.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 08:19:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/3] dt-bindings: arm: amlogic: add G12B bindings
Date:   Tue, 21 May 2019 17:19:50 +0200
Message-Id: <20190521151952.2779-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521151952.2779-1-narmstrong@baylibre.com>
References: <20190521151952.2779-1-narmstrong@baylibre.com>
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
Rob, Martin,

I converted the patch you acked in yaml, I kept the Reviewed-by,
is it ok for you ?

Neil

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

