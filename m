Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBD4EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CA92182B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 14:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="x2KfGd6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730853AbfFSOU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 10:20:27 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50679 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730502AbfFSOUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 10:20:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so2032991wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZRfugtSiNnnWHk67X3XyWfWdW41BFsMrlORgFvQpHB8=;
        b=x2KfGd6nmTs2XlXpPmXh7Bn5s/ja/yB+ssgQg0K8PWsdCScEmLdoLMyeXSoFjpaU2c
         4vLChCMeHfz8s5eFGW5PWmUuBW+WhFnm6MdC8XbYfCgCgrqb/neFu7MUF5Aphbv3FJbY
         3rpX7PLEp7KhW+13YKd2whUbI7ot5zYfNoe0B2rQHZ3QXyi33+xLFOjUBeH9m9QtCWlg
         0dtmZYSnjUWrEjEN8p6g2UDu0QraU68hCPFzX4gYdLGA+VpECer59BYjvNHnwkbq8+Zq
         MnvCWzR162k/zGLHSPwXFrA2UV+fLwDGOQ+FMLWoIkohfJQbSjqNZ+e5o/kif2t2GPlQ
         tMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZRfugtSiNnnWHk67X3XyWfWdW41BFsMrlORgFvQpHB8=;
        b=o4vScBCB2WovL91AlSHWssFKpwzpLeih9GUdhABsEH+HeR3TjCzY3uNfy978SqvSxy
         h3ffbLW0Vl6ijy8OAun0sOtF6LKDjlL7bjgWn+iskTcdooxfVJSZxUzulSWtt7a7gQRM
         OD5PdeRCYXucsiZW0oO0775Czxrrk8T8DQkNPJ2uz21OsTeBTwMjj14Y+9qaToxpv5+n
         PSUqBz4RjvEK4dsNJMri+sC250USGCUEOazU58IMtEg22BHdVNcmGs16QGHRAEJbYUUg
         B7BSmc6rMSpNVq+F36ECF2WqwqcA5iVmQxGu3Anr8mjMSCVHZPjZH97uPhTX+LhiUlSG
         0fgQ==
X-Gm-Message-State: APjAAAVgoW7PZ3Wue7mSlQMQj7gsul81McbGV4n0/+CDVYWfLhELyYHu
        e0wWhlTSbe3VnWxH4jQM7FCMFA==
X-Google-Smtp-Source: APXvYqxviKVJH2mGeoI0M+JIBXaftgWG3sqGHPq1gzdOJBj4y7cCwom3d0P0PUFpn9jhuZU7bp+zXg==
X-Received: by 2002:a1c:4184:: with SMTP id o126mr8614067wma.68.1560954021233;
        Wed, 19 Jun 2019 07:20:21 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-652-1-281-69.w109-210.abo.wanadoo.fr. [109.210.96.69])
        by smtp.gmail.com with ESMTPSA id o20sm24209979wrh.8.2019.06.19.07.20.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 07:20:20 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, matthias.bgg@gmail.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 3/7] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date:   Wed, 19 Jun 2019 16:20:09 +0200
Message-Id: <20190619142013.20913-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190619142013.20913-1-fparent@baylibre.com>
References: <20190619142013.20913-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

v4:

	* Patch was previously sent separately but merge to this patch series
	  since there is a hard dependency on the MFD patch.

---
 .../devicetree/bindings/input/mtk-pmic-keys.txt       | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
index 2888d07c2ef0..858f78e7262c 100644
--- a/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
+++ b/Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
@@ -1,15 +1,18 @@
-MediaTek MT6397/MT6323 PMIC Keys Device Driver
+MediaTek MT6397/MT6392/MT6323 PMIC Keys Device Driver
 
-There are two key functions provided by MT6397/MT6323 PMIC, pwrkey
+There are two key functions provided by MT6397/MT6392/MT6323 PMIC, pwrkey
 and homekey. The key functions are defined as the subnode of the function
 node provided by MT6397/MT6323 PMIC that is being defined as one kind
 of Muti-Function Device (MFD)
 
-For MT6397/MT6323 MFD bindings see:
+For MT6397/MT6392/MT6323 MFD bindings see:
 Documentation/devicetree/bindings/mfd/mt6397.txt
 
 Required properties:
-- compatible: "mediatek,mt6397-keys" or "mediatek,mt6323-keys"
+- compatible: Should be one of:
+	- "mediatek,mt6397-keys"
+	- "mediatek,mt6392-keys"
+	- "mediatek,mt6323-keys"
 - linux,keycodes: See Documentation/devicetree/bindings/input/keys.txt
 
 Optional Properties:
-- 
2.20.1

