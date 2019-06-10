Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086B4C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D068320868
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 09:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="KZSI8mtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbfFJJac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 05:30:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39231 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388910AbfFJJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 05:30:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so5750437wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SwJw3j7/7gnElwksFcendAVLydFxmN7dLijaWX2YTuk=;
        b=KZSI8mtVLDmfWFKHeculnx3pQhWjeomoz92Kvj0hEjAn4j99lQpDa42qJtIglBAzDg
         M5tvyDV2P5ZJQq7LvoWuElO8WpIz1k5sWPrsHcIlhIH7ns0u24a7KWLeWshMK/LoJGeh
         ARlATeqT/53AVvm+L4iS3jGee7ggWoBuJON9KWj07SEWLjssNTNGP7fH1PJQx/GjNkZc
         fz7XSIUWi73sdV65I6ctQC8Zs//rStasSGECPzp0C925IRzv5x5Gvyiq4EcEF2NQOZGV
         7mCJCgYdZRvsV7tftKkek+7b9tEtct8q2B5eMY+9K1iElLioHP5bJ7HVyoNIXsO5K4ZO
         2+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SwJw3j7/7gnElwksFcendAVLydFxmN7dLijaWX2YTuk=;
        b=niIZcRJr9hAYBA7w8eFE569QRt/MyEek+XHle8CnIrmIL+O9Lm86tCwKwGQU5PI6Kw
         lD2MEekMz1MBPkvi8Oiw9UC7XdivPROZ04SmM0Pw2L7Xezk84dfbebhfSgVc2DLb9EmI
         P0+ZQwcldJpbRREZKALSXQEVSdY92cGmoQXdnZE7hCSERSVDGxkNpHpzr/7cFe2u08Ou
         qx3zvpn8Z+3jfqDyYbyJsOdux1e5OzLkp6VSs49J5Q1Np+3lxfwifD9D3adR7jnaSJ+D
         oyUatk6iURBEa/1qBUGdrBFkIiBbHl9M6ope539L7nzmLieNmngws2dJB2iW1GTEh/Eg
         rZJQ==
X-Gm-Message-State: APjAAAXFxaaFj8LjEQIEKXFHQ8gZrJsD+PLqj/lVCxw0+MX0nWCsvqUc
        BLRk7NUtOZYdynW6d+E0r6DamA==
X-Google-Smtp-Source: APXvYqyp16e0fd32IZJUm1h/bwNECayAr89DfYqv93+JSv43LKn4yVOBrY/u2r8Aded7JI70uzl/zQ==
X-Received: by 2002:adf:f50c:: with SMTP id q12mr16830734wro.300.1560159030618;
        Mon, 10 Jun 2019 02:30:30 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j123sm11881943wmb.32.2019.06.10.02.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 02:30:30 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, jic23@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io, dmitry.torokhov@gmail.com,
        linux-input@vger.kernel.org,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 1/3] dt-bindings: Add pixart vendor
Date:   Mon, 10 Jun 2019 11:29:43 +0200
Message-Id: <20190610092945.6330-2-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190610092945.6330-1-amergnat@baylibre.com>
References: <20190610092945.6330-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PixArt Imaging Inc. is expertized in CMOS image sensors (CIS),
capacitive touch controllers and related imaging application development.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 33a65a45e319..ac5060e8de8d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -661,6 +661,8 @@ patternProperties:
     description: Picochip Ltd
   "^pine64,.*":
     description: Pine64
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":
-- 
2.17.1

