Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA6FC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4316D206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 09:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdHw1mp0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfLWJar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 04:30:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32769 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfLWJan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 04:30:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id 6so8532763pgk.0;
        Mon, 23 Dec 2019 01:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZLjuNiKXKBszRB9AdXqYYatRC9mjTciQY/Z/lc2mw8=;
        b=SdHw1mp0m4Yk2IV5+bxFPmxTw74XDvqNdWtaEKoBQnhv+G7zsqtOe5U9MTrUc7MrJJ
         5vQZkF2aWIfboDpSEFBJYGggpAdtdmTs31bRd2bM34PW4N8JH9TrIuSRmaA2y/1z4WjA
         emsqMHZaEOoKpw4miVEtZH85sXdTVHndxXmllOYwQXvXYval1S/axLiGHw3rGZfdTnF7
         vj1s1aH51COV/taORyjyhxTIkoOWp95T0SQcMDMYschON/c+F1yb8b3iKwZ4zLSyR65t
         q3pAGCU7GD+4ztRN12EeEPtO5VeOUttFWAhYBoqqjgLpwCHIcifvWoRGzLy70J4YS56+
         g4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZLjuNiKXKBszRB9AdXqYYatRC9mjTciQY/Z/lc2mw8=;
        b=DbZgeypmUx92kjB83t/klj+PxvEUpTgIy168ZNVutj4+9PbFFs8F3seRBA9GyKKe9z
         xj0Nq5DVVLupYIvSbylUX8iKjlH8vcAfYKhRNSao0Q/7d8U2QRWYnhTdj3Px4uhsKZi5
         LBdPjm12UjTxYnsPGxKdPKakFMEzFcv7ePzg9rAUwDt27pNAiWNrZSXpcEJNcf9Vmwya
         uz12GeFH6rmt2w79s/STpkN4RxNQQ85yCdw8ZF+QIvaH/g9Jg9QpllJjr1s+RJjlP0Fr
         4XTl+ZkAA+JtdBK1/ZHX1NUmy+7DfqzUZjVUBdt1wr8oSThYmiedT55gVWvyZNgkoDsc
         yTHA==
X-Gm-Message-State: APjAAAWK3+W2Q5T/Lih1CDdlmqJvUkro9DnQgdggbxZpgrNdnm47uLwV
        2kZb7+ZVbzkdpPkodMKWtXj+64GE
X-Google-Smtp-Source: APXvYqy6jUhWMsGbnvXEiSZPKxZHudUU9AAn0+bumj0FabTgCjZ+gtRm8+ojZtiAV8heuhEuyYGcdQ==
X-Received: by 2002:a65:6842:: with SMTP id q2mr31081741pgt.345.1577093442447;
        Mon, 23 Dec 2019 01:30:42 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i127sm24625970pfc.55.2019.12.23.01.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 01:30:41 -0800 (PST)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 2/3] dt-bindings: arm: move sprd board file to vendor directory
Date:   Mon, 23 Dec 2019 17:29:47 +0800
Message-Id: <20191223092948.24824-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191223092948.24824-1-zhang.lyra@gmail.com>
References: <20191223092948.24824-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

We've created a vendor directory for sprd, so move the board bindings to
there.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/arm/{ => sprd}/sprd.yaml (92%)

diff --git a/Documentation/devicetree/bindings/arm/sprd.yaml b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
similarity index 92%
rename from Documentation/devicetree/bindings/arm/sprd.yaml
rename to Documentation/devicetree/bindings/arm/sprd/sprd.yaml
index c35fb845ccaa..0258a96bfbde 100644
--- a/Documentation/devicetree/bindings/arm/sprd.yaml
+++ b/Documentation/devicetree/bindings/arm/sprd/sprd.yaml
@@ -2,7 +2,7 @@
 # Copyright 2019 Unisoc Inc.
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/sprd.yaml#
+$id: http://devicetree.org/schemas/arm/sprd/sprd.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Unisoc platforms device tree bindings
-- 
2.20.1

