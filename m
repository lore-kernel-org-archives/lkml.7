Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBD7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D781222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 10:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2ccDoUG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfLSKhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 05:37:38 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35847 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfLSKhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 05:37:33 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so5084509wma.1;
        Thu, 19 Dec 2019 02:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1OGCzyJCrst2owrhk2ZRzZZ6qSHUKtNRJtopFQDCbsw=;
        b=B2ccDoUGkMxCO80QmF5W9iwsdFhTmr2sts5usbCRrkPvh5qTXjbeKAI2lsJUDA3WTh
         10f4LgNyH5xLFiqWtunJ/v2ffVvpP/FvCN8iSS4FiZ0yjYUGleUPJyW2RrxxttsthtV9
         ie4+/WgfQFA6x9sXkBnwzcT2MpN7Wmq36tBReEnOEQMtP1wT2XoAeeCTi38YCXApImUl
         mRcXSZ0O2wKAs9VzY3Rew0i1AMUz/6bZbsHBWD5hhC9Gm0IzrWRZUS7E79nKk3f6Affl
         1zJuJBI1L1cNIH4PzfYo++nXJSL4kCZnH2cuIWLw/ZaMUmpEKNvABqzEAlpSUvdaXLYC
         NJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1OGCzyJCrst2owrhk2ZRzZZ6qSHUKtNRJtopFQDCbsw=;
        b=CcHL/rYg06Y1/Awe95cJ8iNLot9vXOnKKchJcBTrqmdlWEoie21cOTDykSCXShbgKC
         3cIZpqbBVblq1TIx+ODmfZkFi6K1sKKlN3YWOFEe5sbgR4n2uf3gSpHV5JcSedTfsrDF
         DVv31tOXfHFSUIO6up1qiKsRgAFnCWKyiSK+HinhUMShglucrCFlt9d1Y62LN3rZWRKg
         ILLEtlnD4iJGEHqYq6GmbAfj7HK/k/uEFV530QE2HBBnzN1W8X4qd+ksI730U84GH+89
         LuOzpVEucstQgjjdQrPNd+LlqwijtCdKHvNUMIjWXxEywc9HpaQ95HHfog0NKbDjBdwN
         1vGw==
X-Gm-Message-State: APjAAAWAHD/vbaV+6NzdtkW0sG3lRUPxadLbmUDf1xPY6g5JSyGtYHeP
        LAL/JtAeRbmyT2iykZ7xT/w=
X-Google-Smtp-Source: APXvYqzXGUyLsw/d8HZogvct7wS7UZ0HVLfRA4lHFd7hR+zFjnaCtd0fa+P/K1dCYPJduIQWBddgew==
X-Received: by 2002:a7b:c74c:: with SMTP id w12mr9213826wmk.1.1576751851566;
        Thu, 19 Dec 2019 02:37:31 -0800 (PST)
Received: from localhost.localdomain (p5B3F677C.dip0.t-ipconnect.de. [91.63.103.124])
        by smtp.gmail.com with ESMTPSA id c68sm5735147wme.13.2019.12.19.02.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 02:37:31 -0800 (PST)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     sravanhome@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        heiko@sntech.de, shawnguo@kernel.org,
        laurent.pinchart@ideasonboard.com, icenowy@aosc.io,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: Add an entry for Monolithic Power System, MPS
Date:   Thu, 19 Dec 2019 11:37:18 +0100
Message-Id: <20191219103721.10935-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191219103721.10935-1-sravanhome@gmail.com>
References: <20191219103721.10935-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry for Monolithic Power System, MPS

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6046f4555852..5eac9d08bfa8 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -605,6 +605,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mps,.*":
+    description: Monolithic Power Systems, Inc.
   "^mosaixtech,.*":
     description: Mosaix Technologies, Inc.
   "^motorola,.*":
-- 
2.17.1

