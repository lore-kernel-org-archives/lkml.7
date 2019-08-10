Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D4FC32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B03E217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 05:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT05HnTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfHJFaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 01:30:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42418 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfHJFaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 01:30:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id t132so46849180pgb.9;
        Fri, 09 Aug 2019 22:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hwZTuXR1RQwweZBHdOcMrMag4gKUpB96/RLkAJHYs6E=;
        b=iT05HnTWCRVNX3VU2btAQTjum2T+H9ULSXrJJd/2QrK9AKvJeXrvnxM8TyNOPU14rm
         E1GHGLJgMoUZrLrm4iOekEcYzmBbG11qAPmrtCUQoia0mVsrMWI/PxnfwM5ed4OlB2ip
         4uqyj+cqtpqGg1gzRwK2Y/BdxqgF7kMc+dLxKQNblnDrIUZUfnRJtd3Ir8l9ara8AQ4+
         BgsRHPG1sehtgh86UHXL5li5nvBiEPxNaFLCcf7ah+NhWcrnbthtihKz08RDZ1FKNykI
         jH/Q+cXLV0h5we2av3QOQMJ4iTF9weqw6TmMRPbXIKFliH0wy+rBeeIzYLqKiwq1CX9Q
         M1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hwZTuXR1RQwweZBHdOcMrMag4gKUpB96/RLkAJHYs6E=;
        b=YxNhaPv/PK1PX2ESy4XsNnYqCKPQX4fDOi6hB6V9Lt3lVN3hgR+ibE2uuNjg+7g9w9
         2PFr2/tdFOmknS6oW/6kaSP3Chw3R0q+kZ3V2tNDvRo4asFnuGC+OGezU4+GCwRP/QbI
         /sU8t++EjWqelQ0FnCmnSOjKMuXSnJICl6/aY/0WvsBeTyhatotzT366jh1QKgju/Vcm
         ejue7zk3KklIMkPGOiFrTrBmXZREcj3Q+7GSrzr+yLEsK0E/UlUsKJlLzA2VWVRnUgz8
         Q+4v79SI+LOv0n4ne89sYc4BdyCdLF82AlyY2mPh21Cz3Zhk5/2a2Q2TvOZxJb+fUp+Q
         EqqA==
X-Gm-Message-State: APjAAAXNeVyiKU/gMLKO9/SHQ716ouvB7t8caCTCEogEzupQ6YnNCh3X
        rXf48jc1TuGhthU57/kE7yc=
X-Google-Smtp-Source: APXvYqw4s2jvP5CyZ7Z78O0x5bAHOAkoJ+5b1iaaYMbNLO9REx5WqGP6UNJ+iBWk2V4PX1g9bg983w==
X-Received: by 2002:a63:e807:: with SMTP id s7mr20041477pgh.194.1565415023202;
        Fri, 09 Aug 2019 22:30:23 -0700 (PDT)
Received: from localhost ([202.182.106.211])
        by smtp.gmail.com with ESMTPSA id k70sm6641708pje.14.2019.08.09.22.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Aug 2019 22:30:22 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v5 17/18] dt-bindings: thermal: add binding document for r40 thermal controller
Date:   Sat, 10 Aug 2019 05:28:28 +0000
Message-Id: <20190810052829.6032-18-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190810052829.6032-1-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds binding document for allwinner r40 thermal controller.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
index 2e28f5b33d33..28c438d3bfea 100644
--- a/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
+++ b/Documentation/devicetree/bindings/thermal/sun8i-thermal.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     enum:
       - allwinner,sun8i-h3-ths
+      - allwinner,sun8i-r40-ths
       - allwinner,sun50i-a64-ths
       - allwinner,sun50i-h5-ths
       - allwinner,sun50i-h6-ths
-- 
2.17.1

