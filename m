Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34207C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A648214DE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 20:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAnNWzo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfKRUH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:07:27 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]:47017 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKRUFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 15:05:38 -0500
Received: by mail-lf1-f54.google.com with SMTP id o65so14866373lff.13;
        Mon, 18 Nov 2019 12:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q8P9xtI8xhHcaTs4uKBwzdrpTHySQaMQUQDsdsZDaTE=;
        b=iAnNWzo21tlp39Df83u3fzdnEEyFML+6bqMpCRK1IqX3vqUfNv5xFU2xniGb9oSimT
         8hZMTFpyg6s68GjgBISjQV1xoj2zXq9TeUTE6py/zyjD4imI+BJCpdJ+yYU1138p/7v7
         uXoc3GnMG4P7wh1N8prkjL5VrBo9WgFzQ2LqSvJEUYQSMYUowmeWmOmdZz6qQcxbBMi7
         TH/+4p6PigtQjTKriPId/qQdYStB7y+CfWZsjJPgimjK4JsGr9ada9my9JR/c2UZC9U2
         2ShHmUmEctqYMHDYGSOV0kP+cn36dj+ub+mEZTFf4wH+/aWJWMJfnEoLo1HBrh3cf/oo
         LeZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q8P9xtI8xhHcaTs4uKBwzdrpTHySQaMQUQDsdsZDaTE=;
        b=F9Z2LL1zNBoCVLi0YErJQdweVH1s/wkhT6W1NQjAfvHpy2Hh/aQkhaijIZfm02SfNi
         01CTYvdCgZalsDCUbzdWrj5z1ER7usc1Y7Na6P5Dbd16z8FQwLebPfmwF/cMfSB/pDOJ
         pGnNQYgOmS1tMNxziSYRY/2zr3wrlRiE78W1qBYL0gK22cWTOlOUxgoVE51FIShxhtje
         hSLSH0HIzSIA192GbqObl1j4M2u+9aP0epZfX1YPQ5aah3/T0dmVo7aGWmB3gDvXsUlt
         q6iyl3zY47X/x5y52/QBvCS/cw78k3vI+1jhvRlLmsbbkZUvasdPLV0s68Pv8HrgE3JU
         R+Lw==
X-Gm-Message-State: APjAAAXW8wn5uVNOnov11tikXyWzJfaJw9QJ6+04wEHZ7ErhHn49mJOe
        bMyhy4X4Vy4bF90Y0aKvVIA=
X-Google-Smtp-Source: APXvYqxpciZO+2bTdRPuV7Eo6xCsKKBjE1Eln4PJ66P/qZe/XlNohG1C908ZR44WD7VDsuZFLUeTUg==
X-Received: by 2002:a19:9116:: with SMTP id t22mr787720lfd.99.1574107534043;
        Mon, 18 Nov 2019 12:05:34 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id j23sm9166942lji.41.2019.11.18.12.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 12:05:33 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 04/29] dt-bindings: memory: tegra30: emc: Document new interconnect property
Date:   Mon, 18 Nov 2019 23:02:22 +0300
Message-Id: <20191118200247.3567-5-digetx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191118200247.3567-1-digetx@gmail.com>
References: <20191118200247.3567-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

External memory controller is interconnected with memory controller and
with external memory. Document new interconnect property which designates
external memory controller as interconnect provider.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-emc.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
index 7fe0ca14e324..ecdffbe691ce 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-emc.yaml
@@ -31,6 +31,9 @@ properties:
   interrupts:
     maxItems: 1
 
+  "#interconnect-cells":
+    const: 1
+
   nvidia,memory-controller:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -214,6 +217,7 @@ required:
   - interrupts
   - clocks
   - nvidia,memory-controller
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -227,6 +231,8 @@ examples:
 
         nvidia,memory-controller = <&mc>;
 
+        #interconnect-cells = <1>;
+
         emc-timings-1 {
             nvidia,ram-code = <1>;
 
-- 
2.23.0

