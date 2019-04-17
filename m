Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DABC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F1621773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aj5WOKqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733064AbfDQRaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40649 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQRaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so33023154wre.7;
        Wed, 17 Apr 2019 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WIGTjZh4mIwUZpoXVfzkYofixlglZX9sKei53EYiYk=;
        b=Aj5WOKqF+mSgsjBpWaUeAq+PoNX7zsm2Qhnv00UOVUzIGHv1lshy+IKTXP7Ds7rvCG
         b8bamc97MPZYshmWApE7ZV4d3pL/JHGQX6Np8pW1gMJXk5FL5uJ4b331fWKXHDNims4V
         +C7s+9KsDih/C0gAo732PAL9htI9biOlbpXT6qQk+ztwuEI8ldXtWb53WS8K+AZe2+DO
         W/HKBFSRLxC73Fpg3alKPdk2r0TlLoEhPRc0ubdGwOOnCSturulw79N4xX0RYDP7RC5Z
         ryA32XxdX8A3bHO+XaEw58jJSQK6+Sq+bfhZwr6bwTnvhtOFoMuvMPF4hkGnn6u5mWtp
         39GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1WIGTjZh4mIwUZpoXVfzkYofixlglZX9sKei53EYiYk=;
        b=q9mL2HVh6rFNsj39EM1ltmHy4QukqChx5EMP3c0UVZ58v9yy0h5guLTnUBIjeie/Vo
         9Gv8smaZl0z/NWwcifr+lFM/G7s+pfAmag396EO7ylGLgG2K+Db07Vyelbs2D0Wyt2TP
         iDbn8wVeX6JyVeCtgUQA4SWcaJUpD47I5avTFO3DYZz/KrtFgcEgYZExuAvPVXkUgHBU
         0lwNNETvKTTYKB+DDLB9mEFNkWWUxXzSP4L8JGAnVhMOgQlH7ahwvqG1DSZphhbH2pur
         NJcowxSFRdHizqvaDDhFyZPUovk2bEmvG4nd1jzqPpbRIJZOIwdkN2QLdppFako0pvTk
         Rc5Q==
X-Gm-Message-State: APjAAAWFIDcu64g9Xky+GVZ//lP7ZIAdduiBvIvgnKMdRrNLFyjIwq3P
        dqVecYWL/9PSsCLpiW/inDg=
X-Google-Smtp-Source: APXvYqwNLMHTqK/0VWA3BJtBaMVwTn+td1BwYu3foSWz0sVgnvDFN9iuDARntEHkupvbB4rlOB+tFA==
X-Received: by 2002:adf:b458:: with SMTP id v24mr57683336wrd.46.1555522219879;
        Wed, 17 Apr 2019 10:30:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:17 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v3 1/8] dt-bindings: gpu: mali-midgard: Add resets property
Date:   Wed, 17 Apr 2019 19:30:24 +0200
Message-Id: <20190417173031.9920-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417173031.9920-1-peron.clem@gmail.com>
References: <20190417173031.9920-1-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

The Amlogic ARM Mali Midgard requires reset controls to power on and
software reset the GPU, adds these as optional in the bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
index 18a2cde2e5f3..1b1a74129141 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
@@ -37,6 +37,20 @@ Optional properties:
 - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
   for details.
 
+- resets : Phandle of the GPU reset line.
+
+Vendor-specific bindings
+------------------------
+
+The Mali GPU is integrated very differently from one SoC to
+another. In order to accomodate those differences, you have the option
+to specify one more vendor-specific compatible, among:
+
+- "amlogic,meson-gxm-mali"
+  Required properties:
+  - resets : Should contain phandles of :
+    + GPU reset line
+    + GPU APB glue reset line
 
 Example for a Mali-T760:
 
-- 
2.17.1

